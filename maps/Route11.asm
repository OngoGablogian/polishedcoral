Route11_MapScriptHeader:
	db 0 ; scene scripts

	db 1 ; callbacks
	callback MAPCALLBACK_TILES, Route11ChangeBlocks

	db 0 ; warp events

	db 0 ; coord events

	db 0 ; bg events

	db 17 ; object events
	person_event SPRITE_COOLTRAINER_M,  7, 24, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_GENERICTRAINER, 4, TrainerRoute11_1, EVENT_MADE_IT_TO_SOUTH_ONWA
	person_event SPRITE_COOLTRAINER_F, 16, 11, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_GENERICTRAINER, 4, TrainerRoute11_2, EVENT_MADE_IT_TO_SOUTH_ONWA
	person_event SPRITE_BIKER, 18, 22, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_GENERICTRAINER, 3, TrainerRoute11_3, EVENT_MADE_IT_TO_SOUTH_ONWA
	person_event SPRITE_COOLTRAINER_M,  7, 24, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_GENERICTRAINER, 4, TrainerRoute11_1_2, EVENT_HAVENT_MADE_IT_TO_SOUTH_ONWA
	person_event SPRITE_COOLTRAINER_F, 16, 11, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_GENERICTRAINER, 4, TrainerRoute11_2_2, EVENT_HAVENT_MADE_IT_TO_SOUTH_ONWA
	person_event SPRITE_BIKER, 18, 22, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_GENERICTRAINER, 3, TrainerRoute11_3_2, EVENT_HAVENT_MADE_IT_TO_SOUTH_ONWA
	person_event SPRITE_ENGINEER, 22, 13, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, Route11NPC1, EVENT_MADE_IT_TO_SOUTH_ONWA
	person_event SPRITE_ENGINEER, 27, 12, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_MADE_IT_TO_SOUTH_ONWA
	person_event SPRITE_ENGINEER, 27, 13, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_MADE_IT_TO_SOUTH_ONWA
	person_event SPRITE_ENGINEER, 20, 11, SPRITEMOVEDATA_STANDING_DOWN, 1, 1, -1, -1, (1 << 3) | PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, Route11NPC2, -1
	object_event 10, 28, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, MACHOKE, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, ObjectEvent, -1
	object_event 19, 30, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, MACHOKE, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_MADE_IT_TO_SOUTH_ONWA
	person_event SPRITE_MISC_CONE,  8, 21, SPRITEMOVEDATA_TILE_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_MADE_IT_TO_SOUTH_ONWA
	person_event SPRITE_MISC_CONE, 25, 13, SPRITEMOVEDATA_TILE_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_MADE_IT_TO_SOUTH_ONWA
	person_event SPRITE_MISC_CONE, 25, 15, SPRITEMOVEDATA_TILE_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_MADE_IT_TO_SOUTH_ONWA
	itemball_event 20, 17, MAX_REPEL, 1, EVENT_ROUTE_11_POKE_BALL_1
	itemball_event 21, 27, METAL_POWDER, 1, EVENT_ROUTE_11_POKE_BALL_2

	
Route11ChangeBlocks:
	checkevent EVENT_MADE_IT_TO_SOUTH_ONWA
	iffalse .end
	changemap Route11Bridge_BlockData
	moveperson 11, $0a, $14
.end
	return
	
Route11NPC1:
	jumptextfaceplayer Route11NPC1Text
	
Route11NPC2:
	faceplayer
	opentext
	checkevent EVENT_GOT_ROCKY_HELMET
	iftrue .gothelmet
	checkevent EVENT_PLAYER_IS_CORA
	iftrue .girl
	checkevent EVENT_PLAYER_IS_PIPPI
	iftrue .girl
	checkevent EVENT_PLAYER_IS_LEAF
	iftrue .girl
	checkevent EVENT_PLAYER_IS_KRIS
	iftrue .girl
	checkevent EVENT_MADE_IT_TO_SOUTH_ONWA
	iffalse .no_bridge_boy
	writetext Route11NPC2Text1Boy2
	jump .cont
.no_bridge_boy
	writetext Route11NPC2Text1Boy
	jump .cont
.girl
	checkevent EVENT_MADE_IT_TO_SOUTH_ONWA
	iffalse .no_bridge_girl
	writetext Route11NPC2Text1Girl2
	jump .cont
.no_bridge_girl
	writetext Route11NPC2Text1Girl
.cont
	waitbutton
	verbosegiveitem ROCKY_HELMET
	iffalse .NoRoom
.gothelmet
	writetext Route11NPC2Text2
	waitbutton
	closetext
	setevent EVENT_GOT_ROCKY_HELMET
	end
.NoRoom
	writetext Route11NPC2Text3
	waitbutton
	closetext
	end
	
Route11NPC1Text:
	text "We're already way"
	line "behind schedule!"
	
	para "We can't have a"
	line "kid wandering"
	cont "around!"
	done
	
Route11NPC2Text1Boy:
	text "Are you the new"
	line "guy?"
	
	para "You can't be on"
	line "the site without"
	cont "a helmet."
	
	para "Catch!"
	done
	
Route11NPC2Text1Boy2:
	text "Are you the new"
	line "guy?"
	
	para "You're super late!"
	
	para "We're just doin'"
	line "final inspections"
	cont "on the bridge."
	
	para "You can't be on"
	line "the site without"
	cont "a helmet."
	
	para "Catch!"
	done
	
Route11NPC2Text1Girl:
	text "Are you the new"
	line "girl?"
	
	para "You can't be on"
	line "the site without"
	cont "a helmet."
	
	para "Catch!"
	done
	
Route11NPC2Text1Girl2:
	text "Are you the new"
	line "guy?"
	
	para "You're super late!"
	
	para "We're just doin'"
	line "final inspections"
	cont "on the bridge."
	
	para "You can't be on"
	line "the site without"
	cont "a helmet."
	
	para "Catch!"
	done
	
Route11NPC2Text2:
	text "If you decide to"
	line "give that to your"
	cont "#MON,"
	
	para "they'll deal some"
	line "hurt to the other"
	cont "guy when they"
	cont "touch 'em."
	
	para "…"
	
	para "Hold on!"
	
	para "You aren't on the"
	line "crew!"
	done
	
Route11NPC2Text3:
	text "You can't hold more"
	line "stuff?"
	
	para "Well, make room!"
	done
	
TrainerRoute11_1:
	generictrainer COOLTRAINERM, ANDY, EVENT_BEAT_ROUTE_11_TRAINER_1, .SeenText, .BeatenText

	text "Keep going if you"
	line "want, but they"
	cont "won't let you pass."
	
	para "Don't say I didn't"
	line "warn you."
	done

.SeenText:
	text "Road's closed."
	
	para "May as well turn"
	line "around."
	
	para "Well, after our"
	line "battle, of course."
	done

.BeatenText:
	text "Alright.<WAIT_M>"
	line "That's that."
	done

TrainerRoute11_2:
	generictrainer COOLTRAINERF, MARY, EVENT_BEAT_ROUTE_11_TRAINER_2, .SeenText, .BeatenText

	text "I don't think"
	line "we're supposed to"
	cont "be here!"
	
	para "How exciting!"
	done

.SeenText:
	text "Those guys are"
	line "building something"
	cont "with #MON."
	
	para "How cool!"
	done

.BeatenText:
	text "Great battle!<WAIT_M>"
	line "How fun!"
	done

TrainerRoute11_3:
	generictrainer BIKER, HANK, EVENT_BEAT_ROUTE_11_TRAINER_3, .SeenText, .BeatenText

	text "They better finish"
	line "this thing soon."
	
	para "I'm tired of"
	line "waitin'!"
	done

.SeenText:
	text "I hear they're"
	line "building a bridge"
	cont "or somethin'."
	
	para "I'm gonna rip it up"
	line "on my bike when"
	cont "it's done."
	done

.BeatenText:
	text "Rev it up!"
	done
	
TrainerRoute11_1_2:
	generictrainer COOLTRAINERM, ANDY, EVENT_BEAT_ROUTE_11_TRAINER_1, .SeenText, .BeatenText

	text "The new bridge"
	line "makes getting to"
	cont "SOUTH ONWA way"
	cont "easier."
	
	para "You should have a"
	line "look."
	done

.SeenText:
	text "The road recently"
	line "just opened back"
	cont "up."
	
	para "You should have a"
	line "look at the new"
	cont "bridge."
	
	para "Well, after our"
	line "battle, of course."
	done

.BeatenText:
	text "Alright.<WAIT_M>"
	line "That's that."
	done

TrainerRoute11_2_2:
	generictrainer COOLTRAINERF, MARY, EVENT_BEAT_ROUTE_11_TRAINER_2, .SeenText, .BeatenText

	text "I can't wait to"
	line "cross the new"
	cont "bridge!"
	
	para "How exciting!"
	done

.SeenText:
	text "They built the"
	line "new bridge with"
	cont "help from #MON."
	
	para "How cool!"
	done

.BeatenText:
	text "Great battle!<WAIT_M>"
	line "How fun!"
	done

TrainerRoute11_3_2:
	generictrainer BIKER, HANK, EVENT_BEAT_ROUTE_11_TRAINER_3, .SeenText, .BeatenText

	text "Alright, I'm"
	line "gonna go do it."
	
	para "I'm tired of"
	line "waitin'!"
	done

.SeenText:
	text "I heard they just"
	line "built a bridge"
	cont "or somethin'."
	
	para "I'm gonna rip it up"
	line "on my bike."
	done

.BeatenText:
	text "Rev it up!"
	done
