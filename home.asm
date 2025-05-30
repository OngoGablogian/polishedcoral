INCLUDE "constants.asm"


SECTION "NULL", ROM0

NULL::

INCLUDE "home/rst.asm"
INCLUDE "home/interrupts.asm"

SECTION "High Home", ROM0
INCLUDE "home/highhome.asm"

SECTION "Header", ROM0

Start::
	nop
	jp _Start


SECTION "Home", ROM0

INCLUDE "home/init.asm"
INCLUDE "home/vblank.asm"
INCLUDE "home/rtc.asm"
INCLUDE "home/fade.asm"
INCLUDE "home/lcd.asm"
INCLUDE "home/time.asm"
INCLUDE "home/serial.asm"
INCLUDE "home/joypad.asm"
INCLUDE "home/decompress.asm"
INCLUDE "home/palettes.asm"
INCLUDE "home/copy.asm"
INCLUDE "home/text.asm"
INCLUDE "home/video.asm"
INCLUDE "home/map_objects.asm"
INCLUDE "home/sine.asm"
INCLUDE "home/movement.asm"
INCLUDE "home/tilemap.asm"
INCLUDE "home/menu.asm"
INCLUDE "home/handshake.asm"
INCLUDE "home/game_time.asm"
INCLUDE "home/map.asm"
INCLUDE "home/farcall.asm"
INCLUDE "home/predef.asm"
INCLUDE "home/window.asm"
INCLUDE "home/flag.asm"
INCLUDE "home/restore_music.asm"

DisableSpriteUpdates:: ; 0x2ed3
; disables overworld sprite updating?
	xor a
	ldh [hMapAnims], a
	ld [wSpriteUpdatesEnabled], a
	ld a, [wVramState]
	res 0, a
	ld [wVramState], a
	ret
; 0x2ee4

EnableSpriteUpdates:: ; 2ee4
	ld a, $1
	ld [wSpriteUpdatesEnabled], a
	ldh [hMapAnims], a
	ld a, [wVramState]
	set 0, a
	ld [wVramState], a
	ret
; 2ef6

INCLUDE "home/string.asm"

INCLUDE "home/item.asm"
INCLUDE "home/random.asm"
INCLUDE "home/sram.asm"

INCLUDE "home/double_speed.asm"

ClearSprites:: ; 300b
; Erase OAM data
	ld hl, wSprites
	ld b, wSpritesEnd - wSprites
	xor a
.loop
	ld [hli], a
	dec b
	jr nz, .loop
	ret
; 3016

HideSprites:: ; 3016
; Set all OAM y-positions to 160 to hide them offscreen
	ld hl, wSprites
	ld de, 4 ; length of an OAM struct
	ld b, (wSpritesEnd - wSprites) / 4 ; number of OAM structs
	ld a, 160 ; y
.loop
	ld [hl], a
	add hl, de
	dec b
	jr nz, .loop
	ret
; 3026

_Jumptable:
	push de
	ld e, a
	ld d, 0
	add hl, de
	add hl, de
	pop de
IndirectHL::
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl

LoadTileMapToTempTileMap:: ; 309d
; Load wTileMap into wTempTileMap
	ld a, BANK(wTempTileMap)
	call StackCallInWRAMBankA

.Function:
	hlcoord 0, 0
	decoord 0, 0, wTempTileMap
	ld bc, wTileMapEnd - wTileMap
	rst CopyBytes
	ret
; 30b4

Call_LoadTempTileMapToTileMap:: ; 30b4
	xor a
	ldh [hBGMapMode], a
	call LoadTempTileMapToTileMap
	ld a, 1
	ldh [hBGMapMode], a
	ret
; 30bf

LoadTempTileMapToTileMap:: ; 30bf
; Load wTempTileMap into wTileMap
	ld a, BANK(wTempTileMap)
	call StackCallInWRAMBankA

.Function:
	hlcoord 0, 0, wTempTileMap
	decoord 0, 0
	ld bc, wTileMapEnd - wTileMap
	rst CopyBytes
	ret
; 30d6

CopyName1:: ; 30d6
; Copies the name from de to wStringBuffer2
	ld hl, wStringBuffer2

CopyName2:: ; 30d9
; Copies the name from de to hl
.loop
	ld a, [de]
	inc de
	ld [hli], a
	cp "@"
	jr nz, .loop
	ret
; 30e1

INCLUDE "home/math.asm"

PrintLetterDelay:: ; 313d
; Wait before printing the next letter.

; The text speed setting in wOptions1 is actually a frame count:
; 	fast: 1 frame
; 	mid:  3 frames
; 	slow: 5 frames

; wTextBoxFlags[!0] and A or B override text speed with a one-frame delay.
; wOptions1[4] and wTextBoxFlags[!1] disable the delay.

	ld a, [wTextBoxFlags]
	bit 1, a
	ret z
	bit 0, a
	jr z, .forceFastScroll

	ld a, [wOptions1]
	bit NO_TEXT_SCROLL, a
	ret nz
	and %11
	ret z
	ld a, $1
	ldh [hBGMapHalf], a
.forceFastScroll
	push hl
	push de
	push bc
; force fast scroll?
	ld a, [wTextBoxFlags]
	bit 0, a
	ld a, 2
	jr z, .updateDelay
; text speed
	ld a, [wOptions1]
	and %11
	rlca
.updateDelay
	dec a
	ld [wTextDelayFrames], a
.textDelayLoop
	ld a, [wTextDelayFrames]
	and a
	jr z, .done
	call DelayFrame
	call GetJoypad
; Finish execution if A or B is pressed
	ldh a, [hJoyDown]
	and A_BUTTON | B_BUTTON
	jr z, .textDelayLoop
.done
PopBCDEHL::
	pop bc
	pop de
	pop hl
	ret

PrintNum:: ; 3198
	farjp _PrintNum

QueueScript:: ; 31cd
; Push pointer hl in the current bank to wQueuedScriptBank.
	ldh a, [hROMBank]

FarQueueScript:: ; 31cf
; Push pointer a:hl to wQueuedScriptBank.
	ld [wQueuedScriptBank], a
	ld a, l
	ld [wQueuedScriptAddr], a
	ld a, h
	ld [wQueuedScriptAddr + 1], a
	ret
; 31db

StringCmp:: ; 31db
; Compare c bytes at de and hl.
; Return z if they all match, c if hl>de.
.loop
	ld a, [de]
	cp [hl]
	ret nz
	inc de
	inc hl
	dec c
	jr nz, .loop
	ret
; 0x31e4

CompareLong:: ; 31e4
; Compare bc bytes at de and hl.
; Return carry if they all match.

	ld a, [de]
	cp [hl]
	jr nz, .Diff

	inc de
	inc hl
	dec bc

	ld a, b
	or c
	jr nz, CompareLong

	scf
	ret

.Diff:
	and a
	ret
; 31f3

SetPalettes:: ; 32f9
; Inits the Palettes
; depending on the system the monochromes palettes or color palettes
	push de
	ld a, %11100100
	call DmgToCgbBGPals
	lb de, %11100100, %11100100
	call DmgToCgbObjPals
	pop de
	ret
; 3317

ClearPalettes:: ; 3317
; Make all palettes white
	ld a, BANK(wBGPals)
	call StackCallInWRAMBankA

.Function:

; Fill wBGPals and wOBPals with $ffff (white)
	ld hl, wBGPals
if !DEF(MONOCHROME)
	ld bc, 16 palettes
	ld a, $ff
	call ByteFill
else
	ld b, (16 palettes) / 2
.mono_loop
	ld a, PAL_MONOCHROME_WHITE % $100
	ld [hli], a
	ld a, PAL_MONOCHROME_WHITE / $100
	ld [hli], a
	dec b
	jr nz, .mono_loop
endc

; Request palette update
	ld a, 1
	ldh [hCGBPalUpdate], a
	ret
; 333e

GetMemCGBLayout:: ; 333e
	ld b, CGB_RAM
GetCGBLayout:: ; 3340
	predef_jump Predef_LoadCGBLayout
; 334e

SetHPPal:: ; 334e
; Set palette for hp bar pixel length e at hl.
	call GetHPPal
	ld [hl], d
	ret
; 3353

GetHPPal:: ; 3353
; Get palette for hp bar pixel length e in d.
	ld d, HP_GREEN
	ld a, e
	cp 25
	ret nc
	inc d ; HP_YELLOW
	cp 10
	ret nc
	inc d ; HP_RED
	ret
; 335f

CountSetBits:: ; 0x335f
; Count the number of set bits in b bytes starting from hl.
; Return in a, c and [wd265].

	ld c, 0
.next
	ld a, [hli]
	ld e, a
	ld d, 8

.count
	srl e
	ld a, 0 ; not xor a; preserve carry flag?
	adc c
	ld c, a
	dec d
	jr nz, .count

	dec b
	jr nz, .next

	ld a, c
	ld [wd265], a
	ret
; 0x3376

GetWeekday:: ; 3376
	ld a, [wCurDay]
.mod
	sub 7
	jr nc, .mod
	add 7
	ret
; 3380

INCLUDE "home/pokedex_flags.asm"

NamesPointers:: ; 33ab
	dba PokemonNames
	dba MoveNames
	dba ClothesNames
	dba ItemNames
	dba TapeNames
	dbw 0, wPartyMonOT
	dbw 0, wOTPartyMonOT
	dba TrainerClassNames
	dba DecoNames
; 33c0

GetName:: ; 33c3
; Return name wCurSpecies from name list wNamedObjectTypeBuffer in wStringBuffer1.

	ldh a, [hROMBank]
	push af
	push hl
	push bc
	push de

	ld a, [wNamedObjectTypeBuffer]
	cp PKMN_NAME
	jr nz, .NotPokeName

	ld a, [wCurSpecies]
	ld [wNamedObjectIndexBuffer], a
	call GetPokemonName
	ld hl, PKMN_NAME_LENGTH
	add hl, de
	ld e, l
	ld d, h
	jr .done

.NotPokeName:
	ld a, [wNamedObjectTypeBuffer]
	dec a
	ld e, a
	ld d, 0
	ld hl, NamesPointers
	add hl, de
	add hl, de
	add hl, de
	ld a, [hli]
	rst Bankswitch
	ld a, [hli]
	ld h, [hl]
	ld l, a

	ld a, [wCurSpecies]
	dec a
	call GetNthString

	ld de, wStringBuffer1
	push af
	ld a, [wNamedObjectTypeBuffer]
	cp TAPE_NAME
	jr z, .tape
	ld bc, ITEM_NAME_LENGTH
	jr .finish
.tape
	ld bc, TAPE_NAME_LENGTH ;length of wStringBuffer1 + wStringBuffer2
.finish
	pop af
	rst CopyBytes

.done
	pop de
	pop bc
	pop hl
	pop af
	rst Bankswitch
	ret
; 3411

GetNthString:: ; 3411
; Return the address of the
; ath string starting from hl.

	and a
	ret z

	push bc
	ld b, a
.readChar
	ld a, [hli]
	cp "@"
	jr nz, .readChar
	dec b
	jr nz, .readChar
	pop bc
	ret
; 3420

GetBasePokemonName:: ; 3420
; Discards gender (Nidoran).

	push hl
	call GetPokemonName

	ld hl, wStringBuffer1
.loop
	ld a, [hl]
	cp "@"
	jr z, .quit
	cp "♂"
	jr z, .end
	cp "♀"
	jr z, .end
	inc hl
	jr .loop
.end
	ld [hl], "@"
.quit
	pop hl
	ret

; 343b

GetPokemonName:: ; 343b
; Get Pokemon name wNamedObjectIndexBuffer.

	anonbankpush PokemonNames

.Function:
	push hl

; Each name is ten characters
	ld a, [wNamedObjectIndexBuffer]
	dec a
	ld d, 0
	ld e, a
	ld h, 0
	ld l, a
	add hl, hl ; hl = hl * 4
	add hl, hl ; hl = hl * 4
	add hl, de ; hl = (hl*4) + de
	add hl, hl ; hl = (5*hl) + (5*hl)
	ld de, PokemonNames
	add hl, de

; Terminator
	ld de, wStringBuffer1
	push de
	ld bc, PKMN_NAME_LENGTH - 1
	rst CopyBytes
	ld hl, wStringBuffer1 + PKMN_NAME_LENGTH - 1
	ld [hl], "@"
	pop de

	pop hl
	ret
; 3468

GetCurItemName::
; Get item name from item in CurItem
	ld a, [wCurItem]
	ld [wNamedObjectIndexBuffer], a
GetItemName:: ; 3468
; Get item name wNamedObjectIndexBuffer.

	push hl
	push bc
	ld a, [wNamedObjectIndexBuffer]
	ld [wCurSpecies], a
	ld a, ITEM_NAME
	ld [wNamedObjectTypeBuffer], a
	call GetName
	ld de, wStringBuffer1
	pop bc
	pop hl
	ret
; 3487

GetClothesName::
; Get apricorn name wNamedObjectIndexBuffer.
	push hl
	push bc
	ld a, [wNamedObjectIndexBuffer]
	ld [wCurSpecies], a
	ld a, CLOTHES_NAME
	ld [wNamedObjectTypeBuffer], a
	call GetName
	ld de, wStringBuffer1
	pop bc
	pop hl
	ret
	
GetDecoName2::
; Get apricorn name wNamedObjectIndexBuffer.
	push hl
	push bc
	ld a, [wNamedObjectIndexBuffer]
	ld [wCurSpecies], a
	ld a, DECO_NAME
	ld [wNamedObjectTypeBuffer], a
	call GetName
	ld de, wStringBuffer1
	pop bc
	pop hl
	ret

IsHM:: ; 34df
	cp HM01
	jr c, .NotHM
	scf
	ret
.NotHM:
	and a
	ret
; 34e7

ItemIsMail:: ; b9e76
	ld a, d
	cp FLOWER_MAIL
	ccf
	ret
; b9e80

GetMoveName:: ; 34f8
	push hl
	ld a, MOVE_NAME
	ld [wNamedObjectTypeBuffer], a
	ld a, [wNamedObjectIndexBuffer] ; move id
	ld [wCurSpecies], a
	call GetName
	ld de, wStringBuffer1
	pop hl
	ret
; 350c

GetTapeName:: ; 3468
; Get item name wNamedObjectIndexBuffer.

	push hl
	push bc
	ld a, [wNamedObjectIndexBuffer]
	ld [wCurSpecies], a
	ld a, TAPE_NAME
	ld [wNamedObjectTypeBuffer], a
	call GetName
	ld de, wStringBuffer1
	pop bc
	pop hl
	ret

ScrollingMenu:: ; 350c
	call CopyMenuData2
	ldh a, [hROMBank]
	push af

	ld a, BANK(_ScrollingMenu)
	rst Bankswitch

	call _InitScrollingMenu
	call .UpdatePalettes
	call _ScrollingMenu

	pop af
	rst Bankswitch

	ld a, [wMenuJoypad]
	ret
; 3524

.UpdatePalettes: ; 3524
	ld hl, wVramState
	bit 0, [hl]
	jp nz, UpdateTimePals
	jp SetPalettes
; 352f

InitScrollingMenu:: ; 352f
	ld a, [wMenuBorderTopCoord]
	dec a
	ld b, a
	ld a, [wMenuBorderBottomCoord]
	sub b
	ld d, a
	ld a, [wMenuBorderLeftCoord]
	dec a
	ld c, a
	ld a, [wMenuBorderRightCoord]
	sub c
	ld e, a
	push de
	call Coord2Tile
	pop bc
	jp TextBox
; 354b

SetDefaultBGPAndOBP::
	push de
	ld a, %11100100
	call DmgToCgbBGPals
	lb de, %11100100, %11100100
	call DmgToCgbObjPals
	pop de
	ret

JoyTextDelay_ForcehJoyDown:: ; 354b joypad
	call DelayFrame

	ldh a, [hInMenu]
	push af
	ld a, $1
	ldh [hInMenu], a
	call JoyTextDelay
	pop af
	ldh [hInMenu], a

	ldh a, [hJoyLast]
	and D_RIGHT + D_LEFT + D_UP + D_DOWN
	ld c, a
	ldh a, [hJoyPressed]
	and A_BUTTON + B_BUTTON + SELECT + START
	or c
	ld c, a
	ret
; 3567

HandleStoneQueue:: ; 3567
	ldh a, [hROMBank]
	push af

	call SwitchToMapScriptHeaderBank
	call .WarpAction

	pop bc
	ld a, b
	rst Bankswitch
	ret
; 3574

.WarpAction: ; 3574
	ld hl, OBJECT_MAP_OBJECT_INDEX
	add hl, de
	ld a, [hl]
	cp $ff
	jr z, .nope

	ld l, a
	push hl
	call .IsPersonOnWarp
	pop hl
	jr nc, .nope
	ld d, a
	ld e, l
	call .IsObjectInStoneTable
	jr nc, .nope
	call CallMapScript
	farcall EnableScriptMode
	scf
	ret

.nope
	and a
	ret
; 3599

.IsPersonOnWarp: ; 3599
	push de

	ld hl, OBJECT_NEXT_MAP_X
	add hl, de
	ld a, [hl]
	ld hl, OBJECT_NEXT_MAP_Y
	add hl, de
	ld e, [hl]

	sub 4
	ld d, a
	ld a, e
	sub 4
	ld e, a
	call .check_on_warp

	pop de
	ret
; 35b0

.check_on_warp ; 35b0
	ld hl, wCurrMapWarpHeaderPointer
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wCurrMapWarpCount]
	and a
	jr z, .nope2

.loop
	push af
	ld a, [hl]
	cp e
	jr nz, .not_on_warp
	inc hl
	ld a, [hld]
	cp d
	jr nz, .not_on_warp
	pop af
	ld d, a
	ld a, [wCurrMapWarpCount]
	sub d
	inc a
	scf
	ret

.not_on_warp
	ld a, 5
	add l
	ld l, a
	jr nc, .no_carry
	inc h
.no_carry

	pop af
	dec a
	jr nz, .loop

.nope2
	and a
	ret
; 35de

.IsObjectInStoneTable: ; 35de
	ld hl, CMDQUEUE_ADDR
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
.loop2
	ld a, [hli]
	cp $ff
	jr z, .nope3
	cp d
	jr nz, .next_inc3
	ld a, [hli]
	cp e
	jr nz, .next_inc2
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jr .yes

.next_inc3
	inc hl

.next_inc2
	inc hl
	inc hl
	jr .loop2

.nope3
	and a
	ret

.yes
	scf
	ret
; 3600

CheckTrainerBattle2:: ; 3600

	ldh a, [hROMBank]
	push af

	call SwitchToMapScriptHeaderBank
	call CheckTrainerBattle

	pop bc
	ld a, b
	rst Bankswitch
	ret
; 360d

CheckTrainerBattle:: ; 360d
; Check if any trainer on the map sees the player and wants to battle.

; Skip the player object.
	ld a, 1
	ld de, wMapObjects + OBJECT_LENGTH

.loop

; Start a battle if the object:

	push af
	push de

; Has a sprite
	ld hl, MAPOBJECT_SPRITE
	add hl, de
	ld a, [hl]
	and a
	jr z, .next

; Is a trainer
	ld hl, MAPOBJECT_COLOR
	add hl, de
	ld a, [hl]
	and $f
	cp PERSONTYPE_TRAINER
	jr z, .is_trainer
	cp PERSONTYPE_GENERICTRAINER
	jr nz, .next
.is_trainer

; Is visible on the map
	ld hl, MAPOBJECT_OBJECT_STRUCT_ID
	add hl, de
	ld a, [hl]
	cp -1
	jr z, .next

; Is facing the player...
	call GetObjectStruct
	farcall FacingPlayerDistance_bc
	jr nc, .next

; ...within their sight range
	ld hl, MAPOBJECT_RANGE
	add hl, de
	ld a, [hl]
	cp b
	jr c, .next

; And hasn't already been beaten
	push bc
	push de
	ld hl, MAPOBJECT_SCRIPT_POINTER
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld e, [hl]
	inc hl
	ld d, [hl]
	ld b, CHECK_FLAG
	call EventFlagAction
	ld a, c
	pop de
	pop bc
	and a
	jr z, .startbattle

.next
	pop de
	ld hl, OBJECT_LENGTH
	add hl, de
	ld d, h
	ld e, l

	pop af
	inc a
	cp NUM_OBJECTS
	jr nz, .loop
	xor a
	ret

.startbattle
	pop de
	pop af
	ldh [hLastTalked], a
	ld a, b
	ld [wEngineBuffer2], a
	ld a, c
	ld [wEngineBuffer3], a
	jr LoadTrainer_continue
; 3674

TalkToTrainer:: ; 3674
	ld a, 1
	ld [wEngineBuffer2], a
	ld a, -1
	ld [wEngineBuffer3], a

LoadTrainer_continue:: ; 367e
	ld a, [wMapScriptHeaderBank]
	ld [wEngineBuffer1], a

	ldh a, [hLastTalked]
	call GetMapObject

	ld hl, MAPOBJECT_COLOR
	add hl, bc
	ld a, [hl]
	and $f
	cp PERSONTYPE_GENERICTRAINER
	push af
	ld hl, MAPOBJECT_SCRIPT_POINTER
	add hl, bc
	ld a, [wEngineBuffer1]
	call GetFarHalfword
	ld de, wTempTrainerHeader
;	pop af
;	push af
	ld bc, wGenericTempTrainerHeaderEnd - wTempTrainerHeader
	jr z, .skipCopyingLossPtrAndScriptPtr
	ld bc, wTempTrainerHeaderEnd - wTempTrainerHeader
.skipCopyingLossPtrAndScriptPtr
	ld a, [wEngineBuffer1]
	call FarCopyBytes
	pop af
	jr nz, .notGenericTrainer
	push de
	ld d, h
	ld e, l
	pop hl
	; store 0 loss pointer
	xor a
	ld [hli], a
	ld [hli], a
	; store generic trainer script in script pointer
	ld a, .generic_trainer_script % $100
	ld [hli], a
	ld [hl], .generic_trainer_script / $100
	; store after-battle text in wStashedTextPointer
	ld hl, wStashedTextPointer
	ld a, e
	ld [hli], a
	ld a, d
	ld [hl], a
.notGenericTrainer
	xor a
	ld [wRunningTrainerBattleScript], a
	scf
	ret
; 36a5

.generic_trainer_script
	end_if_just_battled
	jumpstashedtext

PrintWinLossText:: ; 3718
	ld a, [wBattleResult]
	ld hl, wWinTextPointer
	and $f
	jr z, .ok
	ld hl, wLossTextPointer

.ok
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld a, [wMapScriptHeaderBank]
	call FarPrintText
	call ApplyTilemapInVBlank
	jp WaitPressAorB_BlinkCursor
; 3741

PrepMonFrontpic:: ; 3786
	ld a, $1
	ld [wBoxAlignment], a

_PrepMonFrontpic:: ; 378b
	ld a, [wCurPartySpecies]
	call IsAPokemon
	jr c, .not_pokemon

	push hl
	ld de, VTiles2
	predef GetFrontpic
	pop hl
	xor a
	ldh [hGraphicStartTile], a
	lb bc, 7, 7
	predef PlaceGraphic
	xor a
	ld [wBoxAlignment], a
	ret

.not_pokemon
	xor a
	ld [wBoxAlignment], a
	inc a
	ld [wCurPartySpecies], a
	ret
; 37b6

INCLUDE "home/cry.asm"

PrintLevel:: ; 382d
; Print wTempMonLevel at hl

	ld a, [wTempMonLevel]
	ld [hl], "<LV>"
	inc hl

; How many digits?
	ld c, 2
	cp 100
	jr c, Print8BitNumRightAlign

; 3-digit numbers overwrite the :L.
	dec hl
	inc c
	; fallthrough

Print8BitNumRightAlign:: ; 3842
	ld [wd265], a
	ld de, wd265
	ld b, PRINTNUM_LEFTALIGN | 1
	jp PrintNum
; 384d

GetBaseData:: ; 3856
	anonbankpush BaseData

.Function:
	push bc
	push de
	push hl

; Egg doesn't have BaseData
	ld a, [wCurSpecies]
	ld c, a
	ld a, [wCurForm]
	ld b, a
	call GetSpeciesAndFormIndex
	dec bc
	ld a, BASEMON_STRUCT_LENGTH
	ld hl, BaseData
	rst AddNTimes
	ld de, wCurBaseData
	ld bc, BASEMON_STRUCT_LENGTH
	rst CopyBytes
	jp HomePopHlDeBc
; 389c


GetNature::
; 'b' contains the target Nature to check
; returns nature in b
	ld a, [wInitialOptions]
	bit NATURES_OPT, a
	jr z, .no_nature
	ld a, b
	and NATURE_MASK
	; assume nature is 0-24
	ld b, a
	ret

.no_nature:
	ld b, NO_NATURE
	ret

GetLeadAbility::
; Returns ability of lead mon unless it's an Egg. Used for field
; abilities
	ld a, [wPartyMon1IsEgg]
	and IS_EGG_MASK
	xor IS_EGG_MASK
	ret z
	ld a, [wPartyMon1Species]
	inc a
	ret z
	dec a
	ret z
	push bc
	push de
	push hl
	ld c, a
	ld hl, wPartyMon1Personality
	call GetAbility
	ld a, b
	jp HomePopHlDeBc

GetAbility::
; 'hl' contains the target personality to check (ability and form)
; 'c' contains the target species
; returns ability in b
; preserves curspecies and base data
	anonbankpush BaseData

.Function:
	ld a, [wInitialOptions]
	and ABILITIES_OPTMASK
	jr z, .got_ability

	inc hl
	ld a, [hld]
	and FORM_MASK
	ld b, a

	push hl
	push bc

	push hl
	call GetSpeciesAndFormIndex
	dec bc
	ld a, BASEMON_STRUCT_LENGTH
	ld hl, BASEMON_ABILITIES
	rst AddNTimes
	pop bc

	ld a, [bc]
	and ABILITY_MASK
	cp ABILITY_1
	jr z, .got_ability_ptr
	inc hl
	cp ABILITY_2
	jr z, .got_ability_ptr
	inc hl
.got_ability_ptr
	ld a, [hl]

	pop bc
	pop hl

.got_ability
	ld b, a
	ret

GetCurNick:: ; 389c
	ld a, [wCurPartyMon]
	ld hl, wPartyMonNicknames

GetNick:: ; 38a2
; Get nickname a from list hl.

	push hl
	push bc

	call SkipNames
	ld de, wStringBuffer1

	push de
	ld bc, PKMN_NAME_LENGTH
	rst CopyBytes
	jp HomePopDeBcHl
; 38bb

GetNickTradeMon:: ; 38a2
; Get nickname a from list hl.

	push hl
	push bc

	call SkipNames
	ld de, wBackupName

	push de
	ld bc, PKMN_NAME_LENGTH
	rst CopyBytes
	jp HomePopDeBcHl

HomePopDeBcHl:
	pop de
	pop bc
	pop hl
	ret
	
HomePopHlDeBc:
	pop hl
	pop de
	pop bc
	ret

GetSpeciesAndFormIndex::
; input: c = species, b = form
; output: bc = extended index
	ldh a, [hROMBank]
	push af
	ld a, BANK(VariantSpeciesAndFormTable)
	rst Bankswitch
	ld hl, VariantSpeciesAndFormTable - 1
	ld a, b
	and FORM_MASK
	ld b, a
.next
	inc hl
.loop
	ld a, [hli]
	and a
	jr z, .normal
	cp c
	jr nz, .next
	ld a, [hli]
	cp b
	jr nz, .loop
	ld bc, -VariantSpeciesAndFormTable
	add hl, bc
	srl h
	rr l
	dec hl
	inc h
	ld b, h
	ld c, l
	pop af
	rst Bankswitch
	ret

.normal
	ld b, 0
	pop af
	rst Bankswitch
	ret

GetGenderRatio::
; 'c' contains the target species
; returns gender ratio in c
; preserves curspecies and base data
	anonbankpush BaseData

.Function:
	push hl
	push bc
	call GetSpeciesAndFormIndex
	dec bc
	ld hl, BASEMON_GENDER
	ld a, BASEMON_STRUCT_LENGTH
	rst AddNTimes
	pop bc
	ld a, [hl]
	pop hl
	swap a
	and $f
	ld c, a
	ret


PrintBCDNumber:: ; 38bb
; function to print a BCD (Binary-coded decimal) number
; de = address of BCD number
; hl = destination address
; c = flags and length
; bit 7: if set, do not print leading zeroes
;        if unset, print leading zeroes
; bit 6: if set, left-align the string (do not pad empty digits with spaces)
;        if unset, right-align the string
; bit 5: if set, print currency symbol at the beginning of the string
;        if unset, do not print the currency symbol
; bits 0-4: length of BCD number in bytes
; Note that bits 5 and 7 are modified during execution. The above reflects
; their meaning at the beginning of the functions's execution.
	ld b, c ; save flags in b
	res 7, c
	res 6, c
	res 5, c ; c now holds the length
	bit 5, b
	jr z, .loop
	bit 7, b
	jr nz, .loop ; skip currency symbol
	ld [hl], "¥"
	inc hl
.loop
	ld a, [de]
	swap a
	call PrintBCDDigit ; print upper digit
	ld a, [de]
	call PrintBCDDigit ; print lower digit
	inc de
	dec c
	jr nz, .loop
	bit 7, b ; were any non-zero digits printed?
	ret z ; if so, we are done
.numberEqualsZero ; if every digit of the BCD number is zero
	bit 6, b ; left or right alignment?
	jr nz, .skipRightAlignmentAdjustment
	dec hl ; if the string is right-aligned, it needs to be moved back one space
.skipRightAlignmentAdjustment
	bit 5, b
	jr z, .skipCurrencySymbol
	ld [hl], "¥" ; currency symbol
	inc hl
.skipCurrencySymbol
	ld [hl], "0"
	call PrintLetterDelay
	inc hl
	ret
; 0x38f2

PrintBCDDigit:: ; 38f2
	and a, %00001111
	and a
	jr z, .zeroDigit
.nonzeroDigit
	bit 7, b ; have any non-space characters been printed?
	jr z, .outputDigit
; if bit 7 is set, then no numbers have been printed yet
	bit 5, b ; print the currency symbol?
	jr z, .skipCurrencySymbol
	ld [hl], "¥"
	inc hl
	res 5, b
.skipCurrencySymbol
	res 7, b ; unset 7 to indicate that a nonzero digit has been reached
.outputDigit
	add a, "0"
	ld [hli], a
	jp PrintLetterDelay

.zeroDigit
	bit 7, b ; either printing leading zeroes or already reached a nonzero digit?
	jr z, .outputDigit ; if so, print a zero digit
	bit 6, b ; left or right alignment?
	ret nz
	ld a, " "
	ld [hli], a ; if right-aligned, "print" a space by advancing the pointer
	ret
; 0x3917

GetPartyParamLocation:: ; 3917
; Get the location of parameter a from wCurPartyMon in hl
	push bc
	ld hl, wPartyMons
	ld c, a
	ld b, 0
	add hl, bc
	ld a, [wCurPartyMon]
	call GetPartyLocation
	pop bc
	ret
; 3927

GetPartyLocation::
; Add the length of a PartyMon struct to hl a times.
	push bc
	ld bc, PARTYMON_STRUCT_LENGTH
	rst AddNTimes
	pop bc
	ret

INCLUDE "home/battle.asm"

HalveBC::
	srl b
	rr c
FloorBC::
	ld a, c
	or b
	ret nz
	inc c
	ret

PushLYOverrides:: ; 3b0c

	ldh a, [hLCDCPointer]
	and a
	ret z

	ld a, wLYOverridesBackup % $100
	ldh [hRequestedVTileSource], a
	ld a, wLYOverridesBackup / $100
	ldh [hRequestedVTileSource + 1], a

	ld a, wLYOverrides % $100
	ldh [hRequestedVTileDest], a
	ld a, wLYOverrides / $100
	ldh [hRequestedVTileDest + 1], a

	ld a, (wLYOverridesEnd - wLYOverrides) / 16
	ldh [hLYOverrideStackCopyAmount], a
	ret
; 3b2a

INCLUDE "home/audio.asm"

INCLUDE "home/ded.asm"

CheckExtendedSpace::
	ldh a, [hROMBank]
	push af
	ld a, BANK(ExtendedSpaceString)
	rst Bankswitch

	ld de, ExtendedSpaceString
	ld hl, .teststring
	ld c, PLAYER_NAME_LENGTH
	call StringCmp
	jr nz, .no
	ld a, 1
	ld [wExtendedSpace], a
	jr .skip
.no
	xor a
	ld [wExtendedSpace], a
.skip
	pop af
	rst Bankswitch
	ret

.teststring:
	db "PIPPI@@@@@@"
	
SECTION "Home2", ROMX
INCLUDE "home/copy2.asm"
