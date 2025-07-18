LusterSewersThroneRoom_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 1 ; warp events
	warp_def 10,  5, 4, LUSTER_SEWERS_B2F

	db 1 ; coord events
	xy_trigger 0,  7,  5, 0, LusterSewersThroneRoomFrankieCutscene, 0, 0

	db 0 ; bg events

	db 12 ; object events
	person_event SPRITE_FRANKIE,  2,  5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_CLEARED_LUSTER_SEWERS
	person_event SPRITE_KAGE,  4,  5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_CLEARED_LUSTER_SEWERS
	person_event SPRITE_DELINQUENT_M,  7,  4, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, LusterSewerThroneRoomGrunt1, EVENT_CLEARED_LUSTER_SEWERS
	person_event SPRITE_DELINQUENT_M,  6,  4, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, ObjectEvent, EVENT_CLEARED_LUSTER_SEWERS
	person_event SPRITE_DELINQUENT_M,  7,  6, SPRITEMOVEDATA_STANDING_LEFT, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, LusterSewerThroneRoomGrunt2, EVENT_CLEARED_LUSTER_SEWERS
	person_event SPRITE_PLAYER_CUTSCENE,  7,  5, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_SILVER, PERSONTYPE_SCRIPT, 0, -1, EVENT_PLAYER_CUTSCENE_SILVER
	person_event SPRITE_NIDOKING_LEADER,  2,  5, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, LusterSewerThroneRoomNidokingLeader, EVENT_LUSTER_PUNKS_NOT_IN_APARTMENT
	person_event SPRITE_NIDOKING_F,  4,  4, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, LusterSewerThroneRoomNidokingGirl, EVENT_LUSTER_PUNKS_NOT_IN_APARTMENT
	person_event SPRITE_NIDOKING_M,  6,  6, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, LusterSewerThroneRoomNidokingGuy, EVENT_LUSTER_PUNKS_NOT_IN_APARTMENT
	person_event SPRITE_DELINQUENT_M,  8,  3, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, LusterSewerThroneRoomNidokingPunk1, EVENT_LUSTER_PUNKS_NOT_IN_APARTMENT
	person_event SPRITE_DELINQUENT_F, 11,  2, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, LusterSewerThroneRoomNidokingPunk2, EVENT_LUSTER_PUNKS_NOT_IN_APARTMENT
	person_event SPRITE_BURGLAR,  9,  8, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_PURPLE, PERSONTYPE_SCRIPT, 0, LusterSewerThroneRoomNidokingPunk3, EVENT_LUSTER_PUNKS_NOT_IN_APARTMENT

	
	const_def 1 ; object constants
	const LUSTERSEWERSTHRONEROOM_FRANKIE
	const LUSTERSEWERSTHRONEROOM_FAKE_FRANKIE
	const LUSTERSEWERSTHRONEROOM_GRUNT1
	const LUSTERSEWERSTHRONEROOM_GRUNT2
	const LUSTERSEWERSTHRONEROOM_GRUNT3
	const LUSTERSEWERSTHRONEROOM_CUTSCENE
	const LUSTERSEWERSTHRONEROOM_NIDO_LEADER

	
LusterSewerThroneRoomNidokingLeader:
	faceplayer
	opentext
	writetext LusterSewerThroneRoomNidokingLeaderText
	waitbutton
	closetext
	spriteface LUSTERSEWERSTHRONEROOM_NIDO_LEADER, DOWN
	end
	
LusterSewerThroneRoomNidokingLeaderText:
	text "Ya showed up!"
	
	para "Make yourself at"
	line "home!"
	
	para "You're one of us"
	line "now, kid!"
	
	para "I'm sure those"
	line "BUNEARYS are"
	cont "plottin' their"
	cont "revenge as we"
	cont "speak."
	
	para "We'll need to be"
	line "ready when they"
	cont "show their faces"
	cont "again."
	done
	
LusterSewerThroneRoomNidokingGirl:
	jumptextfaceplayer LusterSewerThroneRoomNidokingGirlText
	
LusterSewerThroneRoomNidokingGirlText:
	text "You really did us"
	line "a huge favor by"
	cont "kickin' those"
	cont "jerks out."
	
	para "This is our turf"
	line "again!"
	done
	
LusterSewerThroneRoomNidokingGuy:
	jumptextfaceplayer LusterSewerThroneRoomNidokingGuyText
	
LusterSewerThroneRoomNidokingGuyText:
	text "You helped us out,"
	line "so the boss likes"
	cont "you."
	
	para "That means you're"
	line "ok by me!"
	done
	
LusterSewerThroneRoomNidokingPunk1:
	jumptextfaceplayer LusterSewerThroneRoomNidokingPunk1Text
	
LusterSewerThroneRoomNidokingPunk1Text:
	text "We gotta get a"
	line "TV down here or"
	cont "somethin'!"
	done
	
LusterSewerThroneRoomNidokingPunk2:
	jumptextfaceplayer LusterSewerThroneRoomNidokingPunk2Text
	
LusterSewerThroneRoomNidokingPunk2Text:
	text "All is well in"
	line "the world now!"
	done
	
LusterSewerThroneRoomNidokingPunk3:
	jumptextfaceplayer LusterSewerThroneRoomNidokingPunk3Text
	
LusterSewerThroneRoomNidokingPunk3Text:
	text "You know, I've"
	line "been thinking…"
	
	para "Is a sewer really"
	line "the best place to"
	cont "hang out?"
	done
	
LusterSewerThroneRoomGrunt1:
	faceplayer
	opentext
	writetext LusterSewerThroneRoomGrunt1Text
	waitbutton
	closetext
	spriteface LUSTERSEWERSTHRONEROOM_GRUNT1, RIGHT
	end
	
LusterSewerThroneRoomGrunt2:
	faceplayer
	opentext
	writetext LusterSewerThroneRoomGrunt2Text
	waitbutton
	closetext
	spriteface LUSTERSEWERSTHRONEROOM_GRUNT3, LEFT
	end
	
LusterSewersThroneRoomFrankieCutscene:
	spriteface PLAYER, UP	
	playsound SFX_PAY_DAY
	showemote EMOTE_SHOCK, LUSTERSEWERSTHRONEROOM_GRUNT2, 15
	pause 7
	playmusic MUSIC_POKEMANIAC_ENCOUNTER
	applyonemovement LUSTERSEWERSTHRONEROOM_GRUNT2, fast_step_right
	spriteface LUSTERSEWERSTHRONEROOM_GRUNT2, DOWN
	opentext TEXTBOX_PUNK
	writetext LusterSewersThroneRoomFrankieCutsceneText1
	waitbutton
	closetext
	pause 32
	playmusic MUSIC_NONE
	opentext TEXTBOX_PUNK_BOSS
	writetext LusterSewersThroneRoomFrankieCutsceneText2
	waitbutton
	closetext
	pause 20
	applyonemovement LUSTERSEWERSTHRONEROOM_FAKE_FRANKIE, step_down
	opentext TEXTBOX_PUNK_BOSS
	writetext LusterSewersThroneRoomFrankieCutsceneText3
	waitbutton
	closetext
	playsound SFX_PAY_DAY
	showemote EMOTE_SHOCK, LUSTERSEWERSTHRONEROOM_GRUNT2, 15
	pause 7
	spriteface LUSTERSEWERSTHRONEROOM_GRUNT2, UP
	opentext TEXTBOX_PUNK
	writetext LusterSewersThroneRoomFrankieCutsceneText4
	waitbutton
	closetext
	spriteface LUSTERSEWERSTHRONEROOM_GRUNT2, RIGHT
	applymovement LUSTERSEWERSTHRONEROOM_GRUNT2, Movement_LusterSewerThroneRoomGruntStepAside
	pause 5
	applyonemovement LUSTERSEWERSTHRONEROOM_FAKE_FRANKIE, step_down
	pause 10
	opentext TEXTBOX_PUNK_BOSS
	writetext LusterSewersThroneRoomFrankieCutsceneText5
	waitbutton
	closetext
	pause 10
	applyonemovement LUSTERSEWERSTHRONEROOM_FAKE_FRANKIE, slow_step_up
	pause 10
	opentext TEXTBOX_PUNK_BOSS
	writetext LusterSewersThroneRoomFrankieCutsceneText6
	waitbutton
	closetext
	pause 16
	opentext TEXTBOX_PUNK_BOSS
	writetext LusterSewersThroneRoomFrankieCutsceneText7
	waitbutton
	closetext
	pause 48
	playmusic MUSIC_HARDCORE_ENCOUNTER
	applyonemovement LUSTERSEWERSTHRONEROOM_FAKE_FRANKIE, fast_step_down
	opentext TEXTBOX_PUNK_BOSS
	writetext LusterSewersThroneRoomFrankieCutsceneText8
	waitbutton
	closetext
	pause 32
	playmusic MUSIC_NONE
	opentext TEXTBOX_UNKNOWN
	writetext LusterSewersThroneRoomFrankieCutsceneText2
	waitbutton
	closetext
	
	pause 10
	playsound SFX_PAY_DAY
	showemote EMOTE_SHOCK, LUSTERSEWERSTHRONEROOM_FAKE_FRANKIE, 15
	pause 7
	appear LUSTERSEWERSTHRONEROOM_CUTSCENE
	spriteface LUSTERSEWERSTHRONEROOM_FAKE_FRANKIE, UP
	applyonemovement PLAYER, hide_person
	
	pause 32
	applymovement PLAYER, Movement_LusterSewerThroneRoomPlayerCutscene
	pause 32
	opentext TEXTBOX_UNKNOWN
	writetext LusterSewersThroneRoomFrankieCutsceneText9
	waitbutton
	closetext
	pause 10
	
	applyonemovement LUSTERSEWERSTHRONEROOM_FAKE_FRANKIE, turn_step_up

	opentext TEXTBOX_BRUTUS
	writetext LusterSewersThroneRoomFrankieCutsceneText10
	waitbutton
	closetext
	applymovement LUSTERSEWERSTHRONEROOM_FAKE_FRANKIE, Movement_LusterSewerThroneRoomFakeFrankie2
	spriteface LUSTERSEWERSTHRONEROOM_FAKE_FRANKIE, LEFT
	pause 5
	playsound SFX_JUMP_OVER_LEDGE
	applymovement LUSTERSEWERSTHRONEROOM_FRANKIE, Movement_LusterSewerThroneRoomFrankie1
	applymovement PLAYER, Movement_LusterSewerThroneRoomPlayerCutscene2
	spriteface PLAYER, UP
	applyonemovement PLAYER, show_person
	disappear LUSTERSEWERSTHRONEROOM_CUTSCENE
	pause 10
	applyonemovement LUSTERSEWERSTHRONEROOM_FRANKIE, turn_step_up
	applyonemovement LUSTERSEWERSTHRONEROOM_FRANKIE, remove_fixed_facing
	opentext TEXTBOX_FRANKIE
	writetext LusterSewersThroneRoomFrankieCutsceneText11
	waitbutton
	closetext
	pause 10
	playmusic MUSIC_LASS_ENCOUNTER
	applyonemovement LUSTERSEWERSTHRONEROOM_FRANKIE, turn_step_down
	applyonemovement LUSTERSEWERSTHRONEROOM_FRANKIE, remove_fixed_facing
	opentext TEXTBOX_FRANKIE
	writetext LusterSewersThroneRoomFrankieCutsceneText12
	yesorno
	iftrue .saidyes
.return
	writetext LusterSewersThroneRoomFrankieCutsceneText13
	yesorno
	iftrue .saidyes
	writetext LusterSewersThroneRoomFrankieCutsceneText14
	yesorno
	iftrue .saidyes
	closetext
	playmusic MUSIC_NONE
	pause 24
	applyonemovement LUSTERSEWERSTHRONEROOM_FRANKIE, turn_step_up
	applyonemovement LUSTERSEWERSTHRONEROOM_FRANKIE, remove_fixed_facing
	pause 64
	applyonemovement LUSTERSEWERSTHRONEROOM_FRANKIE, turn_step_down
	applyonemovement LUSTERSEWERSTHRONEROOM_FRANKIE, remove_fixed_facing
	opentext TEXTBOX_FRANKIE
	playsound SFX_THUNDER
	earthquake 5
	writetext LusterSewersThroneRoomFrankieCutsceneText15
	waitsfx
	waitbutton
	playsound SFX_THUNDER
	earthquake 5
	writetext LusterSewersThroneRoomFrankieCutsceneText16
	waitsfx
	waitbutton
	playsound SFX_THUNDER
	earthquake 5
	writetext LusterSewersThroneRoomFrankieCutsceneText17
	waitsfx
	waitbutton
	closetext
	waitsfx
	winlosstext LusterSewersThroneRoomFrankieCutsceneText6, 0
	setlasttalked LUSTERSEWERSTHRONEROOM_FRANKIE
	loadtrainer FRANKIE, 1
	writecode VAR_BATTLETYPE, BATTLETYPE_NORMAL
	startbattle
	reloadmapafterbattle
	playmapmusic
	opentext TEXTBOX_FRANKIE
	writetext LusterSewersThroneRoomFrankieCutsceneText18
	waitbutton
	closetext
	pause 5
	applyonemovement LUSTERSEWERSTHRONEROOM_FRANKIE, step_up
	applyonemovement LUSTERSEWERSTHRONEROOM_FRANKIE, turn_step_down
	applyonemovement LUSTERSEWERSTHRONEROOM_FRANKIE, remove_fixed_facing
	pause 5
	opentext TEXTBOX_FRANKIE
	writetext LusterSewersThroneRoomFrankieCutsceneText19
	waitbutton
	closetext
	pause 5
	applymovement LUSTERSEWERSTHRONEROOM_FAKE_FRANKIE, Movement_LusterSewerThroneRoomFakeFrankie3
	spriteface LUSTERSEWERSTHRONEROOM_FAKE_FRANKIE, UP
	opentext TEXTBOX_BRUTUS
	writetext LusterSewersThroneRoomFrankieCutsceneText20
	waitbutton
	closetext
	pause 10
	applyonemovement LUSTERSEWERSTHRONEROOM_FRANKIE, turn_step_up
	applyonemovement LUSTERSEWERSTHRONEROOM_FRANKIE, remove_fixed_facing
	pause 10
	opentext TEXTBOX_FRANKIE
	writetext LusterSewersThroneRoomFrankieCutsceneText21
	waitbutton
	closetext
	pause 10
	special FadeOutPalettesBlack
	pause 10
	playsound SFX_EXIT_BUILDING
	disappear LUSTERSEWERSTHRONEROOM_FAKE_FRANKIE
	disappear LUSTERSEWERSTHRONEROOM_GRUNT1
	disappear LUSTERSEWERSTHRONEROOM_GRUNT2
	disappear LUSTERSEWERSTHRONEROOM_GRUNT3
	pause 10
	special FadeInTextboxPalettes
	pause 10
	applyonemovement LUSTERSEWERSTHRONEROOM_FRANKIE, step_down
	pause 10
	opentext TEXTBOX_FRANKIE
	writetext LusterSewersThroneRoomFrankieCutsceneText22
	waitbutton
	closetext
	applymovement LUSTERSEWERSTHRONEROOM_FRANKIE, Movement_LusterSewerThroneRoomFrankie2
	playsound SFX_EXIT_BUILDING
	disappear LUSTERSEWERSTHRONEROOM_FRANKIE
	setevent EVENT_CLEARED_LUSTER_SEWERS
	setevent EVENT_UNIQUE_ENCOUNTER_FRANKIE
	dotrigger $1
	
	checkevent EVENT_LUSTER_SEWERS_B1F_DISGUISEMAN
	iftrue .end
	clearevent EVENT_LUSTER_SEWERS_B1F_POKEBALL
	setevent EVENT_LUSTER_SEWERS_B1F_DISGUISEMAN
.end
	end
.saidyes
	writetext LusterSewersThroneRoomFrankieYesText
	yesorno
	iftrue .saidyes
	jump .return
	end
	
LusterSewersThroneRoomFrankieCutsceneText1:
	text "Hold it right"
	line "there!"
	
	para "What's a little"
	line "twerp doin' down"
	cont "here?"
	
	para "This is “BUNEARY”"
	line "private property,"
	cont "and you're tres-"
	cont "passin'!"
	
	para "Huh?"
	
	para "You wanna see"
	line "FRANKIE?"
	
	para "Ha!<WAIT_M>"
	line "Hahahaha!"
	
	para "That's rich, kid!"
	
	para "If you think you're"
	line "gettin' to FRANKIE"
	cont "anytime soon,"
	
	para "you're dumber than"
	line "you look!"
	
	para "Let's do this,"
	line "boys!"
	done
	
LusterSewersThroneRoomFrankieCutsceneText2:
	text "HOLD IT!"
	done
	
LusterSewersThroneRoomFrankieCutsceneText3:
	text "Step aside."
	
	para "…<WAIT_L>NOW!"
	done
	
LusterSewersThroneRoomFrankieCutsceneText4:
	text "Uhh…"
	
	para "Sure thing, boss."
	done
	
LusterSewersThroneRoomFrankieCutsceneText5:
	text "Why are you here,"
	line "kid?"
	
	para "“THE NIDOKINGS”"
	line "probably sent"
	cont "you, right?"
	
	para "What's that about,"
	line "huh?"
	
	para "Can't fight their"
	line "own battles?"
	
	para "Have to send a kid"
	line "to do their dirty"
	cont "work for them?"
	
	para "Huh? <WAIT_L>HUH!?"
	done
	
LusterSewersThroneRoomFrankieCutsceneText6:
	text "…"
	done
	
LusterSewersThroneRoomFrankieCutsceneText7:
	text "So…"
	done
	
LusterSewersThroneRoomFrankieCutsceneText8:
	text "THEY THINK THEY"
	line "CAN DISRESPECT US"
	cont "LIKE THIS!?"
	
	para "HUH!?<WAIT_L>"
	line "ANSWER ME!"
	
	para "…"
	
	para "…"
	
	para "Fine!"
	
	para "You really made a"
	line "big mistake"
	cont "coming here…"
	
	para "I'm gonna have to"
	line "end you, kid."
	
	para "Right here, <WAIT_S>right"
	line "now!"
	done
	
LusterSewersThroneRoomFrankieCutsceneText9:
	text "That's enough,"
	line "BRUTUS."
	done	
	
LusterSewersThroneRoomFrankieCutsceneText10:
	text "Right!"
	
	para "Of course, <WAIT_S>MISS"
	line "FRANKIE!"
	done
	
	
LusterSewersThroneRoomFrankieCutsceneText11:
	text "…<WAIT_L>Ahem…"
	done
	
LusterSewersThroneRoomFrankieCutsceneText12:
	text "Please leave us"
	line "alone, big kid…"
	
	para "We're being good,"
	line "I promise!"
	
	para "Those “NIDOKINGS”"
	line "are just big"
	cont "bullies."
	
	para "They made every-"
	line "thing up!"
	
	para "You'll leave us"
	line "alone, won't you?"
	done
	
LusterSewersThroneRoomFrankieCutsceneText13:
	text "Please?"
	done
	
LusterSewersThroneRoomFrankieCutsceneText14:
	text "Pwetty pweeeease?"
	done
	
LusterSewersThroneRoomFrankieCutsceneText15:
	text "ARGH!"
	done
	
LusterSewersThroneRoomFrankieCutsceneText16:
	text "FINE!"
	done
	
LusterSewersThroneRoomFrankieCutsceneText17:
	text "YOU WANNA GO, YOU"
	line "LITTLE PUNK?"
	
	para "<WAIT_M>LET'S DANCE!"
	done
	
LusterSewersThroneRoomFrankieCutsceneText18:
	text "Grrr…"
	
	para "No wonder those"
	line "“NIDOKINGS” sent"
	cont "you down here…"
	
	para "You're tougher than"
	line "they could EVER"
	cont "hope to be."
	
	para "You wouldn't be"
	line "lookin' to switch"
	cont "sides, would ya?"
	
	para "…"
	
	para "Nah, <WAIT_S>of course"
	line "not!"
	
	para "Yeah, <WAIT_S>yeah…"
	
	para "We'll leave for"
	line "now."
	
	para "But this ain't"
	line "over, punk!"
	
	para "Not by a long"
	line "shot!"
	done
	
LusterSewersThroneRoomFrankieCutsceneText19:
	text "Pack it in, boys!"
	
	para "We're outta here!"
	done
	
LusterSewersThroneRoomFrankieCutsceneText20:
	text "But, MISS FRANKIE!"
	done
	
LusterSewersThroneRoomFrankieCutsceneText21:
	text "No ifs, <WAIT_S>no buts,<WAIT_S>"
	line "no coconuts!"
	
	para "Move it!"
	done

LusterSewersThroneRoomFrankieCutsceneText22:
	text "And you!"
	
	para "Watch your back,"
	line "punk…"
	done
	
LusterSewersThroneRoomFrankieYesText:
	text "Really?"
	
	para "No foolin'?"
	done
	
LusterSewerThroneRoomGrunt1Text:
	text "What are you"
	line "lookin' at?"
	done
	
LusterSewerThroneRoomGrunt2Text:
	text "Move along, kid"
	done
	
Movement_LusterSewerThroneRoomGruntStepAside:
	fix_facing
	step_left
	remove_fixed_facing
	step_end
	
Movement_LusterSewerThroneRoomGruntStepAside2:
	fix_facing
	step_right
	remove_fixed_facing
	step_end
	
Movement_LusterSewerThroneRoomFakeFrankie1:
	fix_facing
	jump_step_up
	remove_fixed_facing
	step_end
	
Movement_LusterSewerThroneRoomFakeFrankie2:
	turn_step_up
	turn_step_up
	turn_step_up
	run_step_right
	step_end
	
Movement_LusterSewerThroneRoomFakeFrankie3:
	turn_step_left
	turn_step_left
	turn_step_left
	run_step_left
	step_end
	
Movement_LusterSewerThroneRoomFrankie1:
	jump_step_down
	step_sleep 20
	step_down
	step_down
	step_end
	
Movement_LusterSewerThroneRoomFrankie2:
	step_right
	step_down
	step_down
	step_left
	step_down
	step_down
	step_end
	
Movement_LusterSewerThroneRoomPlayerCutscene:
	slow_step_up
	slow_step_up
	step_end
	
Movement_LusterSewerThroneRoomPlayerCutscene2:
	slow_step_down
	slow_step_down
	step_end
