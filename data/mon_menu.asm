MonMenuOptionStrings: ; 24caf
	db "STATS@"
	db "SWITCH@"
	db "ITEM@"
	db "CANCEL@"
	db "MOVES@"
	db "MAIL@"
	db "Error!@"
	db "FLY@"
	db "ROCK SMASH@"
	db "CUT@"
	db "TEST@"
; 24cd9

MonMenuOptions: ; 24cd9
; Moves
;	db MONMENU_FIELD_MOVE, MONMENU_CUT,        CUT
;	db MONMENU_FIELD_MOVE, MONMENU_FLY,        FLY
;	db MONMENU_FIELD_MOVE, MONMENU_SURF,       SURF
;	db MONMENU_FIELD_MOVE, MONMENU_STRENGTH,   STRENGTH
	db MONMENU_FIELD_MOVE, MONMENU_FLASH,      FLASH
;	db MONMENU_FIELD_MOVE, MONMENU_WATERFALL,  WATERFALL
;	db MONMENU_FIELD_MOVE, MONMENU_WHIRLPOOL,  WHIRLPOOL
	db MONMENU_FIELD_MOVE, MONMENU_DIG,        DIG
	db MONMENU_FIELD_MOVE, MONMENU_TELEPORT,   TELEPORT
	db MONMENU_FIELD_MOVE, MONMENU_HEADBUTT,   HEADBUTT
	db MONMENU_FIELD_MOVE2, MONMENU_SOFTBOILED, SOFTBOILED_MILK_DRINK_RECOVER
;	db MONMENU_FIELD_MOVE, MONMENU_ROCKSMASH,  ROCK_SMASH
;	db MONMENU_FIELD_MOVE, MONMENU_MILKDRINK,  MILK_DRINK
; Options
	db MONMENU_MENUOPTION, MONMENU_STATS,      1 ; STATS
	db MONMENU_MENUOPTION, MONMENU_SWITCH,     2 ; SWITCH
	db MONMENU_MENUOPTION, MONMENU_ITEM,       3 ; ITEM
	db MONMENU_MENUOPTION, MONMENU_CANCEL,     4 ; CANCEL
	db MONMENU_MENUOPTION, MONMENU_MOVE,       5 ; MOVE
	db MONMENU_MENUOPTION, MONMENU_MAIL,       6 ; MAIL
	db MONMENU_MENUOPTION, MONMENU_ERROR,      7 ; ERROR!
	db MONMENU_MENUOPTION, MONMENU_FLY,        8 ; FLY
	db MONMENU_MENUOPTION, MONMENU_ROCKSMASH,  9 ; ROCK_SMASH
	db MONMENU_MENUOPTION, MONMENU_CUT,       10 ; CUT
	
	db -1
; 24d19
