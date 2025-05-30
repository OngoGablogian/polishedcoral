CheckChlorophialshine:
	ldh a, [hBattleTurn]
	and a
	ld hl, wBattleMonSpecies
	jr z, .got_species3
	ld hl, wEnemyMonSpecies
.got_species3
	ld a, [hl]
	cp SUNFLORA
	ret nz
	farcall GetUserItemAfterUnnerve
	ld a, b
	cp HELD_CHLOROPHIAL
	ret nz
	ld a, WEATHER_SUN
	ld b, a
	ld a, [wWeather]
	cp b
	ret nz
	farcall ItemRecoveryAnim
	ld hl, BattleText_Chlorophial
	call StdBattleTextBox
	farcall ConsumeUserItem
	jp FlowerGiftAbility

RunActivationAbilitiesInner:
	call CheckChlorophialshine
	call SwitchTurn
	call CheckChlorophialshine
	call SwitchTurn
	ld hl, BattleEntryAbilities
	jr UserAbilityJumptable

RunEnemyStatusHealAbilities:
	call CallOpponentTurn
RunStatusHealAbilities:
	ld hl, StatusHealAbilities
UserAbilityJumptable:
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
AbilityJumptable:
	; If we at some point make the AI learn abilities, keep this.
	; For now it just jumps to the general jumptable function
	jp BattleJumptable

BattleEntryAbilities:
	dbw FLOWER_GIFT, FlowerGiftAbility
	dbw TRACE, TraceAbility
	dbw IMPOSTER, ImposterAbility
	dbw DRIZZLE, DrizzleAbility
	dbw DROUGHT, DroughtAbility
	dbw SAND_STREAM, SandStreamAbility
	dbw SNOW_WARNING, SnowWarningAbility
	dbw CLOUD_NINE, CloudNineAbility
	dbw INTIMIDATE, IntimidateAbility
	dbw PRESSURE, PressureAbility
	dbw DOWNLOAD, DownloadAbility
	dbw MOLD_BREAKER, MoldBreakerAbility
	dbw ANTICIPATION, AnticipationAbility
	dbw FOREWARN, ForewarnAbility
	dbw FRISK, FriskAbility
	dbw UNNERVE, UnnerveAbility
	; fallthrough
StatusHealAbilities:
; Status immunity abilities that autoproc if the user gets the status or the ability
	dbw LIMBER, LimberAbility
	dbw IMMUNITY, ImmunityAbility
	dbw MAGMA_ARMOR, MagmaArmorAbility
	dbw WATER_VEIL, WaterVeilAbility
	dbw INSOMNIA, InsomniaAbility
	dbw VITAL_SPIRIT, VitalSpiritAbility
	dbw OWN_TEMPO, OwnTempoAbility
	dbw OBLIVIOUS, ObliviousAbility
	dbw -1, -1

CloudNineAbility:
	ld hl, NotifyCloudNine
	jr NotificationAbilities
PressureAbility:
	ld hl, NotifyPressure
	jr NotificationAbilities
MoldBreakerAbility:
	ld hl, NotifyMoldBreaker
	jr NotificationAbilities
UnnerveAbility:
	ld hl, NotifyUnnerve
NotificationAbilities:
	jp StdBattleTextBox

ImmunityAbility:
	ld a, 1 << PSN
	jr HealStatusAbility
WaterVeilAbility:
	ld a, 1 << BRN
	jr HealStatusAbility
MagmaArmorAbility:
	ld a, 1 << FRZ
	jr HealStatusAbility
LimberAbility:
	ld a, 1 << PAR
	jr HealStatusAbility
InsomniaAbility:
VitalSpiritAbility:
	ld a, SLP
	; fallthrough
HealStatusAbility:
	ld b, a
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and b
	ret z ; not afflicted/wrong status
	call ShowAbilityActivation
	ld a, BATTLE_VARS_STATUS
	call GetBattleVarAddr
	xor a
	ld [hl], a
	ld hl, BecameHealthyText
	call StdBattleTextBox
	ldh a, [hBattleTurn]
	and a
	jp z, UpdateBattleMonInParty
	jp UpdateEnemyMonInParty

OwnTempoAbility:
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVar
	and SUBSTATUS_CONFUSED
	ret z ; not confused
	call ShowAbilityActivation
	ld a, BATTLE_VARS_SUBSTATUS3
	call GetBattleVarAddr
	res SUBSTATUS_CONFUSED, [hl]
	ld hl, ConfusedNoMoreText
	jp StdBattleTextBox

ObliviousAbility:
	ld a, BATTLE_VARS_SUBSTATUS1
	call GetBattleVar
	and SUBSTATUS_IN_LOVE
	ret z ; not infatuated
	call ShowAbilityActivation
	ld a, BATTLE_VARS_SUBSTATUS1
	call GetBattleVarAddr
	res SUBSTATUS_IN_LOVE, [hl]
	ld hl, ConfusedNoMoreText
	jp StdBattleTextBox

HandleUserAndOppFlowerGift:
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp FLOWER_GIFT
	jr nz, .skip
	call FlowerGiftAbility
.skip
	call SwitchTurn
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp FLOWER_GIFT
	ret nz
	call FlowerGiftAbility
	jp SwitchTurn

FlowerGiftAbility:
	call GetWeatherAfterCloudNine
	cp WEATHER_SUN
	ret nz
	ldh a, [hBattleTurn]
	and a
	jr nz, .enemy
	ld a, [wBattleMonForm]
	and FORM_MASK
	cp PLAIN_FORM
	ret nz
	ld a, SUNNY_FORM
	ld b, a
	ld a, [wBattleMonForm]
	and $ff - FORM_MASK
	or b
	ld [wBattleMonForm], a
	call ChangePlayerFormAnimation	
	ld a, [wBattleMonSpecies]
	jr .end
	
.enemy
	ld a, [wEnemyMonForm]
	and FORM_MASK
	cp PLAIN_FORM
	ret nz
	ld a, SUNNY_FORM
	ld b, a
	ld a, [wEnemyMonForm]
	and $ff - FORM_MASK
	or b
	ld [wEnemyMonForm], a
	
	push af
	ld a, [wBattleMode]
	cp WILD_BATTLE
	jr z, .wild
	pop af
	
	push af
	ld hl, wOTPartyMon1Form
	ld a, [wCurOTMon]
	call GetPartyLocation
	pop af
	ld [hl], a
	
	ld [wOTPartyMon1Form], a
	call ChangeEnemyFormAnimation	
	ld a, [wEnemyMonSpecies]
	jr .end
.wild
	pop af
	ld [wEnemyBackupForm], a
	call ChangeEnemyFormAnimation
.end
	cp SUNFLORA
	jr z, .sunflora
	ld hl, FlowerGiftTransformedText
	jp StdBattleTextBox
.sunflora
	ld hl, SunfloraTransformedText
	jp StdBattleTextBox

TraceAbility:
	ld a, BATTLE_VARS_ABILITY_OPP
	call GetBattleVar
	cp TRACE
	jr z, .trace_failure
	cp IMPOSTER
	jr z, .trace_failure
	push af
	ld b, a
	farcall BufferAbility
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVarAddr
	pop af
	ld [hl], a
	ld hl, TraceActivationText
	call StdBattleTextBox
	jp RunActivationAbilitiesInner
.trace_failure
	ld hl, TraceFailureText
	jp StdBattleTextBox

; Lasts 5 turns consistent with Generation VI.
DrizzleAbility:
	ld a, WEATHER_RAIN
	jr WeatherAbility
DroughtAbility:
	ld a, WEATHER_SUN
	jr WeatherAbility
SandStreamAbility:
	ld a, WEATHER_SANDSTORM
	jr WeatherAbility
SnowWarningAbility:
	ld a, WEATHER_HAIL
	; fallthrough
WeatherAbility:
	ld b, a
	ld a, [wWeather]
	cp b
	ret z ; don't re-activate it
	call ShowAbilityActivation
	; Disable running animations as part of Start(wWeather) commands. This will not block
	; Call_PlayBattleAnim that plays the animation manually.
	call DisableAnimations
	ld a, b
	cp WEATHER_RAIN
	jr z, .handlerain
	cp WEATHER_SUN
	jr z, .handlesun
	cp WEATHER_HAIL
	jr z, .handlehail
	; is sandstorm
	ld de, SANDSTORM
	farcall Call_PlayBattleAnim
	farcall BattleCommand_startsandstorm
	jp EnableAnimations
.handlerain
	ld de, RAIN_DANCE
	farcall Call_PlayBattleAnim
	farcall BattleCommand_startrain
	jp EnableAnimations
.handlesun
	ld de, SUNNY_DAY
	farcall Call_PlayBattleAnim
	farcall BattleCommand_startsun
	jp EnableAnimations
.handlehail
	ld de, HAIL
	farcall Call_PlayBattleAnim
	farcall BattleCommand_starthail
	jp EnableAnimations

IntimidateAbility:
	call ShowAbilityActivation
	call DisableAnimations
	ld a, [wAttackMissed]
	push af
	ld a, [wEffectFailed]
	push af
	xor a
	ld [wAttackMissed], a
	ld [wEffectFailed], a
	farcall BattleCommand_attackdown
	farcall BattleCommand_statdownmessage
	pop af
	ld [wEffectFailed], a
	pop af
	ld [wAttackMissed], a
	jp EnableAnimations

DownloadAbility:
; Increase Atk if enemy Def is lower than SpDef, otherwise SpAtk
	call ShowAbilityActivation
	call DisableAnimations
	ld hl, wEnemyMonDefense
	ldh a, [hBattleTurn]
	and a
	jr z, .ok
	ld hl, wBattleMonDefense
.ok
	ld a, [hli]
	ld b, a
	ld a, [hl]
	ld c, a
	ld hl, wEnemyMonSpclDef + 1
	ldh a, [hBattleTurn]
	and a
	jr z, .ok2
	ld hl, wBattleMonSpclDef + 1
.ok2
	ld a, [hld]
	ld e, a
	ld a, [hl]
	cp b
	jr c, .inc_spatk
	jr nz, .inc_atk
	; The high defense bits are equal, so compare the lower bits
	ld a, c
	cp e
	jr c, .inc_atk
.inc_spatk
	farcall ResetMiss
	farcall BattleCommand_specialattackup
	farcall BattleCommand_statupmessage
	jp EnableAnimations
.inc_atk
	farcall ResetMiss
	farcall BattleCommand_attackup
	farcall BattleCommand_statupmessage
	jp EnableAnimations

ImposterAbility:
	call ShowAbilityActivation
	call DisableAnimations
	farcall ResetMiss
	farcall BattleCommand_transform
	jp EnableAnimations

AnticipationAbility:
; Anticipation considers special types (just Hidden Power is applicable here) as
; whatever type they are listed as (e.g. HP is Normal). It will also (as of 5gen)
; treat Counter/Mirror Coat (and Metal Burst) as attacking moves of their type.
; It also ignores Pixilate.
	ldh a, [hBattleTurn]
	and a
	ld hl, wEnemyMonMoves
	jr z, .got_move_ptr
	ld hl, wBattleMonMoves
.got_move_ptr
	; Since Anticipation can run in the middle of a turn and we don't want to ruin the
	; opponent's move struct, save the current move of it to be reapplied afterwards.
	call SwitchTurn
	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	push af
	ld b, NUM_MOVES
.loop
	; a mon can have less than 4 moves
	ld a, [hli]
	and a
	jr z, .done
	; copy the current move into the move structure to make CheckTypeMatchup happy
	push hl
	push bc
	dec a
	ld hl, Moves
	ld bc, MOVE_LENGTH
	rst AddNTimes
	ldh a, [hBattleTurn]
	and a
	ld de, wPlayerMoveStruct
	jr z, .got_move_struct
	ld de, wEnemyMoveStruct
.got_move_struct
	ld a, BANK(Moves)
	call FarCopyBytes
	; Ignore status moves. Don't ignore Counter/Mirror Coat (counterintuitive)
	ld a, BATTLE_VARS_MOVE_CATEGORY
	call GetBattleVar
	cp STATUS
	jr z, .end_of_loop
	; If the move is super effective, shudder
	farcall BattleCheckTypeMatchup
	ld a, [wTypeMatchup]
	cp SUPER_EFFECTIVE
	jr nc, .shudder
.end_of_loop
	pop bc
	pop hl
	dec b
	jr nz, .loop
	jr .done
.shudder
	pop bc
	pop hl
	call ShowEnemyAbilityActivation
	ld hl, ShudderedText
	call StdBattleTextBox
.done
	; now restore the move struct
	pop af
	dec a
	ld hl, Moves
	ld bc, MOVE_LENGTH
	rst AddNTimes
	ldh a, [hBattleTurn]
	and a
	ld de, wPlayerMoveStruct
	jr z, .got_move_struct2
	ld de, wEnemyMoveStruct
.got_move_struct2
	ld a, BANK(Moves)
	call FarCopyBytes
	jp SwitchTurn

ForewarnAbility:
; A note on moves with non-regular damage: Bulbapedia and Showdown has conflicting info on
; what power these moves actually have. I am using Showdown numbers here which assigns
; 160 to counter moves and 80 to everything else with nonstandard base power.
	ldh a, [hBattleTurn]
	and a
	ld hl, wEnemyMonMoves
	jr z, .got_move_ptr
	ld hl, wBattleMonMoves
.got_move_ptr
	ld a, NUM_MOVES + 1
	ld [wBuffer1], a ; iterator
	xor a
	ld [wBuffer2], a ; used when randomizing between equal-power moves
	ld [wBuffer3], a ; highest power move index
	ld [wBuffer4], a ; power of said move for comparing
.loop
	ld a, [wBuffer1]
	dec a
	jr z, .done
	ld [wBuffer1], a
	; a mon can have less than 4 moves
	ld a, [hli]
	and a
	jr z, .done
	push af
	push hl
	; Check for special cases
	ld de, 1
	ld hl, DynamicPowerMoves
	call IsInArray
	pop hl
	pop bc
	jr nc, .not_special
	jr .compare_power
.not_special
	ld a, b
	dec a
	push hl
	ld hl, Moves + MOVE_POWER
	call GetMoveAttr
	pop hl
	ld c, a
	; Status moves have 0 power
	and a
	jr z, .loop
.compare_power
	; b: current move ID, c: current move power
	ld a, [wBuffer4]
	cp c
	jr z, .randomize
	jr nc, .loop
	; This move has higher BP, reset the random range
	xor a
	ld [wBuffer2], a
	jr .replace
.randomize
	; Move power was equal: randomize. This is done as follows as to give even results:
	; 2 moves share power: 2nd move replaces 1/2 of the time
	; 3 moves share power: 3rd move replaces 2/3 of the time
	; 4 moves share power: 4th move replaces 3/4 of the time
	ld a, [wBuffer2]
	inc a
	ld [wBuffer2], a
	inc a
	call BattleRandomRange
	and a
	jr z, .loop
.replace
	ld a, b
	ld [wBuffer3], a
	ld a, c
	ld [wBuffer4], a
	jr .loop
.done
	; Check if we have an attacking move in first place
	ld a, [wBuffer3]
	and a
	ret z
	push af
	call ShowAbilityActivation
	pop af
	ld [wNamedObjectIndexBuffer], a
	push hl
	push de
	farcall CheckMultiMoveSlot2
	jr nc, .not_multi_move_slot
	pop de
	pop hl
	push af
	ld a, [wEnemyMonSpecies]
	ld [wCurPartySpecies], a
	pop af
	farcall GetMultiMoveSlotName2
	jr .done_multi_move
.not_multi_move_slot
	pop de
	pop hl
	call GetMoveName
.done_multi_move
	ld hl, ForewarnText
	jp StdBattleTextBox

FriskAbility:
	farcall GetOpponentItem
	ld a, [hl]
	and a
	ret z ; no item
	call GetCurItemName
	ld hl, FriskedItemText
	jp StdBattleTextBox

RunEnemyOwnTempoAbility:
	call SwitchTurn
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp OWN_TEMPO
	call z, OwnTempoAbility
	jp SwitchTurn

RunEnemySynchronizeAbility:
	call SwitchTurn
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp SYNCHRONIZE
	call z, SynchronizeAbility
	jp SwitchTurn

SynchronizeAbility:
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and ALL_STATUS
	ret z ; not statused
	call ShowAbilityActivation
	farcall ResetMiss
	call DisableAnimations
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	cp 1 << PAR
	jr z, .is_par
	cp 1 << BRN
	jr z, .is_brn
	cp 1 << PSN
	jr z, .is_psn
	farcall BattleCommand_toxic
	jp EnableAnimations
.is_psn
	farcall BattleCommand_poison
	jp EnableAnimations
.is_par
	farcall BattleCommand_paralyze
	jp EnableAnimations
.is_brn
	farcall BattleCommand_burn
	jp EnableAnimations

RunFaintAbilities:
; abilities that run after an attack faints an enemy
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	call .user_abilities
	call GetOpponentAbilityAfterMoldBreaker
	push af
	call SwitchTurn
	pop af
	call .opponent_abilities
	jp SwitchTurn

.user_abilities
	cp MOXIE
	jp z, MoxieAbility
	ret
.opponent_abilities
	cp AFTERMATH
	jp z, AftermathAbility
	ret

AftermathAbility:
	; Damp protects against this
	ld a, BATTLE_VARS_ABILITY_OPP
	call GetBattleVar
	cp DAMP
	ret z
	; Only contact moves proc Aftermath
	call CheckOpponentContactMove
	ret c
.is_contact
	call ShowAbilityActivation
	call SwitchTurn
	farcall GetQuarterMaxHP
	farcall SubtractHPFromUser
	jp SwitchTurn

RunHitAbilities:
; abilities that run on hitting the enemy with an offensive attack
	call CheckContactMove
	jr c, .skip_contact_abilities
	call RunContactAbilities
.skip_contact_abilities
	; Store type and category (phy/spe/sta) so that abilities can check on them
	ld a, BATTLE_VARS_MOVE_CATEGORY
	call GetBattleVar
	ld b, a
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	
	farcall MultiSlotMoveTypes
	
	ld c, a
	push bc
	call GetOpponentAbilityAfterMoldBreaker
	push af
	call SwitchTurn
	pop af
	pop bc
	call .do_enemy_abilities
	jp SwitchTurn

.do_enemy_abilities
	cp CURSED_BODY
	jp z, CursedBodyAbility
	push bc
	push af
	call HasUserFainted
	pop bc
	ld a, b
	pop bc
	ret z
	cp JUSTIFIED
	jp z, JustifiedAbility
	cp RATTLED
	jp z, RattledAbility
	cp WEAK_ARMOR
	jp z, WeakArmorAbility
	ret

RunContactAbilities:
; turn perspective is from the attacker
; 30% of the time, activate Poison Touch
	call BattleRandom
	cp 1 + 30 percent
	jr nc, .skip_user_ability
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp POISON_TOUCH
	call z, PoisonTouchAbility
.skip_user_ability
; abilities only trigger 30% of the time
;
; Abilities always run from the ability user's perspective. This is
; consistent. Thus, a switchturn happens here. Feel free to rework
; the logic if you feel that this reduces readability.
	call GetOpponentAbilityAfterMoldBreaker
	ld b, a

	call CallOpponentTurn
	
; Rough Skin always activates
	ld a, b
	cp ROUGH_SKIN
	jp z, RoughSkinAbility
	cp PERISH_BODY
	jp z, PerishBodyAbility
	
	call BattleRandom
	cp 1 + 30 percent
	ret nc
.do_enemy_abilities
	ld a, b
	cp EFFECT_SPORE
	jp z, EffectSporeAbility
	cp FLAME_BODY
	jp z, FlameBodyAbility
	cp POISON_POINT
	jp z, PoisonPointAbility
	cp STATIC
	jp z, StaticAbility
	cp CUTE_CHARM
	jp z, CuteCharmAbility
	cp ROUGH_SKIN
	jp z, RoughSkinAbility
	ret

CursedBodyAbility:
	call BattleRandom
	cp 1 + 30 percent
	ret nc
	call DisableAnimations
	; this runs ShowAbilityActivation when relevant
	farcall BattleCommand_disable
	jp EnableAnimations

CuteCharmAbility:
	call HasUserFainted
	ret z
	call DisableAnimations
	; this runs ShowAbilityActivation when relevant
	farcall BattleCommand_attract
	jp EnableAnimations

RoughSkinAbility:
	farcall GetEighthMaxHP
	ld a, b
	or c
	jr nz, .damage_ok
	inc c
.damage_ok
	farcall SubtractHPFromOpponent
	ld hl, BattleText_HurtByRoughSkin
	jp StdBattleTextBox
	
PerishBodyAbility:
	ld hl, wPlayerSubStatus1
	ld de, wEnemySubStatus1
	bit SUBSTATUS_PERISH, [hl]
	jr z, .ok

	ld a, [de]
	bit SUBSTATUS_PERISH, a
	ret nz

.ok
	bit SUBSTATUS_PERISH, [hl]
	jr nz, .enemy

	set SUBSTATUS_PERISH, [hl]
	ld a, 4
	ld [wPlayerPerishCount], a

.enemy
	ld a, [de]
	bit SUBSTATUS_PERISH, a
	jr nz, .done

	set SUBSTATUS_PERISH, a
	ld [de], a
	ld a, 4
	ld [wEnemyPerishCount], a

.done
	ld hl, PerishBodyText
	jp StdBattleTextBox
	
EffectSporeAbility:
	call CheckIfTargetIsGrassType
	ret z
	ld a, BATTLE_VARS_ABILITY_OPP
	call GetBattleVar
	cp OVERCOAT
	ret z
	call BattleRandom
	cp 1 + 33 percent
	jr c, PoisonPointAbility
	cp 1 + 66 percent
	jr c, StaticAbility
	; there are 2 sleep resistance abilities, so check one here
	ld a, BATTLE_VARS_ABILITY_OPP
	call GetBattleVar
	cp VITAL_SPIRIT
	ret z
	lb bc, INSOMNIA, HELD_PREVENT_SLEEP
	ld d, SLP
	jr AfflictStatusAbility
FlameBodyAbility:
	call CheckIfTargetIsFireType
	ret z
	lb bc, WATER_VEIL, HELD_PREVENT_BURN
	ld d, BRN
	jr AfflictStatusAbility
PoisonTouchAbility:
	; Poison Touch is the same as an opposing Poison Point, and since
	; abilities always run from the ability user's POV...
	; Doesn't apply when opponent has a Substitute up...
	farcall CheckSubstituteOpp
	ret nz
PoisonPointAbility:
	call CheckIfTargetIsPoisonType
	ret z
	call CheckIfTargetIsSteelType
	ret z
	lb bc, IMMUNITY, HELD_PREVENT_POISON
	ld d, PSN
	jr AfflictStatusAbility
StaticAbility:
	call CheckIfTargetIsElectricType
	ret z
	lb bc, LIMBER, HELD_PREVENT_PARALYZE
	ld d, PAR
AfflictStatusAbility:
; While BattleCommand_whatever already does all these checks,
; duplicating them here is minor logic, and it avoids spamming
; needless ability activations that ends up not actually doing
; anything.
	call HasOpponentFainted
	ret z
	ld a, BATTLE_VARS_ABILITY_OPP
	push de
	call GetBattleVar
	pop de
	cp b
	ret z
	push de
	farcall GetOpponentItem
	pop de
	ld a, b
	cp c
	ret z
	ld b, d
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVar
	and a
	ret nz
	call ShowAbilityActivation
	call DisableAnimations
	ld a, b
	cp SLP
	jr z, .slp
	cp BRN
	jr z, .brn
	cp PSN
	jr z, .psn
	farcall BattleCommand_paralyze
	jp EnableAnimations
.slp
	farcall BattleCommand_sleeptarget
	jp EnableAnimations
.brn
	farcall BattleCommand_burn
	jp EnableAnimations
.psn
	farcall BattleCommand_poison
	jp EnableAnimations

CheckNullificationAbilities:
; Doesn't deal with the active effect of this, but just checking if they apply vs
; an opponent's used attack (not Overcoat vs powder which is checked with Grass)
	; Most abilities depends on types and can use a lookup table, but a few
	; doesn't. Check these first.
	call GetOpponentAbilityAfterMoldBreaker
	cp DAMP
	jr z, .damp
	cp ARMOR_TAIL
	jr z, .armor_tail
	ld b, a
	ld hl, .NullificationAbilityTypes
.loop
	ld a, [hli]
	cp b
	jr z, .found_ability
	inc hl
	cp -1
	jr nz, .loop
	ret

.found_ability
	ld a, [hl]
	ld b, a
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	
	farcall MultiSlotMoveTypes
	
	cp b
	jr z, .ability_ok
	ret

.damp
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_EXPLOSION
	jr z, .ability_ok
	ret
	
.armor_tail
	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	ld hl, PriorityMoves
	call IsInArray
	ret nc

.ability_ok
	; Set wAttackMissed to 3 (means ability immunity kicked in), and wTypeMatchup
	; to 0 (not neccessary for the engine itself, but helps the AI)
	ld a, ATKFAIL_ABILITY
	ld [wAttackMissed], a
	xor a
	ld [wTypeMatchup], a
	ret

.NullificationAbilityTypes:
	db VOLT_ABSORB,   ELECTRIC
	db LIGHTNING_ROD, ELECTRIC
	db MOTOR_DRIVE,   ELECTRIC
	db SURGE_SURFER,   ELECTRIC
	db DRY_SKIN,      WATER
	db WATER_ABSORB,  WATER
	db STORM_DRAIN,   WATER
	db FLASH_FIRE,    FIRE
	db SAP_SIPPER,    GRASS
	db LEVITATE,      GROUND
	db -1


RunEnemyNullificationAbilities:
; At this point, we are already certain that the ability will activate, so no additional
; checks are required.
	call CallOpponentTurn
.do_enemy_abilities
	ld hl, NullificationAbilities
	call UserAbilityJumptable
	ret nz

	; For other abilities, don't do anything except print a message (for example Levitate)
	call ShowAbilityActivation
	call SwitchTurn
	ld hl, DoesntAffectText
	call StdBattleTextBox
	jp SwitchTurn

NullificationAbilities:
	dbw DRY_SKIN, DrySkinAbility
	dbw FLASH_FIRE, FlashFireAbility
	dbw LIGHTNING_ROD, LightningRodAbility
	dbw MOTOR_DRIVE, MotorDriveAbility
	dbw SURGE_SURFER, MotorDriveAbility
	dbw SAP_SIPPER, SapSipperAbility
	dbw VOLT_ABSORB, VoltAbsorbAbility
	dbw WATER_ABSORB, WaterAbsorbAbility
	dbw STORM_DRAIN, StormDrainAbility
	dbw DAMP, DampAbility
	dbw -1, -1

DampAbility:
	; doesn't use the normal activation message or "doesn't affect", because it
	; would be confusing
	ld hl, DampAbilityText
	jp StdBattleTextBox

RunEnemyStatIncreaseAbilities:
	call SwitchTurn
	ld hl, StatIncreaseAbilities
	call UserAbilityJumptable
	jp SwitchTurn

StatIncreaseAbilities:
	dbw COMPETITIVE, CompetitiveAbility
	dbw DEFIANT, DefiantAbility
	dbw -1, -1

CompetitiveAbility:
	ld b, $10 | SP_ATTACK
	jr StatUpAbility
DefiantAbility:
	ld b, $10 | ATTACK
	jr StatUpAbility
JustifiedAbility:
	; only for dark type moves
	ld a, c
	cp DARK
	ret nz
	jr AttackUpAbility
MoxieAbility:
	; Don't run if battle is over
	ldh a, [hBattleTurn]
	and a
	jr nz, .enemy
	ld a, [wBattleMode]
	dec a
	ret z
.enemy
	farcall CheckAnyOtherAliveOpponentMons
	ret z
SapSipperAbility:
AttackUpAbility:
	ld b, ATTACK
	jr StatUpAbility
LightningRodAbility:
StormDrainAbility:
	ld b, SP_ATTACK
	jr StatUpAbility
RattledAbility:
	; only for bug-, dark or ghost type moves
	ld a, c
	cp BUG
	jr z, .ok
	cp DARK
	jr z, .ok
	cp GHOST
	jr z, .ok
	ret
.ok
	; fallthrough
MotorDriveAbility:
SteadfastAbility:
SpeedBoostAbility:
	ld b, SPEED
StatUpAbility:
	call HasUserFainted
	ret z
	ld a, [wAttackMissed]
	push af
	call DisableAnimations
	farcall ResetMiss
	ld a, [wEffectFailed]
	push af
	xor a
	ld [wEffectFailed], a
	farcall BattleCommand_statup
	pop af
	ld [wEffectFailed], a
	ld a, [wAttackMissed]
	and a
	jr nz, .cant_raise
	call ShowAbilityActivation
	farcall BattleCommand_statupmessage
	jr .done
.cant_raise
; Lightning Rod, Motor Drive, Surge Surfer, Storm Drain and Sap Sipper prints a "doesn't affect" message instead.
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp LIGHTNING_ROD
	jr z, .print_immunity
	cp MOTOR_DRIVE
	jr z, .print_immunity
	cp SURGE_SURFER
	jr z, .print_immunity
	cp STORM_DRAIN
	jr z, .print_immunity
	cp SAP_SIPPER
	jr nz, .done
.print_immunity
	call ShowAbilityActivation
	call SwitchTurn
	ld hl, DoesntAffectText
	call StdBattleTextBox
	call SwitchTurn
.done
	pop af
	ld [wAttackMissed], a
	jp EnableAnimations

WeakArmorAbility:
	; only physical moves activate this
	ld a, b
	and a ; cp PHYSICAL
	ret nz

	ld b, DEFENSE
	call DisableAnimations
	farcall ResetMiss
	farcall LowerStat ; can't be resisted
	ld a, [wFailedMessage]
	and a
	jr nz, .failed_defensedown
	call ShowAbilityActivation
	call SwitchTurn
	farcall BattleCommand_statdownmessage
	call SwitchTurn
	farcall ResetMiss
	farcall BattleCommand_speedup2
	ld a, [wFailedMessage]
	and a
	jp nz, EnableAnimations
.speedupmessage
	farjp BattleCommand_statupmessage
.failed_defensedown
; If we can still raise Speed, do that and show ability activation anyway
	farcall ResetMiss
	farcall BattleCommand_speedup2
	ld a, [wFailedMessage]
	and a
	jp nz, EnableAnimations
	call ShowAbilityActivation
	jr .speedupmessage

FlashFireAbility:
	call ShowAbilityActivation
	ld a, BATTLE_VARS_SUBSTATUS2
	call GetBattleVarAddr
	ld a, [hl]
	and 1<<SUBSTATUS_FLASH_FIRE
	jr nz, .already_fired_up
	set SUBSTATUS_FLASH_FIRE, [hl]
	ld hl, FirePoweredUpText
	jp StdBattleTextBox
.already_fired_up
	call SwitchTurn
	ld hl, DoesntAffectText
	call StdBattleTextBox
	jp SwitchTurn

DrySkinAbility:
VoltAbsorbAbility:
WaterAbsorbAbility:
	call ShowAbilityActivation
	farcall CheckFullHP
	jr z, .full_hp
	farcall GetQuarterMaxHP
	farjp RestoreHP
.full_hp
	ld hl, HPIsFullText
	jp StdBattleTextBox

ApplySpeedAbilities:
; Passive speed boost abilities
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp SWIFT_SWIM
	jr z, .swift_swim
	cp CHLOROPHYLL
	jr z, .chlorophyll
	cp SAND_RUSH
	jr z, .sand_rush
	cp SLUSH_RUSH
	jr z, .slush_rush
	cp QUICK_FEET
	ret nz
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and a
	ret z
	ld a, $32
	jr .apply_mod
.swift_swim
	ld h, WEATHER_RAIN
	jr .weather_ability
.chlorophyll
	ld h, WEATHER_SUN
	jr .weather_ability
.sand_rush
	ld h, WEATHER_SANDSTORM
	jr .weather_ability
.slush_rush
	ld h, WEATHER_HAIL
.weather_ability
	call GetWeatherAfterCloudNine
	cp h
	ret nz
	ld a, $21
.apply_mod
	jp ApplyDamageMod

ApplyAccuracyAbilities:
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	ld hl, UserAccuracyAbilities
	call AbilityJumptable
	call GetOpponentAbilityAfterMoldBreaker
	ld hl, TargetAccuracyAbilities
	jp AbilityJumptable

UserAccuracyAbilities:
	dbw COMPOUND_EYES, CompoundEyesAbility
	dbw HUSTLE, HustleAccuracyAbility
	dbw -1, -1

TargetAccuracyAbilities:
	dbw TANGLED_FEET, TangledFeetAbility
	dbw WONDER_SKIN, WonderSkinAbility
	dbw SAND_VEIL, SandVeilAbility
	dbw SNOW_CLOAK, SnowCloakAbility
	dbw -1, -1

CompoundEyesAbility:
; Increase accuracy by 30%
	ld a, $da
	jp ApplyDamageMod

HustleAccuracyAbility:
; Decrease accuracy for physical attacks by 20%
	ld a, $45
	jp ApplyPhysicalAttackDamageMod

TangledFeetAbility:
; Double evasion if confused
	ld a, BATTLE_VARS_SUBSTATUS3_OPP
	call GetBattleVar
	bit SUBSTATUS_CONFUSED, a
	ret z
	ld a, $12
	jp ApplyDamageMod

WonderSkinAbility:
; Double evasion for status moves
	ld a, BATTLE_VARS_MOVE_CATEGORY
	call GetBattleVar
	cp STATUS
	ret nz
	ld a, $12
	jp ApplyDamageMod

SandVeilAbility:
	ld b, WEATHER_SANDSTORM
	jr WeatherAccAbility
SnowCloakAbility:
	ld b, WEATHER_HAIL
WeatherAccAbility:
; Decrease target accuracy by 20% in relevant weather
	call GetWeatherAfterCloudNine
	cp b
	ret nz
	ld a, $45
	jp ApplyDamageMod

RunWeatherAbilities:
	call CheckChlorophialshine
	call SwitchTurn
	call CheckChlorophialshine
	call SwitchTurn
	ld hl, WeatherAbilities
	jp UserAbilityJumptable

WeatherAbilities:
	dbw DRY_SKIN, DrySkinWeatherAbility
	dbw SOLAR_POWER, SolarPowerWeatherAbility
	dbw ICE_BODY, IceBodyAbility
	dbw RAIN_DISH, RainDishAbility
	dbw HYDRATION, HydrationAbility
	dbw FLOWER_GIFT, FlowerGiftAbility
	dbw -1, -1

DrySkinWeatherAbility:
	call RainRecoveryAbility
	; fallthrough (these need different weather so calling both is OK)
SolarPowerWeatherAbility:
	call GetWeatherAfterCloudNine
	cp WEATHER_SUN
	ret nz
	call ShowAbilityActivation
	farcall GetEighthMaxHP
	farjp SubtractHPFromUser

IceBodyAbility:
	ld b, WEATHER_HAIL
	jr WeatherRecoveryAbility
RainDishAbility:
RainRecoveryAbility:
	ld b, WEATHER_RAIN
WeatherRecoveryAbility:
	call GetWeatherAfterCloudNine
	cp b
	ret nz
	farcall CheckFullHP
	ret z
	call ShowAbilityActivation
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp DRY_SKIN
	jr z, .eighth_max_hp
	farcall GetSixteenthMaxHP
	jr .restore
.eighth_max_hp
	farcall GetEighthMaxHP
.restore
	farjp RestoreHP

HandleAbilities:
; Abilities handled at the end of the turn.
	farcall SetFastestTurn
	call .do_it
	call SwitchTurn

.do_it
	farcall HasUserEndturnSwitched
	ret z

	ld hl, EndTurnAbilities
	call UserAbilityJumptable
	ld hl, StatusHealAbilities
	jp UserAbilityJumptable

EndTurnAbilities:
	dbw CUD_CHEW, CudChewAbility
	dbw HARVEST, HarvestAbility
	dbw MOODY, MoodyAbility
	dbw PICKUP, PickupAbility
	dbw SHED_SKIN, ShedSkinAbility
	dbw SPEED_BOOST, SpeedBoostAbility
	dbw -1, -1

HarvestAbility:
; At end of turn, re-harvest an used up Berry (100% in sun, 50% otherwise)
	call GetWeatherAfterCloudNine
	cp WEATHER_SUN
	jr z, CudChewAbility
	call BattleRandom
	and 1
	ret z
;fallthrough
CudChewAbility:
	; Don't do anything if we have an item already
	farcall GetUserItem
	ld a, [hl]
	and a
	ret nz

	; Only Berries are picked
	push hl
	call GetUsedItemAddr
	pop de
	ld a, [hl]
	and a
	ret z
	ld [wCurItem], a
	ld b, a
	push bc
	push de
	push hl
	farcall CheckItemBerry
	pop hl
	pop de
	pop bc
	ld a, [wItemAttributeParamBuffer]
	cp 1
	ret nz

	; Kill the used item
	xor a
	ld [hl], a

	; Pick up the item
	ld a, b
	ld [de], a

	ld hl, HarvestedItemText
	call RegainItemByAbility

	; For the player, update backup items
	ldh a, [hBattleTurn]
	and a
	ret nz
	jp SetBackupItem

PickupAbility:
; At end of turn, pickup consumed opponent items if we don't have any
	; Don't do anything if we have an item already
	farcall GetUserItem
	ld a, [hl]
	and a
	ret nz

	; Does the opponent have a consumed item?
	push hl
	call GetOpponentUsedItemAddr
	pop de
	ld a, [hl]
	and a
	ret z

	; Pick up the item
	ld [de], a

	; Kill the used item
	ld b, a
	xor a
	ld [hl], a
	ld a, b

	ld hl, PickedItemText
	; fallthrough
RegainItemByAbility:
	; Update party struct if applicable
	ld [wNamedObjectIndexBuffer], a
	push af
	push hl
	call GetItemName
	pop hl
	call StdBattleTextBox
	pop bc
	ldh a, [hBattleTurn]
	and a
	ld a, [wCurPartyMon]
	ld hl, wPartyMon1Item
	jr z, .got_item_addr
	ld a, [wBattleMode]
	dec a
	ret z
	ld a, [wCurOTMon]
	ld hl, wOTPartyMon1Item
.got_item_addr
	call GetPartyLocation
	ld [hl], b
	ret

MoodyAbility:
; Moody raises one stat by 2 stages and lowers another (not the same one!) by 1.
; It will not try to raise a stat at +6 (or lower one at -6). This means that, should all
; stats be +6, Moody will not raise any stat, and vice versa.

	call ShowAbilityActivation ; Safe -- Moody is certain to work for at least one part.
	call DisableAnimations

	; First, check how many stats aren't maxed out
	ld hl, wPlayerStatLevels
	ldh a, [hBattleTurn]
	and a
	jr z, .got_stat_levels
	ld hl, wEnemyStatLevels
.got_stat_levels
	lb bc, 0, 0 ; bitfield of nonmaxed stats, bitfield of nonminimized stats
	lb de, 1, 0 ; bit to OR into b/c, loop counter
.loop1
	ld a, [hl]
	cp 13
	jr z, .maxed
	ld a, b
	or d
	ld b, a
	ld a, [hl]
	cp 1
	jr z, .minimized
.maxed
	ld a, c
	or d
	ld c, a
.minimized
	inc hl
	inc e
	sla d
	ld a, e
	cp 7
	jr c, .loop1

	; If all stats are maxed (b=0), skip increasing stats
	ld a, b
	and a
	jr z, .all_stats_maxed

	; Randomize values until we get one matching a nonmaxed stat
.loop2
	call BattleRandom
	and $7
	cp 7
	jr z, .loop2 ; there are only 7 stats (0-6)
	lb de, 1, 0 ; e = counter
.loop3
	cp e
	jr z, .loop3_done
	sla d
	inc e
	jr .loop3
.loop3_done
	ld a, b
	and d
	jr z, .loop2

	; We got the stat to raise. Set the e:th bit (using d) in c to 0
	; to avoid lowering the stat as well.
	ld a, d
	cpl
	and c
	ld c, a
	ld a, e
	or $10 ; raise it sharply
	ld b, a
	push bc
	farcall ResetMiss
	farcall BattleCommand_statup
	farcall BattleCommand_statupmessage
	pop bc

.all_stats_maxed
	ld a, c
	and a
	jp z, EnableAnimations ; no stat to lower

.loop4
	call BattleRandom
	and $7
	cp 7
	jr z, .loop4
	lb de, 1, 0 ; e = counter
.loop5
	cp e
	jr z, .loop5_done
	sla d
	inc e
	jr .loop5
.loop5_done
	ld a, c
	and d
	jr z, .loop4

	ld b, e
	farcall ResetMiss
	farcall LowerStat
	call SwitchTurn
	farcall BattleCommand_statdownmessage
	call SwitchTurn
	jp EnableAnimations

ApplyDamageAbilities_AfterTypeMatchup:
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	ld hl, OffensiveDamageAbilities_AfterTypeMatchup
	call AbilityJumptable
	call GetOpponentAbilityAfterMoldBreaker
	ld hl, DefensiveDamageAbilities_AfterTypeMatchup
	jp AbilityJumptable

OffensiveDamageAbilities_AfterTypeMatchup:
	dbw TINTED_LENS, TintedLensAbility
	dbw -1, -1

DefensiveDamageAbilities_AfterTypeMatchup:
	dbw SOLID_ROCK, EnemySolidRockAbility
	dbw FILTER, EnemyFilterAbility
	dbw -1, -1

ApplyDamageAbilities:
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	ld hl, OffensiveDamageAbilities
	call AbilityJumptable
	call GetOpponentAbilityAfterMoldBreaker
	ld hl, DefensiveDamageAbilities
	jp AbilityJumptable

OffensiveDamageAbilities:
	dbw TECHNICIAN, TechnicianAbility
	dbw HUGE_POWER, HugePowerAbility
	dbw HUSTLE, HustleAbility
	dbw OVERGROW, OvergrowAbility
	dbw BLAZE, BlazeAbility
	dbw TORRENT, TorrentAbility
	dbw SWARM, SwarmAbility
	dbw RIVALRY, RivalryAbility
	dbw SHEER_FORCE, SheerForceAbility
	dbw ANALYTIC, AnalyticAbility
	dbw SOLAR_POWER, SolarPowerAbility
	dbw IRON_FIST, IronFistAbility
	dbw SAND_FORCE, SandForceAbility
	dbw RECKLESS, RecklessAbility
	dbw GUTS, GutsAbility
	dbw FLARE_BOOST, FlareBoostAbility
	dbw PIXILATE, PixilateAbility
	dbw STRONG_JAW,	StrongJawAbility
	dbw REFRIGERATE, RefrigerateAbility
	dbw FLOWER_GIFT, SolarPowerAbility
	dbw DEFEATIST, DefeatistAbility
	dbw -1, -1

DefensiveDamageAbilities:
	dbw MULTISCALE, EnemyMultiscaleAbility
	dbw MARVEL_SCALE, EnemyMarvelScaleAbility
	dbw THICK_FAT, EnemyThickFatAbility
	dbw DRY_SKIN, EnemyDrySkinAbility
	dbw FUR_COAT, EnemyFurCoatAbility
	dbw FLOWER_GIFT, EnemyFlowerGiftAbility
	dbw -1, -1

TechnicianAbility:
	ld a, d
	cp 61
	ret nc
	ld a, $32
	jp ApplyDamageMod

HugePowerAbility:
; Doubles physical attack
	ld a, $21
	jp ApplyPhysicalAttackDamageMod

HustleAbility:
; 150% physical attack, 80% accuracy (done elsewhere)
	ld a, $32
	jp ApplyPhysicalAttackDamageMod

DefeatistAbility:
	call CheckDefeatist
	ret nz
	ld a, $12
	jp ApplyDamageMod

CheckDefeatist:
	push hl
	farcall GetHalfMaxHP
	call CompareHP
	pop hl
	jr c, .ok
	ret
.ok
	xor a
	ret

OvergrowAbility:
	ld b, GRASS
	jr PinchAbility
BlazeAbility:
	ld b, FIRE
	jr PinchAbility
TorrentAbility:
	ld b, WATER
	jr PinchAbility
SwarmAbility:
	ld b, BUG
PinchAbility:
; 150% damage if the user is in a pinch (1/3HP or less) for given type
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	
	farcall MultiSlotMoveTypes
	
	cp b
	ret nz
	ld a, [wBuffer1]
	ld e, a
	ld a, [wBuffer2]
	ld d, a
	push de
	call CheckPinch
	pop de
	ld a, e
	ld [wBuffer1], a
	ld a, d
	ld [wBuffer2], a
	ret nz
	ld a, $32
	jp ApplyDamageMod

RivalryAbility:
; 100% damage if either mon is genderless, 125% if same gender, 75% if opposite gender
	farcall CheckOppositeGender
	ret c
	ld a, $54
	jr z, .apply_damage_mod
	ld a, $34
.apply_damage_mod
	jp ApplyDamageMod

SheerForceAbility:
; 130% damage if a secondary effect is suppressed
	ld a, [wEffectFailed]
	and a
	ret z
	ld a, $da
	jp ApplyDamageMod

AnalyticAbility:
; 130% damage if opponent went first
	ld a, [wEnemyGoesFirst] ; 0 = player goes first
	ld b, a
	ldh a, [hBattleTurn] ; 0 = player's turn
	xor b ; nz if opponent went first
	ret z
	ld a, $da
	jp ApplyDamageMod

TintedLensAbility:
; Doubles damage for not very effective moves (x0.5/x0.25)
	ld a, [wTypeModifier]
	cp $10
	ret nc
	ld a, $21
	jp ApplyDamageMod

SolarPowerAbility:
; 150% special attack in sun, take 1/8 damage at turn end in sun (done elsewhere)
	call GetWeatherAfterCloudNine
	cp WEATHER_SUN
	ret nz
	ld a, $32
	jp ApplySpecialAttackDamageMod

IronFistAbility:
; 150% damage for punching moves
	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	ld hl, PunchingMoves
	call IsInArray
	ret c
	ld a, $32
	jp ApplyDamageMod
	
StrongJawAbility:
; 150% damage for biting moves
	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	ld hl, BitingMoves
	call IsInArray
	ret c
	ld a, $32
	jp ApplyDamageMod

SandForceAbility:
; 130% damage for Ground/Rock/Steel-type moves in a sandstorm, not hurt by Sandstorm
	call GetWeatherAfterCloudNine
	cp WEATHER_SANDSTORM
	ret nz
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	
	farcall MultiSlotMoveTypes
	
	cp GROUND
	jr z, .ok
	cp ROCK
	jr z, .ok
	cp STEEL
	ret nz
.ok
	ld a, $da
	jp ApplyDamageMod

RecklessAbility:
; 120% damage for (Hi) Jump Kick and recoil moves except for Struggle
	ld a, BATTLE_VARS_MOVE
	call GetBattleVar
	cp STRUGGLE
	ret z
	ld a, BATTLE_VARS_MOVE_EFFECT
	call GetBattleVar
	cp EFFECT_RECOIL_HIT
	jr z, .ok
	cp EFFECT_JUMP_KICK
	ret nz
.ok
	ld a, $65
	jp ApplyDamageMod

GutsAbility:
; 150% physical attack if user is statused
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	and a
	ret z
	ld a, $32
	jp ApplyPhysicalAttackDamageMod
	
FlareBoostAbility:
; 150% special attack if user is burned
	ld a, BATTLE_VARS_STATUS
	call GetBattleVar
	bit BRN, a
	ret z
	ld a, $32
	jp ApplySpecialAttackDamageMod

PixilateAbility:
RefrigerateAbility:
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	
	farcall MultiSlotMoveTypes
	
	and a ; cp NORMAL
	ret nz
	ld a, $65
	jp ApplyDamageMod

EnemyMultiscaleAbility:
; 50% damage if user is at full HP
	farcall CheckOpponentFullHP
	ret nz
	ld a, $12
	jp ApplyDamageMod

EnemyMarvelScaleAbility:
; 150% physical Defense if statused
	ld a, BATTLE_VARS_STATUS_OPP
	call GetBattleVar
	and a
	ret z
	ld a, $23
	jp ApplyPhysicalDefenseDamageMod

EnemyFlowerGiftAbility:
	call GetWeatherAfterCloudNine
	cp WEATHER_SUN
	ret nz
	ld a, $23
	jp ApplyPhysicalDefenseDamageMod

EnemySolidRockAbility:
EnemyFilterAbility:
; 75% damage for super effective moves
	ld a, [wTypeModifier]
	cp $11
	ret c
	ld a, $34
	jp ApplyDamageMod

EnemyThickFatAbility:
; 50% damage for Fire and Ice-type moves
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	
	farcall MultiSlotMoveTypes
	
	cp FIRE
	jr z, .ok
	cp ICE
	ret nz
.ok
	ld a, $12
	jp ApplyDamageMod

EnemyDrySkinAbility:
; 125% damage for Fire-type moves, heals 1/4 from Water, regenerates 1/8 at end of turn in
; rain, takes 1/8 damage at end of turn in sun. This only handles Fire damage bonus, other
; stuff is elsewhere
	ld a, BATTLE_VARS_MOVE_TYPE
	call GetBattleVar
	
	farcall MultiSlotMoveTypes
	
	cp FIRE
	ret nz
	ld a, $54
	jp ApplyDamageMod

EnemyFurCoatAbility:
; Doubles physical Defense
	ld a, $12
	jp ApplyPhysicalDefenseDamageMod


HydrationAbility:
	call GetWeatherAfterCloudNine
	cp WEATHER_RAIN
	ret nz
	jr HealAllStatusAbility
ShedSkinAbility:
; Cure a non-volatile status 30% of the time
	call BattleRandom
	cp 1 + (30 percent)
	ret nc
	; fallthrough
NaturalCureAbility:
HealAllStatusAbility:
	ld a, ALL_STATUS
	jp HealStatusAbility

AngerPointAbility:
; preserves attack miss result to avoid multi-hit moves aborting
	ld a, [wAttackMissed]
	push af
	call _AngerPointAbility
	pop af
	ld [wAttackMissed], a
	ret

_AngerPointAbility:
	call DisableAnimations
	farcall ResetMiss
	farcall BattleCommand_attackup2
	ld a, [wFailedMessage]
	and a
	jp nz, EnableAnimations
	call ShowAbilityActivation
	farcall BattleCommand_attackup2
	farcall BattleCommand_attackup2
	farcall BattleCommand_attackup2
	farcall BattleCommand_attackup2
	farcall BattleCommand_attackup2
	ld hl, AngerPointMaximizedAttackText
	call StdBattleTextBox
	jp EnableAnimations

RunSwitchAbilities:
; abilities that activate when you switch out
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp NATURAL_CURE
	jr z, NaturalCureAbility
	cp REGENERATOR
	jr z, RegeneratorAbility
	ret

RegeneratorAbility:
	farcall CheckFullHP
	ret z
	call ShowAbilityActivation
	farcall GetThirdMaxHP
	farcall RestoreHP
	ldh a, [hBattleTurn]
	and a
	jp z, UpdateBattleMonInParty
	jp UpdateEnemyMonInParty

DisableAnimations:
	ld a, 1
	ld [wAnimationsDisabled], a
	ret

EnableAnimations:
	xor a
	ld [wAnimationsDisabled], a
	ret

ShowEnemyAbilityActivation::
	call CallOpponentTurn
ShowAbilityActivation::
	push bc
	push de
	push hl
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	ld b, a
	farcall BufferAbility
	ld hl, BattleText_UsersStringBuffer1Activated
	call StdBattleTextBox
	pop hl
	pop de
	pop bc
	ret

RunPostBattleAbilities::
; Checks party for potentially finding items (Pickup) or curing status (Natural Cure)
	ld a, [wPartyCount]
	jr .first_pass
.loop
	ld a, [wCurPartyMon]
.first_pass
	dec a
	cp $ff
	ret z

	ld [wCurPartyMon], a

	push bc
	ld a, MON_SPECIES
	call GetPartyParamLocation
	ld c, [hl]
	ld a, MON_PERSONALITY
	call GetPartyParamLocation
	call GetAbility
	ld a, b
	pop bc
	cp NATURAL_CURE
	jr z, .natural_cure
	cp PICKUP
	call z, .Pickup
	jr .loop

.natural_cure
	; Heal status
	ld a, MON_STATUS
	call GetPartyParamLocation
	xor a
	ld [hl], a
	jr .loop

.Pickup:
	ld a, MON_ITEM
	call GetPartyParamLocation
	ld a, [hl]
	and a
	ret nz

	call Random
	cp 1 + (10 percent)
	ret nc

	ld a, MON_LEVEL
	call GetPartyParamLocation
	ld a, [hl]
	call GetRandomPickupItem
	ld b, a
	ld a, MON_ITEM
	call GetPartyParamLocation
	ld a, b
	ld [hl], a
	push bc
	push de
	ld [wNamedObjectIndexBuffer], a
	call GetItemName
	ld hl, wStringBuffer1
	ld de, wStringBuffer2
	ld bc, ITEM_NAME_LENGTH
	rst CopyBytes
	pop de
	pop bc
	push bc
	push de
	ld a, MON_SPECIES
	call GetPartyParamLocation
	ld a, [hl]
	ld [wNamedObjectIndexBuffer], a
	call ClearTileMap
	ld b, CGB_BATTLE_COLORS
	call GetCGBLayout
	call SetPalettes
	call GetPokemonName
	ld c, 10
	call DelayFrames
	ld hl, BattleText_PickedUpItem
	call StdBattleTextBox
	pop de
	pop bc
	ret

GetRandomPickupItem::
; a = level

; bc = floor((level - 1) / 10)
	ld bc, 0
	dec a ; 1-10 → 0-9, etc
.loop
	sub 10
	jr c, .done
	inc bc
	jr .loop
.done

; Pickup selects from a table, giving better rewards scaling with level and randomness
	ld a, 100
	call RandomRange
	cp 2
	jr c, .rare
	cp 6
	call c, .inc_bc
	cp 10
	call c, .inc_bc
	cp 20
	call c, .inc_bc
	cp 30
	call c, .inc_bc
	cp 40
	call c, .inc_bc
	cp 50
	call c, .inc_bc
	cp 60
	call c, .inc_bc
	cp 70
	call c, .inc_bc
	ld hl, .BasePickupTable
	jr .ok

.rare:
; 2% of Pickup results use a different table with generally better items
	call Random
	cp 1 + 50 percent
	call c, .inc_bc
	ld hl, .RarePickupTable
.ok:
	add hl, bc
	ld a, [hl]
	ret

.inc_bc:
	inc bc
	ret

.BasePickupTable:
	db POTION
	db ANTIDOTE
	db SUPER_POTION
	db GREAT_BALL
	db REPEL
	db ESCAPE_ROPE
	db FULL_HEAL
	db HYPER_POTION
	db ULTRA_BALL
	db REVIVE
	db RARE_CANDY
	db DUSK_STONE
	db SHINY_STONE
	db MAX_ETHER
	db FULL_RESTORE
	db MAX_REVIVE
	db PP_UP
	db MAX_ELIXIR

.RarePickupTable:
	db HYPER_POTION
	db NUGGET
	db KINGS_ROCK
	db FULL_RESTORE
	db ETHER
	db LUCKY_EGG
	db DESTINY_KNOT
	db ELIXIR
	db BIG_NUGGET
	db LEFTOVERS
	db BOTTLE_CAP
	
DisguiseAbility::
	ld a, BATTLE_VARS_ABILITY_OPP
	call GetBattleVar
	cp DISGUISE_A
	jp z, .cont
	xor a
	ret
.cont
	ldh a, [hBattleTurn]
	and a
	jr z, .enemy
	ld a, [wBattleMonForm]
	and FORM_MASK
	cp PLAIN_FORM
	ret nz
	ld a, BUSTED_FORM
	ld b, a
	ld a, [wBattleMonForm]
	and $ff - FORM_MASK
	or b
	ld [wBattleMonForm], a
	
	call SwitchTurn
	ld a, [wBattleMonSpecies] ; TempBattleMonSpecies
	ld [wCurPartySpecies], a ; CurPartySpecies
	ld hl, wBattleMonForm
	predef GetVariant
	ld de, VTiles0 tile $00
	predef GetBackpic
	
	ld a, [wOptions1]
	push af
	ld hl, wOptions1
	set BATTLE_EFFECTS, [hl]
	
	xor a
	ld [wNumHits], a
	ld [wFXAnimIDHi], a
	ld a, 6
	ld [wKickCounter], a
	ld a, TRANSFORM_SKETCH_MIMIC_SPLASH_METRO
	farcall LoadAnim
	call SwitchTurn
	pop af
	ld [wOptions1], a
	
	ld hl, wPartyMon1Form
	ld a, [wCurBattleMon]
	ld [wCurPartyMon], a
	call GetPartyLocation
	ld a, [wBattleMonForm]
	ld [hl], a
	
	ld a, $f
	ld [wCryTracks], a
	ld a, [wBattleMonSpecies]
	call PlayStereoCry
	scf
	ret
.enemy
	ld a, [wEnemyMonForm]
	and FORM_MASK
	cp 1
	ret nz
	cp PLAIN_FORM
	ret nz
	ld a, BUSTED_FORM
	ld b, a
	ld a, [wEnemyMonForm]
	and $ff - FORM_MASK
	or b
	ld [wEnemyMonForm], a
	
	call SwitchTurn
	ld a, [wEnemyMonSpecies] ; TempBattleMonSpecies
	ld [wCurPartySpecies], a ; CurPartySpecies
	ld hl, wEnemyMonForm
	predef GetVariant
	ld de, VTiles0 tile $00
	predef GetFrontpic
	
	ld a, [wOptions1]
	push af
	ld hl, wOptions1
	set BATTLE_EFFECTS, [hl]
	
	xor a
	ld [wNumHits], a
	ld [wFXAnimIDHi], a
	ld a, 6
	ld [wKickCounter], a
	ld a, TRANSFORM_SKETCH_MIMIC_SPLASH_METRO
	farcall LoadAnim
	call SwitchTurn
	pop af
	ld [wOptions1], a
	call PlayMonAnimAfterFormChange
	scf
	ret
	
HandleDisguiseAfterBattle:
	ld a, DISGUISE_A
	ld e, a
	jr HandleFormRevertsAfterBattle
HandleFlowerGiftAfterBattle:
	ld a, FLOWER_GIFT
	ld e, a
;fallthrough
HandleFormRevertsAfterBattle:
	ld hl, wPartyMon1Personality
	ld a, [wPartyMon1Species]
	ld c, a
	call GetAbility
	ld a, b
	cp e
	jr nz, .skip1
	ld a, PLAIN_FORM
	ld b, a
	ld a, [wPartyMon1Form]
	and $ff - FORM_MASK
	or b
	ld hl, wPartyMon1Form
	ld [hl], a
.skip1
	ld hl, wPartyMon2Personality
	ld a, [wPartyMon2Species]
	ld c, a
	call GetAbility
	ld a, b
	cp e
	jr nz, .skip2
	ld a, PLAIN_FORM
	ld b, a
	ld a, [wPartyMon2Form]
	and $ff - FORM_MASK
	or b
	ld hl, wPartyMon2Form
	ld [hl], a
.skip2
	ld hl, wPartyMon3Personality
	ld a, [wPartyMon3Species]
	ld c, a
	call GetAbility
	ld a, b
	cp e
	jr nz, .skip3
	ld a, PLAIN_FORM
	ld b, a
	ld a, [wPartyMon3Form]
	and $ff - FORM_MASK
	or b
	ld hl, wPartyMon3Form
	ld [hl], a
.skip3
	ld hl, wPartyMon4Personality
	ld a, [wPartyMon4Species]
	ld c, a
	call GetAbility
	ld a, b
	cp e
	jr nz, .skip4
	ld a, PLAIN_FORM
	ld b, a
	ld a, [wPartyMon4Form]
	and $ff - FORM_MASK
	or b
	ld hl, wPartyMon4Form
	ld [hl], a
.skip4
	ld hl, wPartyMon5Personality
	ld a, [wPartyMon5Species]
	ld c, a
	call GetAbility
	ld a, b
	cp e
	jr nz, .skip5
	ld a, PLAIN_FORM
	ld b, a
	ld a, [wPartyMon5Form]
	and $ff - FORM_MASK
	or b
	ld hl, wPartyMon5Form
	ld [hl], a
.skip5
	ld hl, wPartyMon6Personality
	ld a, [wPartyMon6Species]
	ld c, a
	call GetAbility
	ld a, b
	cp e
	ret nz
	ld a, PLAIN_FORM
	ld b, a
	ld a, [wPartyMon6Form]
	and $ff - FORM_MASK
	or b
	ld hl, wPartyMon6Form
	ld [hl], a
	ret
	
HandleSunfloraAfterBattle:
	ld hl, wPartyMon1Personality
	ld a, [wPartyMon1Species]
	cp SUNFLORA
	ret nz
	ld a, PLAIN_FORM
	ld b, a
	ld a, [wPartyMon1Form]
	and $ff - FORM_MASK
	or b
	ld hl, wPartyMon1Form
	ld [hl], a
	ld hl, wPartyMon2Personality
	ld a, [wPartyMon2Species]
	cp SUNFLORA
	ret nz
	ld a, PLAIN_FORM
	ld b, a
	ld a, [wPartyMon2Form]
	and $ff - FORM_MASK
	or b
	ld hl, wPartyMon2Form
	ld [hl], a
	ld hl, wPartyMon3Personality
	ld a, [wPartyMon3Species]
	cp SUNFLORA
	ret nz
	ld a, PLAIN_FORM
	ld b, a
	ld a, [wPartyMon3Form]
	and $ff - FORM_MASK
	or b
	ld hl, wPartyMon3Form
	ld [hl], a
	ld hl, wPartyMon4Personality
	ld a, [wPartyMon4Species]
	cp SUNFLORA
	ret nz
	ld a, PLAIN_FORM
	ld b, a
	ld a, [wPartyMon4Form]
	and $ff - FORM_MASK
	or b
	ld hl, wPartyMon4Form
	ld [hl], a
	ld hl, wPartyMon5Personality
	ld a, [wPartyMon5Species]
	cp SUNFLORA
	ret nz
	ld a, PLAIN_FORM
	ld b, a
	ld a, [wPartyMon5Form]
	and $ff - FORM_MASK
	or b
	ld hl, wPartyMon5Form
	ld [hl], a
	ld hl, wPartyMon6Personality
	ld a, [wPartyMon6Species]
	cp SUNFLORA
	ret nz
	ld a, PLAIN_FORM
	ld b, a
	ld a, [wPartyMon6Form]
	and $ff - FORM_MASK
	or b
	ld hl, wPartyMon6Form
	ld [hl], a
	ret
	
ChangePlayerFormAnimation:
	ld a, [wOptions1]
	push af
	ld hl, wOptions1
	set BATTLE_EFFECTS, [hl]
	
	ld a, [wBattleMonSpecies] ; TempBattleMonSpecies
	ld [wCurPartySpecies], a ; CurPartySpecies
	ld hl, wBattleMonForm
	predef GetVariant
	ld de, VTiles0 tile $00
	predef GetBackpic
	call ChangeEnemyFormFadeOutAndIn
	
	ld a, [wBattleMonSpecies]
	ld [wCurSpecies], a
	ld a, [wBattleMonForm]
	ld [wCurForm], a
	call GetBaseData
	ld a, [wBaseType1]
	ld [wBattleMonType1], a
	ld a, [wBaseType2]
	ld [wBattleMonType2], a
	
	pop af
	ld [wOptions1], a
	ld a, $f
	ld [wCryTracks], a
	ld a, [wBattleMonSpecies]
	jp PlayStereoCry

	
ChangeEnemyFormAnimation:
	ld a, [wOptions1]
	push af
	ld hl, wOptions1
	set BATTLE_EFFECTS, [hl]
	
	ld a, [wEnemyMonSpecies] ; TempBattleMonSpecies
	cp SUNFLORA
	ld [wCurPartySpecies], a ; CurPartySpecies
	ld hl, wEnemyMonForm
	jr nz, .not_sunflora
	call CheckMonAnimations
	jr c, .not_sunflora
	call HandleSunfloraFormChange
	jr .done_sunflora
.not_sunflora
	predef GetVariant
	ld de, VTiles0 tile $00
	predef GetFrontpic
	call ChangeEnemyFormFadeOutAndIn
.done_sunflora
	ld a, [wEnemyMonSpecies]
	ld [wCurSpecies], a
	ld a, [wEnemyMonForm]
	ld [wCurForm], a
	call GetBaseData
	ld a, [wBaseType1]
	ld [wEnemyMonType1], a
	ld a, [wBaseType2]
	ld [wEnemyMonType2], a
	pop af
	ld [wOptions1], a
	jp PlayMonAnimAfterFormChange
	
HandleSunfloraFormChange:
	ld a, [wEnemyMonForm]
	inc a
	ld [wEnemyMonForm], a
	ld hl, wEnemyMonForm
	predef GetVariant
	ld de, VTiles0 tile $00
	predef GetFrontpic
	call ChangeEnemyFormFadeOutAndIn
	call PlayMonAnimAfterFormChange
	eventflagset EVENT_SILENT_BATTLE_ANIMATION
	ld a, [wEnemyMonForm]
	dec a
	ld [wEnemyMonForm], a
	ret
	
ChangeEnemyFormFadeOutAndIn:
	xor a
	ld [wNumHits], a
	ld [wFXAnimIDHi], a
	ld a, $12
	ld [wKickCounter], a
	ld a, TRANSFORM_SKETCH_MIMIC_SPLASH_METRO
	farcall LoadAnim
	ld a, $13
	ld [wKickCounter], a
	ld a, TRANSFORM_SKETCH_MIMIC_SPLASH_METRO
	farjp LoadAnim
	
ResetEnemyFlowerGift:
	ld hl, wOTPartyMon1Personality
	ld a, [wOTPartyMon1Species]
	ld c, a
	call GetAbility
	ld a, b
	cp FLOWER_GIFT
	jr nz, .skip1
	ld a, PLAIN_FORM
	ld b, a
	ld a, [wOTPartyMon1Form]
	and $ff - FORM_MASK
	or b
	ld hl, wOTPartyMon1Form
	ld [hl], a
.skip1
	ld hl, wOTPartyMon2Personality
	ld a, [wOTPartyMon2Species]
	ld c, a
	call GetAbility
	ld a, b
	cp FLOWER_GIFT
	jr nz, .skip2
	ld a, PLAIN_FORM
	ld b, a
	ld a, [wOTPartyMon2Form]
	and $ff - FORM_MASK
	or b
	ld hl, wOTPartyMon2Form
	ld [hl], a
.skip2
	ld hl, wOTPartyMon3Personality
	ld a, [wOTPartyMon3Species]
	ld c, a
	call GetAbility
	ld a, b
	cp FLOWER_GIFT
	jr nz, .skip3
	ld a, PLAIN_FORM
	ld b, a
	ld a, [wOTPartyMon3Form]
	and $ff - FORM_MASK
	or b
	ld hl, wOTPartyMon3Form
	ld [hl], a
.skip3
	ld hl, wOTPartyMon4Personality
	ld a, [wOTPartyMon4Species]
	ld c, a
	call GetAbility
	ld a, b
	cp FLOWER_GIFT
	jr nz, .skip4
	ld a, PLAIN_FORM
	ld b, a
	ld a, [wOTPartyMon4Form]
	and $ff - FORM_MASK
	or b
	ld hl, wOTPartyMon4Form
	ld [hl], a
.skip4
	ld hl, wOTPartyMon5Personality
	ld a, [wOTPartyMon5Species]
	ld c, a
	call GetAbility
	ld a, b
	cp FLOWER_GIFT
	jr nz, .skip5
	ld a, PLAIN_FORM
	ld b, a
	ld a, [wOTPartyMon5Form]
	and $ff - FORM_MASK
	or b
	ld hl, wOTPartyMon5Form
	ld [hl], a
.skip5
	ld hl, wOTPartyMon6Personality
	ld a, [wOTPartyMon6Species]
	ld c, a
	call GetAbility
	ld a, b
	cp FLOWER_GIFT
	ret nz
	ld a, PLAIN_FORM
	ld b, a
	ld a, [wOTPartyMon6Form]
	and $ff - FORM_MASK
	or b
	ld hl, wOTPartyMon6Form
	ld [hl], a
	ret
	
RevertFlowerGiftAfterWeather:
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp FLOWER_GIFT
	jr nz, .skip
	call RevertFlowerGift
.skip
	call SwitchTurn
	ld a, BATTLE_VARS_ABILITY
	call GetBattleVar
	cp FLOWER_GIFT
	jr nz, .skip2
	call RevertFlowerGift
.skip2
	jp SwitchTurn
	
RevertFlowerGift:
	ldh a, [hBattleTurn]
	and a
	jr nz, .enemy
	ld a, [wBattleMonForm]
	and FORM_MASK
	cp SUNNY_FORM
	ret nz
	ld a, PLAIN_FORM
	ld b, a
	ld a, [wBattleMonForm]
	and $ff - FORM_MASK
	or b
	ld [wBattleMonForm], a
	
	call ChangePlayerFormAnimation
	
	ld hl, wPartyMon1Form
	ld a, [wCurBattleMon]
	ld [wCurPartyMon], a
	call GetPartyLocation
	ld a, [wBattleMonForm]
	ld [hl], a
	call HandleFlowerGiftAfterBattle
	jr .end
	
.enemy
	ld a, [wEnemyMonForm]
	and FORM_MASK
	cp SUNNY_FORM
	ret nz	
	ld a, PLAIN_FORM
	ld b, a
	ld a, [wEnemyMonForm]
	and $ff - FORM_MASK
	or b
	ld [wEnemyMonForm], a
	call ResetEnemyFlowerGift
	call ChangeEnemyFormAnimation
.end
	ld hl, FlowerGiftTransformedText
	jp StdBattleTextBox
	
PlayMonAnimAfterFormChange:
	call CheckMonAnimations
	jr c, .cry_no_anim
	
	ld a, [wEnemyMonSpecies]
	ld [wCurPartySpecies], a
	ld [wCurSpecies], a
	ld a, [wEnemyMonForm]
	ld [wCurForm], a
	farcall GetBaseData
	ld a, [wBattleMode]
	cp WILD_BATTLE
	ld a, WILDMON
	jr z, .finish
	ld a, OTPARTYMON
.finish
	ld [wMonType], a
	farcall CopyPkmnToTempMon2
	farcall GetMonFrontpic
	eventflagcheck EVENT_SILENT_BATTLE_ANIMATION
	lb de, $0, ANIM_MON_EGG1
	jr nz, .silent
	lb de, $0, ANIM_MON_NORMAL
.silent
	ld bc, wTempEnemyMonSpecies
	hlcoord 12, 0
	predef AnimateFrontpic
	farcall BattleAnimRestoreHuds
	eventflagreset EVENT_SILENT_BATTLE_ANIMATION
	ret
.cry_no_anim
	ld a, $f
	ld [wCryTracks], a
	ld a, [wEnemyMonSpecies]
	jp PlayStereoCry
	
DoGoldTea::
	call SwitchTurn
	call GetHalfMaxHP
	call ItemRecoveryAnim
	call RestoreHP
	ld hl, BattleText_Chlorophial
	call StdBattleTextBox
	farcall ConsumeUserItem
	call SwitchTurn
	ret

CopyBackpic: ; 3fc30
	ldh a, [rSVBK]
	push af
	ld a, $6
	ldh [rSVBK], a
	ld hl, VTiles0
	ld de, VTiles2 tile $31
	ldh a, [hROMBank]
	ld b, a
	ld c, 7 * 7
	call Get2bpp
	pop af
	ldh [rSVBK], a
	call .LoadTrainerBackpicAsOAM
	ld a, $31
	ldh [hGraphicStartTile], a
	hlcoord 2, 6
	lb bc, 6, 6
	predef PlaceGraphic
	ret
; 3fc5b

.LoadTrainerBackpicAsOAM: ; 3fc5b
	ld hl, wSprites
	xor a
	ldh [hMapObjectIndexBuffer], a
	ld b, $6
	ld e, 21 * 8
.outer_loop
	ld c, $3
	ld d, 8 * 8
.inner_loop
	ld [hl], d
	inc hl
	ld [hl], e
	inc hl
	ldh a, [hMapObjectIndexBuffer]
	ld [hli], a
	inc a
	ldh [hMapObjectIndexBuffer], a
	ld a, $1
	ld [hli], a
	ld a, d
	add $8
	ld d, a
	dec c
	jr nz, .inner_loop
	ldh a, [hMapObjectIndexBuffer]
	add $3
	ldh [hMapObjectIndexBuffer], a
	ld a, e
	add $8
	ld e, a
	dec b
	jr nz, .outer_loop
	ret

BossWildAbilities:
	db LEDIAN, HIDDEN_ABILITY
	db MAGMAR, HIDDEN_ABILITY
	db ELECTABUZZ, HIDDEN_ABILITY
	db SNORLAX, HIDDEN_ABILITY
	db SUDOWOODO, ABILITY_2
	db SPIRITOMB, ABILITY_1
	db MAMOSWINE, HIDDEN_ABILITY
	db MUK, ABILITY_1
	db PORYGON, HIDDEN_ABILITY
	db CLEFABLE, ABILITY_2
	db LAPRAS, HIDDEN_ABILITY
	db DRAKLOAK, HIDDEN_ABILITY
	db MIMIKYU, HIDDEN_ABILITY
	db DITTO, HIDDEN_ABILITY
	db -1
	
FindBossWildAbility::
	ld a, [wTempEnemyMonSpecies]
	ld hl, BossWildAbilities
	ld de, 2
    call IsInArray
    jr nc, .default
	ld a, b
	ld bc, 2
	ld hl, BossWildAbilities
	inc hl
	call AddNTimes
	ld a, [hl]
	jr .load
	
.default
	ld a, ABILITY_1
.load
	ld [wBuffer1], a
	ret
