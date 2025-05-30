RunCallback_05_03: ; 1045b0
	call ResetOWMapState
	call GetCurrentMapTrigger
	ld a, MAPCALLBACK_NEWMAP
	call RunMapCallback
RunCallback_03: ; 1045c4
	farcall ClearCmdQueue
	ld a, MAPCALLBACK_CMDQUEUE
	call RunMapCallback
	call GetMapHeaderTimeOfDayNybble
	ld [wMapTimeOfDay], a
	ret

ResetOWMapState:
; reset flash if out of cave
	ld a, [wPermission]
	cp ROUTE
	jr z, .reset_flash
	cp TOWN
	jr z, .reset_flash
	cp FOREST
	jr nz, .keep_flash
.reset_flash
	ld hl, wStatusFlags
	res 2, [hl]
.keep_flash
	xor a
	ld [wPlaceBallsY], a
; reset map buffer event flags
	ld [wEventFlags], a
; reset ow state
	ld hl, wOWState
	ld [hli], a
	ld [hl], a
	ret


EnterMapConnection: ; 1045d6
; Return carry if a connection has been entered.
	ld a, [wPlayerStepDirection]
	and a
	jp z, EnterSouthConnection
	dec a
	jp z, EnterNorthConnection
	dec a
	jp z, EnterWestConnection
	dec a
	jp z, EnterEastConnection
	ret
; 1045ed


EnterWestConnection: ; 1045ed
	ld a, [wWestConnectedMapGroup]
	ld [wMapGroup], a
	ld a, [wWestConnectedMapNumber]
	ld [wMapNumber], a
	ld a, [wWestConnectionStripXOffset]
	ld [wXCoord], a
	ld a, [wWestConnectionStripYOffset]
	ld hl, wYCoord
	add [hl]
	ld [hl], a
	ld c, a
	ld hl, wWestConnectionWindow
	ld a, [hli]
	ld h, [hl]
	ld l, a
	srl c
	jr z, .skip_to_load
	ld a, [wWestConnectedMapWidth]
	add 6
	ld e, a
	ld d, 0

.loop
	add hl, de
	dec c
	jr nz, .loop

.skip_to_load
	ld a, l
	ld [wOverworldMapAnchor], a
	ld a, h
	ld [wOverworldMapAnchor + 1], a
	jp EnteredConnection
; 104629


EnterEastConnection: ; 104629
	ld a, [wEastConnectedMapGroup]
	ld [wMapGroup], a
	ld a, [wEastConnectedMapNumber]
	ld [wMapNumber], a
	ld a, [wEastConnectionStripXOffset]
	ld [wXCoord], a
	ld a, [wEastConnectionStripYOffset]
	ld hl, wYCoord
	add [hl]
	ld [hl], a
	ld c, a
	ld hl, wEastConnectionWindow
	ld a, [hli]
	ld h, [hl]
	ld l, a
	srl c
	jr z, .skip_to_load
	ld a, [wEastConnectedMapWidth]
	add 6
	ld e, a
	ld d, 0

.loop
	add hl, de
	dec c
	jr nz, .loop

.skip_to_load
	ld a, l
	ld [wOverworldMapAnchor], a
	ld a, h
	ld [wOverworldMapAnchor + 1], a
	jp EnteredConnection
; 104665


EnterNorthConnection: ; 104665
	ld a, [wNorthConnectedMapGroup]
	ld [wMapGroup], a
	ld a, [wNorthConnectedMapNumber]
	ld [wMapNumber], a
	ld a, [wNorthConnectionStripYOffset]
	ld [wYCoord], a
	ld a, [wNorthConnectionStripXOffset]
	ld hl, wXCoord
	add [hl]
	ld [hl], a
	ld c, a
	ld hl, wNorthConnectionWindow
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld b, 0
	srl c
	add hl, bc
	ld a, l
	ld [wOverworldMapAnchor], a
	ld a, h
	ld [wOverworldMapAnchor + 1], a
	jp EnteredConnection
; 104696


EnterSouthConnection: ; 104696
	ld a, [wSouthConnectedMapGroup]
	ld [wMapGroup], a
	ld a, [wSouthConnectedMapNumber]
	ld [wMapNumber], a
	ld a, [wSouthConnectionStripYOffset]
	ld [wYCoord], a
	ld a, [wSouthConnectionStripXOffset]
	ld hl, wXCoord
	add [hl]
	ld [hl], a
	ld c, a
	ld hl, wSouthConnectionWindow
	ld a, [hli]
	ld h, [hl]
	ld l, a
	ld b, 0
	srl c
	add hl, bc
	ld a, l
	ld [wOverworldMapAnchor], a
	ld a, h
	ld [wOverworldMapAnchor + 1], a
	; fallthrough
; 1046c4

EnteredConnection: ; 1046c4
	scf
	ret
; 1046c6

LoadWarpData: ; 1046c6
	call .SaveDigWarp
	call .SetSpawn
	ld a, [wNextWarp]
	ld [wWarpNumber], a
	ld a, [wNextMapGroup]
	ld [wMapGroup], a
	ld a, [wNextMapNumber]
	ld [wMapNumber], a
	ret

.SaveDigWarp: ; 1046df (41:46df)
	call GetMapPermission
	call CheckOutdoorMap
	ret nz
	ld a, [wNextMapGroup]
	ld b, a
	ld a, [wNextMapNumber]
	ld c, a
	call GetAnyMapPermission
	call CheckIndoorMap
	ret nz
;	ld a, [wPrevMapGroup]
;	cp GROUP_TIN_TOWER_ROOF
;	jr nz, .not_tin_tower_roof
;	ld a, [wPrevMapNumber]
;	cp MAP_TIN_TOWER_ROOF
;	ret z
;.not_tin_tower_roof
	ld a, [wPrevWarp]
	ld [wDigWarp], a
	ld a, [wPrevMapGroup]
	ld [wDigMapGroup], a
	ld a, [wPrevMapNumber]
	ld [wDigMapNumber], a
	ret

.SetSpawn: ; 104718 (41:4718)
	call GetMapPermission
	call CheckOutdoorMap
	ret nz
	ld a, [wNextMapGroup]
	ld b, a
	ld a, [wNextMapNumber]
	ld c, a
	call GetAnyMapPermission
	call CheckIndoorMap
	ret nz
	ld a, [wNextMapGroup]
	ld b, a
	ld a, [wNextMapNumber]
	ld c, a
	call GetAnyMapTileset
	ld a, c
	cp TILESET_POKECENTER
	ret nz
	ld a, [wMapGroup]
	cp GROUP_BRIGHTBURG
	jr z, .check_bright
.bright_done
	ld a, [wPrevMapGroup]
	ld [wLastSpawnMapGroup], a
	ld a, [wPrevMapNumber]
	ld [wLastSpawnMapNumber], a
	eventflagset EVENT_VISITED_POKEMON_CENTER_ONCE
	ret
.check_bright
	eventflagcheck EVENT_BRIGHT_CENTER_MART_EMPTY
	ret nz
	jr .bright_done

LoadMapTimeOfDay: ; 104750
	ld hl, wVramState
	res 6, [hl]
	ld a, $1
	ld [wSpriteUpdatesEnabled], a
	farcall ReplaceTimeOfDayPals
	farcall UpdateTimeOfDayPal
	call LoadMapPart
	call .ClearBGMap
	decoord 0, 0
	call .copy
	decoord 0, 0, wAttrMap
	ld a, $1
	ldh [rVBK], a
.copy
	hlbgcoord 0, 0
	lb bc, SCREEN_HEIGHT, SCREEN_WIDTH
.row
	push bc
.column
	ld a, [de]
	inc de
	ld [hli], a
	dec c
	jr nz, .column
	ld bc, BG_MAP_WIDTH - SCREEN_WIDTH
	add hl, bc
	pop bc
	dec b
	jr nz, .row
	xor a
	ldh [rVBK], a
	ret

.ClearBGMap: ; 104770 (41:4770)
	ld a, VBGMap0 / $100
	ld [wBGMapAnchor + 1], a
	xor a
	ld [wBGMapAnchor], a
	ldh [hSCY], a
	ldh [hSCX], a
	farcall ApplyBGMapAnchorToObjects
	ldh a, [rVBK]
	push af
	ld a, $1
	ldh [rVBK], a
	xor a
	ld bc, VBGMap1 - VBGMap0
	hlbgcoord 0, 0
	call ByteFill
	pop af
	ldh [rVBK], a
	ld a, "<BLACK>"
	ld bc, VBGMap1 - VBGMap0
	hlbgcoord 0, 0
	jp ByteFill

DeferredLoadGraphics::
	call TilesetUnchanged
	jr z, .done
	call LoadTilesetHeader
	ld a, 3
	ld [wPendingOverworldGraphics], a
.done
	farcall CheckIfTilesetHasRoof
	jr nc, .skip_roof
	farcall LoadMapGroupRoof
.skip_roof
	farcall LoadEmoteGFX
	xor a
	ldh [hMapAnims], a
	ldh [hTileAnimFrame], a
	ret

LoadGraphics:
	call LoadTilesetHeader
	call LoadTileset
.done
	xor a
	ldh [hMapAnims], a
	ldh [hTileAnimFrame], a
	farjp ReloadVisibleSprites

LoadMapPalettes: ; 1047eb
	ld b, CGB_MAPPALS
	jp GetCGBLayout
; 1047f0

RefreshMapSprites: ; 1047f0
	call ClearSprites
	xor a
	ldh [hBGMapMode], a

	farcall ReturnFromMapSetupScript
	call GetMovementPermissions
	farcall GetMovementPermissionsFar
	farcall RefreshPlayerSprite
	farcall CheckReplaceKrisSprite
	ld hl, wPlayerSpriteSetupFlags
	bit 6, [hl]
	jr nz, .skip
	ld hl, wVramState
	set 0, [hl]
	call SafeUpdateSprites
.skip
	ld a, [wPlayerSpriteSetupFlags]
	and %00011100
	ld [wPlayerSpriteSetupFlags], a
	ret

CheckMovingOffEdgeOfMap:: ; 104820 (41:4820)
	ld a, [wPlayerStepDirection]
	cp STANDING
	ret z
	and a ; DOWN
	jr z, .down
	cp UP
	jr z, .up
	cp LEFT
	jr z, .left
	cp RIGHT
	jr z, .right
	and a
	ret

.down
	ld a, [wPlayerStandingMapY]
	sub 4
	ld b, a
	ld a, [wMapHeight]
	add a
	cp b
	jr z, .ok
	and a
	ret

.up
	ld a, [wPlayerStandingMapY]
	sub 4
	cp -1
	jr z, .ok
	and a
	ret

.left
	ld a, [wPlayerStandingMapX]
	sub $4
	cp -1
	jr z, .ok
	and a
	ret

.right
	ld a, [wPlayerStandingMapX]
	sub 4
	ld b, a
	ld a, [wMapWidth]
	add a
	cp b
	jr z, .ok
	and a
	ret

.ok
	scf
	ret


GetCoordOfUpperLeftCorner:: ; 10486d
	ld hl, wOverworldMap
	ld a, [wXCoord]
	bit 0, a
	jr nz, .increment_then_halve1
	srl a
	add $1
	jr .resume

.increment_then_halve1
	add $1
	srl a

.resume
	ld c, a
	ld b, $0
	add hl, bc
	ld a, [wMapWidth]
	add $6
	ld c, a
	ld b, $0
	ld a, [wYCoord]
	bit 0, a
	jr nz, .increment_then_halve2
	srl a
	add $1
	jr .resume2

.increment_then_halve2
	add $1
	srl a

.resume2
	rst AddNTimes
	ld a, l
	ld [wOverworldMapAnchor], a
	ld a, h
	ld [wOverworldMapAnchor + 1], a
	ld a, [wYCoord]
	and $1
	ld [wMetatileStandingY], a
	ld a, [wXCoord]
	and $1
	ld [wMetatileStandingX], a
	ret
; 1048ba
