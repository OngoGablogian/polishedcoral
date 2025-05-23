SunsetBay_MapScriptHeader:
	db 5 ; scene scripts
	scene_script SunsetBayTrigger0
	scene_script SunsetBayTrigger1
	scene_script SunsetBayTrigger2
	scene_script SunsetBayTrigger3
	scene_script SunsetBayTrigger4

	db 2 ; callbacks
	callback MAPCALLBACK_NEWMAP, SunsetBayFlyPoint
	callback MAPCALLBACK_TILES, SunsetBayCallback

	db 7 ; warp events
	warp_event 13, 13, PLAYER_HOUSE_1F, 2
	warp_event 25,  9, SUNSET_POKECENTER, 2
	warp_event 29, 15, SUNSET_CAFE, 2
	warp_event 25, 27, SUNSET_CAPTAINS_HOUSE, 1
	warp_event 19,  9, SUNSET_WATER_GRASS_HOUSE, 2
	warp_event 31,  9, SUNSET_LEGENDS_HOUSE, 2
	warp_event 21, 15, SUNSET_GENGAR_HOUSE, 2

	db 4 ; coord events
	coord_event 37, 12, 0, SunsetGrampsStopsYou1
	coord_event 37, 15, 0, SunsetGrampsStopsYou2
	coord_event 37, 16, 0, SunsetGrampsStopsYou3
	coord_event 37, 17, 0, SunsetGrampsStopsYou4

	db 23 ; bg events
	bg_event 11, 13, SIGNPOST_READ, PlayersHouseSign
	bg_event 27, 15, SIGNPOST_READ, SunsetCafeSign
	bg_event 26,  9, SIGNPOST_READ, SunsetBayPokeCenterSign
	bg_event 37, 13, SIGNPOST_READ, SunsetBaySign
	bg_event 16, 12, SIGNPOST_READ, SunsetMomsFlowers
	bg_event 16, 13, SIGNPOST_READ, SunsetMomsFlowers
	bg_event 34, 17, SIGNPOST_READ, SunsetOtherFlowers
	bg_event 28,  8, SIGNPOST_READ, SunsetOtherFlowers
	bg_event 28,  9, SIGNPOST_READ, SunsetOtherFlowers
	bg_event 34, 12, SIGNPOST_READ, SunsetOtherFlowers
	bg_event 34, 13, SIGNPOST_READ, SunsetOtherFlowers
	bg_event 34, 14, SIGNPOST_READ, SunsetOtherFlowers
	bg_event 34, 15, SIGNPOST_READ, SunsetOtherFlowers
	bg_event 34, 16, SIGNPOST_READ, SunsetOtherFlowers
	bg_event 24, 14, SIGNPOST_READ, SunsetOtherFlowers
	bg_event 24, 15, SIGNPOST_READ, SunsetOtherFlowers
	bg_event 32, 12, SIGNPOST_READ, SunsetGuyOnDate
	bg_event 35, 21, SIGNPOST_ITEM + POKE_BALL, EVENT_SUNSET_BAY_HIDDEN_POKE_BALL
	bg_event 12, 18, SIGNPOST_ITEM + POTION, EVENT_SUNSET_BAY_HIDDEN_POTION
	bg_event 33,  6, SIGNPOST_ITEM + TAPE_PLAYER, EVENT_MUSIC_SUNSET_BAY
	signpost 21, 16, SIGNPOST_ITEM + BOTTLE_CAP, EVENT_SUNSET_BAY_HIDDEN_BOTTLE_CAP_1
	signpost 21,  8, SIGNPOST_ITEM + BOTTLE_CAP, EVENT_SUNSET_BAY_HIDDEN_BOTTLE_CAP_2
	signpost 23, 31, SIGNPOST_ITEM + BOTTLE_CAP, EVENT_SUNSET_BAY_HIDDEN_BOTTLE_CAP_3

	db 19 ; object events
	person_event SPRITE_CUTE_GIRL, 15, 32, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, SunsetNPC1, -1
	object_event 32, 13, SPRITE_ROCKER, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
	person_event SPRITE_GRAMPS, 14, 37, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, SunsetNPC3, -1
	person_event SPRITE_COOLTRAINER_F, 11, 18, SPRITEMOVEDATA_WANDER, 2, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, SunsetNPC4, -1
	person_event SPRITE_FAT_GUY, 18, 15, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, SunsetNPC5, -1
	person_event SPRITE_SUPER_NERD, 18, 33, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, SunsetNPC6, -1
	object_event 27, 28, SPRITE_SAILBOAT, SPRITEMOVEDATA_SAILBOAT_TOP, 0, 0, -1, -1, PAL_OW_SILVER, PERSONTYPE_SCRIPT, 0, SunsetSailboat2, -1
	object_event 27, 29, SPRITE_SAILBOAT, SPRITEMOVEDATA_TILE_UP_SOLID, 0, 0, -1, -1, PAL_OW_SILVER, PERSONTYPE_SCRIPT, 0, SunsetSailboat2, -1
	object_event 26, 29, SPRITE_SAILBOAT, SPRITEMOVEDATA_TILE_DOWN_SOLID, 0, 0, -1, -1, PAL_OW_SILVER, PERSONTYPE_SCRIPT, 0, SunsetSailboat2, -1
	object_event 26, 28, SPRITE_SAILBOAT, SPRITEMOVEDATA_TILE_LEFT_PRIORITY, 0, 0, -1, -1, PAL_OW_SILVER, PERSONTYPE_SCRIPT, 0, SunsetSailboat2, -1
	object_event 10, 24, SPRITE_SAILBOAT, SPRITEMOVEDATA_SAILBOAT_TOP, 0, 0, -1, -1, PAL_OW_SILVER, PERSONTYPE_SCRIPT, 0, SunsetSailboat, -1
	object_event 10, 25, SPRITE_SAILBOAT, SPRITEMOVEDATA_TILE_UP_SOLID, 0, 0, -1, -1, PAL_OW_SILVER, PERSONTYPE_SCRIPT, 0, SunsetSailboat, -1
	object_event  9, 25, SPRITE_SAILBOAT, SPRITEMOVEDATA_TILE_DOWN_SOLID, 0, 0, -1, -1, PAL_OW_SILVER, PERSONTYPE_SCRIPT, 0, SunsetSailboat, -1
	object_event  9, 24, SPRITE_SAILBOAT, SPRITEMOVEDATA_TILE_LEFT_PRIORITY, 0, 0, -1, -1, PAL_OW_SILVER, PERSONTYPE_SCRIPT, 0, SunsetSailboat, -1
	object_event 13, 28, SPRITE_SAILBOAT, SPRITEMOVEDATA_SAILBOAT_TOP, 0, 0, -1, -1, PAL_OW_SILVER, PERSONTYPE_SCRIPT, 0, SunsetSailboat, -1
	object_event 13, 29, SPRITE_SAILBOAT, SPRITEMOVEDATA_TILE_UP_SOLID, 0, 0, -1, -1, PAL_OW_SILVER, PERSONTYPE_SCRIPT, 0, SunsetSailboat, -1
	object_event 12, 29, SPRITE_SAILBOAT, SPRITEMOVEDATA_TILE_DOWN_SOLID, 0, 0, -1, -1, PAL_OW_SILVER, PERSONTYPE_SCRIPT, 0, SunsetSailboat, -1
	object_event 12, 28, SPRITE_SAILBOAT, SPRITEMOVEDATA_TILE_LEFT_PRIORITY, 0, 0, -1, -1, PAL_OW_SILVER, PERSONTYPE_SCRIPT, 0, SunsetSailboat, -1
	hiddentape_event 33, 6, MUSIC_SUNSET_BAY, 1, EVENT_MUSIC_SUNSET_BAY

	const_def 1 ; object constants
	const SUNSET_NPC1
	const SUNSET_NPC2
	const SUNSET_NPC3
	const SUNSET_NPC4
	const SUNSET_NPC5
	const SUNSET_NPC6
	const SUNSET_SAILBOAT1_T1
	const SUNSET_SAILBOAT1_T2
	const SUNSET_SAILBOAT1_B1
	const SUNSET_SAILBOAT1_B2
	const SUNSET_SAILBOAT2_T1
	const SUNSET_SAILBOAT2_T2
	const SUNSET_SAILBOAT2_B1
	const SUNSET_SAILBOAT2_B2
	const SUNSET_SAILBOAT3_T1
	const SUNSET_SAILBOAT3_T2
	const SUNSET_SAILBOAT3_B1
	const SUNSET_SAILBOAT3_B2

SunsetBayTrigger0:
	end
	
SunsetBayTrigger1:
	end
	
SunsetBayTrigger2:
	setevent EVENT_MOM_SPEECH_LOOP
	dotrigger $1
	end
	
SunsetBayTrigger3:
	priorityjump JustRodeBoatSunset
	end
	
SunsetBayTrigger4:
	special Special_StartLandmarkTimer
	checkevent EVENT_GOT_A_POKEMON_FROM_SPRUCE
	iftrue .got_pokegear
	dotrigger $0
	end
.got_pokegear
	dotrigger $1
	end
	
SunsetBayFlyPoint:
	setflag ENGINE_FLYPOINT_SUNSET
	return
		
SunsetBayCallback:
	clearevent EVENT_CAPE_LIGHTHOUSE_COLORS
	domaptrigger SUNSET_CAPE, $0
	checkevent EVENT_SUNSET_STRAND
	iftrue .end
	moveperson SUNSET_SAILBOAT2_T1, 29, 30
	moveperson SUNSET_SAILBOAT2_T2, 29, 31
	moveperson SUNSET_SAILBOAT2_B1, 28, 31
	moveperson SUNSET_SAILBOAT2_B2, 28, 30
.end
	return
		
JustRodeBoatSunset:
	special Special_StopRunning
	special Special_StopLandmarkTimer
	opentext
	writetext SunsetJustRodeBoatText
	waitbutton
	closetext
	wait 5
	playsound SFX_EXIT_BUILDING
	special Special_FadeBlackQuickly
	special Special_ReloadSpritesNoPalettes
	disappear SUNSET_SAILBOAT2_T1
	disappear SUNSET_SAILBOAT2_T2
	disappear SUNSET_SAILBOAT2_B1
	disappear SUNSET_SAILBOAT2_B2
	moveperson SUNSET_SAILBOAT2_T1, 10, 24
	moveperson SUNSET_SAILBOAT2_T2, 10, 25
	moveperson SUNSET_SAILBOAT2_B1, 9, 25
	moveperson SUNSET_SAILBOAT2_B2, 9, 24
	appear SUNSET_SAILBOAT2_T1
	appear SUNSET_SAILBOAT2_T2
	appear SUNSET_SAILBOAT2_B1
	appear SUNSET_SAILBOAT2_B2
	waitsfx
	special Special_FadeInQuickly
	special Special_StartLandmarkTimer
	waitsfx
	setevent EVENT_SUNSET_STRAND
	dotrigger $1
	end
	
PlayersHouseSign:
	jumptext PlayersHouseSignText

SunsetCafeSign:
	jumptext SunsetCafeSignText
	
SunsetBayPokeCenterSign:
	jumpstd pokecentersign
	
SunsetBaySign:
	jumptext SunsetBaySignText
	
SunsetMomsFlowers:
	jumptext SunsetMomsFlowersText

SunsetOtherFlowers:
	jumptext SunsetOtherFlowersText
	
SunsetSailboat:
	jumptext SunsetSailboatText
	
SunsetSailboat2:
	jumptext SunsetSailboat2Text
	
SunsetNPC1:
	faceplayer
	opentext
	writetext SunsetNPC1Text
	waitbutton
	spriteface SUNSET_NPC1, UP
	closetext
	end

SunsetGuyOnDate:
	jumptext SunsetGuyOnDateText
	
SunsetNPC3:
	checkevent EVENT_TALKED_TO_MAN_IN_SHACK
	iffalse SunsetGramps
	jumptextfaceplayer SunsetGrampsText2
	
SunsetGramps:
	jumptextfaceplayer SunsetGrampsText
	
SunsetNPC4:
	jumptextfaceplayer SunsetNPC4Text
	
SunsetNPC5:
	checkevent EVENT_SUNSET_BAY_HIDDEN_POTION
	iftrue SunsetNPC5_2
	faceplayer
	opentext
	writetext SunsetNPC5Text
	waitbutton
	closetext
	end

SunsetNPC5_2:
	jumptextfaceplayer SunsetNPC5Text2

	
SunsetGrampsStopsYou1:
	special Special_StopRunning
	playsound SFX_PAY_DAY
	spriteface SUNSET_NPC3, UP
	showemote EMOTE_SHOCK, SUNSET_NPC3, 15
	spriteface PLAYER, DOWN
;	applymovement SUNSET_NPC3, Movement_GrampsStart1
	opentext
	writetext SunsetGrampsText
	waitbutton
	closetext
	applymovement PLAYER, Movement_BackToSunset
;	stopfollow
;	applymovement SUNSET_NPC3, Movement_GrampsReset1
	end
	
SunsetGrampsStopsYou2:
	special Special_StopRunning
	playsound SFX_PAY_DAY
	spriteface SUNSET_NPC3, DOWN
	showemote EMOTE_SHOCK, SUNSET_NPC3, 15
	spriteface PLAYER, UP
	opentext
	writetext SunsetGrampsText
	waitbutton
	closetext
	applymovement PLAYER, Movement_BackToSunset
	stopfollow
	end
	
SunsetGrampsStopsYou3:
	special Special_StopRunning
	playsound SFX_PAY_DAY
	spriteface SUNSET_NPC3, DOWN
	showemote EMOTE_SHOCK, SUNSET_NPC3, 15
	spriteface PLAYER, UP
	applymovement SUNSET_NPC3, Movement_GrampsStart2
	opentext
	writetext SunsetGrampsText
	waitbutton
	closetext
	applymovement PLAYER, Movement_BackToSunset
	stopfollow
	applymovement SUNSET_NPC3, Movement_GrampsReset2
	end
	
SunsetGrampsStopsYou4:
	special Special_StopRunning
	playsound SFX_PAY_DAY
	spriteface SUNSET_NPC3, DOWN
	showemote EMOTE_SHOCK, SUNSET_NPC3, 15
	spriteface PLAYER, UP
	applymovement SUNSET_NPC3, Movement_GrampsStart3
	opentext
	writetext SunsetGrampsText
	waitbutton
	closetext
	applymovement PLAYER, Movement_BackToSunset
	stopfollow
	applymovement SUNSET_NPC3, Movement_GrampsReset3
	end
	
SunsetNPC6:
	jumptextfaceplayer SunsetNPC6Text
	
Movement_BackToSunset:
	step_left
	step_end
	
Movement_GrampsStart1:
	step_up
	step_end	

Movement_GrampsReset1:
	step_down
	step_end
	
Movement_GrampsStart2:
	step_down
	step_end	

Movement_GrampsReset2:
	step_up
	step_end
	
Movement_GrampsStart3:
	step_down
	step_down
	step_end	

Movement_GrampsReset3:
	step_up
	step_up
	step_end
	
SunsetSailboatText:
	text "It's a sailboat."
	
	para "It's seen some use,"
	line "but it's still in"
	cont "good shape."
	done
	
SunsetSailboat2Text:
	text "CAP'N STRAND's"
	line "sailboat."
	
	para "It's seen a lot of"
	line "use!"
	done
	
SunsetNPC1Text:
	text "Do you mind?"
	line "<WAIT_M>I'm on a date."
	done
	
PlayersHouseSignText:
	text "<PLAYER>'s HOUSE"
	done

SunsetCafeSignText:
	text "SUNSET CAFE"
	done
	
SunsetBaySignText:
	text "SUNSET BAY"
	
	para "The sleepy town"
	line "by the sea."
	done
	
SunsetMomsFlowersText:
	text "Flowers grown by"
	line "MOM."
	
	para "They smell"
	line "wonderful!"
	done

SunsetOtherFlowersText:
	text "Some flowers."
	
	para "They smell pretty"
	line "good."
	
	para "Not as good as"
	line "MOM's, though…"
	done
	
SunsetGuyOnDateText:
	text "…"
	
	para "…"
	
	para "He's ignoring you."
	done
	
SunsetGrampsText:
	text "<PLAYER>!"
	
	para "CAP'N STRAND"
	line "wanted to see you."
	
	para "He lives down by"
	line "the pier."
	done

SunsetGrampsText2:
	text "The lighthouse is"
	line "up ahead."
	
	para "They built it when"
	line "I was just a lad."
	
	para "Where did the time"
	line "go?"
	done
	
SunsetNPC4Text:
	text "Nice RUNNING"
	line "SHOES!"
	
	para "You can run if"
	line "you hold the"
	cont "B BUTTON, <WAIT_S>right?"
	done
	
SunsetNPC5Text:
	text "They say you can"
	line "sometimes find"
	cont "things that people"
	cont "drop on the beach."
	
	para "I don't know,"
	line "though."
	
	para "I don't see"
	line "anything like that"
	cont "around here."
	done
	
SunsetNPC5Text2:
	text "Hey!"
	
	para "They were right!"
	
	para "…<WAIT_L>Who's they?"
	
	para "You know,<WAIT_S>"
	line "I never thought"
	cont "about it."
	done
	
SunsetNPC6Text:
	text "SUNSET BAY doesn't"
	line "have a #MART"
	cont "like most towns,"
	
	para "but you can buy"
	line "most of what you"
	cont "need at the CAFE."
	done
	
SunsetJustRodeBoatText:
	text "Here we are,<WAIT_S>"
	line "SUNSET BAY."
	
	para "Thanks for riding."
	
	para "Come again."
	done
	
SunsetBayHiddenPokeBall:
	dwb EVENT_SUNSET_BAY_HIDDEN_POKE_BALL, POKE_BALL
	
SunsetBayHiddenPotion:
	dwb EVENT_SUNSET_BAY_HIDDEN_POTION, POTION