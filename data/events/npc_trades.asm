NPCTrades:
; OT names have 3 characters less padding so the total struct is 32 bytes
; TRADE_WITH_JAKE_FOR_HERACROSS in Route 5 Gate
	db 0, SCYTHER,       HERACROSS,     "HERC@@@@@@@"
	db $DD, $DD, $DD, ABILITY_2 | ADAMANT, MALE,   POKE_BALL,   SITRUS_BERRY
	dw 64582
	db "JAKE@@@@", $00
; TRADE_WITH_PAUL_FOR_PONYTA on Sunbeam Island
	db 1, SLOWPOKE,       PONYTA,     "SLOW RIDE@@"
	db $DD, $DD, $DD, HIDDEN_ABILITY | HASTY, MALE,   POKE_BALL,   RAWST_BERRY
	dw 15832
	db "PAULIE@@", $00
; TRADE_WITH_ALICE_FOR_GLIGAR in Twinkle Town
	db 2, SNEASEL,       GLIGAR,     "ROBIN@@@@@@"
	db $DD, $DD, $DD, ABILITY_1 | ADAMANT, FEMALE,   POKE_BALL,   RAZOR_CLAW
	dw 25145
	db "ALICE@@@", $00
; TRADE_WITH_EMY_FOR_SCRAGGY in Luster City Residential
	db 3, CROAGUNK,       SCRAGGY,   "SHAGGY@@@@@"
	db $DD, $DD, $DD, ABILITY_2 | JOLLY, MALE,   POKE_BALL,   SHED_SHELL
	dw 37351
	db "EMY@@@@@", $00
; TRADE_WITH_TABBY_FOR_HOUNDOUR in Luster City Business
	db 4, MEOWTH,     HOUNDOUR,  "MITTENS@@@@"
	db $DD, $DD, $DD, HIDDEN_ABILITY | BRAVE,   FEMALE,   POKE_BALL,    DESTINY_KNOT
	dw 12817
	db "TABBY@@@", $00
; TRADE_WITH_CARRIE_FOR_MARACTUS in Brillo Town
	db 5, CACNEA,  MARACTUS,    "SAMBA@@@@@@"
	db $DD, $DD, $DD, HIDDEN_ABILITY | MODEST,    FEMALE, POKE_BALL,    LUM_BERRY
	dw 43876
	db "CARRIE@@", $00
; TRADE_WITH_MARTY_FOR_MIENFOO in Komore Village
	db 6, GIRAFARIG,  MIENFOO,     "KURIRIN@@@@"
	db $DD, $DD, $DD, ABILITY_2 | LONELY, MALE, POKE_BALL,    BLACK_BELT
	dw 50082
	db "MARTY@@@", $00
; TRADE_WITH_BEV_FOR_VOLTORB in Radiant Town
	db 7, SUNKERN, VOLTORB,      "BOOMER@@@@@"
	db $DD, $DD, $DD, HIDDEN_ABILITY | LAX,   MALE,   POKE_BALL,    MACHO_BRACE
	dw 63426
	db "BEV@@@@@", $00
