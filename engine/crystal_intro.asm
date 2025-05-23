Copyright_GFPresents: ; e4579
	ld de, MUSIC_NONE
	call PlayMusic
	call ClearBGPalettes
	call ClearTileMap
	ld a, VBGMap0 / $100
	ldh [hBGMapAddress + 1], a
	xor a
	ldh [hBGMapAddress], a
	ldh [hJoyDown], a
	ldh [hSCX], a
	ldh [hSCY], a
	ld a, $90
	ldh [hWY], a
	
	call CheckVBA
	jp z, .skip_vba
	farcall _VBAScreen
	ld de, MUSIC_YOUNGSTER_ENCOUNTER
	call PlayMusic
	ld c, 15
	call FadePalettes
.vba_loop
	call DelayFrame
	ld a, [wPlaceBallsX]
	cp 1
	jr nc, .vba_loop2
	ld a, [wPlaceBallsY]
	inc a
	ld [wPlaceBallsY], a
	cp $ff
	jr nz, .vba_loop
	ld a, [wPlaceBallsX]
	inc a
	ld [wPlaceBallsX], a
	jr .vba_loop
.vba_loop2
	call GetJoypad
	ld hl, hJoyPressed
	bit A_BUTTON_F, [hl]
	jr z, .vba_loop2
	call SetBlackPals
	ld c, 15
	call FadePalettes
	xor a
	ld [wMusicFadeID], a
	ld [wMusicFadeID + 1], a
	ld a, 2
	and $7f
	ld [wMusicFade], a
	
.skip_vba
	call CheckExtendedSpace
	
	ld a, BANK(wExtendedSpace)
	ld hl, wExtendedSpace
	call GetFarWRAMByte
	; value is now in a
	cp 0
	jr nz, .skip
	farcall _WarnScreen
	ld hl, WarnScreenPalette
	ld de, wUnknBGPals
	ld bc, 1 palettes
	ld a, $5
	call FarCopyWRAM
	ld c, 15
	call FadePalettes
.loop2
	ld a, [wPlaceBallsX]
	inc a
	ld [wPlaceBallsX], a
	cp $ff
	jr nz, .skip2
	ld a, [wPlaceBallsY]
	inc a
	ld [wPlaceBallsY], a
	cp $20
	jr nz, .skip2
	ld hl, wLowHealthAlarm
	set 7, [hl]
.skip2
	call GetJoypad
	ld hl, hJoyPressed
	bit A_BUTTON_F, [hl]
	jr z, .loop2
	call SetBlackPals
	ld c, 15
	call FadePalettes
.skip
	xor a
	ld [wLowHealthAlarm], a
	ld [wPlaceBallsX], a
	ld [wPlaceBallsY], a
	farcall CoralSplashScreen
	call ApplyAttrAndTilemapInVBlank
	
	ld hl, SplashScreenPalette
	ld de, wUnknBGPals
	ld bc, 2 palettes
	ld a, $5
	call FarCopyWRAM
	ld c, 15
	call FadePalettes
	ld c, 200
	call DelayFrames
	ld hl, SplashScreenPalette
	ld de, wUnknBGPals + 1 palettes
	ld bc, 1 palettes
	ld a, $5
	call FarCopyWRAM
	ld c, 15
	call FadePalettes
.loop
	call GetJoypad
	ld hl, hJoyPressed
	bit A_BUTTON_F, [hl]
	jr z, .loop
StartIntroSequence::
	call SetBlackPals
	ld c, 15
	call FadePalettes
	farcall ClearSplashScreenPalettes
	ld b, CGB_GAMEFREAK_LOGO
	call GetCGBLayout
	ld c, 60
	call DelayFrames
	ld de, MUSIC_TITLE
	call PlayMusic
	ld c, 30
	call DelayFrames
	farcall Copyright
	farcall BSOD
	call ApplyTilemapInVBlank
	ld c, 0
	call FadePalettes
	ld c, 143
	call DelayFrames
	call SetBlackPals
	ld c, 15
	call FadePalettes
	call ClearTileMap
	ld c, 80
	call DelayFrames
	farcall CoralDevScreen
	ret
; e45e8

CheckVBA:
	xor a
	ldh [rSC], a ; no-optimize redundant loads (VBA loads this wrong)
	ldh a, [rSC]
	and %01111100
	cp %01111100
	ret

SplashScreenPalette:
	RGB 00, 00, 00
	RGB 00, 00, 00
	RGB 00, 00, 00
	RGB 31, 31, 31
	
	RGB 00, 00, 00
	RGB 00, 00, 00
	RGB 00, 00, 00
	RGB 00, 00, 00

WarnScreenPalette:
	RGB 31, 31, 31
	RGB 31, 25, 00
	RGB 00, 00, 00
	RGB 00, 00, 00
	
WarnScreenPalette2:
	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 00, 00, 00
	RGB 00, 00, 00
	


CrystalIntro: ; e48ac
	ld hl, rIE
	set LCD_STAT, [hl]
	ldh a, [rSVBK]
	push af
	ld a, 5
	ldh [rSVBK], a
	ldh a, [hInMenu]
	push af
	ldh a, [hVBlank]
	push af
	call .InitRAMAddrs
.loop ; e48bc
	call JoyTextDelay
	ldh a, [hJoyLast]
	and BUTTONS
	jr nz, .ShutOffMusic
	ld a, [wJumptableIndex]
	bit 7, a
	jr nz, .done
	call IntroSceneJumper
	farcall PlaySpriteAnimations
	call DelayFrame
	jp .loop

.ShutOffMusic:
	ld de, MUSIC_NONE
	call PlayMusic

.done
	call ClearBGPalettes
	call ClearSprites
	call ClearTileMap
	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	ld a, $7
	ldh [hWX], a
	ld a, $90
	ldh [hWY], a
	pop af
	ldh [hVBlank], a
	pop af
	ldh [hInMenu], a
	pop af
	ldh [rSVBK], a
	ld hl, rIE
	res LCD_STAT, [hl]
	ret
; e4901

.InitRAMAddrs: ; e4901
	xor a
	ldh [hVBlank], a
	ld a, $1
	ldh [hInMenu], a
	xor a
	ldh [hMapAnims], a
	ld [wJumptableIndex], a
	ret
; e490f

IntroSceneJumper: ; e490f
	ld a, [wJumptableIndex]
	ld e, a
	ld d, 0
	ld hl, IntroScenes
	add hl, de
	add hl, de
	ld a, [hli]
	ld h, [hl]
	ld l, a
	jp hl
; e491e

IntroScenes: ; e491e (39:491e)
	dw IntroScene1
	dw IntroScene2
	dw IntroScene3
	dw IntroScene4
	dw IntroScene5
	dw IntroScene6
	dw IntroScene7
	dw IntroScene8
	dw IntroScene9
	dw IntroScene10
	dw IntroScene11
	dw IntroScene12
	dw IntroScene13
	dw IntroScene14
	dw IntroScene15
	dw IntroScene16
	dw IntroScene17
	dw IntroScene18
	dw IntroScene19
	dw IntroScene20
	dw IntroScene21
	dw IntroScene22
	dw IntroScene23
	dw IntroScene24
	dw IntroScene25
	dw IntroScene26
	dw IntroScene27
	dw IntroScene28

NextIntroScene: ; e4956 (39:4956)
	ld hl, wJumptableIndex
	inc [hl]
	ret

IntroScene1: ; e495b (39:495b)
; Setup the next scene.
	call Intro_ClearBGPals
	call ClearSprites
	call ClearTileMap
	xor a
	ldh [hBGMapMode], a
	ld a, $1
	ldh [rVBK], a
	ld hl, IntroTilemap001
	debgcoord 0, 0
	call Intro_DecompressRequest2bpp_64Tiles
	xor a
	ldh [rVBK], a
	ld hl, IntroUnownsGFX
	ld de, VTiles2 tile $00
	call Intro_DecompressRequest2bpp_128Tiles
	ld hl, IntroPulseGFX
	ld de, VTiles0 tile $00
	call Intro_DecompressRequest2bpp_128Tiles
	ld hl, IntroTilemap002
	debgcoord 0, 0
	call Intro_DecompressRequest2bpp_64Tiles
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a
	ld hl, Palette_365ad
	ld de, wUnknBGPals
	ld bc, 16 palettes
	rst CopyBytes
	ld hl, Palette_365ad
	ld de, wBGPals
	ld bc, 16 palettes
	rst CopyBytes
	pop af
	ldh [rSVBK], a
	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	ld a, $7
	ldh [hWX], a
	ld a, $90
	ldh [hWY], a
	farcall ClearSpriteAnims
	call Intro_SetCGBPalUpdate
	xor a
	ld [wIntroSceneFrameCounter], a
	ld [wcf65], a
	jp NextIntroScene

IntroScene2: ; e49d6 (39:49d6)
; First Unown (A) fades in, pulses, then fades out.
	ld hl, wIntroSceneFrameCounter
	ld a, [hl]
	inc [hl]
	cp $80
	jr nc, .endscene
	cp $60
	jr nz, .DontPlaySound
	push af
	depixel 11, 11
	call CrystalIntro_InitUnownAnim
	ld de, SFX_INTRO_UNOWN_1
	call PlaySFX
	pop af
.DontPlaySound:
	ld [wcf65], a
	xor a
	jp CrystalIntro_UnownFade
.endscene
	jp NextIntroScene

IntroScene3: ; e49fd (39:49fd)
; More setup. Transition to the outdoor scene.
	call Intro_ClearBGPals
	call ClearSprites
	call ClearTileMap
	xor a
	ldh [hBGMapMode], a
	ld a, $1
	ldh [rVBK], a
	ld hl, IntroTilemap003
	debgcoord 0, 0
	call Intro_DecompressRequest2bpp_64Tiles
	xor a
	ldh [rVBK], a
	call Intro_SetupCommonScenery
	call Intro_ResetLYOverrides
	call Intro_SetCGBPalUpdate
	xor a
	ld [wIntroSceneFrameCounter], a
	jp NextIntroScene

IntroScene4: ; e4a69 (39:4a69)
; Scroll the outdoor panorama for a bit.
	call Intro_PerspectiveScrollBG
	ld hl, wIntroSceneFrameCounter
	ld a, [hl]
	cp $80
	jr z, .endscene
	inc [hl]
	ret

.endscene
	jp NextIntroScene

IntroScene5: ; e4a7a (39:4a7a)
; Go back to the Unown.
	call Intro_ClearBGPals
	call ClearSprites
	call ClearTileMap
	xor a
	ldh [hBGMapMode], a
	ldh [hLCDCPointer], a
	ld a, $1
	ldh [rVBK], a
	ld hl, IntroTilemap005
	debgcoord 0, 0
	call Intro_DecompressRequest2bpp_64Tiles
	xor a
	ldh [rVBK], a
	ld hl, IntroUnownsGFX
	ld de, VTiles2 tile $00
	call Intro_DecompressRequest2bpp_128Tiles
	ld hl, IntroPulseGFX
	ld de, VTiles0 tile $00
	call Intro_DecompressRequest2bpp_128Tiles
	ld hl, IntroTilemap006
	debgcoord 0, 0
	call Intro_DecompressRequest2bpp_64Tiles
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a
	ld hl, Palette_365ad
	ld de, wUnknBGPals
	ld bc, 16 palettes
	rst CopyBytes
	ld hl, Palette_365ad
	ld de, wBGPals
	ld bc, 16 palettes
	rst CopyBytes
	pop af
	ldh [rSVBK], a
	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	ld a, $7
	ldh [hWX], a
	ld a, $90
	ldh [hWY], a
	farcall ClearSpriteAnims
	call Intro_SetCGBPalUpdate
	xor a
	ld [wIntroSceneFrameCounter], a
	ld [wcf65], a
	jp NextIntroScene

IntroScene6: ; e4af7 (39:4af7)
; Two more Unown (I, H) fade in.
	ld hl, wIntroSceneFrameCounter
	ld a, [hl]
	inc [hl]
	cp $80
	jr nc, .endscene
	cp $60
	jr z, .SecondUnown
	cp $40
	jr nc, .StopUnown
	cp $20
	jr z, .FirstUnown
	jr .NoUnown

.FirstUnown:
	push af
	depixel 7, 15
	call CrystalIntro_InitUnownAnim
	ld de, SFX_INTRO_UNOWN_2
	call PlaySFX
	pop af
.NoUnown:
	ld [wcf65], a
	xor a
	jp CrystalIntro_UnownFade

.SecondUnown:
	push af
	depixel 14, 6
	call CrystalIntro_InitUnownAnim
	ld de, SFX_INTRO_UNOWN_1
	call PlaySFX
	pop af
.StopUnown:
	ld [wcf65], a
	ld a, $1
	jp CrystalIntro_UnownFade

.endscene
	jp NextIntroScene

IntroScene7: ; e4b3f (39:4b3f)
; Back to the outdoor scene.
	call Intro_ClearBGPals
	call ClearSprites
	call ClearTileMap
	xor a
	ldh [hBGMapMode], a

	ld a, $1
	ldh [rVBK], a
	ld hl, IntroTilemap003
	debgcoord 0, 0
	call Intro_DecompressRequest2bpp_64Tiles

	ld hl, IntroPichuWooperGFX
	ld de, VTiles0 tile $00
	call Intro_DecompressRequest2bpp_128Tiles

	xor a
	ldh [rVBK], a
	ld hl, IntroSuicuneRunGFX
	ld de, VTiles0 tile $00
	call Intro_DecompressRequest2bpp_255Tiles

	call Intro_SetupCommonScenery

	call Intro_ResetLYOverrides
	farcall ClearSpriteAnims
	depixel 13, 27, 4, 0
	ld a, SPRITE_ANIM_INDEX_INTRO_SUICUNE
	farcall _InitSpriteAnimStruct
	ld a, $f0
	ld [wGlobalAnimXOffset], a
	call Intro_SetCGBPalUpdate
	xor a
	ld [wIntroSceneFrameCounter], a
	ld [wcf65], a
	jp NextIntroScene

IntroScene8: ; e4bd3 (39:4bd3)
; Scroll the scene, then show Suicune running across the screen.
	ld hl, wIntroSceneFrameCounter
	ld a, [hl]
	inc [hl]
	cp $40
	jr z, .suicune_sound
	jr nc, .animate_suicune
	jp Intro_PerspectiveScrollBG

.suicune_sound
	ld de, SFX_INTRO_SUICUNE_3
	call PlaySFX
.animate_suicune
	ld a, [wGlobalAnimXOffset]
	and a
	jr z, .finish
	sub $8
	ld [wGlobalAnimXOffset], a
	ret

.finish
	ld de, SFX_INTRO_SUICUNE_2
	call PlaySFX
	farcall DeinitializeAllSprites
	jp NextIntroScene

IntroScene9: ; e4c04 (39:4c04)
; Set up the next scene (same bg).
	xor a
	ldh [hLCDCPointer], a
	call ClearSprites
	hlcoord 0, 0, wAttrMap
	; first 12 rows have palette 1
	ld bc, 12 * SCREEN_WIDTH
	ld a, $1
	call ByteFill
	; middle 3 rows have palette 2
	ld bc, 3 * SCREEN_WIDTH
	ld a, $2
	call ByteFill
	; last three rows have palette 3
	ld bc, 3 * SCREEN_WIDTH
	ld a, $3
	call ByteFill
	ld a, $2
	ldh [hBGMapMode], a
	call DelayFrame
	call DelayFrame
	call DelayFrame
	ld a, $c ; $980c
	ldh [hBGMapAddress], a
	call DelayFrame
	call DelayFrame
	call DelayFrame
	xor a
	ldh [hBGMapMode], a
	ldh [hBGMapAddress], a
	ld [wGlobalAnimXOffset], a
	xor a
	ld [wIntroSceneFrameCounter], a
	jp NextIntroScene

IntroScene10: ; e4c4f (39:4c4f)
; Wooper and Pichu enter.
	call Intro_RustleGrass
	ld hl, wIntroSceneFrameCounter
	ld a, [hl]
	inc [hl]
	cp $c0
	jr z, .done
	cp $20
	jr z, .wooper
	cp $40
	jr z, .pichu
	ret

.pichu
	depixel 21, 16, 1, 0
	ld a, SPRITE_ANIM_INDEX_INTRO_PICHU
	farcall _InitSpriteAnimStruct
	ld de, SFX_INTRO_PICHU
	jp PlaySFX

.wooper
	depixel 22, 6
	ld a, SPRITE_ANIM_INDEX_INTRO_WOOPER
	farcall _InitSpriteAnimStruct
	ld de, SFX_INTRO_PICHU
	jp PlaySFX
.done
	jp NextIntroScene

IntroScene11: ; e4c86 (39:4c86)
; Back to Unown again.
	call Intro_ClearBGPals
	call ClearSprites
	call ClearTileMap
	xor a
	ldh [hBGMapMode], a
	ldh [hLCDCPointer], a
	ld a, $1
	ldh [rVBK], a
	ld hl, IntroTilemap007
	debgcoord 0, 0
	call Intro_DecompressRequest2bpp_64Tiles
	xor a
	ldh [rVBK], a
	ld hl, IntroUnownsGFX
	ld de, VTiles2 tile $00
	call Intro_DecompressRequest2bpp_128Tiles
	ld hl, IntroTilemap008
	debgcoord 0, 0
	call Intro_DecompressRequest2bpp_64Tiles
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a
	ld hl, Palette_365ad
	ld de, wUnknBGPals
	ld bc, 16 palettes
	rst CopyBytes
	ld hl, Palette_365ad
	ld de, wBGPals
	ld bc, 16 palettes
	rst CopyBytes
	pop af
	ldh [rSVBK], a
	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	ld a, $7
	ldh [hWX], a
	ld a, $90
	ldh [hWY], a
	farcall ClearSpriteAnims
	call Intro_SetCGBPalUpdate
	xor a
	ld [wIntroSceneFrameCounter], a
	ld [wcf65], a
	jp NextIntroScene

IntroScene12: ; e4cfa (39:4cfa)
; Even more Unown.
	call .PlayUnownSound
	ld hl, wIntroSceneFrameCounter
	ld a, [hl]
	inc [hl]
	cp $c0
	jr nc, .done
	cp $80
	jr nc, .second_half
; first half
	ld c, a
	and $1f
	sla a
	ld [wcf65], a
	ld a, c
	and $e0
	srl a
	swap a
	jp CrystalIntro_UnownFade

.second_half
; double speed
	ld c, a
	and $f
	sla a
	sla a
	ld [wcf65], a
	ld a, c
	and $70
	or $40
	swap a
	jp CrystalIntro_UnownFade

.done
	jp NextIntroScene

.PlayUnownSound: ; e4d36 (39:4d36)
	ld a, [wIntroSceneFrameCounter]
	ld c, a
	ld hl, .UnownSounds
.loop
	ld a, [hli]
	cp -1
	ret z
	cp c
	jr z, .playsound
	inc hl
	inc hl
	jr .loop
.playsound
	ld a, [hli]
	ld d, [hl]
	ld e, a
	push de
	call SFXChannelsOff
	pop de
	jp PlaySFX
; e4d54 (39:4d54)

.UnownSounds: ; e4d54
	dbw $00, SFX_INTRO_UNOWN_3
	dbw $20, SFX_INTRO_UNOWN_2
	dbw $40, SFX_INTRO_UNOWN_1
	dbw $60, SFX_INTRO_UNOWN_2
	dbw $80, SFX_INTRO_UNOWN_3
	dbw $90, SFX_INTRO_UNOWN_2
	dbw $a0, SFX_INTRO_UNOWN_1
	dbw $b0, SFX_INTRO_UNOWN_2
	db -1 ; e4d6d

IntroScene13: ; e4d6d (39:4d6d)
; Switch scenes again.
	call Intro_ClearBGPals
	call ClearSprites
	call ClearTileMap
	xor a
	ldh [hBGMapMode], a
	ld a, $1
	ldh [rVBK], a
	ld hl, IntroTilemap003
	debgcoord 0, 0
	call Intro_DecompressRequest2bpp_64Tiles
	xor a
	ldh [rVBK], a
	ld hl, IntroSuicuneRunGFX
	ld de, VTiles0 tile $00
	call Intro_DecompressRequest2bpp_255Tiles
	call Intro_SetupCommonScenery
	farcall ClearSpriteAnims
	depixel 13, 11, 4, 0
	ld a, SPRITE_ANIM_INDEX_INTRO_SUICUNE
	farcall _InitSpriteAnimStruct
	ld de, MUSIC_EVOLUTION
	call PlayMusic
	xor a
	ld [wGlobalAnimXOffset], a
	call Intro_SetCGBPalUpdate
	xor a
	ld [wIntroSceneFrameCounter], a
	ld [wcf65], a
	jp NextIntroScene

IntroScene14: ; e4dfa (39:4dfa)
; Suicune runs then jumps.
	ldh a, [hSCX]
	sub 10
	ldh [hSCX], a
	ld hl, wIntroSceneFrameCounter
	ld a, [hl]
	inc [hl]
	cp $80
	jr z, .done
	cp $60
	jr z, .jump
	jr nc, .asm_e4e1a
	cp $40
	jr nc, .asm_e4e33
	ret

.jump
	ld de, SFX_INTRO_SUICUNE_4
	call PlaySFX

.asm_e4e1a
	ld a, $1
	ld [wcf65], a
	ld a, [wGlobalAnimXOffset]
	cp $88
	jr c, .asm_e4e2c
	sub $8
	ld [wGlobalAnimXOffset], a
	ret

.asm_e4e2c
	farjp DeinitializeAllSprites

.asm_e4e33
	ld a, [wGlobalAnimXOffset]
	sub $2
	ld [wGlobalAnimXOffset], a
	ret

.done
	jp NextIntroScene

IntroScene15: ; e4e40 (39:4e40)
; Transition to a new scene.
	call Intro_ClearBGPals
	call ClearSprites
	call ClearTileMap
	xor a
	ldh [hBGMapMode], a
	ld a, $1
	ldh [rVBK], a
	ld hl, IntroTilemap009
	debgcoord 0, 0
	call Intro_DecompressRequest2bpp_64Tiles
	xor a
	ldh [rVBK], a
	ld hl, IntroSuicuneJumpGFX
	ld de, VTiles2 tile $00
	call Intro_DecompressRequest2bpp_128Tiles
	ld hl, IntroUnownBackGFX
	ld de, VTiles0 tile $00
	call Intro_DecompressRequest2bpp_128Tiles
	ld de, IntroGrass4GFX
	ld hl, VTiles1 tile $00
	lb bc, BANK(IntroGrass4GFX), 1
	call Request2bpp
	ld hl, IntroTilemap010
	debgcoord 0, 0
	call Intro_DecompressRequest2bpp_64Tiles
	call Intro_LoadTilemap
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a
	ld hl, Palette_e77dd
	ld de, wUnknBGPals
	ld bc, 16 palettes
	rst CopyBytes
	ld hl, Palette_e77dd
	ld de, wBGPals
	ld bc, 16 palettes
	rst CopyBytes
	pop af
	ldh [rSVBK], a
	xor a
	ldh [hSCX], a
	ld a, $90
	ldh [hSCY], a
	ld a, $7
	ldh [hWX], a
	ld a, $90
	ldh [hWY], a
	farcall ClearSpriteAnims
	call Intro_SetCGBPalUpdate
	depixel 8, 5
	ld a, SPRITE_ANIM_INDEX_INTRO_UNOWN_F
	farcall _InitSpriteAnimStruct
	depixel 12, 0
	ld a, SPRITE_ANIM_INDEX_INTRO_SUICUNE_AWAY
	farcall _InitSpriteAnimStruct
	xor a
	ld [wIntroSceneFrameCounter], a
	ld [wcf65], a
	jp NextIntroScene

IntroScene16: ; e4edc (39:4edc)
; Suicune shows its face. An Unown appears in front.
	ld hl, wIntroSceneFrameCounter
	ld a, [hl]
	inc [hl]
	cp $80
	jr nc, .done
	call Intro_Scene16_AnimateSuicune
	ldh a, [hSCY]
	and a
	ret z
	add 8
	ldh [hSCY], a
	ret
.done
	jp NextIntroScene

IntroScene17: ; e4ef5 (39:4ef5)
; ...
	call Intro_ClearBGPals
	call ClearSprites
	call ClearTileMap
	xor a
	ldh [hBGMapMode], a
	ld a, $1
	ldh [rVBK], a
	ld hl, IntroTilemap011
	debgcoord 0, 0
	call Intro_DecompressRequest2bpp_64Tiles
	xor a
	ldh [rVBK], a
	ld hl, IntroSuicuneCloseGFX
	ld de, VTiles1 tile $00
	call Intro_DecompressRequest2bpp_255Tiles
	ld hl, IntroTilemap012
	debgcoord 0, 0
	call Intro_DecompressRequest2bpp_64Tiles
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a
	ld hl, Palette_e6d6d
	ld de, wUnknBGPals
	ld bc, 16 palettes
	rst CopyBytes
	ld hl, Palette_e6d6d
	ld de, wBGPals
	ld bc, 16 palettes
	rst CopyBytes
	pop af
	ldh [rSVBK], a
	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	ld a, $7
	ldh [hWX], a
	ld a, $90
	ldh [hWY], a
	farcall ClearSpriteAnims
	call Intro_SetCGBPalUpdate
	xor a
	ld [wIntroSceneFrameCounter], a
	ld [wcf65], a
	jp NextIntroScene

IntroScene18: ; e4f67 (39:4f67)
; Suicune close up.
	ld hl, wIntroSceneFrameCounter
	ld a, [hl]
	inc [hl]
	cp $60
	jr nc, .done
	ldh a, [hSCX]
	cp $60
	ret z
	add 8
	ldh [hSCX], a
	ret
.done
	jp NextIntroScene

IntroScene19: ; e4f7e (39:4f7e)
; More setup.
	call Intro_ClearBGPals
	call ClearSprites
	call ClearTileMap
	xor a
	ldh [hBGMapMode], a
	ld a, $1
	ldh [rVBK], a
	ld hl, IntroTilemap013
	debgcoord 0, 0
	call Intro_DecompressRequest2bpp_64Tiles
	xor a
	ldh [rVBK], a
	ld hl, IntroSuicuneBackGFX
	ld de, VTiles2 tile $00
	call Intro_DecompressRequest2bpp_128Tiles
	ld hl, IntroUnownsGFX
	ld de, VTiles1 tile $00
	call Intro_DecompressRequest2bpp_128Tiles
	ld de, IntroGrass4GFX
	ld hl, VTiles1 tile $7f
	lb bc, BANK(IntroGrass4GFX), 1
	call Request2bpp
	ld hl, IntroTilemap014
	debgcoord 0, 0
	call Intro_DecompressRequest2bpp_64Tiles
	call Intro_LoadTilemap
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a
	ld hl, Palette_e77dd
	ld de, wUnknBGPals
	ld bc, 16 palettes
	rst CopyBytes
	ld hl, Palette_e77dd
	ld de, wBGPals
	ld bc, 16 palettes
	rst CopyBytes
	pop af
	ldh [rSVBK], a
	xor a
	ldh [hSCX], a
	ld a, $d8
	ldh [hSCY], a
	ld a, $7
	ldh [hWX], a
	ld a, $90
	ldh [hWY], a
	farcall ClearSpriteAnims
	ld hl, wSpriteAnimDict
	xor a
	ld [hli], a
	ld [hl], $7f
	call Intro_SetCGBPalUpdate
	depixel 12, 0
	ld a, SPRITE_ANIM_INDEX_INTRO_SUICUNE_AWAY
	farcall _InitSpriteAnimStruct
	xor a
	ld [wIntroSceneFrameCounter], a
	ld [wcf65], a
	jp NextIntroScene

IntroScene20: ; e5019 (39:5019)
; Suicune running away. A bunch of Unown appear.
	ld hl, wIntroSceneFrameCounter
	ld a, [hl]
	inc [hl]
	cp $98
	jr nc, .finished
	cp $58
	ret nc
	cp $40
	jr nc, .AppearUnown
	cp $28
	ret nc
	ldh a, [hSCY]
	inc a
	ldh [hSCY], a
	ret

.AppearUnown:
	sub $18
	ld c, a
	and $3
	cp $3
	ret nz
	ld a, c
	and $1c
	srl a
	srl a
	ld [wcf65], a
	xor a
	jp Intro_Scene20_AppearUnown
; e5049 (39:5049)

.finished
	jp NextIntroScene

IntroScene21: ; e505d (39:505d)
; Suicune gets more distant and turns black.
	call Intro_ColoredSuicuneFrameSwap
	ld c, 3
	call DelayFrames
	xor a
	ldh [hBGMapMode], a
	ld [wIntroSceneFrameCounter], a
	ld [wcf65], a
	jp NextIntroScene

IntroScene22: ; e5072 (39:5072)
	ld hl, wIntroSceneFrameCounter
	ld a, [hl]
	inc [hl]
	cp $8
	jr nc, .done
	ret
.done
	farcall DeinitializeAllSprites
	jp NextIntroScene

IntroScene23: ; e5086 (39:5086)
	xor a
	ld [wIntroSceneFrameCounter], a
	jp NextIntroScene

IntroScene24: ; e508e (39:508e)
; Fade to white.
	ld hl, wIntroSceneFrameCounter
	ld a, [hl]
	inc [hl]
	cp $20
	jr nc, .done

	ld c, a
	and $3
	ret nz

	ld a, c
	and $1c
	sla a
	jp Intro_Scene24_ApplyPaletteFade

.done
	ld a, $40
	ld [wIntroSceneFrameCounter], a
	jp NextIntroScene

IntroScene25: ; e50ad (39:50ad)
; Wait around a bit.
	ld a, [wIntroSceneFrameCounter]
	dec a
	jr z, .done
	ld [wIntroSceneFrameCounter], a
	ret

.done
	jp NextIntroScene

IntroScene26: ; e50bb (39:50bb)
; Load the final scene.
	call ClearBGPalettes
	call ClearSprites
	call ClearTileMap
	xor a
	ldh [hBGMapMode], a
	ld a, $1
	ldh [rVBK], a
	ld hl, IntroTilemap015
	debgcoord 0, 0
	call Intro_DecompressRequest2bpp_64Tiles
	xor a
	ldh [rVBK], a
	ld hl, IntroCrystalUnownsGFX
	ld de, VTiles2 tile $00
	call Intro_DecompressRequest2bpp_128Tiles
	ld hl, IntroTilemap017
	debgcoord 0, 0
	call Intro_DecompressRequest2bpp_64Tiles
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a
	ld hl, Palette_e679d
	ld de, wUnknBGPals
	ld bc, 16 palettes
	rst CopyBytes
	ld hl, Palette_e679d
	ld de, wBGPals
	ld bc, 16 palettes
	rst CopyBytes
	pop af
	ldh [rSVBK], a
	xor a
	ldh [hSCX], a
	ldh [hSCY], a
	ld a, $7
	ldh [hWX], a
	ld a, $90
	ldh [hWY], a
	farcall ClearSpriteAnims
	call Intro_SetCGBPalUpdate
	xor a
	ld [wIntroSceneFrameCounter], a
	ld [wcf65], a
	jp NextIntroScene

IntroScene27: ; e512d (39:512d)
; Spell out C R Y S T A L with Unown.
	ld hl, wcf65
	inc [hl]
	ld hl, wIntroSceneFrameCounter
	ld a, [hl]
	inc [hl]
	cp $80
	jr nc, .done

	ld c, a
	and $f
	ld [wcf65], a
	ld a, c
	and $70
	swap a
	jp Intro_FadeUnownWordPals

.done
	call NextIntroScene
	ld a, $ff
	ld [wIntroSceneFrameCounter], a
	ret

IntroScene28: ; e5152 (39:5152)
; Cut out when the music ends, and lead into the title screen.
	ld hl, wIntroSceneFrameCounter
	ld a, [hl]
	and a
	jr z, .done
	dec [hl]
	cp $30
	jr z, .clear
	cp $10
	ret nz

	ld de, SFX_TITLE_SCREEN_INTRO
	jp PlaySFX

.clear
	jp ClearBGPalettes

.done
	ld hl, wJumptableIndex
	set 7, [hl]
	ret

Intro_Scene24_ApplyPaletteFade: ; e5172 (39:5172)
; load the (a)th palette from .FadePals to all wBGPals
	ld hl, .FadePals
	add l
	ld l, a
	ld a, 0 ; not xor a; preserve carry flag?
	adc h
	ld h, a

	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a
	ld de, wBGPals
	ld b, 8 ; number of BG pals
.loop1
	push hl
	ld c, 8 ; number of bytes per pal
.loop2
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .loop2
	pop hl
	dec b
	jr nz, .loop1
	pop af
	ldh [rSVBK], a
	ld a, $1
	ldh [hCGBPalUpdate], a
	ret
; e519c (39:519c)

.FadePals: ; e519c
; Fade to white.
if !DEF(MONOCHROME)
	RGB 24, 12, 09
	RGB 31, 31, 31
	RGB 12, 00, 31
	RGB 00, 00, 00

	RGB 31, 19, 05
	RGB 31, 31, 31
	RGB 15, 05, 31
	RGB 07, 07, 07

	RGB 31, 21, 09
	RGB 31, 31, 31
	RGB 18, 09, 31
	RGB 11, 11, 11

	RGB 31, 23, 13
	RGB 31, 31, 31
	RGB 21, 13, 31
	RGB 15, 15, 15

	RGB 31, 25, 17
	RGB 31, 31, 31
	RGB 25, 17, 31
	RGB 19, 19, 19

	RGB 31, 27, 21
	RGB 31, 31, 31
	RGB 27, 21, 31
	RGB 23, 23, 23

	RGB 31, 29, 25
	RGB 31, 31, 31
	RGB 29, 26, 31
	RGB 27, 27, 27

	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31
else
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK

	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK

	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_DARK

	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_DARK

	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_LIGHT

	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_LIGHT

	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE

	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
endc
; e51dc

CrystalIntro_InitUnownAnim: ; e51dc (39:51dc)
	push de
	ld a, SPRITE_ANIM_INDEX_INTRO_UNOWN
	farcall _InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_0C
	add hl, bc
	ld [hl], $8
	ld a, SPRITE_ANIM_FRAMESET_INTRO_UNOWN_4
	farcall ReinitSpriteAnimFrame
	pop de

	push de
	ld a, SPRITE_ANIM_INDEX_INTRO_UNOWN
	farcall _InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_0C
	add hl, bc
	ld [hl], $18
	ld a, SPRITE_ANIM_FRAMESET_INTRO_UNOWN_3
	farcall ReinitSpriteAnimFrame
	pop de

	push de
	ld a, SPRITE_ANIM_INDEX_INTRO_UNOWN
	farcall _InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_0C
	add hl, bc
	ld [hl], $28
	ld a, SPRITE_ANIM_FRAMESET_INTRO_UNOWN_1
	farcall ReinitSpriteAnimFrame
	pop de

	ld a, SPRITE_ANIM_INDEX_INTRO_UNOWN
	farcall _InitSpriteAnimStruct
	ld hl, SPRITEANIMSTRUCT_0C
	add hl, bc
	ld [hl], $38
	ld a, SPRITE_ANIM_FRAMESET_INTRO_UNOWN_2
	jp ReinitSpriteAnimFrame

CrystalIntro_UnownFade: ; e5223 (39:5223)
	add a
	add a
	add a
	ld e, a
	ld d, $0
	ld hl, wBGPals
	add hl, de
	inc hl
	inc hl
	ld a, [wcf65]
	and $3f
	cp $1f
	jr z, .okay
	jr c, .okay
	ld c, a
	ld a, $3f
	sub c
.okay

	ld c, a
	ld b, $0
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a

	push hl
	push bc
	ld hl, wBGPals
if !DEF(MONOCHROME)
	ld bc, 8 palettes
	xor a
	call ByteFill
else
	ld b, (8 palettes) / 2
.mono_loop
	ld a, PAL_MONOCHROME_BLACK % $100
	ld [hli], a
	ld a, PAL_MONOCHROME_BLACK / $100
	ld [hli], a
	dec b
	jr nz, .mono_loop
endc
	pop bc
	pop hl

	push hl
	ld hl, .BWFade
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop hl
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a

	push hl
	ld hl, .BlackLBlueFade
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop hl
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a

	push hl
	ld hl, .BlackBlueFade
	add hl, bc
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop hl
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a

	pop af
	ldh [rSVBK], a
	ld a, $1
	ldh [hCGBPalUpdate], a
	ret
; e5288 (39:5288)

.BWFade: ; e5288
; Fade between black and white.
if !DEF(MONOCHROME)
DEF hue = 0
rept 32
	RGB hue, hue, hue
DEF hue = hue + 1
endr
else
rept 8
	RGB_MONOCHROME_BLACK
endr
rept 8
	RGB_MONOCHROME_DARK
endr
rept 8
	RGB_MONOCHROME_LIGHT
endr
rept 8
	RGB_MONOCHROME_WHITE
endr
endc
; e52c8

.BlackLBlueFade: ; e52c8
; Fade between black and light blue.
if !DEF(MONOCHROME)
DEF hue = 0
rept 32
	RGB 0, hue / 2, hue
DEF hue = hue + 1
endr
else
rept 8
	RGB_MONOCHROME_BLACK
endr
rept 8
	RGB_MONOCHROME_DARK
endr
rept 8
	RGB_MONOCHROME_LIGHT
endr
rept 8
	RGB_MONOCHROME_LIGHT
endr
endc
; e5308

.BlackBlueFade: ; e5308
; Fade between black and blue.
if !DEF(MONOCHROME)
DEF hue = 0
rept 32
	RGB 0, 0, hue
DEF hue = hue + 1
endr
else
rept 8
	RGB_MONOCHROME_BLACK
endr
rept 8
	RGB_MONOCHROME_DARK
endr
rept 8
	RGB_MONOCHROME_DARK
endr
rept 8
	RGB_MONOCHROME_DARK
endr
endc
; e5348

Intro_Scene20_AppearUnown: ; e5348 (39:5348)
; Spawn the palette for the nth Unown
	and a
	jr nz, .load_pal_2

	ld hl, .pal1
	jr .got_pointer

.load_pal_2
	ld hl, .pal2

.got_pointer
	ld a, [wcf65]
	and $7
	add a
	add a
	add a
	ld c, a
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a

	push bc
	ld de, wBGPals

	ld a, c
	add e
	ld e, a
	ld a, 0 ; not xor a; preserve carry flag?
	adc d
	ld d, a

	ld bc, 8
	rst CopyBytes
	pop bc

	ld de, wUnknBGPals
	ld a, c
	add e
	ld e, a
	ld a, 0 ; not xor a; preserve carry flag?
	adc d
	ld d, a

	ld bc, 8
	rst CopyBytes

	pop af
	ldh [rSVBK], a
	ld a, $1
	ldh [hCGBPalUpdate], a
	ret
; e538d (39:538d)

.pal1 ; e538d
if !DEF(MONOCHROME)
	RGB 24, 12, 09
	RGB 31, 31, 31
	RGB 12, 00, 31
	RGB 00, 00, 00
else
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
endc
; e5395

.pal2 ; e5395
if !DEF(MONOCHROME)
	RGB 24, 12, 09
	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31
else
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
endc
; e539d

Intro_FadeUnownWordPals: ; e539d (39:539d)
	add a
	add a
	add a
	ld e, a
	ld d, $0
	ld hl, wBGPals
	add hl, de
rept 4
	inc hl
endr
	ld a, [wcf65]
	add a
	ld c, a
	ld b, $0

	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a

	push hl
	ld hl, .FastFadePalettes
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop hl
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a

	push hl
	ld hl, .SlowFadePalettes
	add hl, bc
	ld a, [hli]
	ld d, [hl]
	ld e, a
	pop hl
	ld a, e
	ld [hli], a
	ld a, d
	ld [hli], a

	pop af
	ldh [rSVBK], a
	ld a, $1
	ldh [hCGBPalUpdate], a
	ret
; e53db (39:53db)

.FastFadePalettes: ; e53db
if !DEF(MONOCHROME)
DEF hue = 31
rept 8
	RGB hue, hue, hue
DEF hue = hue + -1
	RGB hue, hue, hue
DEF hue = hue + -2
endr
else
rept 4
	RGB_MONOCHROME_WHITE
endr
rept 4
	RGB_MONOCHROME_LIGHT
endr
rept 4
	RGB_MONOCHROME_DARK
endr
rept 4
	RGB_MONOCHROME_BLACK
endr
endc
; e53fb

.SlowFadePalettes: ; e53fb
if !DEF(MONOCHROME)
DEF hue = 31
rept 16
	RGB hue, hue, hue
DEF hue = hue + -1
endr
else
rept 8
	RGB_MONOCHROME_WHITE
endr
rept 8
	RGB_MONOCHROME_DARK
endr
endc
; e541b

Intro_LoadTilemap: ; e541b (39:541b)
	ldh a, [rSVBK]
	push af
	ld a, $6
	ldh [rSVBK], a

	ld hl, wScratchTileMap
	decoord 0, 0
	ld b, SCREEN_HEIGHT
.row
	ld c, SCREEN_WIDTH
.col
	ld a, [hli]
	ld [de], a
	inc de
	dec c
	jr nz, .col
	; add hl, $20 - SCREEN_WIDTH
	ld a, $20 - SCREEN_WIDTH
	add l
	ld l, a
	ld a, 0 ; not xor a; preserve carry flag?
	adc h
	ld h, a
	dec b
	jr nz, .row

	pop af
	ldh [rSVBK], a
	ret

Intro_Scene16_AnimateSuicune: ; e5441 (39:5441)
	ld a, [wIntroSceneFrameCounter]
	and $3
	jr z, Intro_ColoredSuicuneFrameSwap
	cp $3
	jr z, .PrepareForSuicuneSwap
	ret

.PrepareForSuicuneSwap:
	xor a
	ldh [hBGMapMode], a
	ret

Intro_ColoredSuicuneFrameSwap: ; e5451 (39:5451)
	hlcoord 0, 0
	ld bc, SCREEN_HEIGHT * SCREEN_WIDTH
.loop
	ld a, [hl]
	and a
	jr z, .skip
	cp $80
	jr nc, .skip
	xor $8
	ld [hl], a
.skip
	inc hl
	dec bc
	ld a, c
	or b
	jr nz, .loop
	ld a, $1
	ldh [hBGMapMode], a
	ret

Intro_RustleGrass: ; e546d (39:546d)
	ld a, [wIntroSceneFrameCounter]
	cp 36
	ret nc
	and $c
	srl a
	ld e, a
	ld d, $0
	ld hl, .RustlingGrassPointers
	add hl, de
	ld a, [hli]
	ldh [hRequestedVTileSource], a
	ld a, [hli]
	ldh [hRequestedVTileSource + 1], a
	ld a, (VTiles2 tile $09) % $100
	ldh [hRequestedVTileDest], a
	ld a, (VTiles2 tile $09) / $100
	ldh [hRequestedVTileDest + 1], a
	ld a, 4
	ldh [hRequested2bpp], a
	ret
; e5496 (39:5496)

.RustlingGrassPointers: ; e5496
	dw IntroGrass1GFX
	dw IntroGrass2GFX
	dw IntroGrass3GFX
	dw IntroGrass2GFX
; e549e

Intro_SetCGBPalUpdate: ; e549e (39:549e)
	ld a, $1
	ldh [hCGBPalUpdate], a
	ret

Intro_ClearBGPals: ; e54a3 (39:54a3)
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a

; Fill wBGPals and wOBPals with $0000 (black)
	ld hl, wBGPals
if !DEF(MONOCHROME)
	ld bc, 16 palettes
	xor a
	call ByteFill
else
	ld b, (16 palettes) / 2
.mono_loop
	ld a, PAL_MONOCHROME_BLACK % $100
	ld [hli], a
	ld a, PAL_MONOCHROME_BLACK / $100
	ld [hli], a
	dec b
	jr nz, .mono_loop
endc

	pop af
	ldh [rSVBK], a
	ld a, $1
	ldh [hCGBPalUpdate], a
	ld c, 64
	jp DelayFrames

Intro_DecompressRequest2bpp_64Tiles: ; e54fa (39:54fa)
	lb bc, 1, 64
	jr Intro_DecompressRequest2bpp

Intro_DecompressRequest2bpp_128Tiles: ; e54c2 (39:54c2)
	lb bc, 1, 128
	jr Intro_DecompressRequest2bpp

Intro_DecompressRequest2bpp_255Tiles: ; e54de (39:54de)
	lb bc, 1, 255
Intro_DecompressRequest2bpp:
	ldh a, [rSVBK]
	push af
	ld a, $6
	ldh [rSVBK], a

	push bc
	push de
	ld de, wDecompressScratch
	call Decompress
	pop hl
	pop bc

	ld de, wDecompressScratch
	call Request2bpp

	pop af
	ldh [rSVBK], a
	ret

Intro_ResetLYOverrides: ; e5516 (39:5516)
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a

	ld hl, wLYOverrides
	ld bc, wLYOverridesEnd - wLYOverrides
	xor a
	call ByteFill

	pop af
	ldh [rSVBK], a
	ld a, rSCX - $ff00
	ldh [hLCDCPointer], a
	ret

Intro_PerspectiveScrollBG: ; e552f (39:552f)
	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a
	; Scroll the grass every frame.
	; Scroll the trees every other frame and at half speed.
	; This creates an illusion of perspective.
	ld a, [wIntroSceneFrameCounter]
	and $1
	jr z, .skip
	; trees in the back
	ld hl, wLYOverrides
	ld a, [hl]
	inc a
	ld bc, $5f
	call ByteFill
.skip
	; grass in the front
	ld hl, wLYOverrides + $5f
	ld a, [hl]
	inc a
	inc a
	ld bc, $31
	call ByteFill
	ld a, [wLYOverrides + 0]
	ldh [hSCX], a
	pop af
	ldh [rSVBK], a
	ret

IntroSuicuneRunGFX: ; e555d
INCBIN "gfx/intro/suicune_run.2bpp.lz"
; e592d

IntroPichuWooperGFX: ; e592d
INCBIN "gfx/intro/pichu_wooper.2bpp.lz"
; e5c7d

IntroTilemap003: ; e5ecd
INCBIN "gfx/intro/003.tilemap.lz"
; e5edd

Intro_SetupCommonScenery:
	ld hl, IntroBackgroundGFX
	ld de, VTiles2 tile $00
	call Intro_DecompressRequest2bpp_128Tiles

	ld hl, IntroTilemap004
	debgcoord 0, 0
	call Intro_DecompressRequest2bpp_64Tiles

	ldh a, [rSVBK]
	push af
	ld a, $5
	ldh [rSVBK], a

	ld hl, Palette_e5edd
	ld de, wUnknBGPals
	ld bc, 16 palettes
	rst CopyBytes

	ld hl, Palette_e5edd
	ld de, wBGPals
	ld bc, 16 palettes
	rst CopyBytes

	pop af
	ldh [rSVBK], a

	xor a
	ldh [hSCX], a
	ldh [hSCY], a

	ld a, $7
	ldh [hWX], a

	ld a, $90
	ldh [hWY], a
	ret

IntroBackgroundGFX: ; e5c7d
INCBIN "gfx/intro/background.2bpp.lz"
; e5e6d

IntroTilemap004: ; e5e6d
INCBIN "gfx/intro/004.tilemap.lz"
; e5ecd

Palette_e5edd: ; e5edd
if !DEF(MONOCHROME)
	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB  0,  4,  5
	RGB  1,  8,  5
	RGB  4, 12,  9
	RGB 24, 12,  9

	RGB  0,  4,  5
	RGB  9,  6,  8
	RGB  8, 16,  5
	RGB  5, 10,  4

	RGB 31, 31, 31
	RGB  9,  6,  8
	RGB 18,  9,  9
	RGB 13,  8,  9

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB  2,  5, 22
	RGB  1,  5, 12

	RGB 31, 31, 31
	RGB 31, 10, 25
	RGB 31, 21,  0
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 21, 31
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0
else
	MONOCHROME_RGB_FOUR
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_BLACK
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
endc

IntroUnownsGFX: ; e5f5d
INCBIN "gfx/intro/unowns.2bpp.lz"
; e634d

IntroPulseGFX: ; e634d
INCBIN "gfx/intro/pulse.2bpp.lz"
; e63dd

IntroTilemap002: ; e63dd
INCBIN "gfx/intro/002.tilemap.lz"
; e641d

IntroTilemap001: ; e641d
INCBIN "gfx/intro/001.tilemap.lz"
; e642d

IntroTilemap006: ; e642d
INCBIN "gfx/intro/006.tilemap.lz"
; e647d

IntroTilemap005: ; e647d
INCBIN "gfx/intro/005.tilemap.lz"
; e649d

IntroTilemap008: ; e649d
INCBIN "gfx/intro/008.tilemap.lz"
; e655d

IntroTilemap007: ; e655d
INCBIN "gfx/intro/007.tilemap.lz"
; e65ad

Palette_365ad: ; e65ad
if !DEF(MONOCHROME)
	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  0,  0,  0

	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  0,  0,  0

	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  0,  0,  0

	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  0,  0,  0

	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  0,  0,  0

	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  0,  0,  0

	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  0,  0,  0

	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  0,  0,  0
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 10,  0, 10
	RGB 19,  0, 19
	RGB 31,  0, 31

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0
else
rept 8
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_BLACK
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_LIGHT
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
endc

IntroCrystalUnownsGFX: ; e662d
INCBIN "gfx/intro/crystal_unowns.2bpp.lz"
; e672d

IntroTilemap017: ; e672d
INCBIN "gfx/intro/017.tilemap.lz"
; e676d

IntroTilemap015: ; e676d
INCBIN "gfx/intro/015.tilemap.lz"
; e679d

Palette_e679d: ; e679d
if !DEF(MONOCHROME)
	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31

	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31

	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31

	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31

	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31

	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31

	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31

	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 31, 31, 31

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0
else
rept 8
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
endr
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
endc

IntroSuicuneCloseGFX: ; e681d
INCBIN "gfx/intro/suicune_close.2bpp.lz"
; e6c3d

IntroTilemap012: ; e6c3d
INCBIN "gfx/intro/012.tilemap.lz"
; e6d0d

IntroTilemap011: ; e6d0d
INCBIN "gfx/intro/011.tilemap.lz"
; e6d6d

Palette_e6d6d: ; e6d6d
if !DEF(MONOCHROME)
	RGB 24, 12,  9
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 24, 12,  9
	RGB 31, 31, 31
	RGB  8,  9, 31
	RGB  0,  0,  0

	RGB 24, 12,  9
	RGB 12, 20, 31
	RGB 19,  8, 31
	RGB  0,  0,  0

	RGB 12, 20, 31
	RGB  8,  9, 31
	RGB 19,  8, 31
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 12, 20, 31
	RGB  8,  9, 31
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0
else
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
endc

IntroSuicuneJumpGFX: ; e6ded
INCBIN "gfx/intro/suicune_jump.2bpp.lz"
; e72ad

IntroSuicuneBackGFX: ; e72ad
INCBIN "gfx/intro/suicune_back.2bpp.lz"
; e764d

IntroTilemap010: ; e764d
INCBIN "gfx/intro/010.tilemap.lz"
; e76ad

IntroTilemap009: ; e76ad
INCBIN "gfx/intro/009.tilemap.lz"
; e76bd

IntroTilemap014: ; e76bd
INCBIN "gfx/intro/014.tilemap.lz"
; e778d

IntroTilemap013: ; e778d
INCBIN "gfx/intro/013.tilemap.lz"
; e77dd

Palette_e77dd: ; e77dd
if !DEF(MONOCHROME)
	RGB 24, 12,  9
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 24, 12,  9
	RGB 31, 31, 31
	RGB  8,  9, 31
	RGB  0,  0,  0

	RGB 24, 12,  9
	RGB 24, 12,  9
	RGB 24, 12,  9
	RGB 24, 12,  9

	RGB 24, 12,  9
	RGB 24, 12,  9
	RGB 24, 12,  9
	RGB 24, 12,  9

	RGB 24, 12,  9
	RGB 24, 12,  9
	RGB 24, 12,  9
	RGB 24, 12,  9

	RGB 24, 12,  9
	RGB 24, 12,  9
	RGB 24, 12,  9
	RGB 24, 12,  9

	RGB 24, 12,  9
	RGB 24, 12,  9
	RGB 24, 12,  9
	RGB 24, 12,  9

	RGB 24, 12,  9
	RGB 24, 12,  9
	RGB 24, 12,  9
	RGB 24, 12,  9

	RGB 31, 31, 31
	RGB 31, 31, 31
	RGB 12,  0, 31
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 21,  9,  0
	RGB 21,  9,  0
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0

	RGB 31, 31, 31
	RGB 20, 20, 20
	RGB 11, 11, 11
	RGB  0,  0,  0
else
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
rept 6
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_LIGHT
	RGB_MONOCHROME_LIGHT
endr
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
	RGB_MONOCHROME_WHITE
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_DARK
	RGB_MONOCHROME_BLACK
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
	MONOCHROME_RGB_FOUR
endc

IntroUnownBackGFX: ; e785d
INCBIN "gfx/intro/unown_back.2bpp.lz"
; e799d

IntroGrass1GFX: ; e799d
INCBIN "gfx/intro/grass1.2bpp"
IntroGrass2GFX: ; e79dd
INCBIN "gfx/intro/grass2.2bpp"
IntroGrass3GFX: ; e7a1d
INCBIN "gfx/intro/grass3.2bpp"
IntroGrass4GFX: ; e7a5d
INCBIN "gfx/intro/grass4.2bpp"

IntroLogoGFX: ; 109407
INCBIN "gfx/intro/logo.2bpp.lz"
