SunbeamReserve_MapScriptHeader:
	db 2 ; scene scripts
	scene_script SunbeamReserveTrigger0
	scene_script SunbeamReserveTrigger1

	db 0 ; callbacks

	db 2 ; warp events
	warp_def 13, 16, 3, SPRUCES_LAB
	warp_def 13, 17, 3, SPRUCES_LAB

	db 0 ; coord events

	db 0 ; bg events

	db 12 ; object events
	person_event SPRITE_SPRUCE, 48,  7, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_ISLAND_BOATMAN
	object_event 19,  8, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, DONPHAN, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, SunbeamReserveDonphan, -1
	person_event SPRITE_SLOWPOKETAIL, 15,  6, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_PINK, PERSONTYPE_SCRIPT, 0, SunbeamReserveSlowpoke, -1
	person_event SPRITE_CUTE_GIRL, 17,  7, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_PINK, PERSONTYPE_SCRIPT, 0, SunbeamIslandNPC3, -1
	object_event 13,  8, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, NIDOQUEEN, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, SunbeamReserveNidoqueen, -1
	object_event 15,  9, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, NIDORAN_M, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, SunbeamReserveNidoranM, -1
	object_event 14,  7, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, NIDORAN_F, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, SunbeamReserveNidoranF, -1
	object_event  8, 12, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, LOPUNNY, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, SunbeamReserveLopunny, -1
	object_event  5, 10, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, ALTARIA, -1, -1, (1 << 3) | PAL_OW_TEAL, PERSONTYPE_SCRIPT, 0, SunbeamReserveAltaria, -1
	object_event 13, 14, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, MAGMAR, -1, -1, (1 << 3) | PAL_OW_RED, PERSONTYPE_SCRIPT, 0, SunbeamReserveMagmar, -1
	object_event 19, 13, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, ELECTABUZZ, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, SunbeamReserveElectabuzz, -1
	itemball_event  6,  4, RARE_CANDY, 1, EVENT_SUNBEAM_RESERVE_ITEM_BALL

	
	const_def 1 ; object constants
	const SUNBEAM_SPRUCE
	
SunbeamReserveTrigger0:
	special Special_StopRunning
	playsound SFX_EXIT_BUILDING
	moveperson SUNBEAM_SPRUCE, $11, $d
	appear SUNBEAM_SPRUCE
	domaptrigger SPRUCES_LAB, $2
	applymovement SUNBEAM_SPRUCE, Movement_SunbeamSpruce1
	spriteface SUNBEAM_SPRUCE, DOWN
	opentext TEXTBOX_SPRUCE
	writetext SunbeamReserveSpruceText1
	waitbutton
	closetext
	follow SUNBEAM_SPRUCE, PLAYER
	applymovement SUNBEAM_SPRUCE, Movement_SunbeamSpruce2
	stopfollow
	spriteface SUNBEAM_SPRUCE, RIGHT
	spriteface PLAYER, RIGHT
	opentext TEXTBOX_SPRUCE
	writetext SunbeamReserveSpruceText2
	waitbutton
	closetext
	applymovement SUNBEAM_SPRUCE, Movement_SunbeamSpruce3
	spriteface SUNBEAM_SPRUCE, DOWN
	opentext TEXTBOX_SPRUCE
	writetext SunbeamReserveSpruceText3
	waitbutton
	changetextboxspeaker  TEXTBOX_POKEMON, DONPHAN
	writetext SunbeamReserveDonphanText
	cry DONPHAN
	waitbutton
	closetext
	applymovement SUNBEAM_SPRUCE, Movement_SunbeamSpruce4
	follow SUNBEAM_SPRUCE, PLAYER
	applymovement SUNBEAM_SPRUCE, Movement_SunbeamSpruce5
	stopfollow
	spriteface SUNBEAM_SPRUCE, UP
	spriteface PLAYER, UP
	opentext TEXTBOX_SPRUCE
	writetext SunbeamReserveSpruceText4
	waitbutton
	closetext
	applymovement SUNBEAM_SPRUCE, Movement_SunbeamSpruce6
	opentext TEXTBOX_SPRUCE
	writetext SunbeamReserveSpruceText5
	waitbutton
	changetextboxspeaker  TEXTBOX_POKEMON, NIDOQUEEN
	writetext SunbeamReserveNidoqueenText
	cry NIDOQUEEN
	waitbutton
	closetext
	applymovement SUNBEAM_SPRUCE, Movement_SunbeamSpruce7
	follow SUNBEAM_SPRUCE, PLAYER
	applymovement SUNBEAM_SPRUCE, Movement_SunbeamSpruce8
	stopfollow
	spriteface SUNBEAM_SPRUCE, LEFT
	opentext TEXTBOX_SPRUCE
	writetext SunbeamReserveSpruceText6
	waitbutton
	closetext
	follow SUNBEAM_SPRUCE, PLAYER
	applymovement SUNBEAM_SPRUCE, Movement_SunbeamSpruce9
	stopfollow
	spriteface SUNBEAM_SPRUCE, LEFT
	opentext TEXTBOX_SPRUCE
	writetext SunbeamReserveSpruceText7
	waitbutton
	closetext
	spriteface PLAYER, DOWN
	special FadeOutPalettes
	changeblock $10, $c, $df
	warpcheck
	end

SunbeamReserveTrigger1:
	end
	
SunbeamReserveNidoqueen:
	opentext TEXTBOX_POKEMON, NIDOQUEEN
	writetext SunbeamReserveNidoqueenText
	cry NIDOQUEEN
	waitbutton
	closetext
	end
	
SunbeamReserveNidoranM:
	opentext TEXTBOX_POKEMON, NIDORAN_M
	writetext SunbeamReserveNidoranMText
	cry NIDORAN_M
	waitbutton
	closetext
	end
	
SunbeamReserveNidoranF:
	opentext TEXTBOX_POKEMON, NIDORAN_F
	writetext SunbeamReserveNidoranFText
	cry NIDORAN_F
	waitbutton
	closetext
	end
	
SunbeamReserveSlowpoke:
	opentext TEXTBOX_POKEMON, SLOWPOKE
	writetext SunbeamReserveSlowpokeText
	cry SLOWPOKE
	waitbutton
	closetext
	end
	
SunbeamReserveLopunny:
	opentext TEXTBOX_POKEMON, LOPUNNY
	writetext SunbeamReserveLopunnyText
	cry LOPUNNY
	waitbutton
	closetext
	end
	
SunbeamReserveAltaria:
	opentext TEXTBOX_POKEMON, ALTARIA
	writetext SunbeamReserveAltariaText
	cry ALTARIA
	waitbutton
	closetext
	end
	
SunbeamReserveDonphan:
	opentext TEXTBOX_POKEMON, DONPHAN
	writetext SunbeamReserveDonphanText
	cry DONPHAN
	waitbutton
	closetext
	end
	
SunbeamReserveMagmar:
	opentext TEXTBOX_POKEMON, MAGMAR
	writetext SunbeamReserveMagmarText
	cry MAGMAR
	waitbutton
	closetext
	end
	
SunbeamReserveElectabuzz:
	opentext TEXTBOX_POKEMON, ELECTABUZZ
	writetext SunbeamReserveElectabuzzText
	cry ELECTABUZZ
	waitbutton
	closetext
	end
	
SunbeamReserveNidoqueenText:
	text "Nido!"
	done
	
SunbeamReserveNidoranMText:
	text "Ran!"
	done
	
SunbeamReserveNidoranFText:
	text "Ran…<WAIT_S> Ran…"
	done
	
SunbeamReserveSlowpokeText:
	text "<WAIT_S>S<WAIT_S>l<WAIT_S>o<WAIT_S>o<WAIT_S>o<WAIT_S>o<WAIT_S>w<WAIT_S>…<WAIT_L><WAIT_L><WAIT_M>"
	line "…poke?"
	done
	
SunbeamReserveLopunnyText:
	text "Lop! <WAIT_S>Lop!"
	done
	
SunbeamReserveAltariaText:
	text "…<WAIT_M>Taria?"
	done
	
SunbeamReserveDonphanText:
	text "Phan…"
	done
	
SunbeamReserveMagmarText:
	text "MAG!<WAIT_S> MAR!"
	done
	
SunbeamReserveElectabuzzText:
	text "BUZZ!<WAIT_S> LECTA!"
	done
	
SunbeamReserveSpruceText1:
	text "My research"
	line "involves #MON"
	cont "conservation."
	
	para "As such, I run a"
	line "#MON reserve."
	done
	
SunbeamReserveSpruceText2:
	text "The #MON here"
	line "are all very"
	cont "docile."
	done
	
SunbeamReserveSpruceText3:
	text "Isn't that right,"
	line "DONPHAN?"
	done
	
SunbeamReserveSpruceText4:
	text "I let the #MON"
	line "live their lives"
	cont "as they would in"
	cont "the wild and study"
	cont "their behavior."
	done
	
SunbeamReserveSpruceText5:
	text "How are the young"
	line "ones, NIDOQUEEN?"
	done
	
SunbeamReserveSpruceText6:
	text "No matter what may"
	line "happen outside of"
	cont "this place,"
	
	para "the #MON here"
	line "will be safe and"
	cont "taken care of."
	done
	
SunbeamReserveSpruceText7:
	text "Let's head back"
	line "inside."
	done
	
Movement_SunbeamSpruce1:
	step_sleep 20
	step_up
	step_left
	step_end
	
Movement_SunbeamSpruce2:
	step_right
	step_right
	step_up
	step_up
	step_up
	step_up
	step_up
	step_end
	
Movement_SunbeamSpruce3:
	step_right
	step_end
	
Movement_SunbeamSpruce4:
	step_left
	step_end
	
Movement_SunbeamSpruce5:
	step_left
	step_left
	step_left
	step_down
	step_left
	step_down
	step_down
	step_left
	step_end
	
Movement_SunbeamSpruce6:
	step_up
	step_end
	
Movement_SunbeamSpruce7:
	step_down
	step_end
	
Movement_SunbeamSpruce8:
	step_down
	step_down
	step_left
	step_left
	step_left
	step_down
	step_end
	
Movement_SunbeamSpruce9:
	step_right
	step_right
	step_right
	step_right
	step_right
	step_right
	step_right
	step_end