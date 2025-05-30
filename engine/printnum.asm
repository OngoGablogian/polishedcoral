_PrintNum:: ; c4c7
; Print c digits of the b-byte value from de to hl.
; Allows 2 to 7 digits. For 1-digit numbers, add
; the value to char "0" instead of calling PrintNum.
; Some extra flags can be given in bits 5-7 of b.
; Bit 5: money if set (unless left-aligned without leading zeros)
; Bit 6: right-aligned if set
; Bit 7: print leading zeros if set

	push bc

	bit PRINTNUM_MONEY_F, b
	jr z, .main
	bit PRINTNUM_LEADINGZEROS_F, b
	jr nz, .moneyflag
	bit PRINTNUM_LEFTALIGN_F, b
	jr z, .main

.moneyflag ; 101xxxxx or 011xxxxx
	ld a, "¥"
	ld [hli], a
	res PRINTNUM_MONEY_F, b ; 100xxxxx or 010xxxxx

.main
	bit PRINTNUM_LEFTALIGN_F, b
	jr z, .continue
	ld a, c
	dec a
	jr nz, .continue
	inc c
.continue
	ld a, c
	dec a
	jr z, .one
	call .do_it
	pop bc
	ret

.one
	dec hl
	ld a, [hl]
	push hl
	push af
	call .do_it
	pop af
	pop hl
	ld [hl], a
	pop bc
	ret

.do_it
	push bc
	xor a
	ldh [hPrintNum1], a
	ldh [hPrintNum2], a
	ldh [hPrintNum3], a
	ld a, b
	and $f
	dec a
	jr z, .byte
	dec a
	jr z, .word
; maximum 3 bytes
.long
	ld a, [de]
	ldh [hPrintNum2], a
	inc de

.word
	ld a, [de]
	ldh [hPrintNum3], a
	inc de

.byte
	ld a, [de]
	ldh [hPrintNum4], a

	push de

	ld d, b
	ld a, c
	swap a
	and $f
	ld e, a
	ld a, c
	and $f
	ld b, a
	ld c, 0
	dec a
	jr z, .two
	dec a
	jr z, .two
	dec a
	jr z, .three
	dec a
	jr z, .four
	dec a
	jr z, .five
	dec a
	jr z, .six

; seven
	ld a, 1000000 / $10000 % $100
	ldh [hPrintNum5], a
	ld a, 1000000 / $100 % $100
	ldh [hPrintNum6], a
	ld a, 1000000 % $100
	ldh [hPrintNum7], a
	call .PrintDigit
	call .AdvancePointer

.six
	ld a, 100000 / $10000 % $100
	ldh [hPrintNum5], a
	ld a, 100000 / $100 % $100
	ldh [hPrintNum6], a
	ld a, 100000 % $100
	ldh [hPrintNum7], a
	call .PrintDigit
	call .AdvancePointer

.five
	xor a
	ldh [hPrintNum5], a
	ld a, 10000 / $100
	ldh [hPrintNum6], a
	ld a, 10000 % $100
	ldh [hPrintNum7], a
	call .PrintDigit
	call .AdvancePointer

.four
	xor a
	ldh [hPrintNum5], a
	ld a, 1000 / $100
	ldh [hPrintNum6], a
	ld a, 1000 % $100
	ldh [hPrintNum7], a
	call .PrintDigit
	call .AdvancePointer

.three
	xor a
	ldh [hPrintNum5], a
	xor a
	ldh [hPrintNum6], a
	ld a, 100
	ldh [hPrintNum7], a
	call .PrintDigit
	call .AdvancePointer

.two
	dec e
	jr nz, .two_skip
	ld a, "0"
	ldh [hPrintNum1], a
.two_skip

	ld c, 0
	ldh a, [hPrintNum4]
	jr .handleLoop
.mod_10
	sub 10
	inc c
.handleLoop
	cp 10
	jr nc, .mod_10
.modded_10

	ld b, a
	ldh a, [hPrintNum1]
	or c
	jr nz, .money
	call .PrintLeadingZero
	jr .money_leading_zero

.money
	call .PrintYen
	push af
	ld a, "0"
	add c
	ld [hl], a
	pop af
	ldh [hPrintNum1], a
	inc e
	dec e
	jr nz, .money_leading_zero
	inc hl
	ld [hl], "."

.money_leading_zero
	call .AdvancePointer
	call .PrintYen
	ld a, "0"
	add b
	ld [hli], a

	pop de
	pop bc
	ret

.PrintYen: ; c5ba
	push af
	ldh a, [hPrintNum1]
	and a
	jr nz, .stop
	bit PRINTNUM_MONEY_F, d
	jr z, .stop
	ld a, "¥"
	ld [hli], a
	res 5, d

.stop
	pop af
	ret

.PrintDigit: ; c5cb (3:45cb)
	dec e
	jr nz, .ok
	ld a, "0"
	ldh [hPrintNum1], a
.ok
	ld c, 0
.loop
	ldh a, [hPrintNum5]
	ld b, a
	ldh a, [hPrintNum2]
	ldh [hPrintNum8], a
	cp b
	jr c, .skip1
	sub b
	ldh [hPrintNum2], a
	ldh a, [hPrintNum6]
	ld b, a
	ldh a, [hPrintNum3]
	ldh [hPrintNum9], a
	cp b
	jr nc, .skip2
	ldh a, [hPrintNum2]
	and a
	jr z, .skip3
	dec a
	ldh [hPrintNum2], a
	ldh a, [hPrintNum3]
.skip2
	sub b
	ldh [hPrintNum3], a
	ldh a, [hPrintNum7]
	ld b, a
	ldh a, [hPrintNum4]
	ldh [hPrintNum10], a
	cp b
	jr nc, .skip4
	ldh a, [hPrintNum3]
	and a
	jr nz, .skip5
	ldh a, [hPrintNum2]
	and a
	jr z, .skip6
	dec a
	ldh [hPrintNum2], a
	xor a
.skip5
	dec a
	ldh [hPrintNum3], a
	ldh a, [hPrintNum4]
.skip4
	sub b
	ldh [hPrintNum4], a
	inc c
	jr .loop
.skip6
	ldh a, [hPrintNum9]
	ldh [hPrintNum3], a
.skip3
	ldh a, [hPrintNum8]
	ldh [hPrintNum2], a
.skip1
	ldh a, [hPrintNum1]
	or c
	jr z, .PrintLeadingZero
	ldh a, [hPrintNum1]
	and a
	jr nz, .done
	bit PRINTNUM_MONEY_F, d
	jr z, .done
	ld a, "¥"
	ld [hli], a
	res 5, d
.done
	ld a, "0"
	add c
	ld [hl], a
	ldh [hPrintNum1], a
	inc e
	dec e
	ret nz
	inc hl
	ld [hl], "."
	ret

.PrintLeadingZero: ; c644
; prints a leading zero unless they are turned off in the flags
	bit PRINTNUM_LEADINGZEROS_F, d ; print leading zeroes?
	ret z
	ld [hl], "0"
	ret

.AdvancePointer: ; c64a
; increments the pointer unless leading zeroes are not being printed,
; the number is left-aligned, and no nonzero digits have been printed yet
	bit PRINTNUM_LEADINGZEROS_F, d ; print leading zeroes?
	jr nz, .inc
	bit PRINTNUM_LEFTALIGN_F, d ; left alignment or right alignment?
	jr z, .inc
	ldh a, [hPrintNum1]
	and a
	ret z
.inc
	inc hl
	ret
