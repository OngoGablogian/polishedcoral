	db  75, 140,  65, 110, 112,  65
	;   hp  atk  def  spd  sat  sdf

	db ROCK, FLYING
	db 45 ; catch rate
	db 177 ; base exp
	db NO_ITEM ; item 1
	db NO_ITEM ; item 2
	dn FEMALE_12_5, 3 ; gender, step cycles to hatch
	dn 7, 7 ; frontpic dimensions
	db DEFEATIST ;DEFEATIST ; ability 1
	db DEFEATIST ;DEFEATIST ; ability 2
	db DEFEATIST ;DEFEATIST ; hidden ability
	db MEDIUM_FAST ; growth rate
	dn AVIAN, INVERTEBRATE ; egg groups

	; ev_yield
	ev_yield   0,   2,   0,   0,   0,   0
	;         hp, atk, def, spd, sat, sdf

	; tmhm
	tmhm ROCK_SMASH, METAL_CLAW, FAKE_OUT, CHARM, ROOST, DIG, CURSE, ROCK_CLIMB, STEEL_WING, BULLDOZE, SUBSTITUTE, PROTECT, HYPER_BEAM, GIGA_IMPACT, TAUNT, ANCIENTPOWER, SANDSTORM, EARTHQUAKE, RAPID_SPIN, DRAGON_CLAW, CUT, FLY
	; end
