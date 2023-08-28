Route19_MapScriptHeader:
	db 2 ; scene scripts
	scene_script Route19Trigger0
	scene_script Route19Trigger1

	db 1 ; callbacks
	callback MAPCALLBACK_NEWMAP, Route19Callback

	db 0 ; warp events

	db 12 ; coord events
	coord_event  6, 18, 1, Route19MakeGrassGreen
	coord_event  7, 18, 1, Route19MakeGrassGreen
	coord_event  6, 19, 0, Route19MakeGrassYellow
	coord_event  7, 19, 0, Route19MakeGrassYellow
	coord_event 10, 26, 1, Route19MakeGrassGreen
	coord_event 11, 26, 1, Route19MakeGrassGreen
	coord_event 10, 28, 0, Route19MakeGrassYellow
	coord_event 10, 29, 0, Route19MakeGrassYellow
	coord_event  9,  6, 1, Route19MakeGrassGreen
	coord_event  9,  7, 1, Route19MakeGrassGreen
	coord_event  8,  6, 0, Route19MakeGrassYellow
	coord_event  8,  7, 0, Route19MakeGrassYellow

	db 2 ; bg events
	signpost 29,  2, SIGNPOST_READ, Route19Sunflower
	signpost 29,  3, SIGNPOST_READ, Route19Sunflower

	db 7 ; object events
	person_event SPRITE_AROMA_LADY,  8, 12, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_SILVER, PERSONTYPE_GENERICTRAINER, 3, Route19Trainer1, -1
	person_event SPRITE_SCHOOLBOY, 11, 16, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_GENERICTRAINER, 2, Route19Trainer2, -1
	person_event SPRITE_POKEFAN_M, 16,  8, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, Route19NPC, -1
	person_event SPRITE_CASINO, 28,  2, SPRITEMOVEDATA_TILE_LEFT_PRIORITY, 0, 0, -1, -1, (1 << 3) | PAL_OW_SILVER, PERSONTYPE_SCRIPT, 0, -1, -1
	person_event SPRITE_CASINO, 28,  3, SPRITEMOVEDATA_TILE_LEFT_PRIORITY, 0, 0, -1, -1, (1 << 3) | PAL_OW_SILVER, PERSONTYPE_SCRIPT, 0, -1, -1
	itemball_event  2,  6, POTION, 1, EVENT_ROUTE_19_POKE_BALL_1
	tmhmball_event  2, 28, TM_DAZZLINGLEAM, EVENT_ROUTE_19_POKE_BALL_2

Route19Sunflower:
	jumptext Route19SunflowerText

Route19Trigger0:
	end
	
Route19Trigger1:
	end

Route19Callback:
	clearevent EVENT_ROUTE_19_GRASS_YELLOW
	dotrigger $0
	return
	
Route19MakeGrassGreen:
	clearevent EVENT_ROUTE_19_GRASS_YELLOW
	special Special_UpdatePalsInstant
	dotrigger $0
	end
	
Route19MakeGrassYellow:
	setevent EVENT_ROUTE_19_GRASS_YELLOW
	special Special_UpdatePalsInstant
	dotrigger $1
	end
	
Route19NPC:
	jumptextfaceplayer Route19NPCText
	
Route19NPCText:
	text "Walking through"
	line "the flowers kicks"
	cont "up tons of pollen."
	
	para "Achoo!"
	
	para "…"
	
	para "It's terrible for"
	line "my allergies!"
	done
	
Route19Trainer1:
	generictrainer AROMA_LADY, MARTHA, EVENT_BEAT_ROUTE_19_TRAINER_1, .SeenText, .BeatenText

	text "Your nose doesn't"
	line "betray you!"
	
	para "The flowers ahead"
	line "smell wonderful!"
	done

.SeenText:
	text "Caught a wiff of"
	line "something sweet?"
	
	para "Very keen nose!"
	done

.BeatenText:
	text "Aha!"
	done
	
Route19Trainer2:
	generictrainer SCHOOLBOY, FLYNN, EVENT_BEAT_ROUTE_19_TRAINER_2, .SeenText, .BeatenText

	text "GRASS-type #MON"
	line "share traits with"
	cont "organisms from the"
	cont "plant AND animal"
	cont "kingdoms!"
	done

.SeenText:
	text "I've been studying"
	line "GRASS-type #MON"
	cont "for school."
	
	para "They're facinating!"
	done

.BeatenText:
	text "Facinating!"
	done
	
Route19SunflowerText:
	text "A huge sunflower!"
	done