KomoreHouse1_MapScriptHeader:
	db 0 ; scene scripts

	db 0 ; callbacks

	db 2 ; warp events
	warp_event  2,  7, KOMORE_VILLAGE, 3
	warp_event  3,  7, KOMORE_VILLAGE, 3

	db 0 ; coord events

	db 0 ; bg events

	db 1 ; object events
	object_event  5,  3, -1, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, (1 << 3) | PAL_OW_GREEN, PERSONTYPE_COMMAND, trade, TRADE_WITH_MARTY_FOR_MIENFOO, -1
	
