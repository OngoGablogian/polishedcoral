MACRO specialcall
; condition, contact, script
	dw \1
	db \2
	dba \3
ENDM

SpecialPhoneCallList:
; entries correspond to SPECIALCALL_* constants
	specialcall SpecialCallOnlyWhenOutside, PHONE_SPRUCE,  SprucePhoneScript    ; SPECIALCALL_POKERUS
	specialcall SpecialCallOnlyWhenOutside, PHONE_SPRUCE,  SprucePhoneScript    ; SPECIALCALL_COMETOISLAND
	specialcall SpecialCallWhereverYouAre, PHONE_MOM,	   MomPhoneScript       ; SPECIALCALL_MOMCOMEGETTRAINERCARD
	specialcall SpecialCallWhereverYouAre, PHONE_AUTO,	   AutoPhoneScript      ; SPECIALCALL_COMEGETUPGRADEDBIKE
	specialcall SpecialCallWhereverYouAre, PHONE_MOM,	   MomPhoneScript       ; SPECIALCALL_MOMCALLABOUTTEAMSNARE
	specialcall SpecialCallWhereverYouAre, PHONE_SPRUCE,   SprucePhoneScript    ; SPECIALCALL_SPRUCECALLABOUTBIRD
	specialcall SpecialCallOnlyWhenOutside, PHONE_SPRUCE,  SprucePhoneScript    ; SPECIALCALL_GAVEANCIENTBALL
