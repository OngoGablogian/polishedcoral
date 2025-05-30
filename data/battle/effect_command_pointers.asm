macro command
	enum \1_command
def \1 equs "db \1_command"
	dw BattleCommand_\1
endm

macro commandonly
	enum \1_command
def \1 equs "db \1_command"
endm

	enum_start 1

BattleCommandPointers:
	command checkturn               ; 01
	command checkobedience          ; 02
	command usedmovetext            ; 03
	command doturn                  ; 04
	command critical                ; 05
	command damagestats             ; 06
	command stab                    ; 07
	command damagevariation         ; 08
	command checkhit                ; 09
	command lowersub                ; 0a
	command hittargetnosub          ; 0b
	command raisesub                ; 0c
	command failuretext             ; 0d
	command checkfaint              ; 0e
	command criticaltext            ; 0f
	command supereffectivetext      ; 10
	command postfainteffects        ; 11
	command posthiteffects          ; 12
	command poisontarget            ; 13
	command sleeptarget             ; 14
	command draintarget             ; 15
	command eatdream                ; 16
	command burntarget              ; 17
	command freezetarget            ; 18
	command paralyzetarget          ; 19
	command selfdestruct            ; 1a
	command statup                  ; 1b
	command statdown                ; 1c
	command payday                  ; 1d
	command conversion              ; 1e
	command resetstats              ; 1f
	command forceswitch             ; 20
	command endloop                 ; 21
	command flinchtarget            ; 22
	command recoil                  ; 23
	command focusenergy             ; 24
	command confuse                 ; 25
	command confusetarget           ; 26
	command heal                    ; 27
	command transform               ; 28
	command screen                  ; 29
	command poison                  ; 2a
	command paralyze                ; 2b
	command substitute              ; 2c
	command rechargenextturn        ; 2d
	command metronome               ; 2e
	command leechseed               ; 2f
	command resetfoestats           ; 30
	command disable                 ; 31
	command cleartext               ; 32
	command charge                  ; 33
	command checkcharge             ; 34
	command traptarget              ; 35
	command growth                  ; 36
	command rampage                 ; 37
	command checkrampage            ; 38
	command constantdamage          ; 39
	command psychup                 ; 3a
	command encore                  ; 3b
	command furycutter              ; 3c
	command sketch                  ; 3d
	command snore	                ; 3e
	command destinybond             ; 3f
	command falseswipe              ; 40
	command healbell                ; 41
	command pressure                ; 42
	command kickcounter             ; 44
	command thief                   ; 45
	command arenatrap               ; 46
	command defrost                 ; 47
	command curse                   ; 48
	command protect                 ; 49
	command spikes                  ; 4a
	command foresight               ; 4b
	command perishsong              ; 4c
	command startsandstorm          ; 4d
	command starthail               ; 4e
	command endure                  ; 4f
	command checkcurl               ; 50
	command rolloutpower            ; 51
	command bulkup                  ; 52
	command conditionalboost        ; 53
	command attract                 ; 54
	command happinesspower          ; 55
	command damagecalc              ; 56
	command safeguard               ; 57
	command checksafeguard          ; 58
	command getmagnitude            ; 59
	command batonpass               ; 5a
	command pursuit                 ; 5b
	command clearhazards            ; 5c
	command healweather             ; 5d
	command hiddenpower             ; 5e
	command startrain               ; 5f
	command startsun                ; 60
	command attackup                ; 61
	command defenseup               ; 62
	command speedup                 ; 63
	command specialattackup         ; 64
	command specialdefenseup        ; 65
	command accuracyup              ; 66
	command evasionup               ; 67
	command attackup2               ; 68
	command defenseup2              ; 69
	command speedup2                ; 6a
	command specialattackup2        ; 6b
	command specialdefenseup2       ; 6c
	command accuracyup2             ; 6d
	command evasionup2              ; 6e
	command attackdown              ; 6f
	command defensedown             ; 70
	command speeddown               ; 71
	command specialattackdown       ; 72
	command specialdefensedown      ; 73
	command accuracydown            ; 74
	command evasiondown             ; 75
	command attackdown2             ; 76
	command defensedown2            ; 77
	command speeddown2              ; 78
	command specialattackdown2      ; 79
	command specialdefensedown2     ; 7a
	command accuracydown2           ; 7b
	command evasiondown2            ; 7c
	command statupmessage           ; 7d
	command statdownmessage         ; 7e
	command statupfailtext          ; 7f
	command statdownfailtext        ; 80
	command effectchance            ; 81
	command statdownanim            ; 82
	command statupanim              ; 83
	command switchturn              ; 84
	command bellydrum               ; 85
	command rage                    ; 86
	command doubleflyingdamage      ; 87
	command doubleundergrounddamage ; 88
	command mirrorcoat              ; 89
	command checkfuturesight        ; 8a
	command futuresight             ; 8b
	command doubleminimizedamage    ; 8c
	command skipsuncharge           ; 8d
	command thunderaccuracy         ; 8e
	command teleport                ; 8f
	command switchout               ; 90
	command ragedamage              ; 91
	command resettypematchup        ; 92
	command allstatsup              ; 93
	command calmmind                ; 94
	command raisesubnoanim          ; 95
	command lowersubnoanim          ; 96
	command dragondance             ; 97
	command clearmissdamage         ; 99
	command movedelay               ; 9a
	command hittarget               ; 9b
	command tristatuschance         ; 9c
	command supereffectivelooptext  ; 9d
	command startloop               ; 9e
	command curl                    ; 9f
	command burn                    ; a0
	command bounceback              ; a1
	command pickpocket              ; a2
	command suckerpunch             ; a3
	command roost                   ; a5
	command superpower              ; a6
	command cottonguard             ; a7
	command trick                   ; a8
	command knockoff                ; a9
	command toxic                   ; aa
	command gyroball                ; ab
	command checkpowder             ; ac
	command brickbreak              ; ad
	command toxicspikes             ; ae
	command fakeout					; af - coral
	command lockon					; b0 - coral
	command burnflinchtarget		; b1 - coral
	command freezeflinchtarget		; b2 - coral
	command paralyzeflinchtarget	; b3 - coral
	command shellsmash				; b4 - coral
	command quiverdance				; b5 - coral
	command mirrormove				; b6 - coral
	command toxictarget				; b7 - coral
	command mimic					; b8 - coral
	command electroball				; b9 - coral
	command lowkick
	command cosmicpower
	command wish
	command taunt
	command conversion2
	command doubleunderwaterdamage
	

	enum_start -1, -1
	commandonly endmove
	commandonly endturn
