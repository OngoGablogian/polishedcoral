	db  55,  45,  45,  15,  25,  25
	;   hp  atk  def  spd  sat  sdf

	db POISON, GROUND
	db 255 ; catch rate
	db 52 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	dn 5, 5 ; frontpic dimensions
	db POISON_POINT ; ability 1
	db WATER_ABSORB ; ability 2
	db UNAWARE ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn AMPHIBIAN, FIELD ; egg groups

	; ev_yield
	ev_yield   1,   0,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm ROCK_SMASH, RAIN_DANCE, DIG, CURSE, BULLDOZE, ROCK_CLIMB, SURF, SAFEGUARD, SUBSTITUTE, PROTECT, SAND_ATTACK_SMOKESCREEN_FLASH, VENOSHOCK, ANCIENTPOWER, SANDSTORM, EARTHQUAKE
	; end
