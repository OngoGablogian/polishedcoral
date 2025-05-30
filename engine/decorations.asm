InitDecorations: ; 26751 (9:6751)
	ld a, DECO_FEATHERY_BED
	ld [wBed], a
;	ld a, DECO_RED_CARPET
;	ld [wCarpet], a
	ret

_KrisDecorationMenu: ; 0x2675c
	ld a, [wWhichIndexSet]
	push af
	ld hl, .MenuDataHeader
	call LoadMenuDataHeader
	xor a
	ld [wBuffer5], a
	ld a, $1
	ld [wBuffer6], a
.top_loop
	ld a, [wBuffer6]
	ld [wMenuCursorBuffer], a
	call .FindCategoriesWithOwnedDecos
	call DoNthMenu
	ld a, [wMenuCursorY]
	ld [wBuffer6], a
	jr c, .exit_menu
	ld a, [wMenuSelection]
	ld hl, .pointers
	call MenuJumptable
	jr nc, .top_loop

.exit_menu
	call ExitMenu
	pop af
	ld [wWhichIndexSet], a
	ld a, [wBuffer5]
	ld c, a
	ret
; 0x2679a

.MenuDataHeader: ; 0x2679a
	db $40 ; flags
	db 00, 05 ; start coords
	db 17, 19 ; end coords
	dw .MenuData2
	db 1 ; default option
; 0x267a2

.MenuData2: ; 0x267a2
	db $a0 ; flags
	db 0 ; items
	dw wd002
	dw PlaceNthMenuStrings
	dw .pointers
; 0x267aa

.pointers ; 267aa
	dw DecoBedMenu, .bed
	dw DecoCarpetMenu, .carpet
	dw DecoPlantMenu, .plant
	dw DecoPosterMenu, .poster
	dw DecoConsoleMenu, .game
	dw DecoOrnamentMenu, .ornament
	dw DecoBigDollMenu, .big_doll
	dw DecoExitMenu, .exit

.bed      db "BED@"
.carpet   db "CARPET@"
.plant    db "PLANT@"
.poster   db "POSTER@"
.game     db "GAME CONSOLE@"
.ornament db "ORNAMENT@"
.big_doll db "BIG DOLL@"
.exit     db "EXIT@"
; 26806

.FindCategoriesWithOwnedDecos: ; 26806
	xor a
	ld [wWhichIndexSet], a
	call .ClearStringBuffer2
	call .FindOwndDecos
	ld a, 7
	call .AppendToStringBuffer2
	ld hl, wStringBuffer2
	ld de, wd002
	ld bc, ITEM_NAME_LENGTH
	rst CopyBytes
	ret

.ClearStringBuffer2: ; 26822 (9:6822)
	ld hl, wStringBuffer2
	xor a
	ld [hli], a
	ld bc, ITEM_NAME_LENGTH - 1
	ld a, -1
	jp ByteFill

.AppendToStringBuffer2: ; 26830 (9:6830)
	ld hl, wStringBuffer2
	inc [hl]
	ld e, [hl]
	ld d, 0
	add hl, de
	ld [hl], a
	ret

.FindOwndDecos: ; 2683a (9:683a)
	ld hl, .dw
.loop
	ld a, [hli]
	ld e, a
	ld a, [hli]
	ld d, a
	or e
	ret z

	push hl
	call _de_
	pop hl
	jr nc, .next
	ld a, [hl]
	push hl
	call .AppendToStringBuffer2
	pop hl
.next
	inc hl
	jr .loop
; 26855 (9:6855)

.dw ; 26855
	dwb FindOwnedBeds, 0 ; bed
	dwb FindOwnedCarpets, 1 ; carpet
	dwb FindOwnedPlants, 2 ; plant
	dwb FindOwnedPosters, 3 ; poster
	dwb FindOwnedConsoles, 4 ; game console
	dwb FindOwnedOrnaments, 5 ; ornament
	dwb FindOwnedBigDolls, 6 ; big doll
	dw 0 ; end
; 2686c

Deco_FillTempWithMinusOne: ; 2686c
	xor a
	ld hl, wd002
	ld [hli], a
	ld a, -1
	ld bc, $10
	jp ByteFill
; 2687a

CheckAllDecorationFlags: ; 2687a
.loop
	ld a, [hli]
	cp -1
	ret z

	push hl
	push af
	ld b, CHECK_FLAG
	call DecorationFlagAction
	ld a, c
	and a
	pop bc
	ld a, b
	call nz, AppendDecoIndex
	pop hl
	jr .loop
; 26891

AppendDecoIndex: ; 26891
	ld hl, wd002
	inc [hl]
	ld e, [hl]
	ld d, $0
	add hl, de
	ld [hl], a
	ret
; 2689b

FindOwnedDecosInCategory: ; 2689b
	push bc
	push hl
	call Deco_FillTempWithMinusOne
	pop hl
	call CheckAllDecorationFlags
	pop bc
	ld a, [wd002]
	and a
	ret z

	ld a, c
	call AppendDecoIndex
	xor a
	call AppendDecoIndex
	scf
	ret
; 268b5

DecoBedMenu: ; 268b5
	call FindOwnedBeds
	call PopulateDecoCategoryMenu
	xor a
	ret
; 268bd

FindOwnedBeds: ; 268bd
	ld hl, .beds
	ld c, BEDS
	jp FindOwnedDecosInCategory
; 268c5

.beds ; 268c5
	db DECO_FEATHERY_BED
	db DECO_PINK_BED
	db DECO_BLUE_BED
	db DECO_YELLOW_BED
	db DECO_GREEN_BED
	db DECO_CHECKER_BED
	db -1
; 268ca

DecoCarpetMenu: ; 268ca
	call FindOwnedCarpets
	call PopulateDecoCategoryMenu
	xor a
	ret
; 268d2

FindOwnedCarpets: ; 268d2
	ld hl, .carpets
	ld c, CARPETS
	jp FindOwnedDecosInCategory
; 268da

.carpets ; 268da
	db DECO_RED_CARPET
	db DECO_BLUE_CARPET
	db DECO_YELLOW_CARPET
	db DECO_GREEN_CARPET
	db DECO_CHECKER_CARPET
	db -1
; 268df

DecoPlantMenu: ; 268df
	call FindOwnedPlants
	call PopulateDecoCategoryMenu
	xor a
	ret
; 268e7

FindOwnedPlants: ; 268e7
	ld hl, .plants
	ld c, PLANTS
	jp FindOwnedDecosInCategory
; 268ef

.plants ; 268ef
	db DECO_MAGNAPLANT
	db DECO_TROPICPLANT
	db DECO_JUMBOPLANT
	db DECO_SPIKEYPLANT
	db -1
; 268f3

DecoPosterMenu: ; 268f3
	call FindOwnedPosters
	call PopulateDecoCategoryMenu
	xor a
	ret
; 268fb

FindOwnedPosters: ; 268fb
	ld hl, .posters
	ld c, POSTERS
	jp FindOwnedDecosInCategory
; 26903

.posters ; 26903
	db DECO_POKEBALL_POSTER
	db DECO_PIKACHU_POSTER
	db DECO_CLEFAIRY_POSTER
	db DECO_JIGGLYPUFF_POSTER
	db DECO_EEVEE_POSTER
	db DECO_MARILL_POSTER
	db DECO_TOWN_MAP
	db DECO_MINAS_PAINTING
	db DECO_MUSEUM_PHOTO
	db -1
; 26908

DecoConsoleMenu: ; 26908
	call FindOwnedConsoles
	call PopulateDecoCategoryMenu
	xor a
	ret
; 26910

FindOwnedConsoles: ; 26910
	ld hl, .consoles
	ld c, CONSOLES
	jp FindOwnedDecosInCategory
; 26918

.consoles ; 26918
	db DECO_SNES
	db DECO_N64
	db -1
; 2691d

DecoOrnamentMenu: ; 2691d
	eventflagcheck EVENT_GOT_TAPE_PLAYER
	jr z, .tape_player
	call FindOwnedOrnaments
	call PopulateDecoCategoryMenu
	xor a
	ret
.tape_player
	ld hl, DecoText_GrabTapePlayer
	call MenuTextBoxBackup
	xor a
	ret

FindOwnedOrnaments: ; 26925
	ld hl, .ornaments
	ld c, DOLLS
	jp FindOwnedDecosInCategory
; 2692d

.ornaments ; 2692d
	db DECO_PIKACHU_DOLL
	db DECO_RAICHU_DOLL
	db DECO_SURF_PIKACHU_DOLL
	db DECO_CLEFAIRY_DOLL
	db DECO_JIGGLYPUFF_DOLL
	db DECO_BULBASAUR_DOLL
	db DECO_CHARMANDER_DOLL
	db DECO_SQUIRTLE_DOLL
	db DECO_CHIKORITA_DOLL
	db DECO_CYNDAQUIL_DOLL
	db DECO_TOTODILE_DOLL
	db DECO_POLIWAG_DOLL
	db DECO_MAREEP_DOLL
	db DECO_TOGEPI_DOLL
	db DECO_MAGIKARP_DOLL
	db DECO_ODDISH_DOLL
	db DECO_GENGAR_DOLL
	db DECO_MARACTUS_DOLL
	db DECO_DITTO_DOLL
	db DECO_VOLTORB_DOLL
	db DECO_GIRAFARIG_DOLL
	db DECO_COTTONEE_DOLL
	db DECO_GEODUDE_DOLL
	db DECO_PINECO_DOLL
	db DECO_EXEGGCUTE_DOLL
	db DECO_TEDDIURSA_DOLL
	db DECO_MEOWTH_DOLL
	db DECO_BUIZEL_DOLL
	db DECO_GROWLITHE_DOLL
	db DECO_EEVEE_DOLL
	db DECO_GOLD_TROPHY_DOLL
	db DECO_SILVER_TROPHY_DOLL
	db -1
; 26945

DecoBigDollMenu: ; 26945
	call FindOwnedBigDolls
	call PopulateDecoCategoryMenu
	xor a
	ret
; 2694d

FindOwnedBigDolls: ; 2694d
	ld hl, .big_dolls
	ld c, BIG_DOLLS
	jp FindOwnedDecosInCategory
; 26955

.big_dolls ; 26955
	db DECO_BIG_SNORLAX_DOLL
	db DECO_BIG_ONIX_DOLL
	db DECO_BIG_LAPRAS_DOLL
	db DECO_BIG_GYARADOS_DOLL
	db DECO_BIG_MAMOSWINE_DOLL
	db DECO_BIG_MUK_DOLL
	db -1
; 26959

DecoExitMenu: ; 26959
	scf
	ret
; 2695b

PopulateDecoCategoryMenu: ; 2695b
	ld a, [wd002]
	and a
	jr z, .empty
	cp 8
	jr nc, .beyond_eight
	xor a
	ld [wWhichIndexSet], a
	ld hl, .NonscrollingMenuDataHeader
	call LoadMenuDataHeader
	call DoNthMenu
	jr c, .no_action_1
	call DoDecorationAction2

.no_action_1
	jp ExitMenu

.beyond_eight
	ld hl, wd002
	ld e, [hl]
	dec [hl]
	ld d, 0
	add hl, de
	ld [hl], -1
	call LoadStandardMenuDataHeader
	ld hl, .ScrollingMenuDataHeader
	call CopyMenuDataHeader
	xor a
	ldh [hBGMapMode], a
	call InitScrollingMenu
	xor a
	ld [wMenuScrollPosition], a
	call ScrollingMenu
	ld a, [wMenuJoypad]
	cp 2
	jr z, .no_action_2
	call DoDecorationAction2

.no_action_2
	jp ExitMenu

.empty
	ld hl, .Text_nothing_to_choose
	jp MenuTextBoxBackup
; 269b0

.Text_nothing_to_choose: ; 0x269b0
	; There's nothing to choose.
	text_jump UnknownText_0x1bc471
	db "@"
; 0x269b5

.NonscrollingMenuDataHeader: ; 0x269b5
	db $40 ; flags
	db 00, 00 ; start coords
	db 17, 19 ; end coords
	dw .NonscrollingMenuData2
	db 1 ; default option
; 0x269bd

.NonscrollingMenuData2: ; 0x269bd
	db $a0 ; flags
	db 0 ; items
	dw wd002
	dw DecorationMenuFunction
	dw DecorationAttributes
; 0x269c5

.ScrollingMenuDataHeader: ; 0x269c5
	db $40 ; flags
	db 01, 01 ; start coords
	db 16, 18 ; end coords
	dw .ScrollingMenuData2
	db 1 ; default option
; 0x269cd

.ScrollingMenuData2: ; 0x269cd
	db $10 ; flags
	db 8, 0 ; rows, columns
	db 1 ; horizontal spacing
	dbw 0, wd002 ; text pointer
	dba DecorationMenuFunction
	dbw 0, 0
	dbw 0, 0
; 269dd


GetDecorationData: ; 269dd
	ld hl, DecorationAttributes
	ld bc, 6
	rst AddNTimes
	ret
; 269e7

GetDecorationName: ; 269e7
	push hl
	call GetDecorationData
	call GetDecoName
	pop hl
	jp CopyName2
; 269f3

DecorationMenuFunction: ; 269f3
	ld a, [wMenuSelection]
	push de
	call GetDecorationData
	call GetDecoName
	pop hl
	jp PlaceString
; 26a02

DoDecorationAction2: ; 26a02
	ld a, [wMenuSelection]
	call GetDecorationData
	ld de, 2 ; function 2
	add hl, de
	ld a, [hl]
	ld hl, .DecoActions
	rst JumpTable
	ret
; 26a12

.DecoActions: ; 26a12
	dw DecoAction_nothing
	dw DecoAction_setupbed
	dw DecoAction_putawaybed
	dw DecoAction_setupcarpet
	dw DecoAction_putawaycarpet
	dw DecoAction_setupplant
	dw DecoAction_putawayplant
	dw DecoAction_setupposter
	dw DecoAction_putawayposter
	dw DecoAction_setupconsole
	dw DecoAction_putawayconsole
	dw DecoAction_setupbigdoll
	dw DecoAction_putawaybigdoll
	dw DecoAction_setupornament
	dw DecoAction_putawayornament
; 26a30


GetDecorationFlag: ; 26a30
	call GetDecorationData
	ld de, 3 ; event flag
	add hl, de
	ld a, [hli]
	ld d, [hl]
	ld e, a
	ret
; 26a3b

DecorationFlagAction: ; 26a3b
	push bc
	call GetDecorationFlag
	pop bc
	jp EventFlagAction
; 26a44

GetDecorationSprite: ; 26a44
	ld a, c
	call GetDecorationData
	ld de, 5 ; sprite
	add hl, de
	ld a, [hl]
	ld c, a
	ret
; 26a4f

GetDecorationSpecies::
	call GetDecorationData
	inc hl
	ld a, [hl]
	ret

_GetDecorationSprite: ; 27085
	ld c, a
	push de
	push hl
	call GetDecorationSprite
	pop hl
	pop de
	ld a, c
	ret
; 27092

INCLUDE "data/decorations/attributes.asm"

INCLUDE "data/decorations/names.asm"

GetDecoName: ; 26c72
	ld a, [hli]
	ld e, [hl]
	ld bc, wStringBuffer2
	push bc
	ld hl, .NameFunctions
	rst JumpTable
	pop de
	ret
; 26c7e

.NameFunctions: ; 26c7e
	dw .invalid
	dw .plant
	dw .bed
	dw .carpet
	dw .poster
	dw .doll
	dw .bigdoll
; 26c8c

.plant ; 26c8d
	ld a, e
	jr .getdeconame

.bed ; 26c90
	call .plant
	ld a, _BED
	jr .getdeconame

.carpet ; 26c97
	call .plant
	ld a, _CARPET
	jr .getdeconame

.poster ; 26c9e
	ld a, e
	call .getpokename
	ld a, _POSTER
	jr .getdeconame

.doll ; 26ca6
	ld a, e
	call .getpokename
	ld a, _DOLL
	jr .getdeconame

.bigdoll ; 26cae
	push de
	ld a, BIG_
	call .getdeconame
	pop de
	ld a, e
	; fallthrough

.getpokename ; 26cc0
	push bc
	ld [wd265], a
	call GetPokemonName
	pop bc
	jr .copy

.getdeconame ; 26cca
	call ._getdeconame
	jr .copy

._getdeconame ; 26ccf
	push bc
	ld hl, DecorationNames
	call GetNthString
	ld d, h
	ld e, l
	pop bc
.invalid ; 26c8c
	ret
; 26c8d

.copy ; 26cda
	ld h, b
	ld l, c
	call CopyName2
	dec hl
	ld b, h
	ld c, l
	ret
; 26ce3

DecoAction_nothing: ; 26ce3
	scf
	ret
; 26ce5

DecoAction_setupbed: ; 26ce5
	ld hl, wBed
	jp DecoAction_TrySetItUp
; 26ceb

DecoAction_putawaybed: ; 26ceb
	ld hl, wBed
	jp DecoAction_TryPutItAway
; 26cf1

DecoAction_setupcarpet: ; 26cf1
	ld hl, wCarpet
	jp DecoAction_TrySetItUp
; 26cf7

DecoAction_putawaycarpet: ; 26cf7
	ld hl, wCarpet
	jp DecoAction_TryPutItAway
; 26cfd

DecoAction_setupplant: ; 26cfd
	ld hl, wPlant
	jp DecoAction_TrySetItUp
; 26d03

DecoAction_putawayplant: ; 26d03
	ld hl, wPlant
	jp DecoAction_TryPutItAway
; 26d09

DecoAction_setupposter: ; 26d09
	ld hl, wPoster
	jp DecoAction_TrySetItUp
; 26d0f

DecoAction_putawayposter: ; 26d0f
	ld hl, wPoster
	jp DecoAction_TryPutItAway
; 26d15

DecoAction_setupconsole: ; 26d15
	ld hl, wConsole
	jp DecoAction_TrySetItUp
; 26d1b

DecoAction_putawayconsole: ; 26d1b
	ld hl, wConsole
	jp DecoAction_TryPutItAway
; 26d21

DecoAction_setupbigdoll: ; 26d21
	ld hl, wBigDoll
	jp DecoAction_TrySetItUp
; 26d27

DecoAction_putawaybigdoll: ; 26d27
	ld hl, wBigDoll
	jp DecoAction_TryPutItAway
; 26d2d

DecoAction_TrySetItUp: ; 26d2d
	ld a, [hl]
	ld [wBuffer1], a
	push hl
	call DecoAction_SetItUp
	jr c, .failed
	ld a, 1
	ld [wBuffer5], a
	pop hl
	ld a, [wMenuSelection]
	ld [hl], a
	xor a
	ret

.failed
	pop hl
	xor a
	ret
; 26d46

DecoAction_SetItUp: ; 26d46
; See if there's anything of the same type already out
	ld a, [wBuffer1]
	and a
	jr z, .nothingthere
; See if that item is already out
	ld b, a
	ld a, [wMenuSelection]
	cp b
	jr z, .alreadythere
; Put away the item that's already out, and set up the new one
	ld a, [wMenuSelection]
	ld hl, wStringBuffer4
	call GetDecorationName
	ld a, [wBuffer1]
	ld hl, wStringBuffer3
	call GetDecorationName
	ld hl, DecoText_PutAwayAndSetUp
	call MenuTextBoxBackup
	xor a
	ret

.nothingthere
	ld a, [wMenuSelection]
	ld hl, wStringBuffer3
	call GetDecorationName
	ld hl, DecoText_SetUpTheDeco
	call MenuTextBoxBackup
	xor a
	ret

.alreadythere
	ld hl, DecoText_AlreadySetUp
	call MenuTextBoxBackup
	scf
	ret
; 26d86

DecoAction_TryPutItAway: ; 26d86
; If there is no item of that type already set, there is nothing to put away.
	ld a, [hl]
	ld [wBuffer1], a
	xor a
	ld [hl], a
	ld a, [wBuffer1]
	and a
	jr z, .nothingthere
; Put it away.
	ld a, $1
	ld [wBuffer5], a
	ld a, [wBuffer1]
	ld [wMenuSelection], a
	ld hl, wStringBuffer3
	call GetDecorationName
	ld hl, DecoText_PutAwayTheDeco
	call MenuTextBoxBackup
	xor a
	ret

.nothingthere
	ld hl, DecoText_NothingToPutAway
	call MenuTextBoxBackup
	xor a
	ret
; 26db3

DecoAction_setupornament: ; 26db3
	ld hl, UnknownText_0x26e41
	call DecoAction_AskWhichSide
	jr c, .cancel
	call DecoAction_SetItUp_Ornament
	jr c, .cancel
	ld a, $1
	ld [wBuffer5], a
	jr DecoAction_FinishUp_Ornament

.cancel
	xor a
	ret

DecoAction_putawayornament: ; 26dc9
	ld hl, DecoText_WhichSide
	call DecoAction_AskWhichSide
	jr nc, .incave
	xor a
	ret

.incave
	call DecoAction_PutItAway_Ornament
	; fallthrough

DecoAction_FinishUp_Ornament: ; 26dd6
	call QueryWhichSide
	ld a, [wBuffer3]
	ld [hl], a
	ld a, [wBuffer4]
	ld [de], a
	xor a
	ret
; 26de3

DecoAction_SetItUp_Ornament: ; 26de3
	ld a, [wBuffer3]
	and a
	jr z, .nothingthere
	ld b, a
	ld a, [wMenuSelection]
	cp b
	jr z, .failed
	ld a, b
	ld hl, wStringBuffer3
	call GetDecorationName
	ld a, [wMenuSelection]
	ld hl, wStringBuffer4
	call GetDecorationName
	ld a, [wMenuSelection]
	ld [wBuffer3], a
	call .getwhichside
	ld hl, DecoText_PutAwayAndSetUp
	call MenuTextBoxBackup
	xor a
	ret

.nothingthere
	ld a, [wMenuSelection]
	ld [wBuffer3], a
	call .getwhichside
	ld a, [wMenuSelection]
	ld hl, wStringBuffer3
	call GetDecorationName
	ld hl, DecoText_SetUpTheDeco
	call MenuTextBoxBackup
	xor a
	ret

.failed
	ld hl, DecoText_AlreadySetUp
	call MenuTextBoxBackup
	scf
	ret
; 26e33

.getwhichside ; 26e33
	ld a, [wMenuSelection]
	ld b, a
	ld a, [wBuffer4]
	cp b
	ret nz
	xor a
	ld [wBuffer4], a
	ret
; 26e41

UnknownText_0x26e41: ; 0x26e41
	; Which side do you want to put it on?
	text_jump UnknownText_0x1bc48c
	db "@"
; 0x26e46

DecoAction_PutItAway_Ornament: ; 26e46
	ld a, [wBuffer3]
	and a
	jr z, .nothingthere
	ld hl, wStringBuffer3
	call GetDecorationName
	ld a, $1
	ld [wBuffer5], a
	xor a
	ld [wBuffer3], a
	ld hl, DecoText_PutAwayTheDeco
	call MenuTextBoxBackup
	xor a
	ret

.nothingthere
	ld hl, DecoText_NothingToPutAway
	call MenuTextBoxBackup
	xor a
	ret
; 26e6b

DecoText_WhichSide: ; 0x26e6b
	; Which side do you want to put away?
	text_jump UnknownText_0x1bc4b2
	db "@"
; 0x26e70

DecoAction_AskWhichSide: ; 26e70
	call MenuTextBox
	ld hl, MenuDataHeader_0x26eab
	call GetMenu2
	call ExitMenu
	call CopyMenuData2
	jr c, .nope
	ld a, [wMenuCursorY]
	cp 3
	jr z, .nope
	ld [wBuffer2], a
	call QueryWhichSide
	ld a, [hl]
	ld [wBuffer3], a
	ld a, [de]
	ld [wBuffer4], a
	xor a
	ret

.nope
	scf
	ret
; 26e9a

QueryWhichSide: ; 26e9a
	ld hl, wLeftOrnament
	ld de, wRightOrnament
	ld a, [wBuffer2]
	cp 1
	ret z
	push hl
	ld h, d
	ld l, e
	pop de
	ret
; 26eab

MenuDataHeader_0x26eab: ; 0x26eab
	db $40 ; flags
	db 00, 00 ; start coords
	db 07, 13 ; end coords
	dw MenuData2_0x26eb3
	db 1 ; default option
; 0x26eb3

MenuData2_0x26eb3: ; 0x26eb3
	db $80 ; flags
	db 3 ; items
	db "LEFT SIDE@"
	db "RIGHT SIDE@"
	db "CANCEL@"
; 0x26ed1

DecoText_GrabTapePlayer:
	text_jump UnknownText_GrabTapePlayer
	db "@"

DecoText_PutAwayTheDeco: ; 0x26ed1
	; Put away the @ .
	text_jump UnknownText_0x1bc4d7
	db "@"
; 0x26ed6

DecoText_NothingToPutAway: ; 0x26ed6
	; There's nothing to put away.
	text_jump UnknownText_0x1bc4ec
	db "@"
; 0x26edb

DecoText_SetUpTheDeco: ; 0x26edb
	; Set up the @ .
	text_jump UnknownText_0x1bc509
	db "@"
; 0x26ee0

DecoText_PutAwayAndSetUp: ; 0x26ee0
	; Put away the @ and set up the @ .
	text_jump UnknownText_0x1bc51c
	db "@"
; 0x26ee5

DecoText_AlreadySetUp: ; 0x26ee5
	; That's already set up.
	text_jump UnknownText_0x1bc546
	db "@"
; 0x26eea

GetDecorationName_c_de: ; 26eea
	ld a, c
	ld h, d
	ld l, e
	jp GetDecorationName
; 26ef1

DecorationFlagAction_c: ; 26ef1
	ld a, c
	jp DecorationFlagAction
; 26ef5


GetDecorationName_c: ; 26ef5 (9:6ef5)
	ld a, c
	call GetDecorationID
	ld hl, wStringBuffer1
	push hl
	call GetDecorationName
	pop de
	ret

GetDecorationID: ; 26f0c
	push hl
	push de
	ld e, a
	ld d, 0
	ld hl, DecorationIDs
	add hl, de
	ld a, [hl]
	pop de
	pop hl
	ret
; 26f19

INCLUDE "data/decorations/decorations.asm"

DescribeDecoration:: ; 26f59
	ld a, b
	ld hl, JumpTable_DecorationDesc
	rst JumpTable
	ret
; 26f5f

JumpTable_DecorationDesc: ; 26f5f
	dw DecorationDesc_Poster
	dw DecorationDesc_LeftOrnament
	dw DecorationDesc_RightOrnament
	dw DecorationDesc_GiantOrnament
	dw DecorationDesc_Console
; 26f69

DecorationDesc_Poster: ; 26f69
	ld a, [wPoster]
	ld hl, DecorationDesc_PosterPointers
	ld de, 3
	call IsInArray
	jr c, .nope
	ld de, DecorationDesc_NullPoster
	ld b, BANK(DecorationDesc_NullPoster)
	ret

.nope
	ld b, BANK(DecorationDesc_TownMapPoster)
	inc hl
	ld a, [hli]
	ld d, [hl]
	ld e, a
	ret
; 26f84

DecorationDesc_PosterPointers: ; 26f84
	dbw DECO_POKEBALL_POSTER, DecorationDesc_PokeballPoster
	dbw DECO_PIKACHU_POSTER, DecorationDesc_PikachuPoster
	dbw DECO_CLEFAIRY_POSTER, DecorationDesc_ClefairyPoster
	dbw DECO_JIGGLYPUFF_POSTER, DecorationDesc_JigglypuffPoster
	dbw DECO_EEVEE_POSTER, DecorationDesc_EeveePoster
	dbw DECO_MARILL_POSTER, DecorationDesc_MarillPoster
	dbw DECO_TOWN_MAP, DecorationDesc_TownMapPoster
	dbw DECO_MINAS_PAINTING, DecorationDesc_MinasPainting
	dbw DECO_MUSEUM_PHOTO, DecorationDesc_MuseumPhoto
	db -1
; 26f91

DecorationDesc_TownMapPoster: ; 0x26f91
	opentext
	writetext .TownMapText
	waitbutton
	special Special_TownMap
	closetext
	end
; 0x26f9b

.TownMapText: ; 0x26f9b
	; It's the TOWN MAP.
	text_jump UnknownText_0x1bc55d
	db "@"
; 0x26fa0

DecorationDesc_PokeballPoster:
	jumptext .PokeballPosterText

.PokeballPosterText:
	text_jump UnknownText_PokeballPoster
	db "@"

DecorationDesc_MinasPainting:
	jumptext .MinasPaintingText
	
.MinasPaintingText: ; 0x26fa3
	; It's a picture painted by MINA.
	text_jump UnknownText_MinaPainting
	db "@"

DecorationDesc_MuseumPhoto:
	opentext
	writetext MuseumPhotoText
	yesorno
	closetext
	iffalse .end
	pause 2
	special FadeOutPalettes
	warp2 DOWN, OBSCURA_MUSEUM_PHOTO, 2, 1
.end
	end
	
MuseumPhotoText:
	text "A photo of you"
	line "taken at the"
	cont "museum."
	
	para "Take a closer"
	line "look?"
	done

DecorationDesc_PikachuPoster: ; 0x26fa0
	jumptext .PikaPosterText
; 0x26fa3

.PikaPosterText: ; 0x26fa3
	; It's a poster of a cute PIKACHU.
	text_jump UnknownText_0x1bc570
	db "@"
; 0x26fa8

DecorationDesc_ClefairyPoster: ; 0x26fa8
	jumptext .ClefairyPosterText
; 0x26fab

.ClefairyPosterText: ; 0x26fab
	; It's a poster of a cute CLEFAIRY.
	text_jump UnknownText_0x1bc591
	db "@"
; 0x26fb0

DecorationDesc_JigglypuffPoster:
	jumptext .JigglypuffPosterText

.JigglypuffPosterText:
	; It's a poster of a cute JIGGLYPUFF.
	text_jump UnknownText_Jigglypuff
	db "@"

DecorationDesc_EeveePoster:
	jumptext .EeveePosterText

.EeveePosterText:
	; It's a poster of a cute EEVEE.
	text_jump UnknownText_Eevee
	db "@"

DecorationDesc_MarillPoster: ; 0x26fb0
	jumptext .MarillPosterText
; 0x26fb3

.MarillPosterText: ; 0x26fb3
	; It's a poster of a cute MARILL.
	text_jump UnknownText_0x1bc5b3
	db "@"
; 0x26fb8

DecorationDesc_NullPoster: ; 26fb8
	end
; 26fb9

DecorationDesc_LeftOrnament: ; 26fb9
	ld a, [wLeftOrnament]
	jr DecorationDesc_Ornament

DecorationDesc_RightOrnament: ; 26fbe
	ld a, [wRightOrnament]
DecorationDesc_Ornament:
	ld c, a
	cp DECO_GOLD_TROPHY_DOLL
	jr z, DecorationDesc_Console.go
	cp DECO_SILVER_TROPHY_DOLL
	jr z, DecorationDesc_Console.go
	ld de, wStringBuffer3
	call GetDecorationName_c_de
	ld b, BANK(.OrnamentScript)
	ld de, .OrnamentScript
	ret

.OrnamentScript:
	jumptext .OrnamentText

.OrnamentText:
	; It's an adorable @ .
	text_jump UnknownText_0x1bc5d7
	db "@"

DecorationDesc_Console: ; 26fc3
	ld a, [wConsole]
	ld c, a
.go:
	ld de, wStringBuffer3
	call GetDecorationName_c_de
	ld b, BANK(.ConsoleScript)
	ld de, .ConsoleScript
	ret
; 26fd5

.ConsoleScript: ; 26fd5
	jumptext .ConsoleText
; 26fd8

.ConsoleText: ; 0x26fd8
	; It's a shiny @ .
	text_jump DecoConsoleText
	db "@"
; 0x26fdd

DecorationDesc_GiantOrnament: ; 26fdd
	ld b, BANK(.BigDollScript)
	ld de, .BigDollScript
	ret
; 26fe3

.BigDollScript: ; 26fe3
	jumptext .BigDollText
; 26fe6

.BigDollText: ; 0x26fe6
	; A giant doll! It's fluffy and cuddly.
	text_jump UnknownText_0x1bc5ef
	db "@"
; 0x26feb

ToggleMaptileDecorations: ; 26feb
	lb de, 2, 4
	ld a, [wBed]
	call SetDecorationTile
	lb de, 8, 4
	ld a, [wPlant]
	call SetDecorationTile
	lb de, 8, 0
	ld a, [wPoster]
	call SetDecorationTile
	call SetPosterVisibility
	lb de, 2, 0
	call PadCoords_de
	ld a, [wCarpet]
	and a
	ret z
	call _GetDecorationSprite
	ld [hl], a
	push af
	lb de, 2, 2
	call PadCoords_de
	pop af
	inc a
	ld [hli], a
	inc a
	ld [hli], a
	dec a
	ld [hli], a
;	ld [hli], a
;	push af
;	lb de, 8, 0
;	call PadCoords_de
;	pop af
;	inc a
;	inc a
;	ld [hl], a
	ret
; 27027

SetPosterVisibility: ; 27027
	ld b, SET_FLAG
	ld a, [wPoster]
	and a
	jr nz, .ok
	ld b, RESET_FLAG

.ok
	ld de, EVENT_KRISS_ROOM_POSTER
	jp EventFlagAction
; 27037

SetDecorationTile: ; 27037
	push af
	call PadCoords_de
	pop af
	and a
	ret z
	call _GetDecorationSprite
	ld [hl], a
	ret
; 27043

ToggleDecorationsVisibility: ; 27043
	ld de, EVENT_KRISS_HOUSE_2F_CONSOLE
	ld hl, wVariableSprites + SPRITE_CONSOLE - SPRITE_VARS
	ld a, [wConsole]
	call .ToggleDecorationVisibility
	ld de, EVENT_KRISS_HOUSE_2F_BIG_DOLL
	ld hl, wVariableSprites + SPRITE_BIG_DOLL - SPRITE_VARS
	ld a, [wBigDoll]
	call .ToggleDecorationVisibility
	ld de, EVENT_KRISS_HOUSE_2F_DOLL_1
	ld hl, wVariableSprites + SPRITE_DOLL_1 - SPRITE_VARS
	ld a, [wLeftOrnament]
	call .ToggleDecorationVisibility
	ld de, EVENT_KRISS_HOUSE_2F_DOLL_2
	ld hl, wVariableSprites + SPRITE_DOLL_2 - SPRITE_VARS
	ld a, [wRightOrnament]
	and a
	jr z, .hide
	call _GetDecorationSprite
	cp SPRITE_MON_DOLL_1
	jr nz, .ok
	inc a ; SPRITE_MON_DOLL_2
	jr .ok

.ToggleDecorationVisibility: ; 27074
	and a
	jr z, .hide
	call _GetDecorationSprite
.ok
	ld [hl], a
	ld b, RESET_FLAG
	jp EventFlagAction

.hide
	ld b, SET_FLAG
	jp EventFlagAction
; 27085
