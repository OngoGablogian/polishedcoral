	db  85,  80,  70,  90, 135,  75
	;   hp  atk  def  spd  sat  sdf

	db NORMAL, NORMAL
	db 30 ; catch rate
	db 185 ; base exp
	db NO_ITEM ; item 1
	db DUBIOUS_DISC ; item 2
	dn GENDERLESS, 3 ; gender, step cycles to hatch
	dn 6, 6 ; frontpic dimensions
	db ADAPTABILITY ; ability 1
	db DOWNLOAD ; ability 2
	db ANALYTIC ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn INANIMATE, INANIMATE ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   0,   3,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm FAKE_OUT, RAIN_DANCE, CURSE, SUNNY_DAY, SUBSTITUTE, PROTECT, HYPER_BEAM, GIGA_IMPACT, THUNDER, BLIZZARD, SOLAR_BEAM, SAND_ATTACK_SMOKESCREEN_FLASH, ZAP_CANNON, SHADOW_BALL
	; end
