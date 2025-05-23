DEF LD_A_FFXX_OP EQU $f0
DEF JR_C_OP	  EQU $38
DEF JP_C_OP	  EQU $da
DEF LD_B_XX_OP   EQU $06
DEF RET_OP	   EQU $c9
DEF RET_C_OP	 EQU $d8

DEF DEC_C_OP	 EQU $0d
DEF JR_NZ_OP	 EQU $20
DEF LD_A_HLI_OP  EQU $2a
DEF LD_C_XX_OP   EQU $0e
DEF ADD_A_OP	 EQU $87

LoadDEDCryHeader::
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ret

PlayDEDCry::
	ldh a, [hROMBank]
	push af
	ld a, BANK(_PlayDEDCry)
	rst Bankswitch
	call _PlayDEDCry
	pop af
	rst Bankswitch
	ret

PlayDEDSamples::
	ldh a, [hROMBank]
	push af
	ld a, b
	rst Bankswitch
	call .Function
	pop af
	rst Bankswitch
	ret

.Function:
	call WriteDEDTreeToWRAM
	ld a, [hli] ; length
	ld e, a
	ld a, [hli]
	ld d, a
	ld a, 8
	ldh [hCurSampVal], a
	ld c, 1
	ld a, (1 << rTAC_ON) | rTAC_16384_HZ
	ldh [rTAC], a
	inc d
	inc e
	jr .handleLoop
.loop
	push de
	ld de, wDEDTempSamp
	ld a, 16
.loop2
	ldh [hLoopCounter], a
	push de
	call wGetDEDByte
	ldh [hCurBitStream], a
	ldh a, [hCurSampVal]
	add b
	and $f
	ldh [hCurSampVal], a
	swap a
	ld d, a
	call wGetDEDByte
	ldh [hCurBitStream], a
	ldh a, [hCurSampVal]
	add b
	and $f
	ldh [hCurSampVal], a
	or d
	pop de
	ld [de], a
	inc de
	ldh a, [hLoopCounter]
	dec a
	jr nz, .loop2
	ei
	xor	a ; reset carry
.haltLoop
	halt ; wait until timer interrupt hits
	nop
	jr nc, .haltLoop
	di
	ldh [rNR51], a
	ldh [rNR30], a
	push hl
	ld hl, wDEDTempSamp
DEF CUR_WAVE = rWAVE
rept 16
	ld a, [hli]
	ldh [CUR_WAVE], a
DEF CUR_WAVE = CUR_WAVE + 1
endr
	ld a, $80
	ldh [rNR30], a
	ld a, $87
	ldh [rNR34], a
	ldh a, [hDEDNR51Mask]
	ldh [rNR51], a

	pop hl
	pop de
.handleLoop
	dec e
	jp nz, .loop
	dec d
	jp nz, .loop
	ret

WriteDEDTreeToWRAM:
	ld d, h
	ld e, l
	ld hl, wGetDEDByte
	ld a, LD_A_FFXX_OP
	ld [hli], a
	ld a, hCurBitStream & $ff
	ld [hli], a
.loop
; control codes are styled as follows
; 1110 xxxx xxxx xxxx: internal internal, x is jump offset
; 1100 xxxx 0000 yyyy: leaf leaf, x if 1, y if 0
; 1000 xxxx: internal leaf, x if 1
; 0xxx xxxx: internal internal, x is jump offset
; 1111 1111: terminator, signifies end of stream
	ld a, [de]
	cp $ff
	jr z, .end
	add a
	jr nc, .huffhuffjr
	add a
	jr nc, .huffleaf
	add a
	jr nc, .leafleaf
.huffhuffjp
	call CopyBitreeCode
	push bc
	ld a, JP_C_OP
	ld [hli], a
	ld a, [de]
	and $f
	ld b, a
	inc de
	ld a, [de]
	inc de
	ld c, a
	push hl
	add hl, bc
	inc hl
	inc hl
	ld b, h
	ld c, l
	pop hl
	ld a, c
	ld [hli], a
	ld a, b
	ld [hli], a
	pop bc
	jr .loop
.leafleaf
	call .leafcommon
	ld a, LD_B_XX_OP
	ld [hli], a
	ld a, [de]
	inc de
	ld [hli], a
	ld a, RET_OP
	ld [hli], a
	jr .loop
.huffleaf
	call .leafcommon
	jr .loop
.huffhuffjr
	call CopyBitreeCode
	ld a, JR_C_OP
	ld [hli], a
	ld a, [de]
	inc de
	ld [hli], a
	jr .loop
.end
	inc de
	ld h, d
	ld l, e
	ret
.leafcommon
	call CopyBitreeCode
	ld a, LD_B_XX_OP
	ld [hli], a
	ld a, [de]
	inc de
	and $f
	ld [hli], a
	ld a, RET_C_OP
	ld [hli], a
	ret

CopyBitreeCode:
	ld a, DEC_C_OP
	ld [hli], a
	ld a, JR_NZ_OP
	ld [hli], a
	ld a, 3
	ld [hli], a
	ld a, LD_A_HLI_OP
	ld [hli], a
	ld a, LD_C_XX_OP
	ld [hli], a
	ld a, 8
	ld [hli], a
	ld a, ADD_A_OP
	ld [hli], a
	ret
	
TransferAnimatingPicDuringHBlank::
	ld hl, wPokeAnimDestination
	ld a, [hli]
	ld d, [hl]
	ld e, a
	ld hl, wPokeAnimCoord
	ld a, [hli]
	ld h, [hl]
	ld l, a

	lb bc, 7, rSTAT & $ff
.loop
	ldh a, [rLY]
	cp $90
	jr nc, .inVBlank
.waitNoHBlank
	ld a, [$ff00+c]
	and 3
	jr z, .waitNoHBlank
.waitHBlank
	ld a, [$ff00+c]
	and 3
	jr nz, .waitHBlank
.inVBlank
	rept 7
	ld a, [hli]
	ld [de], a
	inc e
	endr
	ld a, [hl]
	ld [de], a

	ld a, (BG_MAP_WIDTH - 7)
	add e
	ld e, a
	jr nc, .noCarry
	inc d
.noCarry
	ld a, (SCREEN_WIDTH - 7)
	add l
	ld l, a
	jr nc, .noCarry2
	inc h
.noCarry2
	dec b
	jr nz, .loop
	ret
