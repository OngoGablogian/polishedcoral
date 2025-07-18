SprucesLab_MapScriptHeader:
	db 0 ; scene scripts

	db 1 ; callbacks
	callback MAPCALLBACK_TILES, SpruceLabUnlockDoor

	db 3 ; warp events
	warp_def 7, 4, 6, SUNBEAM_ISLAND
	warp_def 7, 5, 6, SUNBEAM_ISLAND
	warp_def 0, 5, 1, SUNBEAM_RESERVE

	db 1 ; coord events
	xy_trigger 2, 1, 5, 0, SpruceLabComeBackInside, 0, 0

	db 6 ; bg events
	signpost 0, 5, SIGNPOST_READ, SpruceLabDoor
	signpost 0, 4, SIGNPOST_READ, SpruceLabOpenWindow
	signpost  5,  1, SIGNPOST_DOWN, SpruceLabPC
	signpost 3, 9, SIGNPOST_READ, SpruceLabTrashcan
	signpost  1,  2, SIGNPOST_READ, SpruceLabHealMachine
	bg_event  9,  3, SIGNPOST_ITEM + TAPE_PLAYER, EVENT_MUSIC_SPRUCE

	db 7 ; object events
	person_event SPRITE_SPRUCE, 3, 3, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, SpruceLabSpruce, EVENT_SPRUCELAB_SPRUCE1_GONE
	person_event SPRITE_SPRUCE, 0, 5, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, SpruceLabSpruce, EVENT_SPRUCELAB_SPRUCE2_GONE
	person_event SPRITE_SPRUCE,  5,  8, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_BROWN, PERSONTYPE_SCRIPT, 0, SpruceLabSpruce, EVENT_SPRUCELAB_SPRUCE3_GONE
	person_event SPRITE_SNES, 5, 9, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, (1 << 3) | PAL_OW_BLUE, PERSONTYPE_SCRIPT, 0, SpruceLabMunchlaxSleep, EVENT_SPRUCELAB_MUNCH1_GONE
	object_event 9, 5, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, MUNCHLAX, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, SpruceLabMunchlax, EVENT_SPRUCELAB_MUNCH2_GONE
	object_event 0, 4, SPRITE_MON_ICON, SPRITEMOVEDATA_POKEMON, 0, MUNCHLAX, -1, -1, PAL_NPC_BLUE, PERSONTYPE_SCRIPT, 0, SpruceLabMunchlax, EVENT_SPRUCELAB_MUNCH3_GONE
	hiddentape_event 9, 3, MUSIC_SPRUCE, 1, EVENT_MUSIC_SPRUCE

	const_def 1 ; object constants
	const SPRUCELAB_SPRUCE1
	const SPRUCELAB_SPRUCE2
	const SPRUCELAB_SPRUCE3
	const SPRUCELAB_MUNCHLAX1
	const SPRUCELAB_MUNCHLAX2
	const SPRUCELAB_MUNCHLAX3

SpruceLabUnlockDoor:
	checkevent EVENT_TALKED_TO_SPRUCE
	iftrue .UnlockThatBitch
	return
.UnlockThatBitch
	changeblock $4, $0, $24
	return
	
SpruceLabHealMachine:
	opentext
;	checkevent EVENT_TALKED_TO_SPRUCE
;	iffalse .whats_this
	checkcode VAR_PARTYCOUNT
	if_equal 0, .no_pokemon
	writetext SpruceLabHealingMachineText
	yesorno
	iffalse .no
	closetext
	pause 10
	turnobject PLAYER, LEFT
	pause 10
	special HealParty
	special SaveMusic
	playmusic MUSIC_NONE
	writebyte 1 ; Machine is at a Pokemon Center
	special HealMachineAnim
	pause 30
	special RestoreMusic
	turnobject PLAYER, DOWN
	pause 10
	end
.no
	farwritetext BetterNotText
	waitbutton
	closetext
	end
.no_pokemon
	playsound SFX_CHOOSE_PC_OPTION
	farwritetext UnknownText_0x1c1328
	closetext
	end
.whats_this
	writetext SpruceLabHealingMachineText2
	waitbutton
	closetext
	end
	
SpruceLabSpruce:
	checkevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	iftrue .repeatmasterballspeech
	checkevent EVENT_NO_ROOM_FOR_MASTER_BALL
	iftrue .trymasterballagain
	checkevent EVENT_SPRUCE_CAN_GET_MASTER_BALL
	iftrue .masterballspeech
	checkevent EVENT_TALKED_TO_SPRUCE
	iftrue .alreadytalked
	setevent EVENT_TALKED_TO_SPRUCE
	setevent EVENT_SPRUCELAB_SPRUCE1_GONE
	faceplayer
	opentext TEXTBOX_SPRUCE
	writetext SpruceLabSpruceText1
	waitbutton
	closetext
	checkcode VAR_FACING
	if_equal LEFT, .YouAreFacingLeft
	follow SPRUCELAB_SPRUCE1, PLAYER
	applymovement SPRUCELAB_SPRUCE1, Movement_SpruceLabSpruce1
	jump .cont
.YouAreFacingLeft
	applymovement SPRUCELAB_SPRUCE1, Movement_SpruceLabSpruce2
	follow SPRUCELAB_SPRUCE1, PLAYER
	applymovement SPRUCELAB_SPRUCE1, Movement_SpruceLabSpruce3
.cont
	stopfollow
	spriteface PLAYER, UP
	pause 7
	playsound SFX_WALL_OPEN
	pause 7
	faceplayer
	opentext TEXTBOX_SPRUCE
	writetext SpruceLabSpruceText2
	waitbutton
	closetext
	dotrigger $1
	changeblock $5, $0, $24
	applymovement SPRUCELAB_SPRUCE1, Movement_SpruceLabSpruce4
	spriteface SPRUCELAB_SPRUCE1, LEFT
	applymovement PLAYER, Movement_SpruceLabPlayer1
	warpcheck
	end
.alreadytalked
	checkevent EVENT_SAVED_SUNBEAM
	iftrue .sunbeam_done
	jumptextfaceplayer TEXTBOX_SPRUCE, SpruceLabSpruceText18
.sunbeam_done
	jumptextfaceplayer TEXTBOX_SPRUCE, SpruceLabSpruceText8
.trymasterballagain
	faceplayer
	opentext TEXTBOX_SPRUCE
	writetext SpruceLabSpruceText17
	waitbutton
	jump .getmasterball
.masterballspeech
	faceplayer
	opentext TEXTBOX_SPRUCE
	writetext SpruceLabSpruceText14
	waitbutton
.getmasterball
	changetextboxspeaker
	verbosegiveitem MASTER_BALL
	iffalse .no_room
	changetextboxspeaker TEXTBOX_SPRUCE
	writetext SpruceLabSpruceText15
	waitbutton
	closetext
	clearevent EVENT_NO_ROOM_FOR_MASTER_BALL
	clearevent EVENT_SPRUCE_CAN_GET_MASTER_BALL
	clearevent EVENT_SPRUCE_CAN_RECALL_ABOUT_ANCIENTBALL
	setevent EVENT_TEMPORARY_UNTIL_MAP_RELOAD_1
	setevent EVENT_GOT_MASTERBALL
	clearevent EVENT_MUSEUM_ABIE_GONE
	end
.no_room
	changetextboxspeaker TEXTBOX_SPRUCE
	writetext SpruceLabSpruceText16
	waitbutton
	closetext
	setevent EVENT_NO_ROOM_FOR_MASTER_BALL
	end
.repeatmasterballspeech
	faceplayer
	opentext TEXTBOX_SPRUCE
	writetext SpruceLabSpruceText15
	waitbutton
	closetext
	end
	
SpruceLabComeBackInside:
	setevent EVENT_ISLAND_BOATMAN
	applymovement PLAYER, Movement_SpruceLabPlayer2
	pause 14
	playsound SFX_ENTER_DOOR
	appear SPRUCELAB_SPRUCE2
	spriteface PLAYER, UP
	pause 7
	applymovement SPRUCELAB_SPRUCE2, Movement_SpruceLabSpruce5
	spriteface PLAYER, DOWN
	spriteface SPRUCELAB_SPRUCE2, UP
	
	opentext TEXTBOX_SPRUCE
	writetext SpruceLabSpruceText3
	waitbutton
	closetext
	spriteface SPRUCELAB_SPRUCE2, DOWN
	pause 20
	spriteface SPRUCELAB_SPRUCE2, LEFT
	pause 20
	spriteface SPRUCELAB_SPRUCE2, RIGHT
	pause 20
	playsound SFX_PAY_DAY
	showemote EMOTE_SHOCK, SPRUCELAB_SPRUCE2, 15
	pause 7
	opentext TEXTBOX_SPRUCE
	writetext SpruceLabSpruceText4
	waitbutton
	closetext
	follow SPRUCELAB_SPRUCE2, PLAYER
	applymovement SPRUCELAB_SPRUCE2, Movement_SpruceLabSpruce6
	stopfollow
	spriteface SPRUCELAB_SPRUCE2, RIGHT
	pause 5
	opentext TEXTBOX_SPRUCE
	writetext SpruceLabSpruceText5
	waitbutton
	closetext
	spriteface PLAYER, DOWN
	applymovement SPRUCELAB_SPRUCE2, Movement_SpruceLabSpruce8
	pause 30
	applymovement SPRUCELAB_SPRUCE2, Movement_SpruceLabSpruce9
	spriteface SPRUCELAB_SPRUCE2, UP
	opentext
	writetext SpruceLabSpruceText10
	waitbutton
	closetext
	spriteface PLAYER, RIGHT
	spriteface SPRUCELAB_SPRUCE2, RIGHT
	pause 20
	opentext
	writetext SpruceLabPokeFluteText1
	playsound SFX_POKEFLUTE
	waitsfx
	buttonsound
	writetext SpruceLabPokeFluteText2
	appear SPRUCELAB_MUNCHLAX2
	waitbutton
	closetext
	wait 5
	disappear SPRUCELAB_MUNCHLAX1
	opentext TEXTBOX_POKEMON, MUNCHLAX
	writetext SpruceLabMunchlaxText2
	cry MUNCHLAX
	waitsfx
	buttonsound
	changetextboxspeaker
	writetext SpruceLabPokeFluteText3
	waitbutton
	closetext
	pause 5
	spriteface PLAYER, DOWN
	spriteface SPRUCELAB_SPRUCE2, UP
	pause 5
	opentext TEXTBOX_SPRUCE
	writetext SpruceLabSpruceText6
	waitbutton
	closetext
	pause 10
	opentext TEXTBOX_SPRUCE
	writetext SpruceLabSpruceText11
	waitbutton
	closetext
	spriteface SPRUCELAB_SPRUCE2, DOWN
	pause 70
	spriteface SPRUCELAB_SPRUCE2, UP
	opentext TEXTBOX_SPRUCE
	writetext SpruceLabSpruceText7
	waitbutton
	changetextboxspeaker
	verbosegiveitem POKE_FLUTE
	closetext
	follow SPRUCELAB_SPRUCE2, PLAYER
	applymovement SPRUCELAB_SPRUCE2, Movement_SpruceLabSpruce7
	spriteface SPRUCELAB_SPRUCE2, DOWN
	stopfollow
	pause 5
	opentext TEXTBOX_SPRUCE
	writetext SpruceLabSpruceText8
	waitbutton
	closetext
	setevent EVENT_SUNBEAM_SPRUCE_GONE
	setevent EVENT_SPRUCELAB_SPRUCE2_GONE
	setevent EVENT_SPRUCELAB_MUNCH1_GONE
	setevent EVENT_SPRUCELAB_MUNCH2_GONE
	clearevent EVENT_SPRUCELAB_MUNCH3_GONE
	clearevent EVENT_SPRUCELAB_SPRUCE1_GONE
	setevent EVENT_SPRUCELAB_SPRUCE3_GONE
	setevent EVENT_GOT_POKEFLUTE
	clearevent EVENT_FIRST_TRIP_TO_ISLAND
	clearevent EVENT_LAKEHOUSE_SOFTLOCK_PREVENTION
	domaptrigger SUNBEAM_RESERVE, $1
	dotrigger $1
	end

SpruceLabMunchlaxSleep:
	jumptext SpruceLabMunchlaxText1
	
SpruceLabMunchlax:
	opentext
	writetext SpruceLabMunchlaxText2
	cry MUNCHLAX
	waitsfx
	waitbutton
	closetext
	end
	
SpruceLabDoor:
	checkevent EVENT_TALKED_TO_SPRUCE
	iftrue .unlocked
	jumptext SpruceLabDoorText1
.unlocked
	jumptext SpruceLabDoorText2
	
SpruceLabOpenWindow:
	jumptext SpruceLabOpenWindowText
	
SpruceLabPC:
	jumptext SpruceLabPCText
	
SpruceLabTrashcan:
	jumptext SpruceLabTrashcanText
	
SpruceLabHealingMachineText:
	text "Would you like to"
	line "heal your #MON?"
	done
	
SpruceLabHealingMachineText2:
	text "I wonder what this"
	line "does?"
	done
	
SpruceLabSpruceText1:
	text "Ah! <PLAYER>!"
	
	para "You came!"
	
	para "How is the #MON"
	line "I sent for you?"
	
	para "Doing well, I"
	line "hope."
	
	para "Anyway, <WAIT_S>let me"
	line "show you around."
	
	para "Follow me!"
	done
	
SpruceLabSpruceText2:
	text "We'll start outside"
	line "with the #MON"
	cont "reserve."
	
	para "After you."
	done
	
SpruceLabSpruceText3:
	text "Well, that's about"
	line "it."
	
	para "…<WAIT_L>Oh!"
	
	para "I almost forgot to"
	line "introduce you to"
	cont "my assistant."
	
	para "Now where could he"
	line "be?"
	done
	
SpruceLabSpruceText4:
	text "Ah! <WAIT_M>There he is!"
	done
	
SpruceLabSpruceText5:
	text "Ah ha!"
	
	para "Seems like he's"
	line "fallen asleep,"
	cont "again."
	
	para "I have just the"
	line "thing!"
	
	para "Please wait here"
	line "for a moment."
	done
	
SpruceLabSpruceText6:
	text "A song played on"
	line "this will wake any"
	cont "#MON from even"
	cont "the deepest"
	cont "slumber."
	
	para "Strangely though,"
	line "some people say"
	cont "that the soothing"
	cont "sound actually"
	cont "makes them MORE"
	cont "sleepy!"
	
	para "It truly is a"
	line "mysterious instru-"
	cont "ment!"
	done
	
SpruceLabSpruceText7:
	text "Well then!<WAIT_M>"
	line "It's decided!"
	
	para "I'll entrust the"
	line "#FLUTE to you,"
	cont "<PLAYER>!"
	
	para "After all, <WAIT_S>it was"
	line "I who set your"
	cont "journey across"
	cont "ONWA into motion,"
	cont "was it not?"
	
	para "Surely it would"
	line "fall to me to"
	cont "assist you in any"
	cont "way I can."
	
	para "Use it with care."
	done
	
SpruceLabSpruceText8:
	text "Thank you so much"
	line "for stopping by."
	
	para "Do call me if you"
	line "need anything."
	
	para "Good luck on the"
	line "rest of your"
	cont "adventure."
	done
	
SpruceLabSpruceText9:
	text "Feel free to"
	line "return any time"
	cont "you want your"
	cont "#DEX reviewed."

	para "Good luck on the"
	line "rest of your"
	cont "adventure."
	done
	
SpruceLabSpruceText10:
	text "Here we are."
	
	para "The #FLUTE."
	
	para "Watch this!"
	done

SpruceLabSpruceText11:
	text "What's that?"
	
	para "A SNORLAX is"
	line "sleeping and"
	cont "blocking the path"
	cont "near STARGLOW"
	cont "VALLEY?"
	
	para "The #FLUTE"
	line "would surely wake"
	cont "it and clear the"
	cont "path."
	
	para "Hmm…"
	done
	
SpruceLabSpruceText12:
	text "Follow me!"
	done
	
SpruceLabSpruceText13:
	text "Next up, <WAIT_S>this"
	line "machine will heal"
	cont "your #MON."
	
	para "It's just like the"
	line "machines in the"
	cont "#MON CENTER!"
	
	para "Give it a try!"
	
	para "Go ahead and put"
	line "your #BALLs in"
	cont "the machine."
	done
	
SpruceLabSpruceText14:
	text "<PLAYER>!<WAIT_S>"
	line "It's wonderful!"
	
	para "I heard about the"
	line "ancient #BALL"
	cont "you discovered!"
	
	para "Amazing!"
	
	para "…<WAIT_L>What's with that"
	line "look?"
	
	para "Are you confused"
	line "as to how I heard?"
	
	para "Well, you see,"
	line "DR. ABIEGAIL is"
	cont "none other than"
	cont "my daughter!"
	
	para "Before my current"
	line "work with the"
	cont "#MON reserve,"
	
	para "I used to conduct"
	line "research at the"
	cont "OBSCURA MUSEUM."
	
	para "My focus was on"
	line "the relationship"
	cont "between ancient"
	cont "man and #MON."
	
	para "Our contemporary"
	line "understanding is"
	cont "that the #BALL"
	cont "was a relatively"
	cont "recent invention,"
	
	para "and that idea of"
	line "catching #MON"
	cont "originated a few"
	cont "hundred years ago."

	para "My work attempted"
	line "to prove that this"
	cont "wasn't the case,"
	
	para "and that a device"
	line "close to a modern"
	cont "#BALL existed"
	cont "in ancient times."
	
	para "After I retired,"
	line "ABIE followed in"
	cont "my footsteps and"
	cont "carried on my"
	cont "work."
	
	para "That ball of yours"
	line "was the missing"
	cont "piece to my life's"
	cont "research!"
	
	para "I don't know how I"
	line "can thank you,"
	cont "<PLAYER>."
	
	para "I won't take up any"
	line "more of your time"
	cont "with my talking,"
	
	para "but I do have"
	line "something to show"
	cont "my thanks."
	
	para "Take it.<WAIT_S>"
	line "It's yours."
	done
	
SpruceLabSpruceText15:
	text "The MASTER BALL"
	line "cannot fail."
	
	para "It'll catch any"
	line "#MON no matter"
	cont "what."
	
	para "It's a very rare"
	line "and valuable item."
	
	para "I can't think"
	line "of anyone more"
	cont "deserving of it"
	cont "than you."
	done
	
SpruceLabSpruceText16:
	text "You don't have"
	line "room for my"
	cont "gift!"
	
	para "Please make some"
	line "room."
	
	para "This is important!"
	done
	
SpruceLabSpruceText17:
	text "Have you made"
	line "some room?"
	
	para "Take it.<WAIT_S>"
	line "It's yours."
	done
	
SpruceLabSpruceText18:
	text "That #FLUTE…"
	
	para "A song played on"
	line "this will wake any"
	cont "#MON from even"
	cont "the deepest"
	cont "slumber."
	
	para "Strangely though,"
	line "some people say"
	cont "that the soothing"
	cont "sound actually"
	cont "makes them MORE"
	cont "sleepy!"
	
	para "It truly is a"
	line "mysterious instru-"
	cont "ment!"
	done
	
SpruceLabPokeFluteText1:
	text "SPRUCE played the"
	line "#FLUTE."
	done
	
SpruceLabPokeFluteText2:
	text "Now that's a"
	line "catchy tune!"
	done
	
SpruceLabPokeFluteText3:
	text "MUNCHLAX is"
	line "wide awake!"
	done
	
SpruceLabMunchlaxText1:
	text "Muuunch…"
	
	para "It's sleeping"
	line "soundly."
	done
	
SpruceLabMunchlaxText2:
	text "Lax! Lax!"
	done
	
SpruceLabDoorText1:
	text "It's locked!"
	done
	
SpruceLabDoorText2:
	text "It's unlocked!"
	done
	
SpruceLabOpenWindowText:
	text "The window's open."

	para "A pleasant breeze"
	line "is blowing in."
	done
	
SpruceLabPCText:
	text "OBSERVATIONS ON"
	line "#MON HABITATS"

	para "…It says on the"
	line "screen…"
	done
	
SpruceLabTrashcanText:
	text "It's half full of"
	line "empty purified"
	cont "water bottles."
	done
	
Movement_SpruceLabSpruce1:
	step_right
	step_right
	step_up
	step_up
	step_end
	
Movement_SpruceLabSpruce2:
	step_up
	step_right
	step_end
	
Movement_SpruceLabSpruce3:
	step_right
	step_up
	step_end
	
Movement_SpruceLabSpruce4:
	step_right
	step_end
	
Movement_SpruceLabSpruce5:
	step_down
	step_left
	step_down
	step_down
	step_right
	step_end
	
Movement_SpruceLabSpruce6:
	step_down
	step_right
	step_right
	step_right
	step_down
	step_end
	
Movement_SpruceLabSpruce7:
	step_left
	step_left
	step_left
	step_left
	step_left
	step_up
	step_up
	step_end
	
Movement_SpruceLabSpruce8:
	step_left
	step_left
	step_left
	step_left
	step_left
	step_left
	step_end
	
Movement_SpruceLabSpruce9:
	step_right
	step_right
	step_right
	step_right
	step_right
	step_right
	step_end
	
Movement_SpruceLabSpruce10:
	step_right
	step_down
	step_right
	step_right
	step_right
	step_right
	step_down
	step_end
	
Movement_SpruceLabSpruce11:
	step_left
	step_left
	step_up
	step_end
	
Movement_SpruceLabPlayer1:
	step_up
	step_up
	step_end
	
Movement_SpruceLabPlayer2:
	step_down
	step_end
	
Movement_SpruceLabPlayer3:
	step_left
	step_up
	step_end
	