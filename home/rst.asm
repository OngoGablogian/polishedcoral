; rst vectors

SECTION "rst0", ROM0
	di
	jp Start

DisappearUser::
	farjp _DisappearUser

SECTION "rst8", ROM0
	jp RstFarCall

IsAPokemon::
; Return carry if species a is not a Pokemon.
; Since every ID other than $0 and $ff is valid, we can simplify this function.
	inc a
	cp $2 ; sets carry for $0 (inc'ed to $1) and $ff (inc'ed to $0)
	dec a
	ret

SECTION "rst10", ROM0
	ldh [hROMBank], a
	ld [MBC3RomBank], a
	ret

_de_::
	push de
	ret

SECTION "rst18", ROM0
	jp _AddNTimes

FarCopyColorWRAM::
	ld a, BANK("GBC Video")
	; fallthrough

FarCopyWRAM::
	call StackCallInWRAMBankA

SECTION "rst20", ROM0
	jp _CopyBytes

BattleRandom::
; Handles all RNG calls in the battle engine, allowing
; link battles to remain in sync using a shared PRNG.
	farjp _BattleRandom

_hl_::
	jp hl

SECTION "rst28", ROM0
	jp _Jumptable

DoItemEffect::
	farjp _DoItemEffect

SECTION "rst30", ROM0
	jp _Predef

PushWindow::
	farjp _PushWindow

SECTION "rst38", ROM0
	db $fc

ExitMenu::
	push af
	farcall _ExitMenu
	pop af
	ret
