_DoItemEffect:: ; e722
	ld a, [wCurItem]
	ld [wd265], a
	call GetItemName
	call CopyName1
	ld a, 1
	ld [wItemEffectSucceeded], a
	ld a, [wCurItem]
	dec a
	ld hl, ItemEffects
	rst JumpTable
	ret
; e73c


ItemEffects: ; e73c
	dw PokeBallEffect   ; POKE_BALL
	dw PokeBallEffect   ; GREAT_BALL
	dw PokeBallEffect   ; ULTRA_BALL
	dw PokeBallEffect   ; MASTER_BALL
	dw PokeBallEffect   ; SAFARI_BALL
	dw PokeBallEffect   ; LEVEL_BALL
	dw PokeBallEffect   ; LURE_BALL
	dw PokeBallEffect   ; MOON_BALL
	dw PokeBallEffect   ; FRIEND_BALL
	dw PokeBallEffect   ; FAST_BALL
	dw PokeBallEffect   ; HEAVY_BALL
	dw PokeBallEffect   ; LOVE_BALL
	dw PokeBallEffect   ; PARK_BALL
	dw PokeBallEffect   ; REPEAT_BALL
	dw PokeBallEffect   ; TIMER_BALL
	dw PokeBallEffect   ; NEST_BALL
	dw PokeBallEffect   ; NET_BALL
	dw PokeBallEffect   ; DIVE_BALL
	dw PokeBallEffect   ; LUXURY_BALL
	dw PokeBallEffect   ; HEAL_BALL
	dw PokeBallEffect   ; QUICK_BALL
	dw PokeBallEffect   ; DUSK_BALL
	dw PokeBallEffect   ; PREMIER_BALL
	dw PokeBallEffect   ; CHERISH_BALL
	dw RestoreHPEffect  ; POTION
	dw RestoreHPEffect  ; SUPER_POTION
	dw RestoreHPEffect  ; HYPER_POTION
	dw RestoreHPEffect  ; MAX_POTION
	dw HealStatusEffect ; ANTIDOTE
	dw HealStatusEffect ; BURN_HEAL
	dw HealStatusEffect ; PARALYZEHEAL
	dw HealStatusEffect ; AWAKENING
	dw HealStatusEffect ; ICE_HEAL
	dw HealStatusEffect ; FULL_HEAL
	dw FullRestore      ; FULL_RESTORE
	dw ReviveEffect     ; REVIVE
	dw ReviveEffect     ; MAX_REVIVE
	dw RestorePPEffect  ; ETHER
	dw RestorePPEffect  ; MAX_ETHER
	dw RestorePPEffect  ; ELIXIR
	dw RestorePPEffect  ; MAX_ELIXIR
	dw VitaminEffect    ; HP_UP
	dw VitaminEffect    ; PROTEIN
	dw VitaminEffect    ; IRON
	dw VitaminEffect    ; CARBOS
	dw VitaminEffect    ; CALCIUM
	dw VitaminEffect    ; ZINC
	dw RareCandy        ; RARE_CANDY
	dw RestorePPEffect  ; PP_UP
	dw RestorePPEffect  ; PP_MAX
	dw RestoreHPEffect  ; FRESH_WATER
	dw RestoreHPEffect	; SODA_POP
	dw RestoreHPEffect  ; LEMONADE
	dw RestoreHPEffect  ; MOOMOO_MILK
	dw HealStatusEffect ; RAGECANDYBAR
	dw NoEffect    	    ; MOOMOO_BREW
	dw EnergyPowder     ; ENERGYPOWDER
	dw EnergyRoot       ; ENERGY_ROOT
	dw HealPowder       ; HEAL_POWDER
	dw RevivalHerb      ; REVIVAL_HERB
	dw XItemEffect      ; X_ATTACK
	dw XItemEffect      ; X_DEFEND
	dw XItemEffect      ; X_SPEED
	dw XItemEffect      ; X_SPCL_ATK
	dw XItemEffect      ; X_SPCL_DEF
	dw XItemEffect      ; X_ACCURACY
	dw DireHit          ; DIRE_HIT
	dw GuardSpec        ; GUARD_SPEC
	dw RepelEffect      ; REPEL
	dw RepelEffect      ; SUPER_REPEL
	dw RepelEffect      ; MAX_REPEL
	dw EscapeRope       ; ESCAPE_ROPE
	dw PokeDoll         ; POKE_DOLL
	dw AbilityCap       ; ABILITY_CAP
	dw EvoStoneEffect   ; LEAF_STONE
	dw EvoStoneEffect   ; FIRE_STONE
	dw EvoStoneEffect   ; WATER_STONE
	dw EvoStoneEffect   ; THUNDERSTONE
	dw EvoStoneEffect   ; MOON_STONE
	dw EvoStoneEffect   ; SUN_STONE
	dw EvoStoneEffect   ; DUSK_STONE
	dw EvoStoneEffect   ; SHINY_STONE
	dw EvoStoneEffect   ; DAWN_STONE
	dw NoEffect         ; EVERSTONE
	dw Bicycle          ; BICYCLE
	dw OldRod           ; OLD_ROD
	dw GoodRod          ; GOOD_ROD
	dw SuperRod         ; SUPER_ROD
	dw CoinCase         ; COIN_CASE
	dw Itemfinder       ; ITEMFINDER
	dw NoEffect         ; EXP_SHARE
	dw NoEffect         ; LIBRARY_CARD
	dw PokeFlute	    ; POKE_FLUTE
	dw NoEffect         ; THE_THING
	dw NoEffect         ; TORCH
	dw NoEffect         ; OLD_KEY
	dw NoEffect         ; CLAY_POT
	dw NoEffect         ; B_ROOM_KEY
	dw NoEffect         ; Y_ROOM_KEY
	dw NoEffect         ; R_ROOM_KEY
	dw NoEffect         ; ANCIENT_BALL
	dw NoEffect         ; RIVAL_POKEDEX
	dw Skateboard       ; SKATEBOARD
	dw NoEffect         ; TRAIN_TICKET
	dw NoEffect         ; TRAIN_PASS
	dw NettSpecs        ; NETT_SPECS
	dw NoEffect         ; ORANGETICKET
	dw NoEffect         ; MYSTICTICKET
	dw NoEffect         ; OLD_SEA_MAP
	dw NoEffect         ; SHINY_CHARM
	dw NoEffect         ; OVAL_CHARM
	dw NoEffect         ; FLOWER_PETAL
	dw RestoreHPTeaEffect  ; BLOSSOM_TEA
	dw NoEffect         ; PAINTBRUSH
	dw HealStatusEffect ; CHERI_BERRY
	dw HealStatusEffect ; CHESTO_BERRY
	dw HealStatusEffect ; PECHA_BERRY
	dw HealStatusEffect ; RAWST_BERRY
	dw HealStatusEffect ; ASPEAR_BERRY
	dw RestorePPEffect  ; LEPPA_BERRY
	dw RestoreHPEffect  ; ORAN_BERRY
	dw PersimBerry      ; PERSIM_BERRY
	dw HealStatusEffect ; LUM_BERRY
	dw RestoreHPEffect  ; SITRUS_BERRY
	dw RestoreHPEffect  ; FIGY_BERRY
	dw NoEffect         ; UNUSED1
	dw NoEffect         ; UNUSED2
	dw NoEffect         ; UNUSED3
	dw NoEffect         ; UNUSED4
	dw NoEffect         ; UNUSED5
	dw NoEffect         ; UNUSED6
	dw NoEffect         ; UNUSED7
	dw NoEffect         ; UNUSED8
	dw NoEffect         ; UNUSED9
	dw RestoreHPEffect  ; BERRY_JUICE
	dw NoEffect         ; SILK_SCARF
	dw NoEffect         ; BLACK_BELT
	dw NoEffect         ; SHARP_BEAK
	dw NoEffect         ; POISON_BARB
	dw NoEffect         ; SOFT_SAND
	dw NoEffect         ; HARD_STONE
	dw NoEffect         ; SILVERPOWDER
	dw NoEffect         ; SPELL_TAG
	dw NoEffect         ; METAL_COAT
	dw NoEffect         ; CHARCOAL
	dw NoEffect         ; MYSTIC_WATER
	dw NoEffect         ; MIRACLE_SEED
	dw NoEffect         ; MAGNET
	dw NoEffect         ; TWISTEDSPOON
	dw NoEffect         ; NEVERMELTICE
	dw NoEffect         ; DRAGON_FANG
	dw NoEffect         ; BLACKGLASSES
	dw NoEffect         ; PINK_BOW
	dw NoEffect         ; BRIGHTPOWDER
	dw NoEffect         ; SCOPE_LENS
	dw NoEffect         ; QUICK_CLAW
	dw NoEffect         ; KINGS_ROCK
	dw NoEffect         ; FOCUS_BAND
	dw NoEffect         ; LEFTOVERS
	dw NoEffect         ; LUCKY_EGG
	dw NoEffect         ; AMULET_COIN
	dw NoEffect         ; CLEANSE_TAG
	dw NoEffect         ; SMOKE_BALL
	dw TapePlayer         ; TAPE_PLAYER
	dw NoEffect         ; LIGHT_BALL
	dw EvoStoneEffect   ; LINK_CABLE
	dw NoEffect         ; THICK_CLUB
	dw NoEffect         ; LUCKY_PUNCH
	dw NoEffect         ; METAL_POWDER
	dw NoEffect         ; QUICK_POWDER
	dw PollenPouch       ; POLLEN_POUCH
	dw DubiousDogEffect         ; DUBIOUS_DOG
	dw NoEffect         ; ASSAULT_VEST
	dw NoEffect         ; BIG_ROOT
	dw NoEffect         ; FIVESTARHELM
	dw NoEffect         ; DESTINY_KNOT
	dw NoEffect         ; EVIOLITE
	dw NoEffect         ; EXPERT_BELT
	dw NoEffect         ; FOCUS_SASH
	dw NoEffect         ; GRIP_CLAW
	dw NoEffect         ; LIFE_ORB
	dw NoEffect         ; LIGHT_CLAY
	dw NoEffect         ; METRONOME_I
	dw NoEffect         ; MUSCLE_BAND
	dw ReviveEffect     ; ROCK_CANDY
	dw NoEffect         ; ROCKY_HELMET
	dw NoEffect         ; SAFE_GOGGLES
	dw NoEffect         ; SHED_SHELL
	dw NoEffect         ; SHELL_BELL
	dw NoEffect         ; SOOTHE_BELL
	dw NoEffect         ; WEAK_POLICY
	dw NoEffect         ; WIDE_LENS
	dw NoEffect         ; WISE_GLASSES
	dw NoEffect         ; ZOOM_LENS
	dw NoEffect         ; MENTAL_HERB
	dw NoEffect         ; POWER_HERB
	dw NoEffect         ; WHITE_HERB
	dw NoEffect         ; DAMP_ROCK
	dw NoEffect         ; HEAT_ROCK
	dw NoEffect         ; SMOOTH_ROCK
	dw NoEffect         ; ICY_ROCK
	dw NoEffect         ; CHOICE_BAND
	dw NoEffect         ; CHOICE_SCARF
	dw NoEffect         ; CHOICE_SPECS
	dw NoEffect         ; FLAME_ORB
	dw NoEffect         ; TOXIC_ORB
	dw NoEffect         ; BLACK_SLUDGE
	dw NoEffect         ; MACHO_BRACE
	dw NoEffect         ; POWER_WEIGHT
	dw NoEffect         ; POWER_BRACER
	dw NoEffect         ; POWER_BELT
	dw NoEffect         ; POWER_LENS
	dw NoEffect         ; POWER_BAND
	dw NoEffect         ; POWER_ANKLET
	dw NoEffect         ; DRAGON_SCALE
	dw NoEffect         ; UP_GRADE
	dw NoEffect         ; DUBIOUS_DISC
	dw EvoStoneEffect         ; BIG_MALASADA
	dw NoEffect         ; ELECTIRIZER
	dw NoEffect         ; MAGMARIZER
	dw NoEffect         ; RAZOR_FANG
	dw NoEffect         ; RAZOR_CLAW
	dw NoEffect         ; CHLOROPHIAL
	dw NoEffect         ; NUGGET
	dw NoEffect         ; BIG_NUGGET
	dw NoEffect         ; TINYMUSHROOM
	dw NoEffect         ; BIG_MUSHROOM
	dw NoEffect         ; BALMMUSHROOM
	dw NoEffect         ; PEARL
	dw NoEffect         ; BIG_PEARL
	dw NoEffect         ; BLACK_PEARL
	dw NoEffect         ; STARDUST
	dw NoEffect         ; STAR_PIECE
	dw RestoreHPTeaEffect  ; SILVER_TEA
	dw ReviveEffect     ; GOLD_TEA
	dw NoEffect         ; SILVER_LEAF
	dw NoEffect		    ; GOLD_LEAF
	dw NoEffect         ; SLOWPOKETAIL
	dw NoEffect         ; BOTTLE_CAP
	dw NoEffect         ; COVER_FOSSIL
	dw NoEffect         ; PLUME_FOSSIL
	dw SacredAsh        ; MIRACLETONIC
	dw RestoreHPTeaEffect         ; SUNSHINE_TEA
	dw NoEffect         ; SWEET_HONEY
	dw NoEffect         ; FLOWER_MAIL
	dw NoEffect         ; SURF_MAIL
	dw NoEffect         ; LITEBLUEMAIL
	dw NoEffect         ; PORTRAITMAIL
	dw NoEffect         ; LOVELY_MAIL
	dw NoEffect         ; EON_MAIL
	dw NoEffect         ; MORPH_MAIL
	dw NoEffect         ; BLUESKY_MAIL
	dw NoEffect         ; MUSIC_MAIL
	dw NoEffect         ; MIRAGE_MAIL
; e8a2


PokeBallEffect: ; e8a2
	ld a, [wBattleMode]
	dec a
	jp nz, UseBallInTrainerBattle

	ld a, [wBattleType]
	cp BATTLETYPE_GHOST
	jp z, Ball_MonCantBeCaughtMessage
	cp BATTLETYPE_PORYGON
	jr z, .check_porygon
	cp BATTLETYPE_GEN_1
	jr z, .porygon

.not_porygon
	ld a, [wEnemySubStatus3] ; BATTLE_VARS_SUBSTATUS3_OPP
	and 1 << SUBSTATUS_FLYING | 1 << SUBSTATUS_UNDERGROUND | 1 << SUBSTATUS_UNDERWATER
	jp nz, Ball_MonIsHiddenMessage

	ld a, [wPartyCount]
	cp PARTY_LENGTH
	jr z, .check_room
	ld c, a

	; Don't mess with item backup struct if we are in a bug contest
	ld a, [wBattleType]
	cp BATTLETYPE_CONTEST
	jr z, .room_in_party

	; Copy wildmon's item to item backup struct in case we catch
	ld hl, wPartyBackupItems
	ld b, 0
	add hl, bc
	ld a, [wEnemyMonItem]
	ld [hl], a
	jr .room_in_party

.check_porygon
	ld a, [wWalkingOnBridge]
	cp 5
	jr z, .not_porygon
.porygon
	call ReturnToBattle_UseBall
	ld de, ANIM_THROW_POKE_BALL
	ld a, e
	ld [wFXAnimIDLo], a
	ld a, d
	ld [wFXAnimIDHi], a
	ld a, BLOSSOM_TEA
	ld [wBattleAnimParam], a
	xor a
	ldh [hBattleTurn], a
	ld [wNumHits], a
	predef PlayBattleAnim
	ld hl, wOptions1
	res NO_TEXT_SCROLL, [hl]
	ld hl, BallPhasedThruText
	call PrintText
;	ld hl, DontBeAThiefText
;	call PrintText
	jp UseDisposableItem

.check_room
	ld a, BANK(sBoxCount)
	call GetSRAMBank
	ld a, [sBoxCount]
	cp MONS_PER_BOX
	call CloseSRAM
	jp z, Ball_BoxIsFullMessage

.room_in_party
	xor a
	ld [wWildMon], a
	ld a, [wBattleType]
	cp BATTLETYPE_CONTEST
	jr z, .skipReturnToBattle
	cp BATTLETYPE_SAFARI
	jr z, .skipReturnToBattle
	call ReturnToBattle_UseBall

.skipReturnToBattle
	ld hl, wOptions1
	res NO_TEXT_SCROLL, [hl]
	ld hl, UsedItemText
	call PrintText

	ld a, [wEnemyMonCatchRate]
	ld b, a
	ld a, [wCurItem]
	cp MASTER_BALL
	jp z, .catch_without_fail
	ld a, [wSafariBallsRemaining]
	and a
	jr z, .normal
	ld a, [wSafariBallsRemaining]
	cp 1
	jp z, .catch_without_fail
	ld a, 0
	jp .fail_to_catch
.normal
	ld a, [wCurItem]
	ld c, a
	ld hl, BallMultiplierFunctionTable

.get_multiplier_loop
	ld a, [hli]
	cp $ff
	jr z, .skip_or_return_from_ball_fn
	cp c
	jr z, .call_ball_function
	inc hl
	inc hl
	jr .get_multiplier_loop

.call_ball_function
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, .skip_or_return_from_ball_fn
	push de
	jp hl

.skip_or_return_from_ball_fn
	ld a, b
	ldh [hMultiplicand + 2], a

	ld hl, wEnemyMonHP
	ld b, [hl]
	inc hl
	ld c, [hl]
	inc hl
	ld d, [hl]
	inc hl
	ld e, [hl]
	sla c
	rl b

	ld h, d
	ld l, e
	add hl, de
	add hl, de
	ld d, h
	ld e, l
	ld a, d
	and a
	jr z, .okay_1

	srl d
	rr e
	srl d
	rr e
	srl b
	rr c
	srl b
	rr c

	ld a, c
	and a
	jr nz, .okay_1
	ld c, $1
.okay_1
	ld b, e

	push bc
	ld a, b
	sub c
	ldh [hMultiplier], a
	xor a
	ldh [hDividend + 0], a
	ldh [hMultiplicand + 0], a
	ldh [hMultiplicand + 1], a
	call Multiply
	pop bc

	ld a, b
	ldh [hDivisor], a
	ld b, 4
	call Divide

	ldh a, [hQuotient + 2]
	and a
	jr nz, .statuscheck
	ld a, 1
.statuscheck
	ld b, a
	ld a, [wEnemyMonStatus]
	and 1 << FRZ | SLP
	ld c, 10
	jr nz, .addstatus
	ld a, [wEnemyMonStatus]
	and a
	ld c, 5
	jr nz, .addstatus
	ld c, 0
.addstatus
	ld a, b
	add c
	jr nc, .skip_hp_calc
	ld a, $ff

.skip_hp_calc
	ld b, a
	ld a, [wBattleType]
	cp BATTLETYPE_TRAP
	jr z, .half
	cp BATTLETYPE_LEGENDARY
	jr nz, .skip_half
.half
	srl b
.skip_half
	ld a, b
	ld [wBuffer1], a
	ld [wSunsetBayTrigger], a		;Used this for debug
	call Random

	cp b
	ld a, 0 ; not xor a; preserve carry flag
	jr z, .catch_without_fail
	jr nc, .fail_to_catch

.catch_without_fail
	ld a, [wEnemyMonSpecies]

.fail_to_catch
	ld [wWildMon], a
	ld c, 20
	call DelayFrames

	ld a, [wCurItem]
	ld [wBattleAnimParam], a

	ld de, ANIM_THROW_POKE_BALL
	ld a, e
	ld [wFXAnimIDLo], a
	ld a, d
	ld [wFXAnimIDHi], a
	xor a
	ldh [hBattleTurn], a
	ld [wBuffer2], a
	ld [wNumHits], a
	predef PlayBattleAnim

	ld a, [wWildMon]
	and a
	jr nz, .caught
	ld a, [wBuffer2]
	cp $1
	ld hl, Text_NoShake
	jp z, .shake_and_break_free
	cp $2
	ld hl, Text_OneShake
	jp z, .shake_and_break_free
	cp $3
	ld hl, Text_TwoShakes
	jp z, .shake_and_break_free
	cp $4
	ld hl, Text_ThreeShakes
	jp z, .shake_and_break_free

.caught
	ld a, [wTempEnemyMonSpecies]
	ld [wEnemyMonSpecies], a

	ld hl, wEnemyBackupDVs
	ld de, wEnemyMonDVs
	ld bc, 5
	rst CopyBytes

	ld hl, wWildMonMoves
	ld de, wEnemyMonMoves
	ld bc, NUM_MOVES
	rst CopyBytes

	ld hl, wWildMonPP
	ld de, wEnemyMonPP
	ld bc, NUM_MOVES
	rst CopyBytes

	ld a, [wEnemyMonSpecies]
	push af
	ld [wMonJustCaught], a
	ld [wWildMon], a
	ld [wCurPartySpecies], a
	ld [wd265], a
	ld a, [wBattleType]
	cp BATTLETYPE_TUTORIAL
	jp z, .FinishTutorial

	ld hl, Text_GotchaMonWasCaught
	call PrintText

	call ClearSprites

	ld a, [wPartyCount]
	cp 0
	jr z, .skip_exp
	farcall GiveExperiencePointsAfterCatch

.skip_exp
	ld a, [wEnemyMonLevel]
	ld [wCurPartyLevel], a

	ld a, [wEnemyMonSpecies]
	ld [wCurSpecies], a
	ld [wCurPartySpecies], a
	call GetBaseData

	ld de, wEnemyMonMaxHP
	ld b, FALSE
	ld hl, wEnemyMonDVs - (MON_DVS - (MON_EVS -1))
	predef CalcPkmnStats

	ld a, [wEnemyMonSpecies]
	ld [wPlaceBallsY], a

	pop af
	ld [wMonJustCaught], a
	ld [wWildMon], a
	ld [wCurPartySpecies], a
	ld [wd265], a
	dec a
	call CheckCaughtMon

	ld a, c
	push af
	ld a, [wd265]
	ld [wEnemyMonSpecies], a
	dec a
	call SetSeenAndCaughtMon
	pop af
	and a
	jr nz, .skip_pokedex

	call CheckReceivedDex
	jr z, .skip_pokedex

	ld hl, Text_AddedToPokedex
	call PrintText

	call ClearSprites

	ld a, [wEnemyMonSpecies]
	ld [wd265], a
	predef NewPokedexEntry

.skip_pokedex
	ld a, [wPlaceBallsY]
	ld [wMonJustCaught], a
	ld [wWildMon], a
	ld [wCurPartySpecies], a
	ld a, [wBattleType]
	cp BATTLETYPE_CONTEST
	jp z, .catch_bug_contest_mon
	cp BATTLETYPE_LEGENDARY
	jr nz, .not_celebi ; false positive for other legendaries, but that's okay
	ld hl, wBattleResult
	set 6, [hl]
.not_celebi

	ld a, [wPartyCount]
	cp PARTY_LENGTH
	jp z, .SendToPC

	xor a ; PARTYMON
	ld [wMonType], a
	call ClearSprites

	predef TryAddMonToParty

	farcall SetCaughtData

	ld a, [wCurItem]
	cp FRIEND_BALL
	jr nz, .SkipPartyMonFriendBall

	ld a, [wPartyCount]
	dec a
	ld hl, wPartyMon1Happiness
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes

	ld a, FRIEND_BALL_HAPPINESS
	ld [hl], a
.SkipPartyMonFriendBall:

	ld a, [wCurItem]
	cp HEAL_BALL
	jr nz, .SkipPartyMonHealBall

	ld a, [wPartyCount]
	dec a
	ld [wCurPartyMon], a
	farcall HealPartyMonEvenForNuzlocke
.SkipPartyMonHealBall:
	ld a, [wBattleType]
	cp BATTLETYPE_SAFARI
	jp z, .return_from_capture

	ld a, [wInitialOptions]
	bit NUZLOCKE_MODE, a
	jr nz, .AlwaysNickname

	ld hl, Text_AskNicknameNewlyCaughtMon
	call PrintText

	ld a, [wCurPartySpecies]
	ld [wd265], a
	call GetPokemonName

	call YesNoBox
	jp c, .return_from_capture

.AlwaysNickname:
	ld a, [wPartyCount]
	dec a
	ld [wCurPartyMon], a
	ld hl, wPartyMonNicknames
	ld bc, PKMN_NAME_LENGTH
	rst AddNTimes

	ld d, h
	ld e, l
	push de
	xor a ; PARTYMON
	ld [wMonType], a
	ld b, $0 ; pokemon
	farcall NamingScreen

	ld c, 15
	call FadeToWhite

	call LoadStandardFont

	pop hl
	ld de, wStringBuffer1
	call InitName

	jp .return_from_capture

.SendToPC:
	call ClearSprites

	predef SentPkmnIntoBox

	farcall SetBoxMonCaughtData

	ld a, [wCurItem]
	cp FRIEND_BALL
	jr nz, .SkipBoxMonFriendBall
	; Bug: overwrites the happiness of the first mon in the box!
	ld a, FRIEND_BALL_HAPPINESS
	ld [sBoxMon1Happiness], a
.SkipBoxMonFriendBall:
	call CloseSRAM

	ld a, [wInitialOptions]
	bit NUZLOCKE_MODE, a
	jr nz, .AlwaysNicknameBox

	ld hl, Text_AskNicknameNewlyCaughtMon
	call PrintText

	ld a, [wCurPartySpecies]
	ld [wd265], a
	call GetPokemonName

	call YesNoBox
	jr c, .SkipBoxMonNickname

.AlwaysNicknameBox:
	xor a
	ld [wCurPartyMon], a
	ld a, BOXMON
	ld [wMonType], a
	ld de, wMonOrItemNameBuffer
	ld b, $0 ; pokemon
	farcall NamingScreen

	ld a, BANK(sBoxMonNicknames)
	call GetSRAMBank

	ld hl, wMonOrItemNameBuffer
	ld de, sBoxMonNicknames
	ld bc, PKMN_NAME_LENGTH
	rst CopyBytes

	ld hl, sBoxMonNicknames
	ld de, wStringBuffer1
	call InitName

	call CloseSRAM

.SkipBoxMonNickname:
	ld a, BANK(sBoxMonNicknames)
	call GetSRAMBank

	ld hl, sBoxMonNicknames
	ld de, wMonOrItemNameBuffer
	ld bc, PKMN_NAME_LENGTH
	rst CopyBytes

	call CloseSRAM

	ld hl, Text_SentToBillsPC
	call PrintText

	ld a, BANK(sBoxCount)
	call GetSRAMBank
	ld a, [sBoxCount]
	cp MONS_PER_BOX
	call CloseSRAM
	jp nz, .BoxNotFullYet
;	ld hl, wBattleResult
;	set 7, [hl]
	farcall BillBoxSwitchCheck
	ld a, [wScriptVar]
	cp 0
	jr z, .BoxTotallyFull
.BoxNotTotallyFullYet
	ld hl, Ball_BoxIsFullAskSwitchText
	call PrintText
	call YesNoBox
	jr c, .BoxNotFullYet
	farcall BillBoxSwitch
	jr .BoxNotFullYet
.BoxTotallyFull
	ld hl, Ball_BoxIsTotallyFullText
	call PrintText
.BoxNotFullYet:
	ld c, 15
	call FadeToWhite

	call LoadStandardFont
	jr .return_from_capture

.catch_bug_contest_mon
	farcall BugContest_SetCaughtContestMon
	jr .return_from_capture

.FinishTutorial:
	pop af
	ld hl, Text_GotchaMonWasCaught

.shake_and_break_free
	call PrintText
	call ClearSprites

.return_from_capture
	ld a, [wBattleType]
	cp BATTLETYPE_TUTORIAL
	ret z
	cp BATTLETYPE_CONTEST
	jr z, .used_park_ball
	cp BATTLETYPE_SAFARI
	jr z, .used_safari_ball

	ld a, [wWildMon]
	and a
	jr z, .toss

;	call ClearBGPalettes
;	call ClearTileMap
	xor a
	ld [wPlaceBallsX], a

.toss
	ld hl, wNumItems
	inc a
	ld [wItemQuantityChangeBuffer], a
	jp TossItem

.used_park_ball
	ld hl, wParkBallsRemaining
	dec [hl]
	ret

.used_safari_ball
	ld hl, wSafariBallsRemaining
	dec [hl]
	ret
; ec0a


BallMultiplierFunctionTable:
; table of routines that increase or decrease the catch rate based on
; which ball is used in a certain situation.
	dbw GREAT_BALL,  GreatBallMultiplier
	dbw ULTRA_BALL,  UltraBallMultiplier
	dbw SAFARI_BALL, SafariBallMultiplier
	dbw LEVEL_BALL,  LevelBallMultiplier
	dbw LURE_BALL,   LureBallMultiplier
	dbw MOON_BALL,   MoonBallMultiplier
	dbw FAST_BALL,   FastBallMultiplier
	dbw HEAVY_BALL,  HeavyBallMultiplier
	dbw LOVE_BALL,   LoveBallMultiplier
	dbw PARK_BALL,   ParkBallMultiplier
	dbw REPEAT_BALL, RepeatBallMultiplier
	dbw TIMER_BALL,  TimerBallMultiplier
	dbw NEST_BALL,   NestBallMultiplier
	dbw NET_BALL,    NetBallMultiplier
	dbw DIVE_BALL,   DiveBallMultiplier
	dbw QUICK_BALL,  QuickBallMultiplier
	dbw DUSK_BALL,   DuskBallMultiplier
	db $ff

UltraBallMultiplier:
SafariBallMultiplier:
; multiply catch rate by 2
	sla b
	ret nc
	ld b, $ff
	ret

GreatBallMultiplier:
ParkBallMultiplier:
; multiply catch rate by 1.5
	ld a, b
	srl a
	add b
	ld b, a
	ret nc
	ld b, $ff
	ret

GetPokedexEntryBank:
	push hl
	push de
	ld a, [wEnemyMonSpecies]
	rlca
	rlca
	and 3
	ld hl, .PokedexEntryBanks
	ld d, 0
	ld e, a
	add hl, de
	ld a, [hl]
	pop de
	pop hl
	ret

.PokedexEntryBanks:
	db BANK(PokedexEntries1)
	db BANK(PokedexEntries2)
	db BANK(PokedexEntries3)
	db BANK(PokedexEntries4)

HeavyBallMultiplier:
; subtract 20 from catch rate if weight < 102.4 kg
; else add 0 to catch rate if weight < 204.8 kg
; else add 20 to catch rate if weight < 307.2 kg
; else add 30 to catch rate if weight < 409.6 kg
; else add 40 to catch rate (never happens)
	ld a, [wEnemyMonSpecies]
	ld hl, PokedexDataPointerTable
	dec a
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	ld a, BANK(PokedexDataPointerTable)
	call GetFarHalfword

.SkipText:
	call GetPokedexEntryBank
	call GetFarByte
	inc hl
	cp "@"
	jr nz, .SkipText

	call GetPokedexEntryBank
	push bc
	inc hl
	inc hl
	call GetFarHalfword

	srl h
	rr l
	ld b, h
	ld c, l

	rept 4
	srl b
	rr c
	endr
	call .subbc

	srl b
	rr c
	call .subbc

	ld a, h
	pop bc
	jr .compare

.subbc
	; subtract bc from hl
	push bc
	ld a, b
	cpl
	ld b, a
	ld a, c
	cpl
	ld c, a
	inc bc
	add hl, bc
	pop bc
	ret

.compare
	ld c, a
	cp 1024 >> 8 ; 102.4 kg
	jr c, .lightmon

	ld hl, .WeightsTable
.lookup
	ld a, c
	cp [hl]
	jr c, .heavymon
	inc hl
	inc hl
	jr .lookup

.heavymon
	inc hl
	ld a, b
	add [hl]
	ld b, a
	ret nc
	ld b, $ff
	ret

.lightmon
	ld a, b
	sub 20
	ld b, a
	ret nc
	ld b, $1
	ret

.WeightsTable:
; weight factor, boost
	db 2048 >> 8, 0
	db 3072 >> 8, 20
	db 4096 >> 8, 30
	db 65280 >> 8, 40

LureBallMultiplier:
; multiply catch rate by 3 if this is a fishing rod battle
	ld a, [wBattleType]
	cp BATTLETYPE_FISH
	ret nz

	ld a, b
	add a
	jr c, .max

	add b
	jr nc, .done
.max
	ld a, $ff
.done
	ld b, a
	ret

MoonBallMultiplier:
; multiply catch rate by 4 if mon evolves with moon stone
	push bc
	; c = species
	ld a, [wTempEnemyMonSpecies]
	ld c, a
	; b = form
	ld a, [wEnemyMonForm]
	and FORM_MASK
	ld b, a
	; bc = index
	call GetSpeciesAndFormIndex
	dec bc
	ld hl, EvosAttacksPointers
	add hl, bc
	add hl, bc
	ld a, BANK(EvosAttacksPointers)
	call GetFarHalfword
	pop bc

	push bc
	ld a, BANK(EvosAttacks)
	call GetFarByte
	cp EVOLVE_ITEM
	pop bc
	ret nz

	inc hl
	inc hl
	inc hl

	push bc
	ld a, BANK(EvosAttacks)
	call GetFarByte
	cp MOON_STONE
	pop bc
	ret nz

	sla b
	jr c, .max
	sla b
	ret nc
.max
	ld b, $ff
	ret

LoveBallMultiplier:
; multiply catch rate by 8 if mons are of same species, different sex

	; does species match?
	ld a, [wTempEnemyMonSpecies]
	ld c, a
	ld a, [wTempBattleMonSpecies]
	cp c
	ret nz

	; check player mon species
	push bc
	ld a, [wTempBattleMonSpecies]
	ld [wCurPartySpecies], a
	xor a ; PARTYMON
	ld [wMonType], a
	ld a, [wCurBattleMon]
	ld [wCurPartyMon], a
	farcall GetGender
	jr c, .done1 ; no effect on genderless

	ld d, 0 ; male
	jr nz, .playermale
	inc d   ; female
.playermale

	; check wild mon species
	push de
	ld a, [wTempEnemyMonSpecies]
	ld [wCurPartySpecies], a
	ld a, WILDMON
	ld [wMonType], a
	farcall GetGender
	jr c, .done2 ; no effect on genderless

	ld d, 0 ; male
	jr nz, .wildmale
	inc d   ; female
.wildmale

	ld a, d
	pop de
	cp d
	pop bc
	ret z

	sla b
	jr c, .max
	sla b
	jr c, .max
	sla b
	ret nc
.max
	ld b, $ff
	ret

.done2
	pop de

.done1
	pop bc
	ret

FastBallMultiplier:
; multiply catch rate by 4 if enemy mon is in one of the three
; FleeMons tables.
	ld a, [wTempEnemyMonSpecies]
	ld c, a
	ld hl, FleeMons
	ld d, 3

.loop
	ld a, BANK(FleeMons)
	call GetFarByte

	inc hl
	cp -1
	jr z, .next
	cp c
	jr nz, .loop
	sla b
	jr c, .max

	sla b
	ret nc

.max
	ld b, $ff
	ret

.next
	dec d
	jr nz, .loop
	ret

LevelBallMultiplier:
; multiply catch rate by 8 if player mon level / 4 > enemy mon level
; multiply catch rate by 4 if player mon level / 2 > enemy mon level
; multiply catch rate by 2 if player mon level > enemy mon level
	ld a, [wBattleMonLevel]
	ld c, a
	ld a, [wEnemyMonLevel]
	cp c
	ret nc ; if player is lower level, we're done here
	sla b
	jr c, .max

	srl c
	cp c
	ret nc ; if player/2 is lower level, we're done here
	sla b
	jr c, .max

	srl c
	cp c
	ret nc ; if player/4 is lower level, we're done here
	sla b
	ret nc

.max
	ld b, $ff
	ret

RepeatBallMultiplier:
; multiply catch rate by 3 if enemy mon is already in Pokédex
	ld a, [wTempEnemyMonSpecies]
	dec a
	push bc
	call CheckCaughtMon
	pop bc
	ret z

	ld a, b
	add a
	jr c, .max

	add b
	jr nc, .done
.max
	ld a, $ff
.done
	ld b, a
	ret

TimerBallMultiplier:
; multiply catch rate by 1 + (turns passed * 3) / 10, capped at 4
	ld a, [wTotalBattleTurns]
	cp 10
	jr nc, .nocap
	ld a, 10
.nocap
	ld c, a
	add c
	add c

	; hMultiplier = turns passed * 3
	ldh [hMultiplier], a

	; hMultiplicand = catch rate
	xor a
	ldh [hMultiplicand + 0], a
	ldh [hMultiplicand + 1], a
	ld a, b
	ldh [hMultiplicand + 2], a

	push bc

	; hProduct = catch rate * (turns passed * 3)
	call Multiply

	; hDividend = hProduct = catch rate * (turns passed * 3)
	ld hl, hDividend
	ldh a, [hProduct + 0]
	ld [hli], a
	ldh a, [hProduct + 1]
	ld [hli], a
	ldh a, [hProduct + 2]
	ld [hli], a
	ldh a, [hProduct + 3]
	ld [hl], a

	; hDivisor = 10
	ld a, 10
	ldh [hDivisor], a

	; hQuotient = catch rate * (turns passed * 3) / 10
	ld b, 4
	call Divide

	pop bc

	ldh a, [hQuotient + 1]
	and a
	jr nz, .max

	; a = b + hQuotient = catch rate * (1 + (turns passed * 3) / 10)
	ldh a, [hQuotient + 2]
	add b
	jr nc, .nomax

.max
	ld a, $ff
.nomax
	ld b, a
	ret

NestBallMultiplier:
; multiply catch rate by (41 - enemy mon level) / 5, floored at 1
	ld a, [wEnemyMonLevel]
	cp 30
	ret nc

	push bc
	ld b, a
	ld a, 41
	sub b
	pop bc

	; hMultiplier = 41 - level
	ldh [hMultiplier], a

	; hMultiplicand = catch rate
	xor a
	ldh [hMultiplicand + 0], a
	ldh [hMultiplicand + 1], a
	ld a, b
	ldh [hMultiplicand + 2], a

	; hProduct = catch rate * (41 - level)
	call Multiply

	; hDivisor = 5
	ld a, 5
	ldh [hDivisor], a

	; hQuotient = catch rate * (41 - level) / 5
	ld b, 4
	call Divide

	; b = hQuotient = catch rate * (41 - level) / 5
	ldh a, [hQuotient + 2]
	ld b, a

	ret

NetBallMultiplier:
; multiply catch rate by 3 if mon is water or bug type
	ld a, [wEnemyMonType1]
	cp WATER
	jr z, .ok
	cp BUG
	jr z, .ok
	ld a, [wEnemyMonType2]
	cp WATER
	jr z, .ok
	cp BUG
	ret nz

.ok
	ld a, b
	add a
	jr c, .max

	add b
	jr nc, .done
.max
	ld a, $ff
.done
	ld b, a
	ret

DiveBallMultiplier:
; multiply catch rate by 4 if surfing or fishing
	ld a, [wPlayerState]
	cp PLAYER_DIVE
	ret nz

.water
	sla b
	jr c, .max
	sla b
	ret nc
.max
	ld b, $ff
	ret

QuickBallMultiplier:
; multiply catch rate by 5 on first turn
	ld a, [wTotalBattleTurns]
	and a
	ret nz

	ld a, b

	sla b
	jr c, .max

	sla b
	jr c, .max

	add a
	ret nc

.max
	ld b, $ff
	ret

DuskBallMultiplier:
; multiply catch rate by 3 at night or in caves
	ld a, [wPermission]
	cp CAVE
	jr z, .nite

	ld a, [wTimeOfDay]
	cp NITE
	ret nz
.nite
	ld a, b
	add a
	jr c, .max

	add b
	jr nc, .done
.max
	ld a, $ff
.done
	ld b, a
	ret

Text_NoShake: ; 0xedb5
	; Oh no! The #MON broke free!
	text_jump UnknownText_0x1c5aa6
	db "@"
; 0xedba

Text_OneShake: ; 0xedba
	; Aww! It appeared to be caught!
	text_jump UnknownText_0x1c5ac3
	db "@"
; 0xedbf

Text_TwoShakes: ; 0xedbf
	; Aargh! Almost had it!
	text_jump UnknownText_0x1c5ae3
	db "@"
; 0xedc4

Text_ThreeShakes: ; 0xedc4
	; Shoot! It was so close too!
	text_jump UnknownText_0x1c5afa
	db "@"
; 0xedc9

Text_GotchaMonWasCaught: ; 0xedc9
	; Gotcha! @ was caught!@ @
	text_jump UnknownText_0x1c5b17
	start_asm
	call WaitSFX
	push bc
	ld de, MUSIC_NONE
	call PlayMusic
	call DelayFrame
	ld de, MUSIC_CAPTURE
	call PlayMusic
	pop bc
	ld hl, TextJump_Waitbutton
	ret
; ede6

TextJump_Waitbutton: ; 0xede6
	; @
	text_jump Text_Waitbutton_2
	db "@"
; 0xedeb

Text_SentToBillsPC: ; 0xedeb
	; was sent to BILL's PC.
	text_jump UnknownText_0x1c5b38
	db "@"
; 0xedf0

Text_AddedToPokedex: ; 0xedf0
	; 's data was newly added to the #DEX.@ @
	text_jump UnknownText_0x1c5b53
	db "@"
; 0xedf5

Text_AskNicknameNewlyCaughtMon: ; 0xedf5
	; Give a nickname to @ ?
	text_jump UnknownText_0x1c5b7f
	db "@"
; 0xedfa

ReturnToBattle_UseBall: ; edfa (3:6dfa)
	farjp _ReturnToBattle_UseBall


Bicycle: ; ee08
	farjp BikeFunction
; ee0f

Skateboard: ; ee08
	farjp SkateboardFunction

EvoStoneEffect:
	ld b, PARTYMENUACTION_EVO_STONE
	call UseItem_SelectMon

	jp c, .DecidedNotToUse

	ld a, MON_ITEM
	call GetPartyParamLocation

	ld a, [hl]
	cp EVERSTONE
	jr z, .NoEffect

	ld a, $1
	ld [wForceEvolution], a
	farcall EvolvePokemon

	ld a, [wMonTriedToEvolve]
	and a
	jr z, .NoEffect

	jp UseDisposableItem

.NoEffect:
	call WontHaveAnyEffectMessage

.DecidedNotToUse:
	xor a
	ld [wItemEffectSucceeded], a
	ret
; ee3d


VitaminEffect: ; ee3d
	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon

	jp c, RareCandy_StatBooster_ExitMenu

	call RareCandy_StatBooster_GetParameters

	call GetEVRelativePointer

	ld a, MON_EVS
	call GetPartyParamLocation

	add hl, bc
	ld a, [hl]
	cp 252
	jr nc, NoEffectMessage

	add 10
	jr c, .set_to_max
	cp 253
	jr c, .ev_value_ok
.set_to_max
	ld a, 252

.ev_value_ok
	ld [hl], a
	farcall UpdatePkmnStats

	call GetEVRelativePointer

	ld hl, StatStrings
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wStringBuffer2
	ld bc, ITEM_NAME_LENGTH
	rst CopyBytes

	call Play_SFX_FULL_HEAL

	ld hl, Text_StatRose
	call PrintText

	ld c, HAPPINESS_USEDITEM
	farcall ChangeHappiness

	jp UseDisposableItem


NoEffectMessage: ; ee83
	ld hl, WontHaveAnyEffectText
	call PrintText
	call ClearPalettes
	jp ClearTileMap


RareCandy_StatBooster_ExitMenu: ; ee9f
	xor a
	ld [wItemEffectSucceeded], a
	call ClearPalettes
	jp ClearTileMap
; eea6


Text_StatRose: ; 0xeea6
	; 's @  rose.
	text_jump UnknownText_0x1c5b9a
	db "@"
; 0xeeab


StatStrings: ; eeab
	dw .health
	dw .attack
	dw .defense
	dw .speed
	dw .spcl_atk
	dw .spcl_def

.health   db "HEALTH@"
.attack   db "ATTACK@"
.defense  db "DEFENSE@"
.speed    db "SPEED@"
.spcl_atk db "SPCL.ATK@"
.spcl_def db "SPCL.DEF@"
; eed9


GetEVRelativePointer: ; eed9
	ld a, [wCurItem]
	farcall CheckItemParam
	ld c, a
	ld b, 0
	ret
; eeeb


RareCandy_StatBooster_GetParameters: ; eef5
	ld a, [wCurPartySpecies]
	ld [wCurSpecies], a
	ld [wd265], a
	ld a, MON_FORM
	call GetPartyParamLocation
	ld a, [hl]
	ld [wCurForm], a
	ld a, MON_LEVEL
	call GetPartyParamLocation
	ld a, [hl]
	ld [wCurPartyLevel], a
	call GetBaseData
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames
	jp GetNick
; 0xef14


RareCandy: ; ef14
	eventflagcheck EVENT_YOU_CHEATED
	jr z, .no_clown
	jp ClownsCantUseMessage

.no_clown
	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon

	jp c, RareCandy_StatBooster_ExitMenu

	call RareCandy_StatBooster_GetParameters

	ld a, MON_LEVEL
	call GetPartyParamLocation

	ld a, [hl]
	cp MAX_LEVEL
	jp nc, NoEffectMessage

	inc a
	ld [hl], a
	ld [wCurPartyLevel], a
	push de
	ld d, a
	farcall CalcExpAtLevel

	pop de
	ld a, MON_EXP
	call GetPartyParamLocation

	ldh a, [hMultiplicand]
	ld [hli], a
	ldh a, [hMultiplicand + 1]
	ld [hli], a
	ldh a, [hMultiplicand + 2]
	ld [hl], a

	push bc
	ld a, MON_MAXHP
	call GetPartyParamLocation
	push de
	ld de, wStringBuffer3
	ld bc, 12
	rst CopyBytes
	pop de
	pop bc

	farcall UpdatePkmnStats
	farcall LevelUpHappinessMod
	call IsMonFainted
	jr nz, .skip_revive
	push de
	ld a, 0
	ld d, a
	ld a, 1
	ld e, a
	call ContinueRevive
	pop de
.skip_revive
	ld a, PARTYMENUTEXT_LEVEL_UP
	call ItemActionText

	xor a ; PARTYMON
	ld [wMonType], a
	predef CopyPkmnToTempMon

	farcall PrintStatDifferences

	xor a ; PARTYMON
	ld [wMonType], a
	ld a, [wCurPartySpecies]
	ld [wd265], a
	ld a, [wCurPartyMon]
	ld [wPlaceBallsX], a
	predef LearnLevelMoves

	xor a
	ld [wForceEvolution], a
	farcall EvolvePokemon

	jp UseDisposableItem
; efad


HealPowder: ; efad
	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon

	jp c, StatusHealer_ExitMenu

	call UseStatusHealer

	cp $0
	jr nz, .asm_efc9
	ld c, HAPPINESS_BITTERPOWDER
	farcall ChangeHappiness

	call LooksBitterMessage

	xor a

.asm_efc9
	jp StatusHealer_Jumptable
; efcc


HealStatusEffect: ; efcc
	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jp c, StatusHealer_ExitMenu

FullyHealStatus: ; efd4
	call UseStatusHealer
	jp StatusHealer_Jumptable
; efda


UseStatusHealer: ; efda (3:6fda)
	call IsMonFainted
	ld a, $1
	ret z
	call GetItemHealingAction
	ld a, MON_STATUS
	call GetPartyParamLocation
	ld a, [hl]
	and c
	jr nz, .good
	call IsItemUsedOnConfusedMon
	ld a, $1
	ret nc
	ld b, PARTYMENUTEXT_HEAL_CONFUSION
.good
	xor a
	ld [hl], a
	ld a, b
	ld [wPartyMenuActionText], a
	call HealStatus
	call Play_SFX_FULL_HEAL
	call ItemActionTextWaitButton
	call UseDisposableItem
	xor a
	ret

IsItemUsedOnConfusedMon: ; f009 (3:7009)
	call IsItemUsedOnBattleMon
	jr nc, .nope
	ld a, [wPlayerSubStatus3]
	bit SUBSTATUS_CONFUSED, a
	jr z, .nope
	ld a, c
	cp $ff
	jr nz, .nope
	scf
	ret

.nope
	and a
	ret

BattlemonRestoreHealth: ; f01e (3:701e)
	call IsItemUsedOnBattleMon
	ret nc
	ld a, MON_HP
	call GetPartyParamLocation
	ld a, [hli]
	ld [wBattleMonHP], a
	ld a, [hld]
	ld [wBattleMonHP + 1], a
	ret

HealStatus: ; f030 (3:7030)
	call IsItemUsedOnBattleMon
	ret nc
	xor a
	ld [wBattleMonStatus], a
	call GetItemHealingAction
	ld a, c
	cp -1
	ret nz
	ld hl, wPlayerSubStatus3
	res SUBSTATUS_CONFUSED, [hl]
	ret

GetItemHealingAction: ; f058 (3:7058)
	push hl
	ld a, [wCurItem]
	farcall CheckItemParam
	ld c, a
	ld hl, .StatusHealingActionTexts
.next
	cp [hl]
	jr z, .found_it
	inc hl
	inc hl
	jr .next
.found_it
	inc hl
	ld b, [hl]
	pop hl
	ret
; f071 (3:7071)

.StatusHealingActionTexts:
; status param, party menu action text
	db 1 << PSN, PARTYMENUTEXT_HEAL_PSN
	db 1 << BRN, PARTYMENUTEXT_HEAL_BRN
	db 1 << PAR, PARTYMENUTEXT_HEAL_PAR
	db 1 << FRZ, PARTYMENUTEXT_HEAL_FRZ
	db SLP,      PARTYMENUTEXT_HEAL_SLP
	db -1,       PARTYMENUTEXT_HEAL_ALL


StatusHealer_Jumptable: ; f09e (3:709e)
	ld hl, .dw
	rst JumpTable
	ret

.dw ; f0a3 (3:70a3)
	dw StatusHealer_ClearPalettes
	dw StatusHealer_NoEffect
	dw StatusHealer_ExitMenu


RevivalHerb: ; f0a9
	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jp c, StatusHealer_ExitMenu

	call RevivePokemon
	cp 0
	jr nz, .asm_f0c5

	ld c, HAPPINESS_REVIVALHERB
	farcall ChangeHappiness
	call LooksBitterMessage
	xor a

.asm_f0c5
	jp StatusHealer_Jumptable
; f0c8


ReviveEffect: ; f0c8
	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jp c, StatusHealer_ExitMenu

	call RevivePokemon
	jp StatusHealer_Jumptable
; f0d6


RevivePokemon: ; f0d6
	call IsMonFainted
	ld a, 1
	ret nz
	ld a, [wBattleMode]
	and a
	jr z, .skip_to_revive

	ld a, [wCurPartyMon]
	ld c, a
	ld d, 0
	ld hl, wBattleParticipantsIncludingFainted
	ld b, CHECK_FLAG
	predef FlagPredef
	ld a, c
	and a
	jr z, .skip_to_revive

	ld a, [wCurPartyMon]
	ld c, a
	ld hl, wBattleParticipantsNotFainted
	ld b, SET_FLAG
	predef FlagPredef

.skip_to_revive
	xor a
	ld [wLowHealthAlarm], a
	ld a, [wCurItem]
	cp REVIVE
	jr z, .revive_half_hp
	cp GOLD_TEA
	jr z, .gold_tea

.revive_full_hp
	call ReviveFullHP
	jr .finish_revive

.revive_half_hp
	call ReviveHalfHP

.finish_revive
	call HealHP_SFX_GFX
	ld a, PARTYMENUTEXT_REVIVE
	ld [wPartyMenuActionText], a
	call ItemActionTextWaitButton
	call UseDisposableItem
	xor a
	ret
.gold_tea
	ld a, [wCurItem]
	push af
	ld a, SWEET_HONEY
	ld [wCurItem], a
	ld hl, wNumMedicine
	call CheckItem
	jr nc, .no_honey
	ld a, SWEET_HONEY
	ld [wCurItem], a
	ld a, 1
	ld [wItemQuantityChangeBuffer], a
	ld hl, wNumItems
	call TossItem
	call MixSweetHoneyMessage
	ld a, SWEET_HONEY
	ld [wCurItem], a
	ld hl, wNumMedicine
	call CheckItem
	jr c, .still_have_honey
	call OutOfSweetHoneyMessage
.still_have_honey
	pop af
	ld [wCurItem], a
	jr .revive_full_hp
	
.no_honey
	pop af
	ld [wCurItem], a
	jr .revive_half_hp


FullRestore: ; f128
	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jp c, StatusHealer_ExitMenu

	call IsMonFainted
	jp z, StatusHealer_NoEffect

	call IsMonAtFullHealth
	jp nc, FullyHealStatus

	xor a
	ld [wLowHealthAlarm], a
	call ReviveFullHP
	ld a, MON_STATUS
	call GetPartyParamLocation
	xor a
	ld [hli], a
	ld [hl], a
	call HealStatus
	call BattlemonRestoreHealth
	call HealHP_SFX_GFX
	ld a, PARTYMENUTEXT_HEAL_HP
	ld [wPartyMenuActionText], a
	call ItemActionTextWaitButton
	call UseDisposableItem
	xor a
	jp StatusHealer_Jumptable
; f144


PersimBerry: ; f16a
	ld hl, wPlayerSubStatus3
	bit SUBSTATUS_CONFUSED, [hl]
	ld a, 1
	jr z, .done

	res SUBSTATUS_CONFUSED, [hl]
	xor a
	ldh [hBattleTurn], a
	call UseItemText

	ld hl, ConfusedNoMoreText
	call StdBattleTextBox

	xor a

.done
	jp StatusHealer_Jumptable
; f186

DubiousDogEffect:
	call Random
	cp $7f ; 50 percent
	jr c, RestoreHPEffect
	call ItemTakeHP
	jp StatusHealer_Jumptable

RestoreHPEffect: ; f186
	call ItemRestoreHP
	jp StatusHealer_Jumptable
; f18c

RestoreHPTeaEffect:
	call TeaRestoreHP
	jp StatusHealer_Jumptable


EnergyPowder: ; f18c
	ld c, HAPPINESS_BITTERPOWDER
	jr EnergyPowderEnergyRootCommon
; f190

EnergyRoot: ; f190
	ld c, HAPPINESS_ENERGYROOT
; f192

EnergyPowderEnergyRootCommon: ; f192
	push bc
	call ItemRestoreHP
	pop bc
	cp 0
	jr nz, .skip_happiness

	farcall ChangeHappiness
	call LooksBitterMessage
	xor a

.skip_happiness
	jp StatusHealer_Jumptable
; f1a9

TeaRestoreHP:
	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	ld a, 2
	ret c

	call IsMonFainted
	ld a, 1
	ret z

	call IsMonAtFullHealth
	ld a, 1
	ret nc
	
	ld a, [wCurItem]
	push af
	ld a, SWEET_HONEY
	ld [wCurItem], a
	ld hl, wNumMedicine
	call CheckItem
	jr nc, .no_honey
	ld a, SWEET_HONEY
	ld [wCurItem], a
	ld a, 1
	ld [wItemQuantityChangeBuffer], a
	ld hl, wNumItems
	call TossItem
	call MixSweetHoneyMessage
	ld a, SWEET_HONEY
	ld [wCurItem], a
	ld hl, wNumMedicine
	call CheckItem
	jr c, .still_have_honey
	call OutOfSweetHoneyMessage
.still_have_honey
	pop af
	ld [wCurItem], a
	xor a
	ld [wLowHealthAlarm], a
	call GetTeaHoneyHealingItemAmount
	jr ItemRestoreHP.jump2
	
.no_honey
	pop af
	ld [wCurItem], a
	jr ItemRestoreHP.jump1

ItemRestoreHP:
	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	ld a, 2
	ret c

	call IsMonFainted
	ld a, 1
	ret z

	call IsMonAtFullHealth
	ld a, 1
	ret nc
.jump1
	xor a
	ld [wLowHealthAlarm], a
	call GetHealingItemAmount
.jump2
	call RestoreHealth
	call BattlemonRestoreHealth
	call HealHP_SFX_GFX
	ld a, PARTYMENUTEXT_HEAL_HP
	ld [wPartyMenuActionText], a
	call ItemActionTextWaitButton
	call UseDisposableItem
	
	ld a, [wCurItem]
	cp SODA_POP
	jr nz, .not_soda_pop
	ld a, BOTTLE_CAP
	ld [wCurItem], a
	ld a, 1
	ld [wItemQuantityChangeBuffer], a
	ld hl, wNumItems
	call ReceiveItem
	call SaveBottleCapMessage
.not_soda_pop
	ld c, HAPPINESS_USEDITEM
	farcall ChangeHappiness
	xor a
	ret

ItemTakeHP:
	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	ld a, 2
	ret c

	call IsMonFainted
	ld a, 1
	ret z

	call IsMonAtFullHealth
	ld a, 1
	ret nc
	call GetCurHPMinus1
	call RemoveHP
	call BattlemonRestoreHealth
	call TakeHP_SFX_GFX
	ld a, PARTYMENUTEXT_DAMAGE
	ld [wPartyMenuActionText], a
	call ItemActionTextWaitButton
	call UseDisposableItem
	ld c, HAPPINESS_REVIVALHERB
	farcall ChangeHappiness
	xor a
	ret

HealHP_SFX_GFX: ; f1db (3:71db)
	push de
	ld de, SFX_POTION
	call WaitPlaySFX
	pop de
	ld a, [wCurPartyMon]
	hlcoord 11, 0
	ld bc, SCREEN_WIDTH * 2
	rst AddNTimes
	ld a, $2
	ld [wWhichHPBar], a
	predef_jump AnimateHPBar

TakeHP_SFX_GFX:
	push de
	ld de, SFX_SUPER_EFFECTIVE
	call WaitPlaySFX
	pop de
	ld a, [wCurPartyMon]
	hlcoord 11, 0
	ld bc, SCREEN_WIDTH * 2
	rst AddNTimes
	ld a, $2
	ld [wWhichHPBar], a
	predef_jump AnimateHPBar

UseItem_SelectMon2:
; Used on something already: don't reload the graphics
	ld a, b
	ld [wPartyMenuActionText], a
	push hl
	push de
	push bc
	farcall InitPartyMenuWithCancel
	farcall WritePartyMenuTilemap
	farcall PrintPartyMenuText
	farcall PartyMenuSelect
	pop bc
	pop de
	pop hl
	jr UseItem_DoSelectMon

UseItem_SelectMon: ; f1f9 (3:71f9)
	ld a, b
	ld [wPartyMenuActionText], a
	push hl
	push de
	push bc
	call ClearBGPalettes
	call ChoosePkmnToUseItemOn
	pop bc
	pop de
	pop hl
	; fallthrough

UseItem_DoSelectMon:
	ret c

	ld a, MON_IS_EGG
	call GetPartyParamLocation
	bit MON_IS_EGG_F, [hl]
	jr z, .not_egg

	call CantUseOnEggMessage
	scf
	ret

.not_egg
	and a
	ret

ChoosePkmnToUseItemOn: ; f21c (3:721c)
	farcall LoadPartyMenuGFX
	farcall InitPartyMenuWithCancel
	farcall InitPartyMenuGFX
	farcall WritePartyMenuTilemap
	farcall PrintPartyMenuText
	call ApplyTilemapInVBlank
	call SetPalettes
	call DelayFrame
	farjp PartyMenuSelect

ItemActionText: ; f24a (3:724a)
	ld [wPartyMenuActionText], a
	ld a, [wCurPartySpecies]
	push af
	ld a, [wCurPartyMon]
	push af
	push hl
	push de
	push bc
	farcall WritePartyMenuTilemap
	farcall PrintPartyMenuActionText
	call ApplyTilemapInVBlank
	call SetPalettes
	call DelayFrame
	pop bc
	pop de
	pop hl
	pop af
	ld [wCurPartyMon], a
	pop af
	ld [wCurPartySpecies], a
	ret

ItemActionTextWaitButton: ; f279 (3:7279)
	xor a
	ldh [hBGMapMode], a
	hlcoord 0, 0
	ld bc, wTileMapEnd - wTileMap
	ld a, " "
	call ByteFill
	ld a, [wPartyMenuActionText]
	call ItemActionText
	ld a, $1
	ldh [hBGMapMode], a
	ld c, 50
	call DelayFrames
	jp WaitPressAorB_BlinkCursor

StatusHealer_NoEffect: ; f299 (3:7299)
	call WontHaveAnyEffectMessage
	jr StatusHealer_ClearPalettes

StatusHealer_ExitMenu: ; f29e (3:729e)
	xor a
	ld [wItemEffectSucceeded], a
StatusHealer_ClearPalettes: ; f2a2 (3:72a2)
	call ClearPalettes
	jp ClearTileMap

IsItemUsedOnBattleMon: ; f2a6 (3:72a6)
	ld a, [wBattleMode]
	and a
	ret z
	ld a, [wCurPartyMon]
	push hl
	ld hl, wCurBattleMon
	cp [hl]
	pop hl
	jr nz, .nope
	scf
	ret

.nope
	xor a
	ret

ReviveHalfHP: ; f2ba (3:72ba)
	call LoadHPFromBuffer1
	srl d
	rr e
	jr ContinueRevive

ReviveFullHP: ; f2c3 (3:72c3)
	call LoadHPFromBuffer1
ContinueRevive: ; f2c6 (3:72c6)
	ld a, MON_HP
	call GetPartyParamLocation
	ld [hl], d
	inc hl
	ld [hl], e
	jp LoadCurHPIntoBuffer5

RestoreHealth: ; f2d1 (3:72d1)
	ld a, MON_HP + 1
	call GetPartyParamLocation
	ld a, [hl]
	add e
	ld [hld], a
	ld a, [hl]
	adc d
	ld [hl], a
	jr c, .full_hp
	call LoadCurHPIntoBuffer5
	ld a, MON_HP + 1
	call GetPartyParamLocation
	ld d, h
	ld e, l
	ld a, MON_MAXHP + 1
	call GetPartyParamLocation
	ld a, [de]
	sub [hl]
	dec de
	dec hl
	ld a, [de]
	sbc [hl]
	ret c
.full_hp
	jp ReviveFullHP

RemoveHP: ; f2f9 (3:72f9)
	ld a, MON_HP + 1
	call GetPartyParamLocation
	ld a, [hl]
	sub e
	ld [hld], a
	ld a, [hl]
	sbc d
	ld [hl], a
	jr nc, .okay
	xor a
	ld [hld], a
	ld [hl], a
.okay
	jp LoadCurHPIntoBuffer5

IsMonFainted: ; f30d (3:730d)
	push de
	call LoadMaxHPToBuffer1
	call LoadCurHPToBuffer3
	call LoadHPFromBuffer3
	ld a, d
	or e
	pop de
	ret

IsMonAtFullHealth: ; f31b (3:731b)
	call LoadHPFromBuffer3
	ld h, d
	ld l, e
	call LoadHPFromBuffer1
	ld a, l
	sub e
	ld a, h
	sbc d
	ret

LoadCurHPIntoBuffer5: ; f328 (3:7328)
	ld a, MON_HP
	call GetPartyParamLocation
	ld a, [hli]
	ld [wBuffer6], a
	ld a, [hl]
	ld [wBuffer5], a
	ret
; f336 (3:7336)

LoadCurHPToBuffer3: ; f348 (3:7348)
	ld a, MON_HP
	call GetPartyParamLocation
	ld a, [hli]
	ld [wBuffer4], a
	ld a, [hl]
	ld [wBuffer3], a
	ret

LoadHPFromBuffer3: ; f356 (3:7356)
	ld a, [wBuffer4]
	ld d, a
	ld a, [wBuffer3]
	ld e, a
	ret

LoadMaxHPToBuffer1: ; f35f (3:735f)
	push hl
	ld a, MON_MAXHP
	call GetPartyParamLocation
	ld a, [hli]
	ld [wBuffer2], a
	ld a, [hl]
	ld [wBuffer1], a
	pop hl
	ret

LoadHPFromBuffer1: ; f36f (3:736f)
	ld a, [wBuffer2]
	ld d, a
	ld a, [wBuffer1]
	ld e, a
	ret

GetCurHPMinus1:
	call LoadCurHPToBuffer3
	ld a, [wBuffer4]
	ld d, a
	ld a, [wBuffer3]
	dec a
	ld e, a
	ret

GetOneFifthMaxHP: ; f378 (3:7378)
	push bc
	ld a, MON_MAXHP
	call GetPartyParamLocation
	ld a, [hli]
	ldh [hDividend + 0], a
	ld a, [hl]
	ldh [hDividend + 1], a
	ld a, 5
	ldh [hDivisor], a
	ld b, 2
	call Divide
	ldh a, [hQuotient + 1]
	ld d, a
	ldh a, [hQuotient + 2]
	ld e, a
	pop bc
	ret

GetTeaHoneyHealingItemAmount:
	ld a, [wCurItem]
	cp SILVER_TEA
	jr z, .silver_tea
	add a
	ld e, a
	ld d, 0
	cp -1
	ret nz
	ld de, 999
	ret
.silver_tea
	ld a, MON_MAXHP
	call GetPartyParamLocation
	ld a, [hli]
	ld d, a
	ld e, [hl]
	ret

GetHealingItemAmount: ; f395 (3:7395)
	ld a, [wCurItem]
	cp SITRUS_BERRY
	jr z, .sitrus_berry
	cp FIGY_BERRY
	jr z, .figy_berry
	cp SILVER_TEA
	jr z, .figy_berry

	farcall CheckItemParam
	ld e, a
	ld d, 0
	cp -1
	ret nz
	ld de, 999
	ret
; f3af (3:73af)

.figy_berry
	call .set_de_to_hp
	jr .half_hp

.sitrus_berry
	call .set_de_to_hp
	srl d
	rr e
.half_hp
	srl d
	rr e
	ld a, d
	or e
	ret nz
	ld e, 1
	ret

.set_de_to_hp
	ld a, MON_MAXHP
	call GetPartyParamLocation
	ld a, [hli]
	ld d, a
	ld e, [hl]
	ret

Softboiled_MilkDrinkFunction: ; f3df (3:73df)
; Softboiled/Milk Drink in the field
	ld a, [wPartyMenuCursor]
	dec a
	ld b, a
	call .SelectMilkDrinkRecipient ; select pokemon
	jr c, .skip
	ld a, b
	ld [wCurPartyMon], a
	call IsMonFainted
	call GetOneFifthMaxHP
	call RemoveHP
	push bc
	call HealHP_SFX_GFX
	pop bc
	call GetOneFifthMaxHP
	ld a, c
	ld [wCurPartyMon], a
	call IsMonFainted
	call RestoreHealth
	call HealHP_SFX_GFX
	ld a, PARTYMENUTEXT_HEAL_HP
	call ItemActionText
	call JoyWaitAorB
.skip
	ld a, b
	inc a
	ld [wPartyMenuCursor], a
	ret

.SelectMilkDrinkRecipient: ; f419 (3:7419)
.loop
	push bc
	ld a, PARTYMENUACTION_HEALING_ITEM
	ld [wPartyMenuActionText], a
	call ChoosePkmnToUseItemOn
	pop bc
	jr c, .set_carry
	ld a, [wPartyMenuCursor]
	dec a
	ld c, a
	ld a, b
	cp c
	jr z, .cant_use ; chose the same mon as user
	ld a, c
	ld [wCurPartyMon], a
	call IsMonFainted
	jr z, .cant_use
	call IsMonAtFullHealth
	jr nc, .cant_use
	xor a
	ret

.set_carry
	scf
	ret

.cant_use
	push bc
	ld hl, .Text_CantBeUsed
	call MenuTextBoxBackup
	pop bc
	jr .loop
; f44a (3:744a)

.Text_CantBeUsed: ; 0xf44a
	; That can't be used on this #MON.
	text_jump UnknownText_0x1c5bac
	db "@"
; 0xf44f


EscapeRope: ; f44f
	xor a
	ld [wItemEffectSucceeded], a
	farcall EscapeRopeFunction

	ld a, [wItemEffectSucceeded]
	cp 1
	call z, UseDisposableItem
	ret
; f462


RepelEffect: ; f46c
	ld a, [wRepelEffect]
	and a
	ld hl, TextJump_RepelUsedEarlierIsStillInEffect
	jp nz, PrintText

	farcall CheckItemParam
	ld [wRepelEffect], a

	ld a, [wCurItem]
	ld [wRepelType], a

	jp UseItemText

TextJump_RepelUsedEarlierIsStillInEffect: ; 0xf47d
	; The REPEL used earlier is still in effect.
	text_jump Text_RepelUsedEarlierIsStillInEffect
	db "@"
; 0xf482


PokeDoll: ; f48f
	ld a, [wBattleMode]
	dec a
	jr nz, .asm_f4a6
	inc a
	ld [wBattleEnded], a
	xor a
	ld [wPlaceBallsX], a
	ld [wPlaceBallsY], a
	ld a, [wBattleResult]
	and 3 << 6
	or $2
	ld [wBattleResult], a
	call UseItemText
	call ClearBGPalettes
	jp ClearTileMap

.asm_f4a6
	xor a
	ld [wItemEffectSucceeded], a
	ret
; f4ab


GuardSpec: ; f4ab
	ld hl, wPlayerSubStatus4
	bit SUBSTATUS_MIST, [hl]
	jp nz, WontHaveAnyEffect_NotUsedMessage
	set SUBSTATUS_MIST, [hl]
	jp UseItemText
; f4b8


DireHit: ; f4b8
	ld hl, wPlayerSubStatus4
	bit SUBSTATUS_FOCUS_ENERGY, [hl]
	jp nz, WontHaveAnyEffect_NotUsedMessage
	set SUBSTATUS_FOCUS_ENERGY, [hl]
	jp UseItemText
; f4c5


XItemEffect: ; f4c5
	call UseItemText

	farcall CheckItemParam
	ld b, a

	xor a
	ldh [hBattleTurn], a
	ld [wAttackMissed], a
	ld [wEffectFailed], a
	farcall CheckIfStatCanBeRaised
	call WaitSFX

	farcall BattleCommand_statupmessage
	farcall BattleCommand_statupfailtext

	ld a, [wCurBattleMon]
	ld [wCurPartyMon], a
	ld c, HAPPINESS_USEDXITEM
	farcall ChangeHappiness
	call ClearPalettes
	jp ClearTileMap


;BlueCard: ; f58f
;	ld hl, .bluecardtext
;	jp MenuTextBoxWaitButton

;.bluecardtext
;	text_jump UnknownText_0x1c5c5e
;	db "@"

TapePlayer:
	farjp TapePlayerFunction

CoinCase: ; f59a
	ld hl, .coincasetext
	jp MenuTextBoxWaitButton

.coincasetext
	text_jump UnknownText_0x1c5c7b
	db "@"

PollenPouch:
	ld hl, .pollenpouchtext
	jp MenuTextBoxWaitButton

.pollenpouchtext
	text_jump PollenPouchText
	db "@"

ApricornBox:
	ld hl, .MenuDataHeader
	call LoadMenuDataHeader
	hlcoord 5, 1
	lb bc, 9, 13
	call TextBox
	call UpdateSprites
	call ApplyTilemap
	hlcoord 6, 3
	lb bc, 8, 13
	call ClearBox
	ld hl, .Text
	bccoord 6, 3
	call PlaceWholeStringInBoxAtOnce
	call PrintAprValues
	call WaitButton
	jp ExitMenu

.MenuDataHeader:
	db $40 ; flags
	db 01, 05 ; start coords
	db 11, 19 ; end coords
	dw VTiles0
	db 0 ; default option

.Text
	db "<START>"
	db " Red   Blu<LNBRK>"
	db "   ×     ×<LNBRK>"
	db " Ylw   Grn<LNBRK>"
	db "   ×     ×<LNBRK>"
	db " Wht   Blk<LNBRK>"
	db "   ×     ×<LNBRK>"
	db " Pnk<LNBRK>"
	db "   ×@@"

PrintAprValues:
	ret


OldRod: ; f5a5
	ld e, $0
	jr UseRod
; f5a9

GoodRod: ; f5a9
	ld e, $1
	jr UseRod
; f5ad

SuperRod: ; f5ad
	ld e, $2
	; fallthrough

UseRod: ; f5b1
	farjp FishFunction
; f5b8


Itemfinder: ; f5b8
	farjp ItemFinder
; f5bf


RestorePPEffect: ; f5bf
	ld a, [wCurItem]
	ld [wd002], a

.loop
	; Party Screen opens to choose on which Pkmn to use the Item
	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
	jp c, PPRestoreItem_Cancel

.loop2
	ld a, [wd002]
	cp MAX_ELIXIR
	jp z, Elixir_RestorePPofAllMoves
	cp ELIXIR
	jp z, Elixir_RestorePPofAllMoves

	ld hl, TextJump_RaiseThePPOfWhichMove
	ld a, [wd002]
	cp PP_UP
	jr z, .ppup
	cp PP_MAX
	jr z, .ppup
	ld hl, TextJump_RestoreThePPOfWhichMove

.ppup
	call PrintText

	ld a, [wCurMoveNum]
	push af
	xor a
	ld [wCurMoveNum], a
	inc a
	ld [wMoveSelectionMenuType], a
	farcall MoveSelectionScreen2
	pop bc

	ld a, b
	ld [wCurMoveNum], a
	jr nz, .loop
	ld hl, wPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	call GetMthMoveOfNthPartymon

	push hl
	ld a, [hl]
	ld [wd265], a
	push hl
	push de
	farcall CheckMultiMoveSlot2
	jr nc, .not_multi_move_slot
	pop de
	pop hl
	farcall GetMultiMoveSlotName2
	jr .done_multi_move
.not_multi_move_slot
	pop de
	pop hl
	call GetMoveName
.done_multi_move
	call CopyName1
	pop hl

	ld a, [wd002]
	cp PP_UP
	jr z, .ppup2
	cp PP_MAX
	jp nz, Not_PP_Up

.ppup2
	ld a, [hl]
	cp TRANSFORM_SKETCH_MIMIC_SPLASH_METRO ;TODO: Only do this for Smeargle
	jr z, .CantUsePPUpOnSketch

	ld bc, MON_PP - MON_MOVES
	add hl, bc
	ld a, [hl]
	cp 3 << 6 ; have 3 PP Ups already been used?
	jr c, .do_ppup

.CantUsePPUpOnSketch:
.pp_is_maxed_out
	ld hl, TextJump_PPIsMaxedOut
	call PrintText
	jp .loop2

.do_ppup
	push hl
	ld c, HAPPINESS_USEDITEM
	farcall ChangeHappiness
	pop hl
	ld c, 3 << 6
	ld a, [wd002]
	cp PP_MAX
	ld b, 3
	jr z, .pp_restore_loop
	ld b, 1
.pp_restore_loop
	push hl
	push bc
	ld a, [hl]
	add 1 << 6 ; increase PP Up count by 1
	ld [hl], a
	ld a, TRUE
	ld [wd265], a
	call ApplyPPUp
	pop bc
	pop hl

	; Unless PP is maxed, we might want to continue increasing PP further.
	ld a, [hl]
	and c
	cp c
	jr z, .maxed_pp
	dec b
	jr nz, .pp_restore_loop
.maxed_pp
	call Play_SFX_FULL_HEAL

	ld hl, TextJump_PPsIncreased
	ld a, [wd002]
	cp PP_UP
	jr z, .ppup3
	ld hl, TextJump_PPsMaximized
.ppup3
	call PrintText

FinishPPRestore: ; f64c
	call ClearPalettes
	jp UseDisposableItem
; f652

BattleRestorePP: ; f652
	ld a, [wBattleMode]
	and a
	jr z, .not_in_battle
	ld a, [wCurPartyMon]
	ld b, a
	ld a, [wCurBattleMon]
	cp b
	jr nz, .not_in_battle
	ld a, [wPlayerSubStatus2]
	bit SUBSTATUS_TRANSFORMED, a
	jr nz, .not_in_battle
	call .UpdateBattleMonPP

.not_in_battle
	call Play_SFX_FULL_HEAL
	ld hl, UnknownText_0xf739
	call PrintText
	jr FinishPPRestore

.UpdateBattleMonPP:
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	ld de, wBattleMonMoves
	ld b, NUM_MOVES
.loop
	ld a, [de]
	and a
	ret z
	cp [hl]
	jr nz, .next
	push hl
	push de
	push bc
rept NUM_MOVES + 5 ; wBattleMonPP - wBattleMonMoves
	inc de
endr
	ld bc, MON_PP - MON_MOVES
	add hl, bc
	ld a, [hl]
	ld [de], a
	pop bc
	pop de
	pop hl

.next
	inc hl
	inc de
	dec b
	jr nz, .loop
	ret
; f6a7

Not_PP_Up: ; f6a7
	call RestorePP
	jr nz, BattleRestorePP
	jp PPRestoreItem_NoEffect
; f6af

Elixir_RestorePPofAllMoves: ; f6af
	xor a
	ld hl, wMenuCursorY
	ld [hli], a
	ld [hl], a
	ld b, NUM_MOVES
.moveLoop
	push bc
	ld hl, wPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	call GetMthMoveOfNthPartymon
	ld a, [hl]
	and a
	jr z, .next

	call RestorePP
	jr z, .next
	ld hl, wMenuCursorX
	inc [hl]

.next
	ld hl, wMenuCursorY
	inc [hl]
	pop bc
	dec b
	jr nz, .moveLoop
	ld a, [wMenuCursorX]
	and a
	jp nz, BattleRestorePP

PPRestoreItem_NoEffect: ; f6dd
	call WontHaveAnyEffectMessage

PPRestoreItem_Cancel: ; f6e0
	call ClearPalettes
	xor a
	ld [wItemEffectSucceeded], a
	ret
; f6e8

RestorePP: ; f6e8
	xor a ; PARTYMON
	ld [wMonType], a
	call GetMaxPPOfMove
	ld hl, wPartyMon1PP
	ld bc, PARTYMON_STRUCT_LENGTH
	call GetMthMoveOfNthPartymon
	ld a, [wd265]
	ld b, a
	ld a, [hl]
	and (1 << 6) - 1
	cp b
	jr nc, .dont_restore

	ld a, [wd002]
	cp MAX_ELIXIR
	jr z, .restore_all
	cp MAX_ETHER
	jr z, .restore_all

	ld c, 10
	cp LEPPA_BERRY
	jr z, .restore_some

	ld c, 10

.restore_some
	ld a, [hl]
	and (1 << 6) - 1
	add c
	cp b
	jr nc, .restore_all
	ld b, a

.restore_all
	ld a, [hl]
	and 3 << 6
	or b
	ld [hl], a
	ret

.dont_restore
	xor a
	ret
; f725

TextJump_RaiseThePPOfWhichMove: ; 0xf725
	; Raise the PP of which move?
	text_jump Text_RaiseThePPOfWhichMove
	db "@"
; 0xf72a

TextJump_RestoreThePPOfWhichMove: ; 0xf72a
	; Restore the PP of which move?
	text_jump Text_RestoreThePPOfWhichMove
	db "@"
; 0xf72f

TextJump_PPIsMaxedOut: ; 0xf72f
	; 's PP is maxed out.
	text_jump Text_PPIsMaxedOut
	db "@"
; 0xf734

TextJump_PPsIncreased: ; 0xf734
	; 's PP increased.
	text_jump Text_PPsIncreased
	db "@"
; 0xf739

TextJump_PPsMaximized:
	; 's PP maximized.
	text_jump Text_PPsMaximized
	db "@"

UnknownText_0xf739: ; 0xf739
	; PP was restored.
	text_jump UnknownText_0x1c5cf1
	db "@"
; 0xf73e


PokeFlute: ; f73e
	farjp _PokeFlute

NettSpecs: ; f73e
	farjp _NettSpecs

SacredAsh: ; f753
	farcall _SacredAsh
	ld a, [wItemEffectSucceeded]
	cp $1
	ret nz
	jp UseDisposableItem
; f763

NoEffect: ; f77d
	ld a, [wOptions1]
	bit DEBUG_MODE, a
	jp nz, .debugwhiteout
	xor a
	ld [wItemEffectSucceeded], a
	ret

.debugwhiteout
	ld hl, .Whiteout
	call QueueScript
	ld a, $1
	ld [wItemEffectSucceeded], a
	ret

.Whiteout
	farjump Script_OverworldWhiteout

Play_SFX_FULL_HEAL:
	push de
	ld de, SFX_FULL_HEAL
	call WaitPlaySFX
	pop de
	ret
	
Play_SFX_LEVEL_UP:
	push de
	ld de, SFX_LEVEL_UP
	call WaitPlaySFX
	pop de
	ret

UseItemText: ; f789
	ld hl, UsedItemText
	call PrintText
	call Play_SFX_FULL_HEAL
	call WaitPressAorB_BlinkCursor
UseDisposableItem: ; f795
	ld hl, wNumItems
	ld a, 1
	ld [wItemQuantityChangeBuffer], a
	xor a
	ld [wPlaceBallsX], a
	jp TossItem
; f7a0

UseBallInTrainerBattle: ; f7a0
	call ReturnToBattle_UseBall
	ld de, ANIM_THROW_POKE_BALL
	ld a, e
	ld [wFXAnimIDLo], a
	ld a, d
	ld [wFXAnimIDHi], a
	xor a
	ld [wBattleAnimParam], a
	ldh [hBattleTurn], a
	ld [wNumHits], a
	predef PlayBattleAnim
	ld hl, BlockedTheBallText
	call PrintText
	ld hl, DontBeAThiefText
	call PrintText
	jr UseDisposableItem
; f7ca

LooksBitterMessage: ; f7d6
	ld hl, LooksBitterText
	jp PrintText
; f7dc

SaveBottleCapMessage:
	ld hl, SaveBottleCapText
	jp PrintText
	
MixSweetHoneyMessage:
	ld hl, MixSweetHoneyText
	jp PrintText
	
OutOfSweetHoneyMessage:
	ld hl, OutOfSweetHoneyText
	jp PrintText
	
ClownsCantUseMessage:
	ld hl, ClownsCantUseText
	jp PrintText

WontHaveAnyEffect_NotUsedMessage: ; f7ca
	ld hl, WontHaveAnyEffectText
	jr ItemWasntUsedMessage
; f7d6

Ball_BoxIsFullMessage: ; f7dc
	ld hl, Ball_BoxIsFullText
	jr ItemWasntUsedMessage

Ball_MonIsHiddenMessage:
	ld hl, Ball_MonIsHiddenText
	jr ItemWasntUsedMessage

Ball_MonCantBeCaughtMessage:
	ld hl, Ball_MonCantBeCaughtText
	jr ItemWasntUsedMessage

Revive_NuzlockeFailureMessage:
	ld hl, Revive_NuzlockeFailureText
	; fallthrough

ItemWasntUsedMessage:
	; Item wasn't used.
	ld a, $2
	ld [wItemEffectSucceeded], a
	jp PrintText
; f7e8

Ball_NuzlockeFailureMessage:
	ld hl, Ball_NuzlockeFailureText
	call PrintText

	ld a, [wCurItem]
	cp PARK_BALL
	ret z
	cp SAFARI_BALL
	ret z

	; Item wasn't used.
	ld a, $2
	ld [wItemEffectSucceeded], a
	jp PrintText

CantUseOnEggMessage: ; f7e8
	ld hl, CantUseOnEggText
	jr CantUseItemMessage

;IsntTheTimeMessage: ; f7ed
;	ld hl, IsntTheTimeText
;	jr CantUseItemMessage

WontHaveAnyEffectMessage: ; f7f2
	ld hl, WontHaveAnyEffectText
	; fallthrough

CantUseItemMessage: ; f804
; Item couldn't be used.
	xor a
	ld [wItemEffectSucceeded], a
	jp PrintText
; f80b

LooksBitterText: ; 0xf80b
	; It looks bitter…
	text_jump UnknownText_0x1c5d3e
	db "@"
; 0xf810

SaveBottleCapText:
	; Better save the…
	text_jump UnknownText_SaveBottleCap
	db "@"

MixSweetHoneyText:
	; <PLAYER> mixed in some…
	text_jump UnknownText_MixSweetHoney
	db "@"
	
OutOfSweetHoneyText:
	; <PLAYER> mixed in some…
	text_jump UnknownText_OutOfSweetHoney
	db "@"

ClownsCantUseText:
	; Clowns cant do that…
	text_jump UnknownText_ClownSave
	db "@"

CantUseOnEggText: ; 0xf810
	; That can't be used on an EGG.
	text_jump UnknownText_0x1c5d50
	db "@"
; 0xf815

;IsntTheTimeText: ; 0xf815
	; OAK:  ! This isn't the time to use that!
;	text_jump UnknownText_0x1c5d6e
;	db "@"
; 0xf81a

WontHaveAnyEffectText: ; 0xf81f
	; It won't have any effect.
	text_jump UnknownText_0x1c5db6
	db "@"
; 0xf824

BlockedTheBallText: ; 0xf824
	; The trainer blocked the BALL!
	text_jump UnknownText_0x1c5dd0
	db "@"
; 0xf829

DontBeAThiefText: ; 0xf829
	; Don't be a thief!
	text_jump UnknownText_0x1c5def
	db "@"

BallPhasedThruText: ; 0xf824
	text_jump UnknownText_BallPhasedThru
	db "@"

Ball_BoxIsFullText: ; 0xf838
	; The #MON BOX is full. That can't be used now.
	text_jump UnknownText_0x1c5e3a
	db "@"
; 0xf83d

Ball_BoxIsTotallyFullText:
	text_jump BoxIsTotallyFullText
	db "@"
	
BoxIsTotallyFullText:
	text "Your PC BOX is"
	line "completely full!"
	
	para "No more #MON"
	line "can be caught!"
	prompt

Ball_BoxIsFullAskSwitchText:
	text_jump BoxIsFullAskSwitchText
	db "@"

BoxIsFullAskSwitchText:
	text "The #MON BOX"
	line "is full."
	
	para "Save the game"
	line "and switch boxes?"
	done

Ball_MonIsHiddenText:
	; The #MON can't be seen!
	text_jump Text_MonIsHiddenFromBall
	db "@"

Ball_MonCantBeCaughtText:
	; The #MON can't be caught!
	text_jump Text_MonCantBeCaught
	db "@"

Ball_NuzlockeFailureText:
	; You already encountered a #MON here.
	text_jump Text_NuzlockeBallFailure
	db "@"

Revive_NuzlockeFailureText:
	; You can't revive #MON in NUZLOCKE mode!
	text_jump Text_NuzlockeReviveFailure
	db "@"

UsedItemText: ; 0xf83d
	; used the@ .
	text_jump UnknownText_0x1c5e68
	db "@"
; 0xf842


ApplyPPUp: ; f84c
	ld a, MON_MOVES
	call GetPartyParamLocation
	push hl
	ld de, wBuffer1
	predef FillPP
	pop hl
	ld bc, MON_PP - MON_MOVES
	add hl, bc
	ld de, wBuffer1
	ld b, 0
.loop
	inc b
	ld a, b
	cp NUM_MOVES + 1
	ret z
	ld a, [wd265]
	dec a
	jr nz, .use
	ld a, [wMenuCursorY]
	inc a
	cp b
	jr nz, .skip

.use
	ld a, [hl]
	and 3 << 6
	call nz, ComputeMaxPP

.skip
	inc hl
	inc de
	jr .loop
; f881



ComputeMaxPP: ; f881
	push bc
	; Divide the base PP by 5.
	ld a, [de]
	ldh [hDividend + 3], a
	xor a
	ldh [hDividend], a
	ldh [hDividend + 1], a
	ldh [hDividend + 2], a
	ld a, 5
	ldh [hDivisor], a
	ld b, 4
	call Divide
	; Get the number of PP, which are bits 6 and 7 of the PP value stored in RAM.
	ld a, [hl]
	ld b, a
	swap a
	and $f
	srl a
	srl a
	ld c, a
	; If this value is 0, we are done
	and a
	jr z, .NoPPUp

.loop
	; Normally, a move with 40 PP would have 64 PP with three PP Ups.
	; Since this would overflow into bit 6, we prevent that from happening
	; by decreasing the extra amount of PP each PP Up provides, resulting
	; in a maximum of 61.
	ldh a, [hQuotient + 2]
	cp $8
	jr c, .okay
	ld a, $7

.okay
	add b
	ld b, a
	ld a, [wd265]
	dec a
	jr z, .NoPPUp
	dec c
	jr nz, .loop

.NoPPUp:
	ld [hl], b
	pop bc
	ret
; f8b9

RestoreAllPP: ; f8b9
	ld a, MON_PP
	call GetPartyParamLocation
	push hl
	ld a, MON_MOVES
	call GetPartyParamLocation
	pop de
	xor a ; PARTYMON
	ld [wMenuCursorY], a
	ld [wMonType], a
	ld c, NUM_MOVES
.loop
	ld a, [hli]
	and a
	ret z
	push hl
	push de
	push bc
	call GetMaxPPOfMove
	pop bc
	pop de
	ld a, [de]
	and 3 << 6
	ld b, a
	ld a, [wd265]
	add b
	ld [de], a
	inc de
	ld hl, wMenuCursorY
	inc [hl]
	pop hl
	dec c
	jr nz, .loop
	ret
; f8ec


GetMaxPPOfMove: ; f8ec
	ld a, [wStringBuffer1 + 0]
	push af
	ld a, [wStringBuffer1 + 1]
	push af

	ld a, [wMonType]
	and a

	ld hl, wPartyMon1Moves
	ld bc, PARTYMON_STRUCT_LENGTH
	jr z, .got_partymon ; PARTYMON

	ld hl, wOTPartyMon1Moves
	dec a
	jr z, .got_partymon ; OTPARTYMON

	ld hl, wTempMonMoves
	dec a
	jr z, .got_nonpartymon ; BOXMON
	dec a
	jr z, .got_nonpartymon ; BREEDMON

	ld hl, wBattleMonMoves ; WILDMON

.got_nonpartymon ; BOXMON, BREEDMON, WILDMON
	call GetMthMoveOfCurrentMon
	jr .gotdatmove

.got_partymon ; PARTYMON, OTPARTYMON
	call GetMthMoveOfNthPartymon

.gotdatmove
	ld a, [hl]
	dec a

	push hl
	ld hl, Moves + MOVE_PP
	ld bc, MOVE_LENGTH
	rst AddNTimes
	ld a, BANK(Moves)
	call GetFarByte
	ld b, a
	ld de, wStringBuffer1
	ld [de], a
	pop hl

	push bc
	ld bc, MON_PP - MON_MOVES
	ld a, [wMonType]
	cp WILDMON
	jr nz, .notwild
	ld bc, wEnemyMonPP - wEnemyMonMoves
.notwild
	add hl, bc
	ld a, [hl]
	and 3 << 6
	pop bc

	or b
	ld hl, wStringBuffer1 + 1
	ld [hl], a
	xor a
	ld [wd265], a
	call ComputeMaxPP
	ld a, [hl]
	and (1 << 6) - 1
	ld [wd265], a

	pop af
	ld [wStringBuffer1 + 1], a
	pop af
	ld [wStringBuffer1 + 0], a
	ret
; f963

GetMthMoveOfNthPartymon: ; f963
	ld a, [wCurPartyMon]
	rst AddNTimes

GetMthMoveOfCurrentMon: ; f969
	ld a, [wMenuCursorY]
	ld c, a
	ld b, 0
	add hl, bc
	ret
; f971

AbilityCap:
; If a pokémon doesn't have its hidden ability, switch between its
; 1st and 2nd ability
	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon
.loop
	jr c, .abort

	push hl
	ld a, MON_ABILITY
	call GetPartyParamLocation
	ld a, [hl]
	and ABILITY_MASK
	cp HIDDEN_ABILITY
	jr nz, .normal
	;hidden ability
	ld d, h
	ld e, l
	push de
	ld hl, ChangeHiddenAbilityText
	call PrintText
	pop de
	pop hl
	push hl
	ld a, MON_SPECIES
	call GetPartyParamLocation
	ld a, [hl]
	ld [wCurSpecies], a
	call GetBaseData
	jr .ability_1
	
.normal
	; Check if the ability would change
	ld d, h
	ld e, l
	pop hl
	push hl
	ld a, MON_SPECIES
	call GetPartyParamLocation
	ld a, [hl]
	ld [wCurSpecies], a
	call GetBaseData
	ld a, [wBaseAbility1]
	ld b, a
	ld a, [wBaseAbility2]
	cp b
	jr z, .no_effect

	; Ability would change: ask for a confirmation
	ld a, [de]
	and ABILITY_MASK
	cp ABILITY_1
	ld a, [wBaseAbility2]
	ld c, ABILITY_2
	jr z, .got_new_ability
.ability_1
	ld a, [wBaseAbility1]
	ld c, ABILITY_1
.got_new_ability
	ld b, a
	push bc
	push de
	farcall BufferAbility
	ld hl, ChangeAbilityToText
	call PrintText
	call YesNoBox
	pop de
	pop bc
	pop hl
	jr c, .loopnext

	; Change ability
	ld a, ABILITY_MASK
	cpl
	ld h, d
	ld l, e
	and [hl]
	or c
	ld [hl], a
	call UseDisposableItem
	call Play_SFX_LEVEL_UP
	ld hl, AbilityChangedText
	call PrintText
	call WaitSFX
.abort
	call ClearPalettes
	jp ClearTileMap

.no_effect
	call WontHaveAnyEffectMessage
	pop hl
.loopnext
	ld b, PARTYMENUACTION_HEALING_ITEM
	call UseItem_SelectMon2
	jp .loop

ChangeHiddenAbilityText:
	text "This #MON has"
	line "a HIDDEN ABILITY."
	
	para "If changed, it can"
	line "not be recovered!"
	prompt
	

ChangeAbilityToText:
	text "Change ability to"
	line "@"
	text_from_ram wStringBuffer1
	text "?"
	done

AbilityChangedText:
	text "The ability was"
	line "changed!"
	done

INCLUDE "engine/battle_anims/pokeball_wobble.asm"
