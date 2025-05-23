HDMATransferTileMapToWRAMBank3:: ; 10402d
	call CallInSafeGFXMode

.Function:
	decoord 0, 0
	ld hl, wScratchTileMap
	call CutAndPasteTilemap
	ld a, $0
	ldh [rVBK], a
	ld hl, wScratchTileMap
	jp HDMATransferToWRAMBank3
; 104047

HDMATransferAttrMapToWRAMBank3: ; 104047
	call CallInSafeGFXMode

.Function:
	decoord 0, 0, wAttrMap
	ld hl, wScratchAttrMap
	call CutAndPasteAttrMap
	ld a, $1
	ldh [rVBK], a
	ld hl, wScratchAttrMap
	jp HDMATransferToWRAMBank3
; 104061

ReloadMapPart:: ; 104061
	call CallInSafeGFXMode

.Function:
	decoord 0, 0, wAttrMap
	ld hl, wScratchAttrMap
	call CutAndPasteAttrMap
	decoord 0, 0
	ld hl, wScratchTileMap
	call CutAndPasteTilemap

	di
	ldh a, [rVBK]
	push af
	ld a, $1
	ldh [rVBK], a
	ld hl, wScratchAttrMap
	call DoHBlankHDMATransfer_toBGMap
	ld a, $0
	ldh [rVBK], a
	ld hl, wScratchTileMap
	call DoHBlankHDMATransfer_toBGMap
	pop af
	ldh [rVBK], a
	reti

HDMATransferToWRAMBank3: ; 10419d (41:419d)
	ld a, h
	ldh [rHDMA1], a
	ld a, l
	ldh [rHDMA2], a
	ldh a, [hBGMapAddress + 1]
	and $1f
	ldh [rHDMA3], a
	ldh a, [hBGMapAddress]
	ldh [rHDMA4], a

	ld a, $23
	ldh [hDMATransfer], a
	; fallthrough

WaitDMATransfer:
	jr .handleLoop
.loop
	call DelayFrame
.handleLoop
	ldh a, [hDMATransfer]
	and a
	jr nz, .loop
	ret

CallInSafeGFXMode:
	pop hl

	ldh a, [hBGMapMode]
	push af
	ldh a, [hMapAnims]
	push af
	xor a
	ldh [hBGMapMode], a
	ldh [hMapAnims], a
	ldh a, [rSVBK]
	push af
	ld a, BANK(wScratchTileMap)
	ldh [rSVBK], a
	ldh a, [rVBK]
	push af

	call _hl_

	pop af
	ldh [rVBK], a
	pop af
	ldh [rSVBK], a
	pop af
	ldh [hMapAnims], a
	pop af
	ldh [hBGMapMode], a
	ret

DoHBlankHDMATransfer_toBGMap:
	ldh a, [hBGMapAddress + 1]
	ld d, a
	ldh a, [hBGMapAddress]
	ld e, a
	ld c, $23
	ld a, h
	ldh [rHDMA1], a
	ld a, l
	and $f0
	ldh [rHDMA2], a
	ld a, d
	and $1f
	ldh [rHDMA3], a
	ld a, e
	and $f0
	ldh [rHDMA4], a
	ldh a, [rLY]
	add c ; calculate end LY
	cp $80 ; is the end LY greater than the max LY
	call nc, DI_DelayFrame ; if so, delay a frame to reset the LY
	set 7, c
.waitHBlank
	ldh a, [rSTAT]
	and $3
	jr nz, .waitHBlank
	ld hl, rHDMA5
	ld [hl], c
	ld a, $ff
.waitHDMALoop
	cp [hl]
	jr nz, .waitHDMALoop
	ret

DoHBlankHDMATransfer:
	ld b, $7f
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
	dec c ; c = number of LYs needed
	ld e, c
	set 7, e ; hblank dma transfers
	ldh a, [rLY]
	add c ; calculate end LY
	cp b ; is the end LY greater than the max LY
	call nc, DI_DelayFrame ; if so, delay a frame to reset the LY

	lb bc, %11, rSTAT & $ff
.noHBlankWait
	ldh a, [c]
	and b
	jr z, .noHBlankWait
.hBlankWaitLoop
	ldh a, [c]
	and b
	jr nz, .hBlankWaitLoop
	ld hl, rHDMA5
	ld [hl], e
	ld a, $ff
.waitForHDMA
	cp [hl]
	jr nz, .waitForHDMA
	ret

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
	ld b, 12
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

HDMAHBlankTransferTileMap_DuringDI::
	call CallInSafeGFXMode
	
.Function
	decoord 0, 0
	ld hl, wDecompressScratch
	call CutAndPasteTilemap
	xor a
	ldh [rVBK], a
	ld hl, wDecompressScratch
	jp DoHBlankHDMATransfer_toBGMap
	
HDMAHBlankTransferAttrMap_DuringDI::
	call CallInSafeGFXMode

.Function
	decoord 0, 0, wAttrMap
	ld hl, wScratchTileMap
	call CutAndPasteAttrMap
	ld a, $1
	ldh [rVBK], a
	ld hl, wScratchTileMap
	jp DoHBlankHDMATransfer_toBGMap

	
HDMATransfer_OnlyTopFourRows:: ; 104303
	call CallInSafeGFXMode

.Function:
	ld hl, wScratchTileMap
	decoord 0, 0
	call .Copy
	ld hl, wScratchTileMap + $80
	decoord 0, 0, wAttrMap
	call .Copy
	di
	ld a, $1
	ldh [rVBK], a
	ld c, $8
	ld hl, wScratchTileMap + $80
	debgcoord 0, 0, VBGMap1
	call DoHBlankHDMATransfer
	xor a
	ldh [rVBK], a
	ld c, $8
	ld hl, wScratchTileMap
	debgcoord 0, 0, VBGMap1
	call DoHBlankHDMATransfer

	reti

.Copy: ; 10433a (41:433a)
	ld b, 4
.outer_loop
	ld c, SCREEN_WIDTH
.inner_loop
	ld a, [de]
	ld [hli], a
	inc de
	dec c
	jr nz, .inner_loop
	ld a, l
	add $20 - SCREEN_WIDTH
	ld l, a
	ld a, h
	adc $0
	ld h, a
	dec b
	jr nz, .outer_loop
	ret

DI_DelayFrame:
	ldh a, [rLY]
	push bc
	ld b, a
.loop
	ldh a, [rLY]
	and a
	jr z, .done
	cp b
	jr nc, .loop
.done
	pop bc
	ret

ShockEmote:      INCBIN "gfx/emotes/shock.2bpp"
QuestionEmote:   INCBIN "gfx/emotes/question.2bpp"
HappyEmote:      INCBIN "gfx/emotes/happy.2bpp"
SadEmote:        INCBIN "gfx/emotes/sad.2bpp"
HeartEmote:      INCBIN "gfx/emotes/heart.2bpp"
BoltEmote:       INCBIN "gfx/emotes/bolt.2bpp"
SleepEmote:      INCBIN "gfx/emotes/sleep.2bpp"
FishEmote:       INCBIN "gfx/emotes/fish.2bpp"

JumpShadowGFX:   INCBIN "gfx/overworld/shadow.2bpp"
FishingRodGFX:   INCBIN "gfx/overworld/fishing_rod.2bpp"
BoulderDustGFX:  INCBIN "gfx/overworld/boulderdust.2bpp"
ShakingGrassGFX: INCBIN "gfx/overworld/shaking_grass.2bpp"
PuddleSplashGFX: INCBIN "gfx/overworld/puddle_splash.2bpp"
ShakingSnowGFX:  INCBIN "gfx/overworld/shaking_snow.2bpp"
ShakingPollenGFX:  INCBIN "gfx/overworld/shaking_pollen.2bpp"
