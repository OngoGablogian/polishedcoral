CopyGrowlOrRoarPals::
	ld de, rSTAT
	ld a, [wFXAnimIDLo]
	cp ROAR_WHIRLWIND
	jr nz, .growl
	call .roar
	ldh a, [hBGMapMode]
	and a
	jp nz, TransferAnimatingPicDuringHBlank
	ret
; growl copies 1 BGP pal (dependent on turn) and 1 OBP pal
.growl
	ld c, rBGPI & $ff
	ldh a, [hBattleTurn]
	and a
	ld a, 1 << 7 | 8
	jr z, .player
	ld a, 1 << 7
.player
	ld [$ff00+c], a
	inc c
	ld l, a ; the strats
	ld h, wBGPals >> 8
	ldh a, [rLY]
	cp $90
	jr z, .inVBlank1
.waitNoHBlankLoop
	ld a, [de]
	and 3
	jr z, .waitNoHBlankLoop
.waitHBlankLoop
	ld a, [de]
	and 3
	jr nz, .waitHBlankLoop
.inVBlank1
rept 1 palettes
	ld a, [hli]
	ld [$ff00+c], a
endr

.roar
	ld c, rOBPI & $ff
	ld a, 1 << 7 | 16
	ld [$ff00+c], a
	inc c
	ld hl, wOBPals + 16
	ldh a, [rLY]
	cp $90
	jr nc, .inVBlank2
.waitNoHBlankLoop2
	ld a, [de]
	and 3
	jr z, .waitNoHBlankLoop2
.waitHBlankLoop2
	ld a, [de]
	and 3
	jr nz, .waitHBlankLoop2
.inVBlank2
rept 1 palettes
	ld a, [hli]
	ld [$ff00+c], a
endr
	ret