	db  85,  90,  80, 130,  70,  80
	;   hp  atk  def  spd  sat  sdf

	db POISON, FLYING
	db 90 ; catch rate
	db 204 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 2 ; gender, step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db INNER_FOCUS ; ability 1
	db INNER_FOCUS ; ability 2
	db INFILTRATOR ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn AVIAN, AVIAN ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   3,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm FAKE_OUT, RAIN_DANCE, ROOST, FLY, CURSE, SUNNY_DAY, STEEL_WING, SUBSTITUTE, PROTECT, HYPER_BEAM, GIGA_IMPACT, VENOSHOCK, TAUNT, GIGA_DRAIN, ACROBATICS, SHADOW_BALL, RAPID_SPIN
	; end
