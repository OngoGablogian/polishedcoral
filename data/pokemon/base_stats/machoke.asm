	db  80, 100,  70,  45,  50,  60
	;   hp  atk  def  spd  sat  sdf

	db FIGHTING, FIGHTING
	db 90 ; catch rate
	db 146 ; base exp
	db NO_ITEM ; item 1
	db FOCUS_BAND ; item 2
	dn FEMALE_25, 3 ; gender, step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db GUTS ; ability 1
	db NO_GUARD ; ability 2
	db STEADFAST ; hidden ability
	db MEDIUM_SLOW ; growth rate
	dn HUMANSHAPE, HUMANSHAPE ; egg groups

	; ev_yield
	ev_yield   0,   2,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm STRENGTH, ROCK_SMASH, ICE_PUNCH, FIRE_PUNCH, THUNDERPUNCH, RAIN_DANCE, DIG, CURSE, SUNNY_DAY, WORK_UP_GROWTH, ROCK_CLIMB, BULLDOZE, SUBSTITUTE, PROTECT, FIRE_BLAST, BULK_UP, BRICK_BREAK, EARTHQUAKE
	; end
