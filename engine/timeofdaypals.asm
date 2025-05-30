UpdateTimeOfDayPal:: ; 8c001
	call UpdateTime
	ld a, [wTimeOfDay]
	ld [wCurTimeOfDay], a
	call GetTimePalette
	ld [wTimeOfDayPal], a
	ret
; 8c011


_TimeOfDayPals:: ; 8c011
; return carry if pals are changed

; force updating pals
	ld hl, wTimeOfDayPalFlags
	bit 6, [hl]
	res 6, [hl]
	jr nz, .change

; force keeping pals
	bit 7, [hl]
	jr nz, .dontchange

; do we need to bother updating?
	ld a, [wTimeOfDay]
	ld hl, wCurTimeOfDay
	cp [hl]
	jr z, .dontchange

; if so, the time of day has changed
	ld a, [wTimeOfDay]
	ld [wCurTimeOfDay], a

; get palette id
	call GetTimePalette

; same palette as before?
	ld hl, wTimeOfDayPal
	cp [hl]
	jr z, .dontchange

; update palette id
	ld [wTimeOfDayPal], a

.change
; save bg palette 7
	ld hl, wUnknBGPals palette 7

; save wram bank
	ldh a, [rSVBK]
	ld b, a
; wram bank 5
	ld a, 5
	ldh [rSVBK], a

; push palette
	ld c, 4 ; NUM_PAL_COLORS
.push
	ld d, [hl]
	inc hl
	ld e, [hl]
	inc hl
	push de
	dec c
	jr nz, .push

; restore wram bank
	ld a, b
	ldh [rSVBK], a


; update cgb pals
	ld b, CGB_MAPPALS
	call GetCGBLayout


; restore bg palette 7
	ld hl, wUnknBGPals palette 7 + 1 palettes - 1 ; last byte in UnknBGPals

; save wram bank
	ldh a, [rSVBK]
	ld d, a
; wram bank 5
	ld a, 5
	ldh [rSVBK], a

; pop palette
	ld e, 4 ; NUM_PAL_COLORS
.pop
	pop bc
	ld [hl], c
	dec hl
	ld [hl], b
	dec hl
	dec e
	jr nz, .pop

; restore wram bank
	ld a, d
	ldh [rSVBK], a

; update palettes
	farcall OWFadePalettesInit
	
; successful change
	scf
	ret

.dontchange
; no change occurred
	and a
	ret
; 8c070


_UpdateTimePals:: ; 8c070
	ld c, $9 ; normal
	call GetTimePalFade
	jp DmgToCgbTimePals
; 8c079

FadeInPalettesSign::
	xor a
	ld [wLandmarkSignTimer], a
	ld a, $90
	ldh [rWY], a
	ldh [hWY], a
	xor a
	ldh [hLCDCPointer], a
	call GetMapPermission
	cp GATE
	jr z, .cont
	call CheckMovingWithinLandmarkFade
	jr z, .cont
	ld a, $70
	ld [wLandmarkSignTimer], a
.cont
FadeInPalettes::
	ld c, 10
	jp FadePalettes

FadeOutPalettes::
;	ld a, [wLandmarkSignTimer]
;	cp $00
;	jr z, .cont
;	ld a, $70
;	ld [wLandmarkSignTimer], a

	ld c, 10
	jp FadeToWhite
	
FadeOutPalettesBlack::
	ld c, 10
	jp FadeToBlack
	
FadeInTextboxPalettes::
	ld b, CGB_MAPPALS
	call GetCGBLayout
	farcall LoadRegularTextboxPalette
	farjp FadeInPalettes

Special_BattleTower_Fade: ; 8c092
	call FillWhiteBGColor
	ld c, $9
	call GetTimePalFade
	ld b, $4
.asm_8c09c
	call DmgToCgbTimePals
	inc hl
	inc hl
	inc hl
	ld c, $7
	call DelayFrames
	dec b
	jr nz, .asm_8c09c
	ret
; 8c0ab

Special_FadeInQuickly: ; 8c0ab
	ld c, $0
	call GetTimePalFade
	ld b, $4
	jp ConvertTimePalsIncHL
; 8c0b6

Special_FadeBlackQuickly: ; 8c0b6
	ld c, $9
	call GetTimePalFade
	ld b, $4
	jp ConvertTimePalsDecHL
; 8c0c1


FillWhiteBGColor: ; 8c0c1
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a

	ld hl, wUnknBGPals
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	ld hl, wUnknBGPals palette 1
	ld c, 6
.loop
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a
rept 6
	inc hl
endr
	dec c
	jr nz, .loop

	pop af
	ldh [rSVBK], a
	ret
; 8c0e5

MACRO brightlevel
	db (\1 << 6) | (\2 << 4) | (\3 << 2) | \4
ENDM

ReplaceTimeOfDayPals:: ; 8c0e5
;	xor a
;	ld [wTimeOfDayPalFlags], a

	ld hl, .BrightnessLevels
	ld a, [wMapTimeOfDay]
	cp PALETTE_DARK ; needs Flash
	jr z, .DarkCave
	and $7
	add l
	ld l, a
	ld a, 0 ; not xor a; preserve carry flag?
	adc h
	ld h, a
	ld a, [hl]
	ld [wTimeOfDayPalset], a
	ret

.DarkCave:
	ld a, [wStatusFlags]
	bit 2, a ; Flash
	jr nz, .UsedFlash
	ld a, %11111111 ; 3, 3, 3, 3
	ld [wTimeOfDayPalset], a
	ret

.UsedFlash:
	ld a, %10101010 ; 2, 2, 2, 2
	ld [wTimeOfDayPalset], a
	ret
; 8c10f (23:410f)

.BrightnessLevels: ; 8c10f
	brightlevel 3, 2, 1, 0 ; PALETTE_AUTO
	brightlevel 1, 1, 1, 1 ; PALETTE_DAY
	brightlevel 2, 2, 2, 2 ; PALETTE_NITE
	brightlevel 0, 0, 0, 0 ; PALETTE_MORN
	brightlevel 3, 3, 3, 3 ; PALETTE_DARK
	brightlevel 3, 2, 1, 0
	brightlevel 3, 2, 1, 0
	brightlevel 3, 2, 1, 0
; 8c117

GetTimePalette: ; 8c117
	ld a, [wTimeOfDay]
	ld e, a
	ld d, 0
	ld hl, .TimePalettes
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl
; 8c126

.TimePalettes:
	dw .MorningPalette
	dw .DayPalette
	dw .NitePalette
	dw .DarknessPalette

.MorningPalette:
	ld a, [wTimeOfDayPalset]
	and %00000011 ; 0
	ret

.DayPalette:
	ld a, [wTimeOfDayPalset]
	and %00001100 ; 1
	srl a
	srl a
	ret

.NitePalette:
	ld a, [wTimeOfDayPalset]
	and %00110000 ; 2
	swap a
	ret

.DarknessPalette:
	ld a, [wTimeOfDayPalset]
	and %11000000 ; 3
	rlca
	rlca
	ret
; 8c14e


DmgToCgbTimePals: ; 8c14e
	push hl
	push de
	ld a, [hli]
	call DmgToCgbBGPals
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	call DmgToCgbObjPals
	pop de
	pop hl
	ret
; 8c15e

ConvertTimePalsIncHL: ; 8c15e
.loop
	call DmgToCgbTimePals
	inc hl
	inc hl
	inc hl
	ld c, 2
	call DelayFrames
	dec b
	jr nz, .loop
	ret
; 8c16d

ConvertTimePalsDecHL: ; 8c16d
.loop
	call DmgToCgbTimePals
	dec hl
	dec hl
	dec hl
	ld c, 2
	call DelayFrames
	dec b
	jr nz, .loop
	ret
; 8c17c


GetTimePalFade: ; 8c17c
	ld hl, .cgbfade
	ld b, $0
	add hl, bc
	ret

.cgbfade
	db %11111111, %11111111, %11111111
	db %11111110, %11111110, %11111110
	db %11111001, %11111001, %11111001
	db %11100100, %11100100, %11100100
	db %10010000, %10010000, %10010000
	db %01000000, %01000000, %01000000
	db %00000000, %00000000, %00000000
; 8c20f

CheckMovingWithinLandmarkFade:
	ld a, [wCurrentLandmark]
	ld c, a
	ld a, [wPreviousLandmark]
	cp c
	ret z
	and a ; cp SPECIAL_MAP
	ret
	