; Syntactic sugar macros

MACRO lb ; r, hi, lo
	ld \1, ((\2) & $ff) << 8 | ((\3) & $ff)
ENDM

MACRO ln ; r, hi, lo
	ld \1, ((\2) & $f) << 4 | ((\3) & $f)
ENDM

MACRO ldpixel
if _NARG >= 5
	lb \1, \2 * 8 + \4, \3 * 8 + \5
else
	lb \1, \2 * 8, \3 * 8
endc
ENDM

DEF depixel EQUS "ldpixel de,"
DEF bcpixel EQUS "ldpixel bc,"


; Design patterns

MACRO jumptable
	ld a, [\2]
	ld e, a
	ld d, 0
	ld hl, \1
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl
ENDM

DEF eventflagset   EQUS "flagset wEventFlags,"
DEF eventflagreset EQUS "flagreset wEventFlags,"
DEF eventflagcheck EQUS "flagcheck wEventFlags,"

MACRO flagset
	ld hl, \1 + (\2 >> 3)
	set (\2 & $7), [hl]
ENDM

MACRO flagreset
	ld hl, \1 + (\2 >> 3)
	res (\2 & $7), [hl]
ENDM

MACRO flagcheck
	ld hl, \1 + (\2 >> 3)
	bit (\2 & $7), [hl]
ENDM

macro changebridgeblock
	; lb de, \1 + 4, \2 + 4
	; call GetBlockLocation
	ld hl, wOverworldMap + (\2 / 2 + 3) * (\4_WIDTH + 6) + \1 / 2 + 3
	; hard-coding the above calculation for efficiency
	ld [hl], \3
ENDM
