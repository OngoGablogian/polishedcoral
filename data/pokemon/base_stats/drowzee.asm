	db  60,  48,  45,  42,  43,  90
	;   hp  atk  def  spd  sat  sdf

	db PSYCHIC, PSYCHIC
	db 190 ; catch rate
	db 102 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	dn 6, 6 ; frontpic dimensions
	db INSOMNIA ; ability 1
	db FOREWARN ; ability 2
	db INNER_FOCUS ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn HUMANSHAPE, HUMANSHAPE ; egg groups

	; ev_yield
	ev_yield   0,   0,   0,   0,   0,   1
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm CURSE, SUNNY_DAY, LIGHT_SCREEN, PROTECT, RAIN_DANCE, SAFEGUARD, FAKE_OUT, SUBSTITUTE, THUNDERPUNCH, FIRE_PUNCH, ICE_PUNCH, SAND_ATTACK_SMOKESCREEN_FLASH, TAUNT, DESTINY_BOND, ZAP_CANNON, BRICK_BREAK, DAZZLINGLEAM, SHADOW_BALL, CALM_MIND
	; end
