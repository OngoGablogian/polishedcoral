	db  90,  92,  75,  60,  92,  85
	;   hp  atk  def  spd  sat  sdf

	db GRASS, ICE
	db 60 ; catch rate
	db 214 ; base exp
	db NEVERMELTICE ; item 1
	db NEVERMELTICE ; item 2
	dn FEMALE_50, 3 ; gender, step cycles to hatch
	dn 5, 5 ; frontpic dimensions
	db SNOW_WARNING ; ability 1
	db SNOW_WARNING ; ability 2
	db SNOW_WARNING ; hidden ability
	db SLOW ; growth rate
	dn MONSTER, PLANT ; egg groups

	; ev_yield
	ev_yield   0,   1,   0,   0,   1,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm
	; end