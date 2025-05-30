_InitializeStartDay: ; 113d6
	jp InitializeStartDay
; 113da

ClearDailyTimers: ; 113da
	xor a
	ld [wLuckyNumberDayBuffer], a
	ld [wDailyResetTimer], a
	ret
; 113e5

InitCallReceiveDelay:: ; 113e5
	xor a
	ld [wTimeCyclesSinceLastCall], a

NextCallReceiveDelay: ; 113e9
	ld a, [wTimeCyclesSinceLastCall]
	cp 3
	jr c, .okay
	ld a, 3

.okay
	ld e, a
	ld d, 0
	ld hl, .ReceiveCallDelays
	add hl, de
	ld a, [hl]
	jp RestartReceiveCallDelay
; 113fd

.ReceiveCallDelays:
if DEF(NO_RTC)
	db 20 * NO_RTC_SPEEDUP, 10 * NO_RTC_SPEEDUP, 5 * NO_RTC_SPEEDUP, 3 * NO_RTC_SPEEDUP
else
	db 20, 10, 5, 3
endc
; 11401

CheckReceiveCallTimer: ; 11401
	call CheckReceiveCallDelay ; check timer
	ret nc
	ld hl, wTimeCyclesSinceLastCall
	ld a, [hl]
	cp 3
	jr nc, .ok
	inc [hl]

.ok
	call NextCallReceiveDelay ; restart timer
	scf
	ret
; 11413

InitOneDayCountdown: ; 11413
	ld a, 1

InitNDaysCountdown: ; 11415
	ld [hl], a
	push hl
	call UpdateTime
	pop hl
	inc hl
	jp CopyDayToHL
; 11420

CheckDayDependentEventHL: ; 11420
	inc hl
	push hl
	call CalcDaysSince
	call GetDaysSince
	pop hl
	dec hl
	jp UpdateTimeRemaining
; 1142e

RestartReceiveCallDelay: ; 1142e
	ld hl, wReceiveCallDelay_MinsRemaining
	ld [hl], a
	call UpdateTime
	ld hl, wReceiveCallDelay_StartTime
	jp CopyDayHourMinToHL
; 1143c

CheckReceiveCallDelay:
	ld hl, wReceiveCallDelay_StartTime
	call CalcMinsHoursDaysSince
	call GetMinutesSinceIfLessThan60

	; Double effective time if lead mon has Lightning Rod, which boosts call rate
	push bc
	ld b, a
	call GetLeadAbility
	cp LIGHTNING_ROD
	ld a, b
	pop bc
	jr nz, .ok
	add a
	jr nc, .ok
	ld a, -1
.ok
	ld hl, wReceiveCallDelay_MinsRemaining
	jp UpdateTimeRemaining

RestartDailyResetTimer:
	ld hl, wDailyResetTimer
	jp InitOneDayCountdown

CheckDailyResetTimer:: ; 11452
	ld hl, wDailyResetTimer
	call CheckDayDependentEventHL
	ret nc
	call ResetDailyEventFlags
	ld a, [wDailyFlags2]
	ld [wSlots], a
	xor a
	ld hl, wDailyFlags
	ld [hli], a ; wDailyFlags
	ld [hli], a ; wDailyFlags2
	ld [hli], a ; wDailyFlags3
	ld [hli], a ; wWeeklyFlags
	ld [hli], a ; wWeeklyFlags2
	ld [hl], a ; wSwarmFlags
	ld hl, wDailyRematchFlags
rept 4
	ld [hli], a
endr
	ld hl, wDailyPhoneItemFlags
rept 4
	ld [hli], a
endr
	ld hl, wDailyPhoneTimeOfDayFlags
rept 4
	ld [hli], a
endr
	ld hl, wSlots
	bit 7, [hl] ; ENGINE_WINDY_DAY
	jr z, .notset
	ld hl, wDailyFlags2
	res 7, [hl] ; ENGINE_WINDY_DAY
	jr .finish
.notset
	ld hl, wDailyFlags2
	set 7, [hl] ; ENGINE_WINDY_DAY
.finish
	jr RestartDailyResetTimer
; 11485

ResetDailyEventFlags:
	eventflagreset EVENT_ROUTE_24_MUSHROOM_1
	eventflagreset EVENT_ROUTE_24_MUSHROOM_2
	eventflagreset EVENT_ROUTE_24_MUSHROOM_3
	eventflagreset EVENT_ROUTE_24_MUSHROOM_4
	eventflagreset EVENT_ROUTE_24_BRELOOM
	eventflagreset EVENT_ROUTE_22_TRASHCAN
	eventflagreset EVENT_BACK_ALLEY_TRASHCAN_1
	eventflagreset EVENT_BACK_ALLEY_TRASHCAN_2
	eventflagreset EVENT_BACK_ALLEY_TRASHCAN_3
	eventflagreset EVENT_LUSTER_TRASHCAN_1
	eventflagreset EVENT_LUSTER_TRASHCAN_2
	eventflagreset EVENT_LUSTER_TRASHCAN_3
	eventflagreset EVENT_LUSTER_TRASHCAN_4
	eventflagreset EVENT_LUSTER_TRASHCAN_5
	eventflagreset EVENT_LUSTER_TRASHCAN_6
	eventflagreset EVENT_LUSTER_TRASHCAN_7
	eventflagreset EVENT_LEILANI_CANDY
	eventflagreset EVENT_BOUGHT_MOO_MOO_MILK_TODAY
	eventflagreset EVENT_ROCK_CANDY_SOLD_OUT
	ret

Special_SampleKenjiBreakCountdown: ; 11485
; Generate a random number between 3 and 6
	call Random
	and 3
	add 3
	ld [wKenjiBreakTimer], a
	ret
; 11490

StartBugContestTimer: ; 11490
if DEF(NO_RTC)
	ld a, 20 * NO_RTC_SPEEDUP
else
	ld a, 20
endc
	ld [wBugContestMinsRemaining], a
	xor a
	ld [wBugContestSecsRemaining], a
	call UpdateTime
	ld hl, wBugContestStartTime
	jp CopyDayHourMinSecToHL
; 114a4

StartRanchRaceTimer: ; 11490
	ld a, 0
	ld [wBugContestMinsRemaining], a
	ld a, 60
	ld [wBugContestSecsRemaining], a
	call UpdateTime
	ld hl, wBugContestStartTime
	call CopyDayHourMinSecToHL
	ret
	
StartTempleTimer::
	ld [wBugContestSecsRemaining], a
	xor a
	ld [wBugContestMinsRemaining], a
	call UpdateTime
	ld hl, wBugContestStartTime
	jp CopyDayHourMinSecToHL

CheckBugContestTimer:: ; 114a4 (4:54a4)
	ld hl, wBugContestStartTime
	call CalcSecsMinsHoursDaysSince
	ld a, [wDaysSince]
	and a
	jr nz, .timed_out
	ld a, [wHoursSince]
	and a
	jr nz, .timed_out
	ld a, [wSecondsSince]
	ld b, a
	ld a, [wBugContestSecsRemaining]
	sub b
	jr nc, .okay
	add 60

.okay
	ld [wBugContestSecsRemaining], a
	ld a, [wMinutesSince]
	ld b, a
	ld a, [wBugContestMinsRemaining]
	sbc b
	ld [wBugContestMinsRemaining], a
	jr c, .timed_out
	and a
	ret

.timed_out
	xor a
	ld [wBugContestMinsRemaining], a
	ld [wBugContestSecsRemaining], a
	scf
	ret


InitializeStartDay: ; 114dd
	call UpdateTime
	ld hl, wTimerStartDay
	jp CopyDayToHL
; 114e7

CheckPokerusTick:: ; 114e7
	ld hl, wTimerStartDay
	call CalcDaysSince
	call GetDaysSince
	and a
	jr z, .done ; not even a day has passed since game start
	ld b, a
	farcall ApplyPokerusTick
.done
	xor a
	ret
; 114fc

RestartLuckyNumberCountdown: ; 1152b
	call .GetDaysUntilNextFriday
	ld hl, wLuckyNumberDayBuffer
	jp InitNDaysCountdown
; 11534

.GetDaysUntilNextFriday: ; 11534
	call GetWeekday
	ld c, a
	ld a, FRIDAY
	sub c
	jr z, .friday_saturday
	ret nc

.friday_saturday
	add 7
	ret
; 11542

CheckLuckyNumberShowFlag: ; 11542
	ld hl, wLuckyNumberDayBuffer
	jp CheckDayDependentEventHL
; 11548

UpdateTimeRemaining: ; 11586
; If the amount of time elapsed exceeds the capacity of its
; unit, skip this part.
	cp -1
	jr z, .set_carry
	ld c, a
	ld a, [hl] ; time remaining
	sub c
	jr nc, .ok
	xor a

.ok
	ld [hl], a
	jr z, .set_carry
	xor a
	ret

.set_carry
	xor a
	ld [hl], a
	scf
	ret
; 11599

GetMinutesSinceIfLessThan60: ; 115ae
	ld a, [wDaysSince]
	and a
	jr nz, GetTimeElapsed_ExceedsUnitLimit
	ld a, [wHoursSince]
	and a
	jr nz, GetTimeElapsed_ExceedsUnitLimit
	ld a, [wMinutesSince]
	ret
; 115be

GetDaysSince: ; 115c8
	ld a, [wDaysSince]
	ret
; 115cc

GetTimeElapsed_ExceedsUnitLimit: ; 115cc
	ld a, -1
	ret
; 115cf

CalcDaysSince: ; 115cf
	xor a
	jr _CalcDaysSince
; 115d2

CalcHoursDaysSince: ; 115d2
	inc hl
	xor a
	jr _CalcHoursDaysSince
; 115d6

CalcMinsHoursDaysSince: ; 115d6
	inc hl
	inc hl
	xor a
	jr _CalcMinsHoursDaysSince
; 115db

CalcSecsMinsHoursDaysSince: ; 115db
	inc hl
	inc hl
	inc hl
	ldh a, [hSeconds]
	ld c, a
	sub [hl]
	jr nc, .skip
	add 60
.skip
	ld [hl], c ; current seconds
	dec hl
	ld [wSecondsSince], a ; seconds since

_CalcMinsHoursDaysSince: ; 115eb
	ldh a, [hMinutes]
	ld c, a
	sbc [hl]
	jr nc, .skip
	add 60
.skip
	ld [hl], c ; current minutes
	dec hl
	ld [wMinutesSince], a ; minutes since

_CalcHoursDaysSince: ; 115f8
	ldh a, [hHours]
	ld c, a
	sbc [hl]
	jr nc, .skip
	add 24
.skip
	ld [hl], c ; current hours
	dec hl
	ld [wHoursSince], a ; hours since

_CalcDaysSince:
	ld a, [wCurDay]
	ld c, a
	sbc [hl]
	jr nc, .skip
	add 20 * 7
.skip
	ld [hl], c ; current days
	ld [wDaysSince], a ; days since
	ret
; 11613

CopyDayHourMinSecToHL: ; 11613
	ld a, [wCurDay]
	ld [hli], a
	ldh a, [hHours]
	ld [hli], a
	ldh a, [hMinutes]
	ld [hli], a
	ldh a, [hSeconds]
	ld [hli], a
	ret
; 11621

CopyDayToHL: ; 11621
	ld a, [wCurDay]
	ld [hl], a
	ret
; 11626

CopyDayHourMinToHL: ; 1162e
	ld a, [wCurDay]
	ld [hli], a
	ldh a, [hHours]
	ld [hli], a
	ldh a, [hMinutes]
	ld [hli], a
	ret
; 11639
