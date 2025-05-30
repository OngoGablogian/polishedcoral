PlayStereoCry:: ; 37b6
	push af
	ld a, 1
	ld [wStereoPanningMask], a
	pop af
	call _PlayCry
	jp WaitSFX
; 37c4

PlayStereoCry2:: ; 37c4
; Don't wait for the cry to end.
; Used during pic animations.
	push af
	ld a, 1
	ld [wStereoPanningMask], a
	pop af
	jr _PlayCry
; 37ce

PlayCry:: ; 37ce
	call PlayCry2
	jp WaitSFX
; 37d5

PlayCry2:: ; 37d5
; Don't wait for the cry to end.
	push af
	xor a
	ld [wStereoPanningMask], a
	ld [wCryTracks], a
	pop af
	; fallthrough

_PlayCry:: ; 37e2
	push bc
	push de
	push hl

	call GetCryIndex
;	jr c, .done

;	ld e, c
;	ld d, b
;	call PlayCryHeader

;.done
	call nc, PlayCryHeader
PlayCry_PopBCDEHLOff::
	jp HomePopHlDeBc
; 37f3

LoadCryHeader:: ; 37f3
; Load cry header bc.

	call GetCryIndex
	ret c

	ldh a, [hROMBank]
	push af
	ld a, BANK(CryHeaders)
	rst Bankswitch

;	ld hl, CryHeaders
;rept 6
;	add hl, bc
;endr

;	ld e, [hl]
;	inc hl
;	ld d, [hl]
;	inc hl
	ld a, [hli]
	cp $ff
	jr z, .ded
	
	ld d, 0
	ld e, a
	
	ld a, [hli]
	ld [wCryPitch], a
	ld a, [hli]
	ld [wCryPitch + 1], a
	ld a, [hli]
	ld [wCryLength], a
	ld a, [hl]
	ld [wCryLength + 1], a

	pop af
	rst Bankswitch
	and a
	ret
	
.ded
	call LoadDEDCryHeader
	pop af
	rst Bankswitch
	scf
	ret
; 381e

GetCryIndex:: ; 381e
	and a
	jr z, .no
	cp EGG
	jr z, .no
	cp NUM_POKEMON + 1
	jr nc, .no

	dec a
	ld c, a
	ld b, 0
	ld a, BANK(wExtendedSpace)
	ld hl, wExtendedSpace
	call GetFarWRAMByte
	; value is now in a
	cp 0
	jr z, .no_extended_space
	ld hl, CryHeaders
	jr .cont
.no_extended_space
	ld hl, CryHeaders2
.cont
	ld a, 5
	rst AddNTimes
	and a
	ret

.no
	scf
	ret
	
	
	

	
; 382d
