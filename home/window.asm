RefreshScreen:: ; 2dba
	call ClearWindowData
	ldh a, [hROMBank]
	push af
	ld a, BANK(ReanchorBGMap_NoOAMUpdate) ; BANK(LoadFonts_NoOAMUpdate)
	rst Bankswitch

	call ReanchorBGMap_NoOAMUpdate
	call BGMapAnchorTopLeft
	call LoadFonts_NoOAMUpdate

	pop af
	rst Bankswitch
	ret
; 2dcf

RefreshScreenFast::
	; Don't use for bridge updates, just call GenericFinishBridge
	call GetMovementPermissions
	farjp ReanchorBGMap_NoOAMUpdate_NoDelay

CloseText:: ; 2dcf
	ldh a, [hOAMUpdate]
	push af
	ld a, $1
	ldh [hOAMUpdate], a

	call .CloseText

	pop af
	ldh [hOAMUpdate], a
	ld hl, wVramState
	res 6, [hl]
	ret
; 2de2

.CloseText: ; 2de2
	call ClearWindowData
	xor a
	ldh [hBGMapMode], a
	call LoadMapPart
	call BGMapAnchorTopLeft
	xor a
	ldh [hBGMapMode], a
	call SafeUpdateSprites
	farcall ReloadVisibleSprites
	ld a, $90
	ldh [hWY], a
;	call ReplaceKrisSprite
	xor a
	ldh [hBGMapMode], a
	ret
;	farjp ReturnFromMapSetupScript
; 2e08

OpenText:: ; 2e08
	call ClearWindowData
	ldh a, [hROMBank]
	push af
	ld a, BANK(ReanchorBGMap_NoOAMUpdate) ; and BANK(LoadFonts_NoOAMUpdate)
	rst Bankswitch

	call ReanchorBGMap_NoOAMUpdate
	call SpeechTextBox
	call BGMapAnchorTopLeft
	call LoadFonts_NoOAMUpdate
	pop af
	rst Bankswitch

	ret
; 2e20

BGMapAnchorTopLeft::
	; OpenText
	ld hl, .Function
	jp CallInSafeGFXMode

.Function:
	; Transfer AttrMap and Tilemap to BGMap
	; Fill vBGAttrs with $00
	; Fill vBGTiles with " "
	decoord 0, 0, wAttrMap
	ld hl, wScratchAttrMap
	call CutAndPasteAttrMap
	decoord 0, 0
	ld hl, wScratchTileMap
	call CutAndPasteTilemap
	call DelayFrame

	di
	ldh a, [rVBK]
	push af
	ld a, $1
	ldh [rVBK], a
	ld hl, wScratchAttrMap
	call HDMATransfer_Wait123Scanlines_toBGMap
	ld a, $0
	ldh [rVBK], a
	ld hl, wScratchTileMap
	call HDMATransfer_Wait123Scanlines_toBGMap
	pop af
	ldh [rVBK], a
	ei
	ret

SafeUpdateSprites:: ; 2e31
	ldh a, [hOAMUpdate]
	push af
	ldh a, [hBGMapMode]
	push af
	xor a
	ldh [hBGMapMode], a
	ld a, $1
	ldh [hOAMUpdate], a
	call UpdateSprites
	xor a
	ldh [hOAMUpdate], a
	call DelayFrame
	pop af
	ldh [hBGMapMode], a
	pop af
	ldh [hOAMUpdate], a
	ret
; 2e4e

HDMATransfer_Wait127Scanlines_toBGMap: ; 1041ad (41:41ad)
; HDMA transfer from hl to [hBGMapAddress]
; hBGMapAddress -> de
; 2 * SCREEN_HEIGHT -> c
	ldh a, [hBGMapAddress + 1]
	ld d, a
	ldh a, [hBGMapAddress]
	ld e, a
	ld c, 2 * SCREEN_HEIGHT
	jr HDMATransfer_Wait127Scanlines

HDMATransfer_Wait123Scanlines_toBGMap: ; 1041b7 (41:41b7)
; HDMA transfer from hl to [hBGMapAddress]
; hBGMapAddress -> de
; 2 * SCREEN_HEIGHT -> c
; $7b --> b
	ldh a, [hBGMapAddress + 1]
	ld d, a
	ldh a, [hBGMapAddress]
	ld e, a
	ld c, 2 * SCREEN_HEIGHT
	jr HDMATransfer_Wait123Scanlines
; 1041c1 (41:41c1)

HDMATransfer_NoDI: ; 1041c1
; HDMA transfer from hl to [hBGMapAddress]
; [hBGMapAddress] --> de
; 2 * SCREEN_HEIGHT --> c
	ldh a, [hBGMapAddress + 1]
	ld d, a
	ldh a, [hBGMapAddress]
	ld e, a
	ld c, 2 * SCREEN_HEIGHT

	; [rHDMA1, rHDMA2] = hl & $fff0
	ld a, h
	ldh [rHDMA1], a
	ld a, l
	and $f0
	ldh [rHDMA2], a
	; [rHDMA3, rHDMA4] = de & $1ff0
	ld a, d
	and $1f
	ldh [rHDMA3], a
	ld a, e
	and $f0
	ldh [rHDMA4], a
	; b = c | %10000000
	ld a, c
	dec c
	or $80
	ld b, a
	; d = $7f - c + 1
	ld a, $7f
	sub c
	ld d, a
	; while [rLY] >= d: pass
.loop1
	ldh a, [rLY]
	cp d
	jr nc, .loop1
	; while not [rSTAT] & 3: pass
.loop2
	ldh a, [rSTAT]
	and $3
	jr z, .loop2
	; load the 5th byte of HDMA
	ld a, b
	ldh [rHDMA5], a
	; wait until rLY advances (c + 1) times
	ldh a, [rLY]
	inc c
	ld hl, rLY
.loop3
	cp [hl]
	jr z, .loop3
	ld a, [hl]
	dec c
	jr nz, .loop3
	ld hl, rHDMA5
	res 7, [hl]
	ret
; 104205

HDMATransfer_Wait123Scanlines:
	ld b, $7b
	jr _continue_HDMATransfer


HDMATransfer_Wait127Scanlines:
	ld b, $7f
_continue_HDMATransfer:
; a lot of waiting around for hardware registers
	; [rHDMA1, rHDMA2] = hl & $fff0
	ld a, h
	ldh [rHDMA1], a
	ld a, l
	and $f0 ; high nybble
	ldh [rHDMA2], a
	; [rHDMA3, rHDMA4] = de & $1ff0
	ld a, d
	and $1f ; lower 5 bits
	ldh [rHDMA3], a
	ld a, e
	and $f0 ; high nybble
	ldh [rHDMA4], a
	; e = c | %10000000
	ld a, c
	dec c
	or $80
	ld e, a
	; d = b - c + 1
	ld a, b
	sub c
	ld d, a
	; while [rLY] >= d: pass
.ly_loop
	ldh a, [rLY]
	cp d
	jr nc, .ly_loop

	di
	; while [rSTAT] & 3: pass
.rstat_loop_1
	ldh a, [rSTAT]
	and $3
	jr nz, .rstat_loop_1
	; while not [rSTAT] & 3: pass
.rstat_loop_2
	ldh a, [rSTAT]
	and $3
	jr z, .rstat_loop_2
	; load the 5th byte of HDMA
	ld a, e
	ldh [rHDMA5], a
	; wait until rLY advances (c + 1) times
	ldh a, [rLY]
	inc c
	ld hl, rLY
.final_ly_loop
	cp [hl]
	jr z, .final_ly_loop
	ld a, [hl]
	dec c
	jr nz, .final_ly_loop
	ld hl, rHDMA5
	res 7, [hl]
	ei

	ret
; 10424e

CutAndPasteTilemap: ; 10425f (41:425f)
	ld c, " "
	jr CutAndPasteMap

CutAndPasteAttrMap: ; 104263 (41:4263)
	ld c, $0

CutAndPasteMap: ; 104265 (41:4265)
; back up the value of c to hMapObjectIndexBuffer
	ldh a, [hMapObjectIndexBuffer]
	push af
	ld a, c
	ldh [hMapObjectIndexBuffer], a

; for each row on the screen
	ld c, SCREEN_HEIGHT
.loop1
; for each tile in the row
	ld b, SCREEN_WIDTH
.loop2
; copy from de to hl
	ld a, [de]
	inc de
	ld [hli], a
	dec b
	jr nz, .loop2

; load the original value of c into hl 12 times
	ldh a, [hMapObjectIndexBuffer]
	ld b, BG_MAP_WIDTH - SCREEN_WIDTH
.loop3
	ld [hli], a
	dec b
	jr nz, .loop3

	dec c
	jr nz, .loop1

; restore the original value of hMapObjectIndexBuffer
	pop af
	ldh [hMapObjectIndexBuffer], a
	ret
	
CallInSafeGFXMode: ; 104177
	ldh a, [hBGMapMode]
	push af
	ldh a, [hMapAnims]
	push af
	xor a
	ldh [hBGMapMode], a
	ldh [hMapAnims], a
	ldh a, [rSVBK]
	push af
	ld a, $6
	ldh [rSVBK], a
	ldh a, [rVBK]
	push af

	call ._hl_

	pop af
	ldh [rVBK], a
	pop af
	ldh [rSVBK], a
	pop af
	ldh [hMapAnims], a
	pop af
	ldh [hBGMapMode], a
	ret
; 10419c

._hl_ ; 10419c
	jp hl
; 10419d
