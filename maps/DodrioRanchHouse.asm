DodrioRanchHouse_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_def 7, 2, 1, ROUTE_9
	warp_def 7, 3, 1, ROUTE_9

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	person_event SPRITE_COWGIRL, 3, 2, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_SCRIPT, 0, RanchHouseDodrioGirl, -1
	
RanchHouseDodrioGirl:
	faceplayer
	opentext
	checkevent EVENT_RANCH_CAN_GET_DODUO
	iftrue .get_doduo
	writetext RanchHouseDodrioGirlText1
	special PlaceMoneyTopRight
	yesorno
	iffalse .no
	checkmoney $0, 500
	if_equal $2, .nomoney
	playsound SFX_TRANSACTION
	takemoney $0, 500
	special PlaceMoneyTopRight
	writetext RanchHouseDodrioGirlText2
	waitbutton
	closetext
	playsound SFX_ENTER_DOOR
	special Special_FadeBlackQuickly
	writecode VAR_MOVEMENT, PLAYER_DODRIO
	domaptrigger DODRIO_RANCH_RACETRACK, $3
	waitsfx
	setevent EVENT_CANT_HEADBUTT
	warpfacing DOWN, DODRIO_RANCH_RACETRACK, 8, 14
	end
.no
	writetext RanchHouseDodrioGirlText3
	waitbutton
	closetext
	end
.nomoney
	writetext RanchHouseDodrioGirlText4
	waitbutton
	closetext
	end
.get_doduo
	writetext RanchHouseDodrioGirlText5
	waitbutton
	checkcode VAR_PARTYCOUNT
	if_equal 6, .PartyFull
	writetext RanchRideGotDoduoText
	playsound SFX_CAUGHT_MON
	waitsfx
	givepoke DODUO, 10
	special TeachDoduoExtremeSpeed
	writetext RanchHouseDodrioGirlText6
	waitbutton
	closetext
	setevent EVENT_RANCH_GOT_DODUO
	clearevent EVENT_RANCH_CAN_GET_DODUO
	end
.PartyFull
	writetext RanchHouseDodrioGirlText7
	waitbutton
	closetext
	end
	
RanchHouseDodrioGirlText1:
	text "Howdy!"
	
	para "Welcome to the"
	line "world-famous"
	cont "DODRIO RANCH!"
	
	para "The DODRIO we"
	line "raise here are the"
	cont "fastest in the"
	cont "world!"
	
	para "People come from"
	line "far and wide to"
	cont "ride 'em."
	
	para "So, how 'bout it,"
	line "youngin?"
	
	para "Wanna ride one of"
	line "our DODRIO?"
	
	para "It's only ¥500!"
	done
	
RanchHouseDodrioGirlText2:
	text "Great!"
	
	para "You won't regret"
	line "it!"
	
	para "Let's get you"
	line "saddled up!"
	done
	
RanchHouseDodrioGirlText3:
	text "Well, shucks."
	
	para "Some other time,"
	line "then."
	done
	
RanchHouseDodrioGirlText4:
	text "Oh…"
	
	para "Sorry, sugar."
	
	para "Seems like your a"
	line "little short on"
	cont "funds…"
	
	para "Come back some"
	line "other time!"
	done
	
RanchHouseDodrioGirlText5:
	text "Howdy, sugar."
	
	para "Did you come to"
	line "pick up yer lil"
	cont "prize DODUO?"
	done
	
RanchHouseDodrioGirlText6:
	text "That DODUO hatched"
	line "just recently."
	
	para "It was born to"
	line "run!"
	
	para "It's a natural,"
	line "like you, sugar!"
	
	para "Come back tomorrow"
	line "for a chance at"
	cont "another prize!"
	done
	
RanchHouseDodrioGirlText7:
	text "Oh no!"
	
	para "You still gotta"
	line "make some room!"
	done
	