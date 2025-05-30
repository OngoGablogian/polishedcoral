FarDeinitBattleAnimation:
	farjp DeinitBattleAnimation

FarReinitBattleAnimFrameset:
	farjp ReinitBattleAnimFrameset

DoBattleAnimFrame: ; ccfbe
	ld hl, BATTLEANIMSTRUCT_FUNCTION
	add hl, bc
	ld e, [hl]
	ld d, 0
	ld hl, .Jumptable
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl
; ccfce

.Jumptable:
	dw BattleAnimFunction_Null ; 00
	dw BattleAnimFunction_MoveFromUserToTarget ; 01
	dw BattleAnimFunction_MoveFromUserToTargetAndDisappear ; 02
	dw BattleAnimFunction_MoveInCircle ; 03
	dw BattleAnimFunction_MoveWaveToTarget ; 04
	dw BattleAnimFunction_ThrowFromUserToTarget ; 05
	dw BattleAnimFunction_ThrowFromUserToTargetAndDisappear ; 06
	dw BattleAnimFunction_Drop ; 07
	dw BattleAnimFunction_MoveFromUserToTargetSpinAround ; 08
	dw BattleAnimFunction_Shake ; 09
	dw BattleAnimFunction_FireBlast ; 0a
	dw BattleAnimFunction_RazorLeaf ; 0b
	dw BattleAnimFunction_Bubble ; 0c
	dw BattleAnimFunction_Surf ; 0d
	dw BattleAnimFunction_Sing ; 0e
	dw BattleAnimFunction_WaterGun ; 0f
	dw BattleAnimFunction_Ember ; 10
	dw BattleAnimFunction_Powder ; 11
	dw BattleAnimFunction_PokeBall ; 12
	dw BattleAnimFunction_PokeBallBlocked ; 13
	dw BattleAnimFunction_14 ; 14
	dw BattleAnimFunction_15 ; 15
	dw BattleAnimFunction_16 ; 16
	dw BattleAnimFunction_17 ; 17
	dw BattleAnimFunction_18 ; 18
	dw BattleAnimFunction_19 ; 19
	dw BattleAnimFunction_1A ; 1a
	dw BattleAnimFunction_1B ; 1b
	dw BattleAnimFunction_1C ; 1c
	dw BattleAnimFunction_1D ; 1d
	dw BattleAnimFunction_MoveUp ; 1e
	dw BattleAnimFunction_1F ; 1f
	dw BattleAnimFunction_LeechSeed ; 20
	dw BattleAnimFunction_21 ; 21
	dw BattleAnimFunction_22 ; 22
	dw BattleAnimFunction_23 ; 23
	dw BattleAnimFunction_24 ; 24
	dw BattleAnimFunction_25 ; 25
	dw BattleAnimFunction_26 ; 26
	dw BattleAnimFunction_27 ; 27
	dw BattleAnimFunction_28 ; 28
	dw BattleAnimFunction_SpiralDescent ; 29
	dw BattleAnimFunction_PoisonGas ; 2a
	dw BattleAnimFunction_Horn ; 2b
	dw BattleAnimFunction_2C ; 2c
	dw BattleAnimFunction_2D ; 2d
	dw BattleAnimFunction_2E ; 2e
	dw BattleAnimFunction_2F ; 2f
	dw BattleAnimFunction_30 ; 30
	dw BattleAnimFunction_31 ; 31
	dw BattleAnimFunction_32 ; 32
	dw BattleAnimFunction_33 ; 33
	dw BattleAnimFunction_SmokeFlameWheel ; 34
	dw BattleAnimFunction_35 ; 35
	dw BattleAnimFunction_StrengthSeismicToss ; 36
	dw BattleAnimFunction_37 ; 37
	dw BattleAnimFunction_Sludge ; 38
	dw BattleAnimFunction_39 ; 39
	dw BattleAnimFunction_3A ; 3a
	dw BattleAnimFunction_Agility ; 3b
	dw BattleAnimFunction_SacredFire ; 3c
	dw BattleAnimFunction_3D ; 3d
	dw BattleAnimFunction_3E ; 3e
	dw BattleAnimFunction_3F ; 3f
	dw BattleAnimFunction_40 ; 40
	dw BattleAnimFunction_41 ; 41
	dw BattleAnimFunction_42 ; 42
	dw BattleAnimFunction_43 ; 43
	dw BattleAnimFunction_44 ; 44
	dw BattleAnimFunction_HiddenPower ; 45
	dw BattleAnimFunction_46 ; 46
	dw BattleAnimFunction_47 ; 47
	dw BattleAnimFunction_48 ; 48
	dw BattleAnimFunction_49 ; 49
	dw BattleAnimFunction_4A ; 4a
	dw BattleAnimFunction_4B ; 4b
	dw BattleAnimFunction_4C ; 4c
	dw BattleAnimFunction_4D ; 4d
	dw BattleAnimFunction_RockSmash ; 4e
	dw BattleAnimFunction_4F ; 4f
	dw BattleAnimFunction_50
	dw BattleAnimFunction_52
	dw BattleAnimFunction_54
	dw BattleAnimFunction_55
	dw BattleAnimFunction_57
	dw BattleAnimFunction_58
	dw BattleAnimFunction_5d
	dw BattleAnimFunction_RadialMoveOut
	dw BattleAnimFunction_RadialMoveOut_Slow
	dw BattleAnimFunction_FallAndStop
	dw BattleAnimFunction_RadialMoveIn_Slow_Stay
	dw BattleAnimFunction_RadialMoveOut_Delay
	dw BattleAnimFunction_RadialMoveOut_CP_BG
	dw BattleAnimFunction_RadialMoveOut_Fast
	dw BattleAnimFunction_BubbleSplash
	dw BattleAnimFunction_LastResort
	dw BattleAnimFunction_Roost
	dw BattleAnimFunction_RadialMoveIn
	dw BattleAnimFunction_DarkPulse
	dw BattleAnimFunction_RadialMoveOut_Spore
	dw BattleAnimFunction_RadialMoveOut_VerySlow
	dw BattleAnimFunction_SpiralDescent_Fast
	dw BattleAnimFunction_HiddenPower_Fast

BattleAnimFunction_Null: ; cd06e (33:506e)
	call BattleAnim_AnonJumptable
.anon_dw
	dw DoNothingFunction
	dw .one
.one
	call FarDeinitBattleAnimation
DoNothingFunction:
	ret

BattleAnimFunction_ThrowFromUserToTargetAndDisappear: ; cd079 (33:5079)
	call BattleAnimFunction_ThrowFromUserToTarget
	ret c
	jp FarDeinitBattleAnimation

BattleAnimFunction_ThrowFromUserToTarget: ; cd081 (33:5081)
	; If x coord at $88 or beyond, abort.
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $88
	ret nc
	; Move right 2 pixels
	add $2
	ld [hl], a
	; Move down 1 pixel
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	dec [hl]
	; Decrease ??? and hold onto its previous value (argument of the sine function)
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	dec [hl]
	; Get ???, which is the amplitude of the sine function
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld d, [hl]
	call Sine
	; Store the result in the Y offset
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	; Carry flag denotes success
	scf
	ret

BattleAnimFunction_MoveWaveToTarget: ; cd0a6 (33:50a6)
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $88
	jr c, .asm_cd0b3
	jp FarDeinitBattleAnimation

.asm_cd0b3
	add $2
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	dec [hl]
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
rept 4
	inc [hl]
endr
	ld d, $10
	push af
	push de
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	sra a
	sra a
	sra a
	sra a
	ld [hl], a
	ret

BattleAnimFunction_MoveInCircle: ; cd0e3 (33:50e3)
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
.zero
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	bit 7, [hl]
	ld a, 0 ; not xor a; preserve carry flag?
	jr z, .asm_cd0f9
	ld a, $20
.asm_cd0f9
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $7f
	ld [hl], a
.one
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld d, [hl]
	push af
	push de
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	inc [hl]
	ret

BattleAnimFunction_MoveFromUserToTarget: ; cd12a (33:512a)
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
.one
	jp FarDeinitBattleAnimation

.zero
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $84
	ret nc
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	jp Functionce70a

BattleAnimFunction_MoveFromUserToTargetAndDisappear: ; cd146 (33:5146)
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $84
	jr nc, .asm_cd158
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	jp Functionce70a

.asm_cd158
	jp FarDeinitBattleAnimation

BattleAnimFunction_PokeBall: ; cd15c (33:515c)
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw DoNothingFunction
	dw .three
	dw .four
	dw DoNothingFunction
	dw .six
	dw .seven
	dw .eight
	dw DoNothingFunction
	dw .ten
	dw .eleven
.zero ; init
	call GetBallAnimPal
	jp BattleAnim_IncAnonJumptableIndex

.one
	call BattleAnimFunction_ThrowFromUserToTarget
	ret c
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	add [hl]
	ld [hl], a
	ld a, BATTLEANIMFRAMESET_POKE_BALL_3
	call FarReinitBattleAnimFrameset
	jp BattleAnim_IncAnonJumptableIndex

.three
	call BattleAnim_IncAnonJumptableIndex
	ld a, BATTLEANIMFRAMESET_POKE_BALL_1
	call FarReinitBattleAnimFrameset
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $0
	inc hl
	ld [hl], $10
.four
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	dec a
	ld [hl], a
	and $1f
	ret nz
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	sub $4
	ld [hl], a
	ret nz
	ld a, BATTLEANIMFRAMESET_POKE_BALL_4
	call FarReinitBattleAnimFrameset
	jp BattleAnim_IncAnonJumptableIndex

.six
	ld a, BATTLEANIMFRAMESET_POKE_BALL_5
	call FarReinitBattleAnimFrameset
	ld hl, BATTLEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	dec [hl]
	ret

.seven
	call GetBallAnimPal
	ld a, BATTLEANIMFRAMESET_POKE_BALL_2
	call FarReinitBattleAnimFrameset
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], $20
.eight
.ten
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	dec a
	ld [hl], a
	and $1f
	jr z, .eleven
	and $f
	ret nz
	jp BattleAnim_IncAnonJumptableIndex

.eleven
	jp FarDeinitBattleAnimation

BattleAnimFunction_PokeBallBlocked: ; cd212 (33:5212)
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw .two
.zero
	call GetBallAnimPal
	jp BattleAnim_IncAnonJumptableIndex

.one
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $70
	jr nc, .next
	jp BattleAnimFunction_ThrowFromUserToTarget

.next
	call BattleAnim_IncAnonJumptableIndex
.two
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	cp $80
	jr nc, .done
	add $4
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	dec [hl]
	dec [hl]
	ret

.done
	jp FarDeinitBattleAnimation

GetBallAnimPal: ; cd249 (33:5249)
	ld hl, BATTLEANIMSTRUCT_PALETTE
	add hl, bc
	ld [hl], PAL_BATTLE_OB_RED
	ret

BattleAnimFunction_Ember: ; cd284 (33:5284)
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw .two
	dw .three
	dw .four
.zero
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	swap a
	and $f
	ld hl, BATTLEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld [hl], a
	ret

.one
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $88
	ret nc
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	jp Functionce70a

.two
	jp FarDeinitBattleAnimation

.three
	call BattleAnim_IncAnonJumptableIndex
	ld a, BATTLEANIMFRAMESET_FLAMETHROWER
	call FarReinitBattleAnimFrameset
.four
	ret

BattleAnimFunction_Drop: ; cd2be (33:52be)
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
.zero
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $30
	inc hl
	ld [hl], $48
.one
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	inc [hl]
	ld a, [hl]
	and $3f
	ret nz
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $20
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	sub [hl]
	jr z, .done
	jr c, .done
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], a
	ret

.done
	jp FarDeinitBattleAnimation

BattleAnimFunction_MoveFromUserToTargetSpinAround: ; cd306 (33:5306)
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw .two
	dw .three
.zero
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $80
	jr nc, .next
	jp .SetCoords

.next
	call BattleAnim_IncAnonJumptableIndex
.one
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $0
.two
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	cp $40
	jr nc, .loop_back
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	ld d, $18
	call Cosine
	sub $18
	sra a
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	ld d, $18
	call Sine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $f
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	add [hl]
	ld [hl], a
	ret

.loop_back
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $f0
	jr z, .finish
	sub $10
	ld d, a
	ld a, [hl]
	and $f
	or d
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	dec [hl]
	ret

.finish
	call BattleAnim_IncAnonJumptableIndex
.three
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $b0
	jp nc, FarDeinitBattleAnimation

.SetCoords:
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $f
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	add [hl]
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $f
	ld e, a
	srl e
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
.loop
	dec [hl]
	dec e
	jr nz, .loop
	ret

BattleAnimFunction_Shake: ; cd3ae (33:53ae)
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw .two
.zero
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $0
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $f
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
.one
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	and a
	jr z, .done_one
	dec [hl]
	ret

.done_one
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	swap a
	and $f
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld a, [hl]
	cpl
	inc a
	ld [hl], a
	ret

.two
	jp FarDeinitBattleAnimation

BattleAnimFunction_FireBlast: ; cd3f2 (33:53f2)
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw .two
	dw .three
	dw .four
	dw .five
	dw DoNothingFunction
	dw .seven
	dw .eight
	dw FarDeinitBattleAnimation
.zero
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld [hl], a
	cp $7
	jr z, .seven
	ld a, BATTLEANIMFRAMESET_BURNED
	jp FarReinitBattleAnimFrameset

.seven
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $88
	jr nc, .set_up_eight
	add $2
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	dec [hl]
	ret

.set_up_eight
	call BattleAnim_IncAnonJumptableIndex
	ld a, BATTLEANIMFRAMESET_EMBER
	call FarReinitBattleAnimFrameset
.eight
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	ld d, $10
	push af
	push de
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	inc [hl]
	ret

.one
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	dec [hl]
	ret

.four
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	inc [hl]
.two
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	dec [hl]
	ret

.five
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	inc [hl]
.three
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	inc [hl]
	ret

BattleAnimFunction_RazorLeaf: ; cd478 (33:5478)
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw .two
	dw .three
	dw .four
	dw .five
	dw .six
	dw .seven
	dw .eight
.zero
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $40
.one
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	cp $30
	jr nc, .sine_cosine
	call BattleAnim_IncAnonJumptableIndex
	xor a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hli], a
	ld [hl], a
	ld a, BATTLEANIMFRAMESET_RAZOR_LEAF_2
	call FarReinitBattleAnimFrameset
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	bit 6, [hl]
	ret z
	ld hl, BATTLEANIMSTRUCT_FRAME
	add hl, bc
	ld [hl], $5
	ret

.sine_cosine
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $3f
	ld d, a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	dec [hl]
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	call Functioncd557
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld h, [hl]
	ld l, a
	add hl, de
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hl], d
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], e
	ret

.two
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	cp $20
	jr nz, .sine_cosine_2
	jp FarDeinitBattleAnimation

.sine_cosine_2
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	ld d, $10
	call Sine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	bit 6, [hl]
	jr nz, .decrease
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	inc [hl]
	jr .finish

.decrease
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	dec [hl]
.finish
	ld de, $80
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld h, [hl]
	ld l, a
	add hl, de
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], d
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], e
	ret

.three
	ld a, BATTLEANIMFRAMESET_RAZOR_LEAF_1
	call FarReinitBattleAnimFrameset
	ld hl, BATTLEANIMSTRUCT_01
	add hl, bc
	res 5, [hl]
.four
.five
.six
.seven
	jp BattleAnim_IncAnonJumptableIndex

.eight
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $c0
	ret nc
	ld a, $8
	jp Functionce70a

Functioncd557: ; cd557 (33:5557)
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	bit 7, a
	jr nz, .negative
	cp $20
	jr nc, .plus_256
	cp $18
	jr nc, .plus_384
	ld de, $200
	ret

.plus_384
	ld de, $180
	ret

.plus_256
	ld de, $100
	ret

.negative
	and $3f
	cp $20
	jr nc, .minus_256
	cp $18
	jr nc, .minus_384
	ld de, -$200
	ret

.minus_384
	ld de, -$180
	ret

.minus_256
	ld de, -$100
	ret

BattleAnimFunction_54:
	call BattleAnim_AnonJumptable

	dw BattleAnimFunction_54_2.after_frameset
	dw BattleAnimFunction_54_2.one

BattleAnimFunction_54_2:
	call BattleAnim_AnonJumptable

	dw .zero
	dw .one

.zero
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $40
	rlca
	rlca
	add $19
	ld hl, BATTLEANIMSTRUCT_FRAMESET_ID
	add hl, bc
	ld [hl], a
.after_frameset
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $40
.one
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	cp $30
	jp c, FarDeinitBattleAnimation
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $3f
	ld d, a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	dec [hl]
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	call Functioncd557
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld h, [hl]
	ld l, a
	add hl, de
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hl], d
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], e
	ret

BattleAnimFunction_BubbleSplash:
	call BattleAnim_AnonJumptable

	dw BattleAnimFunction_RockSmash.after_frameset
	dw BattleAnimFunction_RockSmash.one

BattleAnimFunction_RockSmash: ; cd58a (33:558a)
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
.zero
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $40
	rlca
	rlca
	add $19
	ld hl, BATTLEANIMSTRUCT_FRAMESET_ID
	add hl, bc
	ld [hl], a
.after_frameset
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $40
.one
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	cp $30
	jr nc, .sine_cosine
	jp FarDeinitBattleAnimation

.sine_cosine
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $3f
	ld d, a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	dec [hl]
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	call Functioncd557
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld h, [hl]
	ld l, a
	add hl, de
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hl], d
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], e
	ret

BattleAnimFunction_Bubble: ; cd5e9 (33:55e9)
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw .two
.zero
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $c
.one
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	and a
	jr z, .next
	dec [hl]
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	jp Functionce70a

.next
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $0
	ld a, BATTLEANIMFRAMESET_PULSING_BUBBLE
	call FarReinitBattleAnimFrameset
.two
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $98
	jr nc, .okay
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld h, [hl]
	ld l, a
	ld de, $60
	add hl, de
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], e
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hl], d
.okay
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	cp $20
	ret c
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $f0
	ld e, a
	ld d, $ff
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld h, [hl]
	ld l, a
	add hl, de
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], e
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld [hl], d
	ret

BattleAnimFunction_Surf: ; cd66a (33:566a)
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw DoNothingFunction
	dw .three
	dw .four
.zero
	call BattleAnim_IncAnonJumptableIndex
	ld a, rSCY - $ff00
	ld [hLCDCPointer], a
	ld a, $58
	ld [hLYOverrideStart], a
	ld a, $5e
	ld [hLYOverrideEnd], a
	ret

.one
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld e, [hl]
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	cp e
	jr nc, .move
	call BattleAnim_IncAnonJumptableIndex
	xor a
	ld [hLYOverrideStart], a
	ret

.move
	dec a
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	ld d, $10
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	add [hl]
	sub $10
	ret c
	ld [hLYOverrideStart], a
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld a, [hl]
	inc a
	and $7
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	inc [hl]
	inc [hl]
	ret

.three
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	cp $70
	jr c, asm_cd6da
	xor a
	ld [hLCDCPointer], a
	ld [hLYOverrideStart], a
	ld [hLYOverrideEnd], a
.four
	jp FarDeinitBattleAnimation

asm_cd6da: ; cd6da (33:56da)
	inc a
	inc a
	ld [hl], a
	sub $10
	ret c
	ld [hLYOverrideStart], a
	ret

BattleAnimFunction_Sing: ; cd6e3 (33:56e3)
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functioncd6ea
	dw Functioncd6f7
Functioncd6ea: ; cd6ea (33:56ea)
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, BATTLEANIMFRAMESET_MUSIC_NOTE_1
	add [hl] ; offset
	call FarReinitBattleAnimFrameset
Functioncd6f7: ; cd6f7 (33:56f7)
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $b8
	jr c, .asm_cd704
	jp FarDeinitBattleAnimation

.asm_cd704
	ld a, $2
	call Functionce70a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	dec [hl]
	ld d, $8
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ret

BattleAnimFunction_WaterGun: ; cd71a (33:571a)
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw .two
	dw DoNothingFunction

.zero:
	call BattleAnim_IncAnonJumptableIndex
.one:
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	cp $30
	jr c, .run_down
	ld a, $2
	call Functionce70a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	dec [hl]
	ld d, $8
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ret

.run_down
	call BattleAnim_IncAnonJumptableIndex
	ld a, BATTLEANIMFRAMESET_WATER_GUN_2
	call FarReinitBattleAnimFrameset
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], $0
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld [hl], $30
	ld hl, BATTLEANIMSTRUCT_01
	add hl, bc
	ld a, [hl]
	and $1
	ld [hl], a
.two:
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	cp $10
	jr nc, .splash
	inc [hl]
	ret

.splash
	call BattleAnim_IncAnonJumptableIndex
	ld a, BATTLEANIMFRAMESET_WATER_GUN_3
	jp FarReinitBattleAnimFrameset

BattleAnimFunction_Powder: ; cd777 (33:5777)
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	cp $38
	jr c, .asm_cd784
	jp FarDeinitBattleAnimation

.asm_cd784
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld l, [hl]
	ld h, a
	ld de, $80
	add hl, de
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], e
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], d
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld a, [hl]
	xor $10
	ld [hl], a
	ret

BattleAnimFunction_14: ; cd7a4 (33:57a4)
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functioncd7ab
	dw Functioncd7d2
Functioncd7ab: ; cd7ab (33:57ab)
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $f0
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $f
	sla a
	sla a
	sla a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld [hl], $1
Functioncd7d2: ; cd7d2 (33:57d2)
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	and a
	jr nz, .asm_cd7de
	jp FarDeinitBattleAnimation

.asm_cd7de
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	inc [hl]
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld d, [hl]
	push af
	push de
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	xor $1
	ld [hl], a
	ret z
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	dec [hl]
	ret

BattleAnimFunction_15: ; cd80c (33:580c)
	call BattleAnim_AnonJumptable
.anon_dw
	dw DoNothingFunction
	dw .one
	dw DoNothingFunction
	dw FarDeinitBattleAnimation

.one
	call BattleAnim_IncAnonJumptableIndex
	ld a, BATTLEANIMFRAMESET_THUNDER_WAVE_EXTRA
	jp FarReinitBattleAnimFrameset

BattleAnimFunction_16: ; cd824 (33:5824)
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functioncd835
	dw Functioncd860
	dw Functioncd88f
	dw Functioncd88f
	dw Functioncd88f
	dw Functioncd88f
	dw Functioncd893
Functioncd835: ; cd835 (33:5835)
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_FRAMESET_ID
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	bit 7, [hl]
	jr nz, .asm_cd852
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $10
	jr .asm_cd858

.asm_cd852
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $30
.asm_cd858
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $7f
	ld [hl], a
Functioncd860: ; cd860 (33:5860)
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld d, [hl]
	call Sine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	bit 7, a
	jr nz, .load_no_inc
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	inc a
	jr .reinit

.load_no_inc
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
.reinit
	call FarReinitBattleAnimFrameset
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	inc [hl]
	ld a, [hl]
	and $1f
	ret nz
Functioncd88f: ; cd88f (33:588f)
	jp BattleAnim_IncAnonJumptableIndex

Functioncd893: ; cd893 (33:5893)
	ld hl, BATTLEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld [hl], $1
	ret

BattleAnimFunction_17: ; cd89a (33:589a)
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functioncd8ab
	dw Functioncd8cc
	dw Functioncd8f5
	dw Functioncd8f5
	dw Functioncd8f5
	dw Functioncd8f5
	dw Functioncd8f9
Functioncd8ab: ; cd8ab (33:58ab)
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	bit 7, [hl]
	jr nz, .asm_cd8be
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $10
	jr .asm_cd8c4

.asm_cd8be
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $30
.asm_cd8c4
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $7f
	ld [hl], a
Functioncd8cc: ; cd8cc (33:58cc)
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld d, [hl]
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	bit 7, a
	jr nz, .asm_cd8e6
	ld a, $3d
	jr .asm_cd8e8

.asm_cd8e6
	ld a, $3c
.asm_cd8e8
	call FarReinitBattleAnimFrameset
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	inc [hl]
	inc [hl]
	ld a, [hl]
	and $1f
	ret nz
Functioncd8f5: ; cd8f5 (33:58f5)
	jp BattleAnim_IncAnonJumptableIndex

Functioncd8f9: ; cd8f9 (33:58f9)
	ld hl, BATTLEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld [hl], $1
	ret

BattleAnimFunction_18: ; cd900 (33:5900)
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functioncd907
	dw Functioncd913
Functioncd907: ; cd907 (33:5907)
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $28
	inc hl
	ld [hl], $0
Functioncd913: ; cd913 (33:5913)
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld d, [hl]
	push af
	push de
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	and a
	jr z, .asm_cd950
	ld d, a
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld e, [hl]
	ld hl, hPushOAM ; $ff80
	add hl, de
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], e
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], d
	ret

.asm_cd950
	jp FarDeinitBattleAnimation

BattleAnimFunction_19: ; cd954 (33:5954)
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functioncd961
	dw Functioncd96a
	dw Functioncd96e
	dw Functioncd96a
	dw Functioncd97b
Functioncd961: ; cd961 (33:5961)
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld [hl], $0
Functioncd96a: ; cd96a (33:596a)
	jp Functioncd99a

Functioncd96e: ; cd96e (33:596e)
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $88
	jr c, asm_cd988
	jp BattleAnim_IncAnonJumptableIndex

Functioncd97b: ; cd97b (33:597b)
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $b8
	jr c, asm_cd988
	jp FarDeinitBattleAnimation

asm_cd988: ; cd988 (33:5988)
	call Functioncd99a
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	inc [hl]
	ld a, [hl]
	and $1
	ret nz
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	dec [hl]
	ret

Functioncd99a: ; cd99a (33:599a)
	call Functioncd9f4
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	push af
	push de
	call Sine
	sra a
	sra a
	sra a
	sra a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	add [hl]
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	sub $8
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and a
	jr z, .asm_cd9d7
	cp $c2
	jr c, .asm_cd9e2
.asm_cd9d7
	dec a
	ld [hl], a
	and $7
	ret nz
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	inc [hl]
	ret

.asm_cd9e2
	xor a
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hli], a
	ld [hl], a
	ret

Functioncd9f4: ; cd9f4 (33:59f4)
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld e, [hl]
	ld d, 0
	ld hl, Unknown_cda01
	add hl, de
	ld d, [hl]
	ret

; cda01 (33:5a01)
Unknown_cda01: ; cda01
	db 8, 6, 5, 4, 5, 6, 8, 12, 16
; cda0a
BattleAnimFunction_1C: ; cda0a (33:5a0a)
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $30
	jr nc, .asm_cda17
	jp FarDeinitBattleAnimation

.asm_cda17
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $f
	ld e, a
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	sub e
	ld [hl], a
	srl e
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
.asm_cda2c
	inc [hl]
	dec e
	jr nz, .asm_cda2c
	ret

BattleAnimFunction_1F: ; cda31 (33:5a31)
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functioncda4c
	dw Functioncda3a
	dw Functioncda4c
Functioncda3a: ; cda3a (33:5a3a)
	ld hl, BATTLEANIMSTRUCT_FRAMESET_ID
	add hl, bc
	ld a, [hl]
	inc a
	call FarReinitBattleAnimFrameset
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $8
Functioncda4c: ; cda4c (33:5a4c)
	ret

BattleAnimFunction_LeechSeed: ; cda4d (33:5a4d)
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw .two
	dw .three

.zero: ; cda58 (33:5a58)
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], $40
	ret

.one: ; cda62 (33:5a62)
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	cp $20
	jr c, .sprout
	jp Functioncda8d

.sprout
	ld [hl], $40
	ld a, BATTLEANIMFRAMESET_LEECH_SEED_2
	call FarReinitBattleAnimFrameset
	jp BattleAnim_IncAnonJumptableIndex

.two: ; cda7a (33:5a7a)
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	and a
	jr z, .flutter
	dec [hl]
.three: ; cda8c (33:5a8c)
	ret

.flutter
	call BattleAnim_IncAnonJumptableIndex
	ld a, BATTLEANIMFRAMESET_LEECH_SEED_3
	jp FarReinitBattleAnimFrameset

Functioncda8d: ; cda8d (33:5a8d)
	dec [hl]
	ld d, $20
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_02
	add hl, bc
	ld a, [hl]
	add $2
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld e, [hl]
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld d, [hl]
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld h, [hl]
	ld a, h
	and $f
	swap a
	ld l, a
	ld a, h
	and $f0
	swap a
	ld h, a
	add hl, de
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], e
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hl], d
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	and $1
	ret nz
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	dec [hl]
	ret

BattleAnimFunction_3F: ; cdad6 (33:5ad6)
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functioncdadf
	dw Functioncdae9
	dw Functioncdaf9
Functioncdadf: ; cdadf (33:5adf)
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], $40
	ret

Functioncdae9: ; cdae9 (33:5ae9)
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	cp $20
	jr c, .asm_cdaf6
	jp Functioncda8d

.asm_cdaf6
	call BattleAnim_IncAnonJumptableIndex
Functioncdaf9: ; cdaf9 (33:5af9)
	ret

BattleAnimFunction_1A: ; cdafa (33:5afa)
	call BattleAnimFunction_MoveInCircle
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	add $f
	ld [hl], a
	ret

BattleAnimFunction_1B: ; cdb06 (33:5b06)
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functioncdb13
	dw Functioncdb14
	dw Functioncdb28
	dw Functioncdb50
	dw Functioncdb65
Functioncdb13: ; cdb13 (33:5b13)
	ret

Functioncdb14: ; cdb14 (33:5b14)
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	cp $30
	jr c, .asm_cdb24
	ld hl, BATTLEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld [hl], $0
	ret

.asm_cdb24
	add $4
	ld [hl], a
	ret

Functioncdb28: ; cdb28 (33:5b28)
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $98
	ret nc
	inc [hl]
	inc [hl]
	ld hl, BATTLEANIMSTRUCT_01
	add hl, bc
	set 0, [hl]
	ld hl, BATTLEANIMSTRUCT_02
	add hl, bc
	ld [hl], $90
	ld hl, BATTLEANIMSTRUCT_FRAME
	add hl, bc
	ld [hl], $0
	ld hl, BATTLEANIMSTRUCT_DURATION
	add hl, bc
	ld [hl], $2
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	dec [hl]
	ret

Functioncdb50: ; cdb50 (33:5b50)
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $2c
	ld hl, BATTLEANIMSTRUCT_FRAME
	add hl, bc
	ld [hl], $0
	ld hl, BATTLEANIMSTRUCT_DURATION
	add hl, bc
	ld [hl], $80
Functioncdb65: ; cdb65 (33:5b65)
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $98
	ret nc
	inc [hl]
	inc [hl]
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	inc [hl]
	ld d, $8
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ret

BattleAnimFunction_1D: ; cdb80 (33:5b80)
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functioncdb9f
	dw Functioncdbb3
	dw Functioncdbcf
	dw Functioncdbeb
	dw Functioncdc74
	dw Functioncdc1a
	dw Functioncdbc1
	dw Functioncdc1e
	dw Functioncdc27
	dw Functioncdc39
	dw Functioncdc74
	dw Functioncdc48
	dw Functioncdc57
	dw Functioncdc74
Functioncdb9f: ; cdb9f (33:5b9f)
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $28
	inc hl
	ld [hl], $10
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld [hl], a
	ret

Functioncdbb3: ; cdbb3 (33:5bb3)
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $40
	jr nc, .asm_cdbbd
	inc [hl]
.asm_cdbbd
	jp Functioncdc75

Functioncdbc1: ; cdbc1 (33:5bc1)
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $4b
	jr nc, .asm_cdbcb
	inc [hl]
.asm_cdbcb
	jp Functioncdc75

Functioncdbcf: ; cdbcf (33:5bcf)
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $88
	jr nc, .asm_cdbe6
	and $f
	jr nz, asm_cdbfa
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], $10
	jp BattleAnim_IncAnonJumptableIndex

.asm_cdbe6
	call BattleAnim_IncAnonJumptableIndex
	inc [hl]
	ret

Functioncdbeb: ; cdbeb (33:5beb)
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	and a
	jr z, .asm_cdbf5
	dec [hl]
	ret

.asm_cdbf5
	ld hl, BATTLEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	dec [hl]
asm_cdbfa: ; cdbfa (33:5bfa)
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	inc [hl]
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld d, [hl]
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld e, [hl]
	ld hl, hPushOAM ; $ff80
	add hl, de
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld [hl], d
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], e
	ret

Functioncdc1a: ; cdc1a (33:5c1a)
	jp FarDeinitBattleAnimation

Functioncdc1e: ; cdc1e (33:5c1e)
	ld a, BATTLEANIMFRAMESET_EGG_WOBBLE
	call FarReinitBattleAnimFrameset
	jp BattleAnim_IncAnonJumptableIndex

Functioncdc27: ; cdc27 (33:5c27)
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	inc [hl]
	inc [hl]
	ld d, $2
	call Sine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

Functioncdc39: ; cdc39 (33:5c39)
	ld a, BATTLEANIMFRAMESET_EGG_CRACKED_BOTTOM
	call FarReinitBattleAnimFrameset
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], $4
	jp BattleAnim_IncAnonJumptableIndex

Functioncdc48: ; cdc48 (33:5c48)
	ld a, BATTLEANIMFRAMESET_EGG_CRACKED_TOP
	call FarReinitBattleAnimFrameset
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $40
	ret

Functioncdc57: ; cdc57 (33:5c57)
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	ld d, $20
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	cp $30
	jr c, .asm_cdc71
	dec [hl]
	ret

.asm_cdc71
	call BattleAnim_IncAnonJumptableIndex
Functioncdc74: ; cdc74 (33:5c74)
	ret

Functioncdc75: ; cdc75 (33:5c75)
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	inc [hl]
	ld a, [hl]
	and $3f
	ret nz
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $20
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	sub $8
	ld [hl], a
	ret nz
	xor a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hli], a
	ld [hl], a
	jp BattleAnim_IncAnonJumptableIndex

BattleAnimFunction_MoveUp: ; cdca6 (33:5ca6)
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	and a
	jr z, .asm_cdcb6
	cp $d8
	jr nc, .asm_cdcb6
	jp FarDeinitBattleAnimation

.asm_cdcb6
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld d, [hl]
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	sub d
	ld [hl], a
	ret

BattleAnimFunction_21: ; cdcc3 (33:5cc3)
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functioncdcca
	dw Functioncdced
Functioncdcca: ; cdcca (33:5cca)
	ld a, [hBattleTurn]
	and a
	jr z, .asm_cdcd9
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	cpl
	add $3
	ld [hl], a
.asm_cdcd9
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $8
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, BATTLEANIMFRAMESET_SOUND_1
	add [hl]
	jp FarReinitBattleAnimFrameset

Functioncdced: ; cdced (33:5ced)
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	and a
	jr z, .asm_cdcfa
	dec [hl]
	jp Functioncdcfe

.asm_cdcfa
	jp FarDeinitBattleAnimation

Functioncdcfe: ; cdcfe (33:5cfe)
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	inc [hl]
	inc [hl]
	ld d, $10
	call Sine
	ld d, a
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and a
	jr z, .asm_cdd20
	dec a
	ret z
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], d
	ret

.asm_cdd20
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, d
	cpl
	inc a
	ld [hl], a
	ret

BattleAnimFunction_22: ; cdd2a (33:5d2a)
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functioncdd31
	dw Functioncdd4f
Functioncdd31: ; cdd31 (33:5d31)
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $3f
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $80
	rlca
	ld [hl], a
	add BATTLEANIMFRAMESET_CONFUSE_RAY_1
	jp FarReinitBattleAnimFrameset

Functioncdd4f: ; cdd4f (33:5d4f)
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	swap a
	ld d, a
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	inc [hl]
	push af
	push de
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $80
	ret nc
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	and $3
	jr nz, .asm_cdd87
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	dec [hl]
.asm_cdd87
	and $1
	ret nz
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	inc [hl]
	ret

BattleAnimFunction_23: ; cdd90 (33:5d90)
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functioncdd97
	dw Functioncddbc
Functioncdd97: ; cdd97 (33:5d97)
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_FRAMESET_ID
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $80
	rlca
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	add [hl]
	call FarReinitBattleAnimFrameset
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $7f
	ld [hl], a
Functioncddbc: ; cddbc (33:5dbc)
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld d, $10
	push af
	push de
	call Sine
	sra a
	sra a
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	inc [hl]
	and $3f
	jr z, .asm_cddf0
	and $1f
	ret nz
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	inc a
	jr .asm_cddf5

.asm_cddf0
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
.asm_cddf5
	jp FarReinitBattleAnimFrameset

BattleAnimFunction_24: ; cddf9 (33:5df9)
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functioncde02
	dw Functioncde20
	dw Functioncde21
Functioncde02: ; cde02 (33:5e02)
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	add BATTLEANIMFRAMESET_AMNESIA_1
	call FarReinitBattleAnimFrameset
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld e, [hl]
	ld d, 0
	ld hl, Unknown_cde25
	add hl, de
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
Functioncde20: ; cde20 (33:5e20)
	ret

Functioncde21: ; cde21 (33:5e21)
	jp FarDeinitBattleAnimation

; cde25 (33:5e25)
Unknown_cde25: ; cde25
	db $ec, $f8, $00
; cde28
BattleAnimFunction_25: ; cde28 (33:5e28)
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	inc [hl]
	inc [hl]
	ld d, $4
	call Sine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld d, [hl]
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld e, [hl]
	ld hl, $ffa0
	add hl, de
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], d
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], e
	ret

BattleAnimFunction_26: ; cde54 (33:5e54)
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	dec [hl]
	dec [hl]
	ld d, $10
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	inc [hl]
	ret

BattleAnimFunction_27: ; cde6b (33:5e6b)
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functioncde72
	dw Functioncde88
Functioncde72: ; cde72 (33:5e72)
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and a
	jr nz, .asm_cde83
	ld hl, BATTLEANIMSTRUCT_01
	add hl, bc
	set 6, [hl]
.asm_cde83
	add BATTLEANIMFRAMESET_STRING_SHOT_1
	call FarReinitBattleAnimFrameset
Functioncde88: ; cde88 (33:5e88)
	ret

BattleAnimFunction_28: ; cde89 (33:5e89)
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functioncde90
	dw Functioncdebf
Functioncde90: ; cde90 (33:5e90)
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $0
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld e, [hl]
	ld a, e
	and $70
	swap a
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld a, e
	and $80
	jr nz, .asm_cdeb2
	ld a, e
	and $f
	ld [hl], a
	ret

.asm_cdeb2
	ld a, e
	and $f
	cpl
	inc a
	ld [hl], a
	ld a, BATTLEANIMFRAMESET_PARALYZED_FLIPPED
	jp FarReinitBattleAnimFrameset

Functioncdebf: ; cdebf (33:5ebf)
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	and a
	jr z, .asm_cdec9
	dec [hl]
	ret

.asm_cdec9
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld a, [hl]
	cpl
	inc a
	ld [hl], a
	ret

BattleAnimFunction_SpiralDescent: ; cdedd (33:5edd)
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	ld d, $18
	push af
	push de
	call Sine
	sra a
	sra a
	sra a
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	add [hl]
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	inc [hl]
	ld a, [hl]
	and $7
	ret nz
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	cp $28
	jr nc, .delete
	inc [hl]
	ret

.delete
	jp FarDeinitBattleAnimation

BattleAnimFunction_2D: ; cdf1b (33:5f1b)
; Object moves downwards in a spiral around the user. Object disappears at y coord $30
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	ld d, $18
	push af
	push de
	call Sine
	sra a
	sra a
	sra a
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	add [hl]
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	inc [hl]
	ld a, [hl]
	and $3
	ret nz
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	cp $30
	jr nc, .end
	inc [hl]
	inc [hl]
	ret

.end
	call FarDeinitBattleAnimation
	ret

BattleAnimFunction_PoisonGas: ; cdf59 (33:5f59)
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functioncdf60
	dw BattleAnimFunction_SpiralDescent
Functioncdf60: ; cdf60 (33:5f60)
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $84
	jr nc, .next
	inc [hl]
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	inc [hl]
	ld d, $18
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	and $1
	ret nz
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	dec [hl]
	ret

.next
	jp BattleAnim_IncAnonJumptableIndex

BattleAnimFunction_SmokeFlameWheel: ; cdf8c (33:5f8c)
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld d, $18
	push af
	push de
	call Sine
	sra a
	sra a
	sra a
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	add [hl]
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	inc [hl]
	inc [hl]
	ld a, [hl]
	and $7
	ret nz
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	cp $e8
	jr z, .asm_cdfc7
	dec [hl]
	ret

.asm_cdfc7
	jp FarDeinitBattleAnimation

BattleAnimFunction_SacredFire: ; cdfcb (33:5fcb)
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld d, $18
	push af
	push de
	call Sine
	sra a
	sra a
	sra a
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	add [hl]
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	inc [hl]
	inc [hl]
	ld a, [hl]
	and $3
	ret nz
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	cp $d0
	jr z, .asm_ce007
	dec [hl]
	dec [hl]
	ret

.asm_ce007
	jp FarDeinitBattleAnimation

BattleAnimFunction_35: ; ce00b (33:600b)
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functionce014
	dw Functionce023
	dw Functionce05f
Functionce014: ; ce014 (33:6014)
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $34
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], $10
Functionce023: ; ce023 (33:6023)
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $6c
	jr c, .asm_ce02d
	ret

.asm_ce02d
	ld a, $2
	call Functionce70a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld d, [hl]
	call Sine
	bit 7, a
	jr nz, .asm_ce046
	cpl
	inc a
.asm_ce046
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	sub $4
	ld [hl], a
	and $1f
	cp $20
	ret nz
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	srl [hl]
	ret

Functionce05f: ; ce05f (33:605f)
	jp FarDeinitBattleAnimation

BattleAnimFunction_Horn: ; ce063 (33:6063)
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw .two
	dw Functionce09e

.zero: ; ce06e (33:606e)
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], a
	ret

.one: ; ce083 (33:6083)
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $58
	ret nc
	ld a, $2
	jp Functionce70a

.two: ; ce091 (33:6091)
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	cp $20
	jr c, Functionce09e
	jp FarDeinitBattleAnimation

Functionce09e: ; ce09e (33:609e)
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	ld d, $8
	call Sine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	sra a
	cpl
	inc a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	add [hl]
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	add $8
	ld [hl], a
	ret

BattleAnimFunction_2C: ; ce0c5 (33:60c5)
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functionce0ce
	dw Functionce0f8
	dw Functionce0dd
Functionce0ce: ; ce0ce (33:60ce)
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $f0
	swap a
	ld hl, BATTLEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld [hl], a
	ret

Functionce0dd: ; ce0dd (33:60dd)
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	ld d, $10
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	bit 7, a
	jr z, .asm_ce0f0
	ld [hl], a
.asm_ce0f0
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	sub $4
	ld [hl], a
Functionce0f8: ; ce0f8 (33:60f8)
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $84
	jr c, .asm_ce105
	jp FarDeinitBattleAnimation

.asm_ce105
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	jp Functionce70a

BattleAnimFunction_2E: ; ce10e (33:610e)
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functionce115
	dw Functionce12a
Functionce115: ; ce115 (33:6115)
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $28
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	sub $28
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], a
Functionce12a: ; ce12a (33:612a)
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	and [hl]
	jr nz, .asm_ce149
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	dec [hl]
.asm_ce149
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	inc [hl]
	ld a, [hl]
	and $3f
	ret nz
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $20
	inc hl
	srl [hl]
	ret

BattleAnimFunction_2F: ; ce15c (33:615c)
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld d, [hl]
	push af
	push de
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	inc [hl]
	ld a, [hl]
	and $1
	jr nz, .asm_ce189
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	dec [hl]
.asm_ce189
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $3
	jr nz, .asm_ce197
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	inc [hl]
.asm_ce197
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	cp $5a
	jr nc, .asm_ce1aa
	ld a, [hl]
	and a
	jr z, .asm_ce1ac
	dec [hl]
	ret

.asm_ce1aa
	inc [hl]
	ret

.asm_ce1ac
	jp FarDeinitBattleAnimation

BattleAnimFunction_42: ; ce1b0 (33:61b0)
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	inc [hl]
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld d, [hl]
	push af
	push de
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	inc [hl]
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	cp $40
	jr nc, .asm_ce1df
	inc [hl]
	ret

.asm_ce1df
	ld a, [hl]
	dec [hl]
	and a
	ret nz
	jp FarDeinitBattleAnimation

BattleAnimFunction_30: ; ce1e7 (33:61e7)
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functionce1ee
	dw Functionce1fb
Functionce1ee: ; ce1ee (33:61ee)
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], a
Functionce1fb: ; ce1fb (33:61fb)
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld d, $30
	call Sine
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	add [hl]
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	add $8
	ld d, $30
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	inc [hl]
	ret

BattleAnimFunction_31: ; ce226 (33:6226)
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functionce22d
	dw Functionce254
Functionce22d: ; ce22d (33:622d)
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld d, $10
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld d, $10
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld [hl], $f
Functionce254: ; ce254 (33:6254)
	ret

BattleAnimFunction_32: ; ce255 (33:6255)
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functionce260
	dw Functionce274
	dw Functionce278
	dw Functionce289
Functionce260: ; ce260 (33:6260)
	call BattleAnim_IncAnonJumptableIndex
	ld a, [hBattleTurn]
	and a
	jr nz, .asm_ce26c
	ld a, $f0
	jr .asm_ce26e

.asm_ce26c
	ld a, $cc
.asm_ce26e
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], a
	ret

Functionce274: ; ce274 (33:6274)
	jp Functionce29f

Functionce278: ; ce278 (33:6278)
	call Functionce29f
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $84
	ret nc
	ld a, $4
	jp Functionce70a

Functionce289: ; ce289 (33:6289)
	call Functionce29f
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $d0
	jr nc, .asm_ce29b
	ld a, $4
	jp Functionce70a

.asm_ce29b
	jp FarDeinitBattleAnimation

Functionce29f: ; ce29f (33:629f)
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	and $7
	inc [hl]
	srl a
	ld e, a
	ld d, $0
	ld hl, Unknown_ce2c4
	add hl, de
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	and [hl]
	ld [wOBP0], a
	ret
; ce2c4 (33:62c4)

Unknown_ce2c4: ; ce2c4
	db $ff, $aa, $55, $aa
; ce2cc

BattleAnimFunction_33: ; ce2cc (33:62cc)
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld d, $18
	call Sine
	sra a
	sra a
	sra a
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	add [hl]
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	inc [hl]
	ld d, $18
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	dec [hl]
	dec [hl]
	ret

BattleAnimFunction_StrengthSeismicToss: ; ce2fd (33:62fd)
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw .two
.zero: ; ce306 (33:6306)
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	cp $e0
	jr nz, .move_up
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $2
	ret

.move_up
	ld d, a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld e, [hl]
	ld hl, hPushOAM ; $ff80
	add hl, de
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], d
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], e
	ret

.one: ; ce330 (33:6330)
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	and a
	jr z, .switch_position
	dec [hl]
	ret

.switch_position
	ld [hl], $4
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	cpl
	inc a
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	add [hl]
	ld [hl], a
	ret

.two: ; ce34c (33:634c)
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $84
	jr nc, .asm_ce35b
	ld a, $4
	jp Functionce70a

.asm_ce35b
	jp FarDeinitBattleAnimation

BattleAnimFunction_37: ; ce35f (33:635f)
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functionce366
	dw Functionce375
Functionce366: ; ce366 (33:6366)
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $7f
	add BATTLEANIMFRAMESET_SPEED_LINE_1 ; BATTLEANIMFRAMESET_SPEED_LINE_2 BATTLEANIMFRAMESET_SPEED_LINE_3
	call FarReinitBattleAnimFrameset
Functionce375: ; ce375 (33:6375)
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	bit 7, [hl]
	jr nz, .asm_ce383
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	inc [hl]
	ret

.asm_ce383
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	dec [hl]
	ret

BattleAnimFunction_Sludge: ; ce389 (33:6389)
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functionce392
	dw Functionce39c
	dw Functionce3ae
Functionce392: ; ce392 (33:6392)
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $c
	ret

Functionce39c: ; ce39c (33:639c)
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	and a
	jr z, .asm_ce3a6
	dec [hl]
	ret

.asm_ce3a6
	call BattleAnim_IncAnonJumptableIndex
	ld a, BATTLEANIMFRAMESET_SLUDGE_BUBBLE_BURST
	call FarReinitBattleAnimFrameset
Functionce3ae: ; ce3ae (33:63ae)
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	dec [hl]
	ret

BattleAnimFunction_39: ; ce3b4 (33:63b4)
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	inc [hl]
	inc [hl]
	push af
	ld d, $2
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop af
	ld d, $8
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

BattleAnimFunction_3A: ; ce3d2 (33:63d2)
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	cp $20
	jr c, .asm_ce3df
	jp FarDeinitBattleAnimation

.asm_ce3df
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld d, $8
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	add $2
	ld [hl], a
	and $7
	ret nz
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	inc [hl]
	ret

BattleAnimFunction_Agility: ; ce3ff (33:63ff)
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functionce406
	dw Functionce412
Functionce406: ; ce406 (33:6406)
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	add [hl]
	ld [hl], a
	ret

Functionce412: ; ce412 (33:6412)
	jp FarDeinitBattleAnimation

BattleAnimFunction_3D: ; ce416 (33:6416)
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld d, $18
	push af
	push de
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	sra a
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	inc [hl]
	ret

BattleAnimFunction_3E: ; ce43a (33:643a)
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functionce443
	dw Functionce465
	dw Functionce490
Functionce443: ; ce443 (33:6443)
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $28
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $f
	ld hl, BATTLEANIMSTRUCT_FRAMESET_ID
	add hl, bc
	add [hl]
	call FarReinitBattleAnimFrameset
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $f0
	or $8
	ld [hl], a
Functionce465: ; ce465 (33:6465)
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	and a
	jr z, .asm_ce48b
	dec [hl]
	add $8
	ld d, a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	push af
	push de
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

.asm_ce48b
	ld [hl], $10
	call BattleAnim_IncAnonJumptableIndex
Functionce490: ; ce490 (33:6490)
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	dec [hl]
	and a
	ret nz
	jp FarDeinitBattleAnimation

BattleAnimFunction_40: ; ce49c (33:649c)
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functionce4a3
	dw Functionce4b0
Functionce4a3: ; ce4a3 (33:64a3)
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, BATTLEANIMFRAMESET_MUSIC_NOTE_1
	add [hl] ; BATTLEANIMFRAMESET_MUSIC_NOTE_2 BATTLEANIMFRAMESET_MUSIC_NOTE_3
	call FarReinitBattleAnimFrameset

Functionce4b0: ; ce4b0 (33:64b0)
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	cp $38
	jr nc, .asm_ce4d8
	inc [hl]
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	inc [hl]
	ld d, $18
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	ld a, [hl]
	and $1
	ret nz
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	dec [hl]
	ret

.asm_ce4d8
	jp FarDeinitBattleAnimation

BattleAnimFunction_41: ; ce4dc (33:64dc)
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and a
	ret z
	ld d, a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	inc [hl]
	call Sine
	bit 7, a
	jr nz, .asm_ce4f4
	cpl
	inc a
.asm_ce4f4
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	and $1f
	ret nz
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	srl [hl]
	ret

BattleAnimFunction_43: ; ce508 (33:6508)
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	cp $10
	jr nc, .asm_ce52e
	inc [hl]
	inc [hl]
	ld d, a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	push af
	push de
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

.asm_ce52e
	jp FarDeinitBattleAnimation

BattleAnimFunction_44: ; ce532 (33:6532)
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld e, [hl]
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld d, [hl]
	ld a, e
	and $c0
	rlca
	rlca
	add [hl]
	ld [hl], a
	ld a, e
	and $3f
	push af
	push de
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

BattleAnimFunction_HiddenPower: ; ce55b (33:655b)
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functionce564
	dw Functionce56e
	dw Functionce577
Functionce564: ; ce564 (33:6564)
	ld d, $18
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	inc [hl]
	jr asm_ce58f

Functionce56e: ; ce56e (33:656e)
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $18
Functionce577: ; ce577 (33:6577)
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	cp $80
	jr nc, .asm_ce58b
	ld d, a
	add $8
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	jr asm_ce58f

.asm_ce58b
	jp FarDeinitBattleAnimation

asm_ce58f: ; ce58f (33:658f)
	jp BattleAnim_StepCircle

BattleAnimFunction_46: ; ce593 (33:6593)
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functionce5b3
	dw Functionce59a
Functionce59a: ; ce59a (33:659a)
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $30
	jr c, .asm_ce5b0
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	dec [hl]
	dec [hl]
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	inc [hl]
	inc [hl]
	ret

.asm_ce5b0
	call FarDeinitBattleAnimation
Functionce5b3: ; ce5b3 (33:65b3)
	ret

BattleAnimFunction_47: ; ce5b4 (33:65b4)
	ld d, $50
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	inc [hl]
	inc [hl]
	push af
	push de
	call Sine
	sra a
	sra a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	add [hl]
	inc [hl]
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

BattleAnimFunction_48: ; ce5dc (33:65dc)
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	cp $d0
	jr z, .disappear
rept 4
	dec [hl]
endr
	ret

.disappear
	jp FarDeinitBattleAnimation

BattleAnimFunction_49: ; ce5ee (33:65ee)
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functionce5f9
	dw Functionce60a
	dw Functionce622
	dw Functionce618
Functionce5f9: ; ce5f9 (33:65f9)
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and a
	jr nz, asm_ce61c
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], $ec
Functionce60a: ; ce60a (33:660a)
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	cp $4
	jr z, Functionce618
rept 4
	inc [hl]
endr
	ret

Functionce618: ; ce618 (33:6618)
	jp FarDeinitBattleAnimation

asm_ce61c: ; ce61c (33:661c)
	call BattleAnim_IncAnonJumptableIndex
	call BattleAnim_IncAnonJumptableIndex
Functionce622: ; ce622 (33:6622)
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	cp $d8
	ret z
rept 4
	dec [hl]
endr
	ret

BattleAnimFunction_4A: ; ce62f (33:662f)
	call BattleAnim_AnonJumptable
.anon_dw
	dw Functionce63a
	dw Functionce648
	dw Functionce65c
	dw Functionce672
Functionce63a: ; ce63a (33:663a)
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld [hl], a
	jp BattleAnim_IncAnonJumptableIndex

Functionce648: ; ce648 (33:6648)
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	add $4
	cp $70
	jr c, .asm_ce654
	xor a
.asm_ce654
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	inc [hl]
	inc [hl]
	ret

Functionce65c: ; ce65c (33:665c)
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	add $4
	cp $70
	jr c, .asm_ce668
	xor a
.asm_ce668
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld a, [hl]
	add $8
	ld [hl], a
	ret

Functionce672: ; ce672 (33:6672)
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	add $4
	cp $70
	jr c, .asm_ce67e
	xor a
.asm_ce67e
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld a, [hl]
	add $4
	ld [hl], a
	ret

BattleAnimFunction_4B: ; ce688 (33:6688)
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld d, [hl]
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld e, [hl]
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld l, a
	and $f0
	ld h, a
	swap a
	or h
	ld h, a
	ld a, l
	and $f
	swap a
	ld l, a
	add hl, de
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld [hl], d
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], e
	ret

BattleAnimFunction_4C: ; ce6b3 (33:66b3)
	ld d, $18
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	inc [hl]
	jp BattleAnim_StepCircle

BattleAnimFunction_4F: ; ce6bf (33:66bf)
	ld d, $18
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	inc [hl]
	srl a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	add [hl]
	jp BattleAnim_StepCircle

BattleAnimFunction_4D: ; ce6d2 (33:66d2)
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	cp $20
	jr nc, .asm_ce6ed
	inc [hl]
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld d, [hl]
	call Sine
	cpl
	inc a
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ret

.asm_ce6ed
	jp FarDeinitBattleAnimation

BattleAnim_StepCircle: ; ce6f1 (33:66f1)
	push af
	push de
	call Sine
	sra a
	sra a
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

Functionce70a: ; ce70a (33:670a)
	and $f
	ld e, a
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	add [hl]
	ld [hl], a
	srl e
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
.asm_ce719
	dec [hl]
	dec e
	jr nz, .asm_ce719
	ret

BattleAnim_AnonJumptable: ; ce71e (33:671e)
	pop de
	ld hl, BATTLEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld l, [hl]
	ld h, $0
	add hl, hl
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

BattleAnim_IncAnonJumptableIndex: ; ce72c (33:672c)
	ld hl, BATTLEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	inc [hl]
	ret
	
BattleAnimFunction_50:
	call BattleAnim_AnonJumptable

	dw .zero
	dw .one
	dw .two

.zero
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	and $f0
	swap a
	ld hl, BATTLEANIMSTRUCT_JUMPTABLE_INDEX
	add hl, bc
	ld [hl], a
	ret

.two
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	ld d, $10
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	bit 7, a
	jr z, .skip
	ld [hl], a
.skip
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	sub 4
	ld [hl], a
.one
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $e4
	jp nc, FarDeinitBattleAnimation
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	jp Functionce70a
	
BattleAnimFunction_52:
	call BattleAnim_AnonJumptable

	dw .zero
	dw .one
	dw .none

.zero
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $30
	inc hl
	ld [hl], $48
.one
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	inc [hl]
	ld a, [hl]
	and $3f
	ret nz
	jp BattleAnim_IncAnonJumptableIndex
.none
	ret
	
BattleAnimFunction_55:
	call BattleAnim_AnonJumptable

	dw .zero
	dw .one
	dw .two

.zero
	ld d, 24
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	inc [hl]
	jp asm_ce58f

.one
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], 24
.two
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	cp 160
	jp nc, FarDeinitBattleAnimation
	ld d, a
	add 3
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	jp asm_ce58f
	
BattleAnimFunction_57:
	call BattleAnim_AnonJumptable

	dw .zero
	dw .one

.zero
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $28
	inc hl
	ld [hl], 0
.one
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld d, [hl]
	push af
	push de
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hli]
	ld d, a
	ld e, [hl]
	ld hl, -$480
	add hl, de
	jp nc, FarDeinitBattleAnimation
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, e
	ld [hld], a
	ld [hl], d
	ret

BattleAnimFunction_58:
	call BattleAnim_AnonJumptable

	dw .zero
	dw .one
	dw .two
	dw FarDeinitBattleAnimation

.zero
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld a, [hl]
	cp -1
	jr nz, .not_done_climbing
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], 2
	ret

.not_done_climbing
	ld d, a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld e, [hl]
	ld hl, -$80
	add hl, de
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], d
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], e
	ret

.one
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	and a
	jr z, .delay_done
	dec [hl]
	ret

.delay_done
	ld [hl], 4
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	cpl
	inc a
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	add [hl]
	ld [hl], a
	ret

.two
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $c0
	ret nc
	ld a, 8
	jp Functionce70a
	
BattleAnimFunction_5d:
	ld hl, BATTLEANIMSTRUCT_XCOORD
	add hl, bc
	ld a, [hl]
	cp $88
	jp nc, FarDeinitBattleAnimation

	add 2
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_YCOORD
	add hl, bc
	dec [hl]
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	inc [hl]
	inc [hl]
	inc [hl]
	inc [hl]
	ld d, $08
	push af
	push de
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	sra a
	sra a
	sra a
	sra a
	ld [hl], a
	ret
	
BattleAnimFunction_RadialMoveOut:
	call BattleAnim_AnonJumptable
	
	dw InitRadial
	dw Step
	dw Step_VerySlow ; for Cross Chop
	dw Step_Short ; for Cross Chop

BattleAnimFunction_RadialMoveOut_CP_BG:
	call BattleAnim_AnonJumptable

	dw InitRadial
	dw Step_CP_BG

BattleAnimFunction_RadialMoveOut_Delay:
	call BattleAnim_AnonJumptable
	
	dw DoNothingFunction
	dw InitRadial
	dw Step

BattleAnimFunction_RadialMoveOut_Slow:
	call BattleAnim_AnonJumptable

	dw InitRadial
	dw Step_Slow

BattleAnimFunction_RadialMoveOut_VerySlow:
	call BattleAnim_AnonJumptable

	dw InitRadial
	dw Step_VerySlow
	dw FarDeinitBattleAnimation

BattleAnimFunction_RadialMoveOut_Fast:
	call BattleAnim_AnonJumptable

	dw InitRadial
	dw Step_Fast

BattleAnimFunction_RadialMoveOut_Spore:
	call BattleAnim_AnonJumptable

	dw InitRadial
	dw Step_Spore

InitRadial:
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	xor a
	ld [hld], a
	ld [hl], a ; initial position = 0
	call BattleAnim_IncAnonJumptableIndex

Step:
	call Get_Rad_Pos
	ld hl, 6.0 ; speed
	call Set_Rad_Pos
	cp 80 ; final position
	jp nc, FarDeinitBattleAnimation
	jr Rad_Move

Step_VerySlow:
	call Get_Rad_Pos
	ld hl, 0.5 ; speed
	call Set_Rad_Pos
	cp 120 ; final position
	jp nc, FarDeinitBattleAnimation
	jr Rad_Move

Step_Spore:
	call Get_Rad_Pos
	ld hl, 1.5 ; speed
	call Set_Rad_Pos
	cp 40 ; final position
	jp nc, FarDeinitBattleAnimation
	jr Rad_Move

Step_Short:
	call Get_Rad_Pos
	ld hl, 6.0 ; speed
	call Set_Rad_Pos
	cp 60 ; final position
	jp nc, FarDeinitBattleAnimation
	jr Rad_Move

Step_CP_BG:
	call Get_Rad_Pos
	ld hl, 0.06 ; speed
	call Set_Rad_Pos
	cp 120 ; final position
	jp nc, FarDeinitBattleAnimation
	jr Rad_Move

Step_Slow:
	call Get_Rad_Pos
	ld hl, 1.5 ; speed
	call Set_Rad_Pos
	cp 120 ; final position
	jp nc, FarDeinitBattleAnimation
	jr Rad_Move

Step_Fast:
	call Get_Rad_Pos
	ld hl, 10.0 ; speed
	call Set_Rad_Pos
	cp 160 ; final position
	jp nc, FarDeinitBattleAnimation
	jr Rad_Move

Get_Rad_Pos:
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hli]
	ld e, [hl]
	ld d, a
	ret 

Set_Rad_Pos:
	add hl, de
	ld a, h
	ld e, l
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hli], a
	ld [hl], e
	ret

Rad_Move:
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld e, [hl]
	push de
	ld a, e
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	ld a, e
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ret

BattleAnimFunction_FallAndStop:
	call BattleAnim_AnonJumptable

	dw .zero
	dw .one
	dw DoNothingFunction

.zero
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, $30
	ld [hli], a
	ld [hl], $48
.one
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	inc [hl]
	ld a, [hl]
	and $3f
	ret nz
	jp BattleAnim_IncAnonJumptableIndex

BattleAnimFunction_RadialMoveIn_Slow_Stay:
	call BattleAnim_AnonJumptable

	dw .zero
	dw .one

.zero
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, 40
	ld [hli], a
	ld [hl], 0
.one
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld d, [hl]
	push af
	push de
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hli]
	ld d, a
	ld e, [hl]
	ld hl, -3.5
	add hl, de
	ret nc
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, e
	ld [hld], a
	ld [hl], d
	ret

BattleAnimFunction_LastResort:
; A rotating circle of objects centered at a position. It expands for $40 frames and then shrinks. Once radius reaches 0, the object disappears.
; Obj Param: Defines starting point in the circle
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	inc [hl] ; These speed up spinning
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld d, [hl]
	push af
	push de
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	inc [hl]
	inc [hl] ; the rest of these control the in and out.
	inc [hl]
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	cp $40
	jr nc, .shrink
	inc [hl]
	inc [hl] ; in and out
	inc [hl]
	ret

.shrink
	ld a, [hl]
	dec [hl]
	dec [hl] ; in and out
	dec [hl]
	and a
	ret nz
	jp FarDeinitBattleAnimation

BattleAnimFunction_Roost:
; Moves object in a circle where the height is 1/8 the width, while also moving downward 1 pixel per frame
; Obj Param: Defines where the object starts in the circle
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld d, $18
	call Sine
	sra a
	sra a
	sra a
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	add [hl]
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	inc [hl]
	ld d, $18
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	inc [hl]
	ld a, [hl]
	and $7
	ret nz
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	cp $1e
	jp nc, FarDeinitBattleAnimation
	inc [hl]
	inc [hl]
	ret

BattleAnimFunction_RadialMoveIn:
	call BattleAnim_AnonJumptable

	dw .zero
	dw .one

.zero
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, 40
	ld [hli], a
	ld [hl], 0
.one
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld d, [hl]
	push af
	push de
	call Sine
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hli]
	ld d, a
	ld e, [hl]
	ld hl, -4.5
	add hl, de
	jp nc, FarDeinitBattleAnimation
	ld e, l
	ld d, h
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, e
	ld [hld], a
	ld [hl], d
	ret

BattleAnimFunction_DarkPulse:
; Expands object out in a ring around position at 1 pixel at a time for 13 frames and then disappears
; Obj Param: Defines starting position in circle
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	cp $80
	jp nc, FarDeinitBattleAnimation
	ld d, a
	add $2
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	jp BattleAnim_StepCircle

BattleAnimFunction_SpiralDescent_Fast:
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	ld d, $18
	push af
	push de
	call Sine
	sra a
	sra a
	sra a
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	add [hl]
	ld hl, BATTLEANIMSTRUCT_YOFFSET
	add hl, bc
	ld [hl], a
	pop de
	pop af
	call Cosine
	ld hl, BATTLEANIMSTRUCT_XOFFSET
	add hl, bc
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	inc [hl]
	inc [hl]
	inc [hl]
	ld a, [hl]
	and $7
	ret nz
	ld hl, BATTLEANIMSTRUCT_VAR2
	add hl, bc
	ld a, [hl]
	cp $18
	jp nc, FarDeinitBattleAnimation
	inc [hl]
	inc [hl]
	inc [hl]
	inc [hl]
	inc [hl]
	ret

BattleAnimFunction_HiddenPower_Fast:
	call BattleAnim_AnonJumptable
.anon_dw
	dw .zero
	dw .one
	dw .two

.zero:
	ld d, $18
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	inc [hl] ; increased rotation speed
	inc [hl]
	jr .step_circle

.one:
	call BattleAnim_IncAnonJumptableIndex
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld [hl], $18
.two:
	ld hl, BATTLEANIMSTRUCT_VAR1
	add hl, bc
	ld a, [hl]
	cp $80
	jr nc, .done
	ld d, a
	add $8
	ld [hl], a
	ld hl, BATTLEANIMSTRUCT_PARAM
	add hl, bc
	ld a, [hl]
	jr .step_circle

.done
	jp FarDeinitBattleAnimation

.step_circle:
	jp BattleAnim_StepCircle