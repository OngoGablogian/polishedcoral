UnknownText_0x1c0043::
	text "Hello, hello! <WAIT_S>I'm"
	line "the NAME RATER."

	para "I rate the names"
	line "of #MON."

	para "Would you like me"
	line "to rate names?"
	done

UnknownText_0x1c00a0::
	text "Which #MON's"
	line "nickname should I"
	cont "rate for you?"
	prompt

UnknownText_0x1c00cd::
	text "Hm… @"
	text_from_ram wStringBuffer1
	text "…"
	line "That's a fairly"
	cont "decent name."

	para "But, how about a"
	line "slightly better"
	cont "nickname?"

	para "Want me to give it"
	line "a better name?"
	done

UnknownText_0x1c0142::
	text "All right. <WAIT_S>What"
	line "name should we"
	cont "give it, then?"
	prompt

UnknownText_0x1c0171::
	text "That's a better"
	line "name than before!"

	para "Well done!"
	done

UnknownText_0x1c019e::
	text "OK, then. <WAIT_S>Come"
	line "again sometime."
	done

UnknownText_0x1c01be::
	text "Hm… @"
	text_from_ram wStringBuffer1
	text "?"
	line "What a great name!<WAIT_S>"
	cont "It's perfect."

	para "Treat @"
	text_from_ram wStringBuffer1
	text ""
	line "with loving care."
	done

UnknownText_0x1c0208::
	text "Whoa… <WAIT_S>That's just"
	line "an EGG."
	done

UnknownText_0x1c0222::
	text "It might look the"
	line "same as before,"

	para "but this new name"
	line "is much better!"

	para "Well done!"
	done

UnknownText_0x1c0272::
	text "All right. <WAIT_S>This"
	line "#MON is now"
	cont "named @"
	text_from_ram wStringBuffer1
	text "."
	prompt

Text_Gained::
	text_from_ram wStringBuffer1
	text " gained@@"

Text_ABoostedStringBuffer2ExpPoints::
	text ""
	line "a boosted"
	cont "@"
	deciram wStringBuffer2, 2, 5
	text " EXP. POINTS!"
	prompt

Text_StringBuffer2ExpPoints::
	text ""
	line "@"
	deciram wStringBuffer2, 2, 5
	text " EXP. POINTS!"
	prompt

Text_GoPkmn::
	text "Go! <WAIT_S>@@"

Text_DoItPkmn::
	text "Do it! <WAIT_S>@@"

Text_GoForItPkmn::
	text "Go for it,"
	line "@@"

Text_YourFoesWeakGetmPkmn::
	text "Your foe's weak!<WAIT_S>"
	line "Get'm, @@"

Text_BattleMonNick01::
	text_from_ram wBattleMonNick
	text "!"
	done

Text_BattleMonNickComma::
	text_from_ram wBattleMonNick
	text ",@@"

Text_ThatsEnoughComeBack::
	text " that's"
	line "enough! <WAIT_S>Come back!@@"

Text_OKComeBack::
	text " OK!<WAIT_S>"
	line "Come back!@@"

Text_GoodComeBack::
	text " good!<WAIT_S>"
	line "Come back!@@"

Text_ComeBack::
	text " come"
	line "back!"
	done

UnknownText_0x1c0373::
	text "Booted up a TM."
	done

UnknownText_0x1c0384::
	text "Booted up an HM."
	done

UnknownText_0x1c0396::
	text "It contained"
	line "@"
	text_from_ram wStringBuffer2
	text "."

	para "Teach @"
	text_from_ram wStringBuffer2
	text ""
	line "to a #MON?"
	done

UnknownText_0x1c03c2::
	text_from_ram wStringBuffer2
	text " is"
	line "not compatible"
	cont "with @"
	text_from_ram wStringBuffer1
	text "."

	para "It can't learn"
	line "@"
	text_from_ram wStringBuffer2
	text "."
	prompt

_BadgeRequiredText::
	text "Sorry! <WAIT_S>A new BADGE"
	line "is required."
	prompt

_DebugFieldMoveText::
	text "SUPER DEBUG POWER"
	line "ACTIVATE!"
	prompt
	
UnknownText_0x1c05c8::
	text "Can't use that"
	line "here."
	prompt

UnknownText_0x1c05dd::
	text_from_ram wStringBuffer2
	text " used"
	line "CUT!"
	prompt

UnknownText_0x1c05ec::
	text "There's nothing to"
	line "CUT here."
	prompt

UnknownText_0x1c0609::
	text "A blinding FLASH"
	line "lights the area!@"
	text_waitbutton
	db "@@"

_UsedFlyText::
	text_from_ram wStringBuffer2
	text " used"
	line "FLY!"
	done
	
_UsedSurfText::
	text_from_ram wStringBuffer2
	text " used"
	line "SURF!"
	done

_CantSurfText::
	text "You can't SURF"
	line "here."
	prompt

_AlreadySurfingText::
	text "You're already"
	line "SURFing."
	prompt

_AskSurfText::
	text "The water is calm."
	
	para "Want to SURF?"
	done
	
_AskLavaSurfText::
	text "The lava is"
	line "bubbling."
	
	para "Want to ride on"
	line "@"
	text_from_ram wStringBuffer2
	text "?"
	done
	
_UsedLavaSurfText::
	text "<PLAYER> got on"
	line "@"
	text_from_ram wStringBuffer2
	text "."
	done

_SewerSurfText::
	text "The water smells"
	line "disgusting."
	
	para "It might clear up"
	line "if you can kick"
	cont "those punks out!"
	done
	
_SewerSurf2Text::
	text "The water smells"
	line "disgusting."
	done
	
UnknownText_0x1c068e::
	text_from_ram wStringBuffer2
	text " used"
	line "WATERFALL!"
	done

UnknownText_0x1c06a3::
	text "Wow, <WAIT_S>it's a huge"
	line "waterfall."
	done

UnknownText_0x1c06bf::
	text "Do you want to use"
	line "WATERFALL?"
	done

AskUseDiveText::
	text "The sea is deep"
	line "here!"
	
	para "Do you want to use"
	line "DIVE?"
	done
	
AskUseDiveText2::
	text "Light is filtering"
	line "down from above."
	
	para "Do you want to use"
	line "DIVE?"
	done
	
UsedDiveText::
	text_from_ram wStringBuffer2
	text " used"
	line "DIVE!"
	done
	
CantDoDiveText::
	text "The sea is deep"
	line "here!"
	done

AskUseRockClimbText::
	text "Looks like a #-"
	line "MON could climb"
	cont "the rocks here!"
	
	para "Do you want to use"
	line "ROCK CLIMB?"
	done
	
UsedRockClimbText::
	text_from_ram wStringBuffer2
	text " used"
	line "ROCK CLIMB!"
	done
	
CantDoRockClimbText::
	text "Looks like a #-"
	line "MON could climb"
	cont "the rocks here!"
	done
	
UnknownText_0x1c06de::
	text_from_ram wStringBuffer2
	text " used"
	line "DIG!"
	done

UnknownText_0x1c06ed::
	text "<PLAYER> used an"
	line "ESCAPE ROPE."
	done

UnknownText_0x1c0705::
	text "Can't use that"
	line "here."
	done

UnknownText_0x1c073b::
	text "Can't use that"
	line "here."

	para ""
	done

UnknownText_0x1c0774::
	text_from_ram wStringBuffer2
	text " used"
	line "STRENGTH!"
	done

UnknownText_0x1c0788::
	text_from_ram wStringBuffer1
	text " can"
	line "move boulders."
	prompt

UnknownText_0x1c07a0::
	text "A #MON may be"
	line "able to move this."

	para "Want to use"
	line "STRENGTH?"
	done

UnknownText_0x1c07d8::
	text "Boulders may now"
	line "be moved!"
	done

UnknownText_0x1c07f4::
	text "A #MON may be"
	line "able to move this."
	done

UnknownText_0x1c0816::
	text_from_ram wStringBuffer2
	text " used"
	line "WHIRLPOOL!"
	prompt

UnknownText_0x1c082b::
	text "It's a vicious"
	line "whirlpool!"

	para "A #MON may be"
	line "able to pass it."
	done

UnknownText_0x1c0864::
	text "A whirlpool is in"
	line "the way."

	para "Want to use"
	line "WHIRLPOOL?"
	done

UnknownText_0x1c0897::
	text_from_ram wStringBuffer2
	text " did a"
	line "HEADBUTT!"
	prompt

UnknownText_0x1c08ac::
	text "Nope. <WAIT_S>Nothing…"
	done

UnknownText_0x1c08bc::
	text "A #MON could be"
	line "in this tree."

	para "Want to HEADBUTT"
	line "it?"
	done

UnknownText_0x1c08f0::
	text_from_ram wStringBuffer2
	text " used"
	line "ROCK SMASH!"
	prompt

UnknownText_0x1c0906::
	text "Maybe a #MON"
	line "can break this."
	done

UnknownText_0x1c0924::
	text "This rock looks"
	line "breakable."
	
	para "Want to use ROCK"
	line "SMASH?"
	done

UnknownText_0x1c0958::
	text "Oh!<WAIT_S>"
	line "A bite!"
	prompt

UnknownText_0x1c0965::
	text "Not even a nibble…"
	prompt

UnknownText_0x1c099a::
	text "You can't get off"
	line "here!"
	done

UnknownText_0x1c09b2::
	text "<PLAYER> got on the"
	line "@"
	text_from_ram wStringBuffer2
	text "."
	done

UnknownText_0x1c09c7::
	text "<PLAYER> got off"
	line "the @"
	text_from_ram wStringBuffer2
	text "."
	done
	
UnknownText_0x1c09dd::
	text "This tree can be"
	line "CUT!"

	para "Want to use CUT?"
	done

UnknownText_0x1c0a05::
	text "This tree can be"
	line "CUT!"
	done

UnknownText_0x1c0a1c::
	text "<PLAYER> found"
	line "@"
	text_from_ram wStringBuffer3
	text "!"
	done

WhiteoutText::
	text "<PLAYER> is out of"
	line "useable #MON!"

	para "<PLAYER> blacked"
	line "out!"
	done

WhiteoutToWildText::
	text "<PLAYER> is out of"
	line "useable #MON!"

	para "<PLAYER> panicked"
	line "and dropped half"
	cont "of their money…"

	para "………………"
	line "………………"

	para "<PLAYER> blacked"
	line "out!"
	done

WhiteoutToTrainerText::
	text "<PLAYER> is out of"
	line "useable #MON!"

	para "<PLAYER> paid out"
	line "half their money"
	cont "to the winner…"

	para "………………"
	line "………………"

	para "<PLAYER> blacked"
	line "out!"
	done

UnknownText_0x1c0a77::
	text "Yes! <WAIT_S>ITEMFINDER"
	line "indicates there's"
	cont "an item nearby."
	prompt

UnknownText_0x1c0aa9::
	text "Nope! <WAIT_S>ITEMFINDER"
	line "isn't responding."
	prompt

UnknownText_0x1c0acc::
	text_from_ram wStringBuffer3
	text ""
	line "recovered from"
	cont "its poisoning!"
	prompt

UnknownText_0x1c0b3b::
	text "<PLAYER> sprinkled"
	line "water."

	para "But nothing"
	line "happened…"
	done

UnknownText_0x1c0b65::
	text "<PLAYER>'s #MON"
	line "were all healed!"
	done
	
UnknownText_0x1c0b652::
	text "<PLAYER> used the"
	line "MIRACLETONIC."
	done
	

Text_AnEGGCantHoldAnItem::
	text "An EGG can't hold"
	line "an item."
	prompt

UnknownText_0x1c0ba5::
	text "Throw away how"
	line "many?"
	done

UnknownText_0x1c0bbb::
	text "Throw away @"
	deciram wItemQuantityChangeBuffer, 1, 2
	text ""
	line "@"
	text_from_ram wStringBuffer2
	text "(s)?"
	done

UnknownText_0x1c0bd8::
	text "Threw away"
	line "@"
	text_from_ram wStringBuffer2
	text "(s)."
	prompt

UnknownText_0x1c0bee::
	text "SPRUCE: <PLAYER>!"
	line "This isn't the"
	cont "time to use that!"
	prompt

Text_YouDontHaveAPkmn::
	text "You don't have a"
	line "#MON!"
	prompt

UnknownText_0x1c0c2e::
	text "Registered the"
	line "@"
	text_from_ram wStringBuffer2
	text "."
	prompt

UnknownText_0x1c0c45::
	text "You can't register"
	line "that item."
	prompt

UnknownText_0x1c0c63::
	text "Where should this"
	line "be moved to?"
	done

UnknownText_0x1c0c83::
	text ""
	done

Text_AreYouABoyOrAreYouAGirl::
	text "Are you a BOY?<WAIT_M>"
	line "Or are you a GIRL?"
	done

Text_SoYoureABoy::
	text "So you're a BOY?"
	done

Text_SoYoureAGirl::
	text "So you're a GIRL?"
	done

UnknownText_0x1c0cc6::
	text "<USER>'s"
	line "@"
	text_from_ram wStringBuffer2
	db "@@"

UnknownText_0x1c0cd0::
	interpret_data
	text $4c, "rose sharply!"
	prompt

UnknownText_0x1c0ce0::
	text " rose!"
	prompt

UnknownText_0x1c0ceb::
	text "<TARGET>'s"
	line "@"
	text_from_ram wStringBuffer2
	db "@@"

UnknownText_0x1c0cf5::
	interpret_data
	text $4c, "harshly fell!"
	prompt

UnknownText_0x1c0d06::
	text " fell!"
	prompt

UnknownText_0x1c0d0e::
	text "<USER>@@"

UnknownText_0x1c0d26::
	text ""
	line "took in sunlight!"
	prompt
	
UnknownText_SkullBash::
	text ""
	line "lowered its head!"
	prompt

UnknownText_0x1c0d5c::
	text ""
	line "flew up high!"
	prompt

UnknownText_0x1c0d6c::
	text ""
	line "dug a hole!"
	prompt
	
UnknownText_Dive::
	text ""
	line "dove underwater!"
	prompt

UnknownText_0x1c0db0::
	text "Huh?"
	para "@@"

UnknownText_0x1c0db8::
	text ""
	done

UnknownText_0x1c0dba::
	text_from_ram wStringBuffer1
	text " came"
	line "out of its EGG!@"
	sound_caught_mon
	text_waitbutton
	db "@@"

UnknownText_0x1c0dd8::
	text "Give a nickname to"
	line "@"
	text_from_ram wStringBuffer1
	text "?"
	done

UnknownText_0x1c0df3::
	text "It's @"
	text_from_ram wBreedMon2Nick
	text ""
	line "that was left with"
	cont "the DAY-CARE LADY."
	done

UnknownText_0x1c0e24::
	text "It's @"
	text_from_ram wBreedMon1
	text ""
	line "that was left with"
	cont "the DAY-CARE MAN."
	done

UnknownText_0x1c0e6f::
	text "It has no interest"
	line "in @"
	text_from_ram wStringBuffer1
	text "."
	prompt

UnknownText_0x1c0e8d::
	text "It appears to care"
	line "for @"
	text_from_ram wStringBuffer1
	text "."
	prompt

UnknownText_0x1c0eac::
	text "It's friendly with"
	line "@"
	text_from_ram wStringBuffer1
	text "."
	prompt

UnknownText_0x1c0ec6::
	text "It shows interest"
	line "in @"
	text_from_ram wStringBuffer1
	text "."
	prompt

_EmptyMailboxText::
	text "There's no MAIL"
	line "here."
	prompt

ClearedMailPutAwayText::
	text "The cleared MAIL"
	line "was put away."
	prompt

MailPackFullText::
	text "The BAG is full."
	prompt

MailMessageLostText::
	text "The MAIL's message"
	line "will be lost. OK?"
	done

MailAlreadyHoldingItemText::
	text "It's already hold-"
	line "ing an item."
	prompt

MailEggText::
	text "An EGG can't hold"
	line "any MAIL."
	prompt

MailMovedFromBoxText::
	text "The MAIL was moved"
	line "from the MAILBOX."
	prompt

Text_WasSentToBillsPC::
	text_from_ram wStringBuffer1
	text " was"
	line "sent to BILL's PC."
	prompt

UnknownText_0x1c1006::
	text "You gotta have"
	line "#MON to call!"
	prompt

UnknownText_0x1c1024::
	text "What do you want"
	line "to do?"
	done

UnknownText_0x1c102b::
	text "There is a #MON"
	line "holding MAIL."

	para "Please remove the"
	line "MAIL."
	prompt

UnknownText_0x1c10c0::
	text "Caught @"
	text_from_ram wStringBuffer1
	text "!"
	prompt

UnknownText_0x1c10cf::
	text "Switch #MON?"
	done

UnknownText_0x1c10dd::
	text "You already caught"
	line "a @"
	text_from_ram wStringBuffer1
	text "."
	prompt

ContestJudging_FirstPlaceText::
	text "This Bug-Catching"
	line "Contest winner is@"
	interpret_data
	text "…"

	para "@"
	text_from_ram wBugContestWinnerName
	text ","
	line "who caught a"
	cont "@"
	text_from_ram wStringBuffer1
	text "!@@"

ContestJudging_FirstPlaceScoreText::
	text ""

	para "The winning score"
	line "was @"
	deciram wBugContestFirstPlaceScore, 2, 3
	text " points!"
	prompt

ContestJudging_SecondPlaceText::
	text "Placing second was"
	line "@"
	text_from_ram wBugContestWinnerName
	text ","
	para "who caught a"
	line "@"
	text_from_ram wStringBuffer1
	text "!@@"

ContestJudging_SecondPlaceScoreText::
	text ""
	para "The score was"
	line "@"
	deciram wBugContestSecondPlaceScore, 2, 3
	text " points!"
	prompt

ContestJudging_ThirdPlaceText::
	text "Placing third was"
	line "@"
	text_from_ram wBugContestWinnerName
	text ","
	para "who caught a"
	line "@"
	text_from_ram wStringBuffer1
	text "!@@"

ContestJudging_ThirdPlaceScoreText::
	text ""
	para "The score was"
	line "@"
	deciram wBugContestThirdPlaceScore, 2, 3
	text " points!"
	prompt

UnknownText_0x1c1203::
	text "Let me measure"
	line "that MAGIKARP."

	para "…Hm, it measures"
	line "@"
	text_from_ram wStringBuffer1
	text "."
	prompt

UnknownText_0x1c123a::
	text "@"

UnknownText_0x1c1261::
	text "Congratulations!"

	para "We have a match"
	line "with the ID number"

	para "of @"
	text_from_ram wStringBuffer1
	text " in"
	line "your party."
	prompt

UnknownText_0x1c12ae::
	text "Congratulations!"

	para "We have a match"
	line "with the ID number"

	para "of @"
	text_from_ram wStringBuffer1
	text " in"
	line "your PC Box."
	prompt

UnknownText_0x1c12fc::
	text "Give a nickname to"
	line "the @"
	text_from_ram wStringBuffer1
	text " you"
	cont "caught?"
	done

UnknownText_0x1c1328::
	text "Bzzzzt!"
	
	para "You must have a"
	line "#MON to log in!"
	prompt
	
UnknownText_0x1c13282::
	text "Bzzzzt!"
	
	para "No account found!"
	prompt

UnknownText_0x1c1353::
	text "<PLAYER> turned on"
	line "the PC."
	prompt

UnknownText_0x1c1368::
	text "What do you want"
	line "to do?"
	done

_KrissPCHowManyWithdrawText::
	text "How many do you"
	line "want to withdraw?"
	done

_KrissPCWithdrewItemsText::
	text "Withdrew @"
	deciram wItemQuantityChangeBuffer, 1, 2
	text ""
	line "@"
	text_from_ram wStringBuffer2
	text "(s)."
	prompt

_KrissPCNoRoomWithdrawText::
	text "There's no room"
	line "for more items."
	prompt

UnknownText_0x1c13df::
	text "No items here!"
	prompt

_KrissPCCantDepositItemText::
	text "That item can't"
	line "be deposited."
	prompt

_KrissPCHowManyDepositText::
	text "How many do you"
	line "want to deposit?"
	done

_KrissPCDepositItemsText::
	text "Deposited @"
	deciram wItemQuantityChangeBuffer, 1, 2
	text ""
	line "@"
	text_from_ram wStringBuffer2
	text "(s)."
	prompt

_KrissPCNoRoomDepositText::
	text "There's no room to"
	line "store items."
	prompt

UnknownText_0x1c144d::
	text "<PLAYER> turned on"
	line "the PC.<WAIT_L>"
	prompt

UnknownText_0x1c1462::
	text "Access whose PC?"
	done

UnknownText_0x1c1474::
	text "BILL's PC"
	line "accessed."

	para "#MON STORAGE"
	line "SYSTEM opened."
	prompt

UnknownText_0x1c14a4::
	text "Accessed own PC."

	para "ITEM STORAGE"
	line "SYSTEM opened."
	prompt

UnknownText_0x1c14d2::
	text "PROF.OAK's PC"
	line "accessed."

	para "#DEX Rating"
	line "System opened."
	prompt

UnknownText_0x1c1505::
	text "…<WAIT_S>"
	line "Link closed…"
	done

UnknownText_MallPC::
	text "Just kidding!"

	para "It's just for"
	line "display purposes!"
	prompt
	
_OakPCText1::
	text "Want to get your"
	line "#DEX rated?"
	done

_OakPCText2::
	text "Current #DEX"
	line "completion level:"
	prompt

_OakPCText3::
	text_from_ram wStringBuffer3
	text " #MON seen"
	line "@"
	text_from_ram wStringBuffer4
	text " #MON owned"

	para "PROF.SPRUCE's"
	line "Rating:"
	done

_OakRating01::
	text "Look for #MON"
	line "in grassy areas!"
	done

_OakRating02::
	text "Good. I see you"
	line "understand how to"
	cont "use # BALLS."
	done

_OakRating03::
	text "You're getting"
	line "good at this."

	para "But you have a"
	line "long way to go."
	done

_OakRating04::
	text "You need to fill"
	line "up the #DEX."

	para "Catch different"
	line "kinds of #MON!"
	done

_OakRating05::
	text "You're trying--I"
	line "can see that."

	para "Your #DEX is"
	line "coming together."
	done

_OakRating06::
	text "To evolve, some"
	line "#MON grow,"

	para "others use the"
	line "effects of STONES."
	done

_OakRating07::
	text "Have you gotten a"
	line "fishing ROD? You"

	para "can catch #MON"
	line "by fishing."
	done

_OakRating08::
	text "Excellent! <WAIT_S>You"
	line "seem to like col-"
	cont "lecting things!"
	done

_OakRating09::
	text "Some #MON only"
	line "appear during"

	para "certain times of"
	line "the day."
	done

_OakRating10::
	text "Your #DEX is"
	line "filling up. Keep"
	cont "up the good work!"
	done

_OakRating11::
	text "I'm impressed."
	line "You're evolving"

	para "#MON, not just"
	line "catching them."
	done

_OakRating12::
	text "Make sure to use"
	line "different BALLS."
	
	para "It should really"
	line "help."
	done

_OakRating13::
	text "Wow. <WAIT_S>You've found"
	line "over 150?"

	para "Keep up the good"
	line "work!"
	done

_OakRating14::
	text "Are you trading"
	line "your #MON?"

	para "It's tough to do"
	line "this alone!"
	done

_OakRating15::
	text "Wow! <WAIT_S>"
	line "You've hit 200!"
	
	para "Your #DEX is"
	cont "looking great!"
	done

_OakRating16::
	text "You've found so"
	line "many #MON!"

	para "You've really"
	line "helped my studies!"
	done

_OakRating17::
	text "Magnificent! <WAIT_S>You"
	line "could become a"

	para "#MON PROF."
	line "yourself!"
	done

_OakRating18::
	text "Your #DEX is"
	line "amazing! <WAIT_S>You're"

	para "ready to turn"
	line "professional!"
	done

_OakRating19::
	text "Whoa! <WAIT_S>A perfect"
	line "#DEX!"

	para "I've dreamt about"
	line "this!"
	
	para "Congratulations!"
	done

_OakPCText4::
	text "The link to PROF."
	line "SPRUCE's PC closed."
	done

UnknownText_0x1c1a5b::
	text " , yeah!"
	done

UnknownText_0x1c1a65::
	text "Darn…"
	done

UnknownText_0x1c1a6c::
	text "Would you like to"
	line "end the Contest?"
	done

UnknownText_0x1c1a90::
	text "Toss out how many"
	line "@"
	text_from_ram wStringBuffer2
	text "(s)?"
	done

UnknownText_0x1c1aad::
	text "Throw away @"
	deciram wItemQuantityChangeBuffer, 1, 2
	text ""
	line "@"
	text_from_ram wStringBuffer2
	text "(s)?"
	done

UnknownText_0x1c1aca::
	text "Discarded"
	line "@"
	text_from_ram wStringBuffer1
	text "(s)."
	prompt

UnknownText_0x1c1adf::
	text "That's too impor-"
	line "tant to toss out!"
	prompt

UnknownText_0x1c1b03::
	text "This isn't the"
	line "time to use that!"
	done

UnknownText_0x1c1b2c::
	text "Took @"
	text_from_ram wMonOrItemNameBuffer
	text "'s"
	line "@"
	text_from_ram wStringBuffer1
	text " and"

	para "made it hold"
	line "@"
	text_from_ram wStringBuffer2
	text "."
	prompt

UnknownText_0x1c1b57::
	text "Made @"
	text_from_ram wMonOrItemNameBuffer
	text ""
	line "hold @"
	text_from_ram wStringBuffer2
	text "."
	prompt

UnknownText_0x1c1b6f::
	text "Please remove the"
	line "MAIL first."
	prompt

UnknownText_0x1c1b8e::
	text_from_ram wMonOrItemNameBuffer
	text " isn't"
	line "holding anything."
	prompt

UnknownText_0x1c1baa::
	text "Item storage space"
	line "full."
	prompt

UnknownText_0x1c1bc4::
	text "Took @"
	text_from_ram wStringBuffer1
	text ""
	line "from @"
	text_from_ram wMonOrItemNameBuffer
	text "."
	prompt

UnknownText_0x1c1bdc::
	text_from_ram wMonOrItemNameBuffer
	text " is"
	line "already holding"

	para "@"
	text_from_ram wStringBuffer1
	text ".<WAIT_S>"
	line "Switch items?"
	done

UnknownText_0x1c1c09::
	text "That item can't be"
	line "held."
	prompt

UnknownText_0x1c1c22::
	text "The MAIL will lose"
	line "its message. OK?"
	done

UnknownText_0x1c1c47::
	text "MAIL detached from"
	line "@"
	text_from_ram wStringBuffer1
	text "."
	prompt

UnknownText_0x1c1c62::
	text "There's no space"
	line "for removing MAIL."
	prompt

UnknownText_0x1c1c86::
	text "Send the removed"
	line "MAIL to your PC?"
	done

UnknownText_0x1c1ca9::
	text "Your PC's MAILBOX"
	line "is full."
	prompt

UnknownText_0x1c1cc4::
	text "The MAIL was sent"
	line "to your PC."
	prompt

UnknownText_0x1c1ce3::
	text "Not enough HP!"
	prompt

UnknownText_0x1c1cf3::
	text "An item in your"
	line "BAG may be"

	para "registered for use"
	line "on SELECT BUTTON."
	done

_InitialOptionsText::
	text "Please choose how"
	line "you want to play"
	cont "Polished Crystal."
	prompt

_SpruceText1::
	text "Hello!"

	para "Welcome to the"
	line "world of #MON!"

	para "My name is"
	line "SPRUCE, but most"
	
	para "people just call"
	line "me the #MON"
	cont "PROFESSOR!"
	prompt

_SpruceText2::
	text "#MON are magni-"
	line "ficent creatures."
	
	para "Some #MON like"
	line "battling, and"
	
	para "others prefer to"
	line "be companions, "
	
	para "like my friend,"
	line "MUNCHLAX, here.@"

_SpruceText3::
	text_waitbutton
	db "@@"

_SpruceText4::
	text "But we must be"
	line "cautious about how"
	cont "we treat #MON."

	para "That's where my"
	line "research comes in."
	prompt

_SpruceText5::
	text "I study #MON"
	line "training and how"
	cont "it relates to the"
	cont "the expansion of"
	cont "civilization."
	
	para "These days though,"
	line "I mostly focus on"
	cont "running a #MON"
	cont "reserve at my LAB."
	
	para "But that's just"
	line "me."
	
	para "You have your own"
	line "#MON story to"
	cont "discover!"
	prompt
	
_NoBikeText::
	text "The floor is too"
	line "bumpy!"

	para "You can't bike"
	line "here."
	done

UnknownText_ReminderNotCompatible::
	text "It can't remember"
	line "anything…"
	prompt