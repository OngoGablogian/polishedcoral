RunMapSetupScript:: ; 15363
	ldh a, [hMapEntryMethod]
	and $f
	dec a
	ld c, a
	ld b, 0
	ld hl, MapSetupScripts
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp ReadMapSetupScript
; 15377

INCLUDE "data/maps/setup_scripts.asm"


ReadMapSetupScript: ; 1541d
.loop
	ld a, [hli]
	cp -1
	ret z

	push hl

	ld c, a
	ld b, 0
	ld hl, MapSetupCommands
	add hl, bc
	add hl, bc
	add hl, bc

	; bank
	ld b, [hl]
	inc hl

	; address
	ld a, [hli]
	ld h, [hl]
	ld l, a

	; Bit 7 of the bank indicates a parameter.
	; This is left unused.
	bit 7, b
	jr z, .go

	pop de
	ld a, [de]
	ld c, a
	inc de
	push de

.go
	ld a, b
	and $7f
	call FarCall_hl

	pop hl
	jr .loop
; 15440

MapSetupCommands: ; 15440
	dba EnableLCD ; 00
	dba DisableLCD ; 01
	dba MapSetup_Sound_Off ; 02
	dba PlayMapMusic ; 03
	dba RestartMapMusic ; 04
	dba FadeToMapMusic ; 05
	dba RotatePalettesRightMapAndMusic ; 06
	dba EnterMapMusic ; 07
	dba ForceMapMusic ; 08
	dba FadeInMusic ; 09
	dba LoadBlockData ; 0a (callback 1)
	dba LoadNeighboringBlockData ; 0b
	dba SaveScreen ; 0c
	dba BufferScreen ; 0d
	dba LoadGraphics ; 0e
	dba LoadTilesetHeader ; 0f
	dba LoadMapTimeOfDay ; 10
	dba LoadMapPalettes ; 11
	dba LoadWildMonData ; 12
	dba RefreshMapSprites ; 13
	dba RunCallback_05_03 ; 14
	dba RunCallback_03 ; 15
	dba LoadObjectsRunCallback_02 ; 16
	dba LoadSpawnPoint ; 17
	dba EnterMapConnection ; 18
	dba LoadWarpData ; 19
	dba LoadMapAttributes ; 1a
	dba LoadMapAttributes_Continue  ; 1b
	dba ClearBGPalettes ; 1c
	dba FadeOutPalettes ; 1d
	dba FadeInPalettesSign ; 1e
	dba GetCoordOfUpperLeftCorner ; 1f
	dba RestoreFacingAfterWarp ; 20
	dba SpawnInFacingDown ; 21
	dba SpawnPlayer ; 22
	dba RefreshPlayerCoords ; 23
	dba DelayClearingOldSprites ; 24
	dba DelayLoadingNewSprites ; 25
	dba UpdateRoamMons ; 26
	dba JumpRoamMons ; 27
	dba FadeOldMapMusic ; 28
	dba ActivateMapAnims ; 29
	dba SuspendMapAnims ; 2a
	dba RetainOldPalettes ; 2b
	dba ReturnFromMapSetupScript ; 2c
	dba DecompressMetatiles ; 2d
	dba DeferredLoadGraphics ; 2e

ActivateMapAnims:: ; 154cf
	ld a, $1
	ldh [hMapAnims], a
	ret
; 154d3

SuspendMapAnims: ; 154d3
	xor a
	ldh [hMapAnims], a
	ret
; 154d7

LoadObjectsRunCallback_02: ; 154d7
	ld a, MAPCALLBACK_OBJECTS
	call RunMapCallback
	call LoadObjectMasks
	farjp InitializeVisibleSprites
; 154ea (5:54ea)

LoadObjectMasks: ; 2454f
	ld hl, wObjectMasks
	xor a
	ld bc, NUM_OBJECTS
	call ByteFill
	ld bc, wMapObjects
	ld de, wObjectMasks
	xor a
.loop
	push af
	push bc
	push de
	call GetObjectTimeMask
	jr c, .next
	call CheckObjectFlag
.next
	pop de
	ld [de], a
	inc de
	pop bc
	ld hl, OBJECT_LENGTH
	add hl, bc
	ld b, h
	ld c, l
	pop af
	inc a
	cp NUM_OBJECTS
	jr nz, .loop
	ret

CheckObjectFlag: ; 2457d (9:457d)
	ld hl, MAPOBJECT_SPRITE
	add hl, bc
	ld a, [hl]
	and a
	jr z, .masked
	ld hl, MAPOBJECT_EVENT_FLAG
	add hl, bc
	ld a, [hli]
	ld e, a
	ld a, [hl]
	ld d, a
	cp -1
	jr nz, .check
	ld a, e
	cp -1
	jr z, .unmasked
	jr .masked
.check
	ld b, CHECK_FLAG
	call EventFlagAction
	ld a, c
	and a
	jr nz, .masked
.unmasked
	xor a
	ret

.masked
	ld a, -1
	scf
	ret

GetObjectTimeMask: ; 245a7 (9:45a7)
	call CheckObjectTime
	ld a, -1
	ret c
	xor a
	ret

DelayClearingOldSprites: ; 154eb
	ld hl, wPlayerSpriteSetupFlags
	set 7, [hl]
	ret
; 154f1

DelayLoadingNewSprites: ; 154f1
	ld hl, wPlayerSpriteSetupFlags
	set 6, [hl]
	ret

CheckReplaceKrisSprite: ; 154f7
;	call .CheckSkateboarding
;	jr c, .ok
	call .CheckBiking
	jr c, .ok
	call .CheckSurfing
	jr c, .ok
	call .CheckSurfing2
	jr c, .ok
	ret

.ok
	jp ReplaceKrisSprite
	
;.CheckSkateboarding: ; 1550c (5:550c)
;	and a
;	ld hl, wOWState
;	bit OWSTATE_BIKING_FORCED, [hl]
;	ret z
;	ld a, PLAYER_SKATEBOARD
;	ld [wPlayerState], a
;	scf
;	ret

.CheckBiking: ; 1550c (5:550c)
	and a
	ld hl, wOWState
	bit OWSTATE_BIKING_FORCED, [hl]
	ret z
	ld a, PLAYER_BIKE
	ld [wPlayerState], a
	scf
	ret

.CheckSurfing2: ; 1551a (5:551a)
	ld a, [wPlayerState]
	cp PLAYER_NORMAL
	jr z, .nope
	cp PLAYER_RUN
	jr z, .nope
	cp PLAYER_SLIP
	jr z, .nope
	cp PLAYER_DODRIO
	jr z, .nope
	cp PLAYER_SURF
	jr z, .surfing
	cp PLAYER_DIVE
	jr z, .surfing
	cp PLAYER_SURF_LAVA
	jr z, .surfing
	call GetMapPermission
	cp INDOOR
	jr z, .checkbiking
	cp DUNGEON
	jr z, .checkbiking
	jr .nope
.checkbiking
	ld a, [wPlayerState]
	cp PLAYER_SKATEBOARD
	jr nz, .check_skateboard_moving
	jr .surfing
.check_skateboard_moving
	cp PLAYER_SKATEBOARD_MOVING
	jr nz, .not_skateboarding
	jr .surfing
.not_skateboarding
	cp PLAYER_FALLING
	jr z, .surfing
	cp PLAYER_BIKE
	jr nz, .nope
.surfing
	ld a, PLAYER_NORMAL
	ld [wPlayerState], a
	xor a
	ld [wOnBike], a
	ld [wOnSkateboard], a
	scf
	ret

.nope
	and a
	ret

.CheckSurfing: ; 1554e (5:554e)
	call CheckOnWater
	jr nz, .ret_nc
	ld a, [wPlayerState]
	cp PLAYER_SURF
	jr z, ._surfing
	cp PLAYER_DIVE
	jr z, ._surfing
	ld a, [wTileset]
	cp TILESET_DIVE
	jr nz, .not_underwater
	ld a, -PLAYER_DIVE
	ld [wPlayerState], a
	jr ._surfing
.not_underwater
	ld a, PLAYER_SURF
	ld [wPlayerState], a
._surfing
	scf
	ret
.ret_nc
	and a
	ret
; 15567

FadeOldMapMusic: ; 15567
	ld a, 6
	jp SkipMusic
; 1556d

RetainOldPalettes: ; 1556d
	farjp _UpdateTimePals

RotatePalettesRightMapAndMusic:
	eventflagcheck EVENT_YOU_CHEATED
	jr nz, .skip
	ld e, 0
	ld a, [wMusicFadeIDLo]
	ld d, 0
	ld a, [wMusicFadeIDHi]
	ld a, $4
	ld [wMusicFade], a
.skip
	farjp FadeOutPalettes

ForceMapMusic: ; 15587
;	ld a, [wPlayerState]
;	cp PLAYER_BIKE
;	jr nz, .notbiking
;	call VolumeOff
;	ld a, $88
;	ld [wMusicFade], a
;.notbiking
	jp TryRestartMapMusic

DecompressMetatiles::
	call TilesetUnchanged
	ret z

	ld hl, wTilesetBlocksBank
	ld c, BANK(wDecompressedMetatiles)
	call .Decompress

	ld hl, wTilesetAttributesBank
	ld c, BANK(wDecompressedAttributes)

.Decompress:
	ld a, [hli]
	ld b, a
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld de, wDecompressedMetatiles
	ld a, c
	call StackCallInWRAMBankA

.Function
	jp FarDecompressAtB_D000
