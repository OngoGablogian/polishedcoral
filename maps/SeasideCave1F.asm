SeasideCave1F_MapScriptHeader:
	db 0 ; scene scripts

	db 1 ; callbacks
	callback MAPCALLBACK_TILES, SeasideCave1FCallback

	db 4 ; warp events
	warp_event  7,  1, ROUTE_19, 3
	warp_event 15,  3, SEASIDE_CAVE_B1F, 1
	warp_event 15, 19, SEASIDE_CAVE_B1F, 2
	warp_event 17, 35, ROUTE_22_TUNNEL, 6

	db 0 ; coord events

	db 1 ; bg events
	signpost  9,  4, SIGNPOST_ITEM + ZINC, EVENT_SEASIDE_CAVE_1F_HIDDEN_ITEM

	db 7 ; object events
	object_event 15,  9, SPRITE_TRUNKS, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, SeasideCave1FNPC1, EVENT_TALKED_TO_SEASIDE_CAVE_GUY_3
	object_event 15, 13, SPRITE_SWIMMER_GIRL, SPRITEMOVEDATA_SPINCOUNTERCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_TEAL, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
	object_event 14, 14, SPRITE_TRUNKS_WATER, SPRITEMOVEDATA_SPINCLOCKWISE, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_SEASIDE_CAVE_GUY_NOT_SPINNING
	tapeball_event 20,  8, MUSIC_EVOLUTION, 1, EVENT_MUSIC_EVOLUTION
	itemball_event 13,  5, DUSK_BALL, 1, EVENT_SEASIDE_CAVE_1F_POKE_BALL
	person_event SPRITE_SUPER_NERD, 30, 10, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_GENERICTRAINER, 1, SeasideCave1FTrainer1, -1
	person_event SPRITE_ROCKER, 32, 15, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_GENERICTRAINER, 3, SeasideCave1FTrainer2, -1
	
	
	const_def 1 ; object constants
	const SEASIDE_CAVE_NPC_1
	const SEASIDE_CAVE_NPC_2
	
SeasideCave1FCallback:
	domaptrigger ROUTE_22_TUNNEL, $0
	return
	
SeasideCave1FTrainer1:
	generictrainer SUPER_NERD, MARIO, EVENT_BEAT_SEASIDE_CAVE_1F_TRAINER_1, .SeenText, .BeatenText

	text "This is a great"
	line "place to train"
	cont "ELECTRIC-type"
	cont "#MON!"
	done

.SeenText:
	text "Are you ready for"
	line "a shocking battle?"
	done

.BeatenText:
	text "Shocking!"
	done
	
SeasideCave1FTrainer2:
	generictrainer GUITARIST, VINNY, EVENT_BEAT_SEASIDE_CAVE_1F_TRAINER_2, .SeenText, .BeatenText

	text "Dun da nuh"
	line "nuh nuh."
	
	para "I'm bluer than"
	line "the big blue sea…"
	done

.SeenText:
	text "Dun da nuh"
	line "nuh nuh."
	
	para "I got the blues"
	line "like you wouldn't"
	cont "believe…"
	
	para "Maybe a battle"
	line "would help me."
	done

.BeatenText:
	text "Dun da nuh"
	line "nuh nuh."
	done
	
SeasideCave1FNPC1:
	faceplayer
	opentext
	checkevent EVENT_TALKED_TO_SEASIDE_CAVE_GUY_2
	iftrue .alreadytalked2
	checkevent EVENT_TALKED_TO_SEASIDE_CAVE_GUY_1
	iftrue .alreadytalked1
	writetext SeasideCave1FNPC1Text1
	setevent EVENT_TALKED_TO_SEASIDE_CAVE_GUY_1
	jump .cont
.alreadytalked1
	writetext SeasideCave1FNPC1Text2
	setevent EVENT_TALKED_TO_SEASIDE_CAVE_GUY_2
	jump .cont
.alreadytalked2
	writetext SeasideCave1FNPC1Text3
	setevent EVENT_TALKED_TO_SEASIDE_CAVE_GUY_3
	clearevent EVENT_SEASIDE_CAVE_GUY_NOT_SPINNING
.cont
	waitbutton
	closetext
	spriteface SEASIDE_CAVE_NPC_1, DOWN
	end
	
SeasideCave1FNPC1Text1:
	text "We wandered into"
	line "this cave and my"
	cont "friend got swept"
	cont "up in the current!"
	
	para "I should probably"
	line "help her, but…"
	done
	
SeasideCave1FNPC1Text2:
	text "Look at her go!"
	
	para "Looks kinda like"
	line "fun!"
	done
	
SeasideCave1FNPC1Text3:
	text "…"
	
	para "I might join her…"
	done
	