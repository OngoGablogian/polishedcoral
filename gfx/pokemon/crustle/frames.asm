	dw .frame1
	dw .frame2
	dw .frame3
	dw .frame4
	dw .frame5
	dw .frame6
.frame1
	db $00 ; bitmask
	db $31, $32, $33, $34
.frame2
	db $01 ; bitmask
	db $31, $32, $35, $36, $37, $38, $39, $3a, $3b, $3c, $3d
.frame3
	db $02 ; bitmask
	db $3e, $3f, $40, $41, $42, $43, $31, $32, $35, $36, $37, $38, $39, $3a, $3b, $3c, $3d
.frame4
	db $03 ; bitmask
	db $44, $45, $46, $47, $48, $49
.frame5
	db $04 ; bitmask
	db $4a, $4b, $4c, $4d, $4e
.frame6
	db $05 ; bitmask
	db $4f, $50, $51, $52, $53
