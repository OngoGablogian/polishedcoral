MACRO spawn
; map, y, x
	map_id \1
	db \2, \3
ENDM

SpawnPoints: ; 0x152ab
	spawn PLAYER_HOUSE_2F,              4,  3
	spawn SUNSET_BAY,                  25, 10
	spawn DAYBREAK_VILLAGE,            13,  8
	spawn GLINT_CITY,                  27, 16
	spawn STARGLOW_VALLEY,			   17, 18
	spawn LAKE_ONWA,				   19, 18
	spawn SUNBEAM_ISLAND,			   17, 36
	spawn EVENTIDE_VILLAGE,			   13, 18
	spawn FLICKER_STATION,			   11, 30
	spawn TWINKLE_TOWN,				   11, 48
	spawn LUSTER_CITY_RESIDENTIAL,	   17, 26
	spawn SHIMMER_CITY,                37, 18
	spawn BRILLO_TOWN,				   22, 14
	spawn RADIANT_TOWNSHIP,             7,  8
	spawn DUSK_TURNPIKE,			   23, 32
	spawn CROSSROADS,      		       30,  8
	spawn KOMORE_VILLAGE, 			   31,  6
	spawn BRIGHTBURG,	 			   19, 10
	spawn OBSCURA_CITY,	 			   21, 40
	
	spawn STARGLOW_CAVERN_DEPTHS,	   16, 15
	spawn FAKE_ROUTE_1,   		       20, 29
	
	spawn N_A,                        -1, -1 ; SPAWN_LASTFLYPOINT
	spawn N_A,                        -1, -1 ; SPAWN_KANTO
