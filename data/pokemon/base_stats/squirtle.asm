	db  44,  48,  65,  43,  50,  64
	;   hp  atk  def  spd  sat  sdf

	db WATER, WATER
	db 45 ; catch rate
	db 66 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_12_5, 3 ; gender, step cycles to hatch
	dn 5, 5 ; frontpic dimensions
	db TORRENT ; ability 1
	db TORRENT ; ability 2
	db RAIN_DISH ; hidden ability
	db MEDIUM_SLOW ; growth rate
	dn MONSTER, AMPHIBIAN ; egg groups

	; ev_yield
	ev_yield   0,   0,   1,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm ROCK_SMASH, FAKE_OUT, CUT, FALSE_SWIPE, RAIN_DANCE, HAIL, DIG, CURSE
	; end
