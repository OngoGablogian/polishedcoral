	dw .frame1
	dw .frame2
	dw .frame3
	dw .frame4
	dw .frame5
.frame1
	db $00 ; bitmask
	db $31, $32, $33, $34, $35, $36
.frame2
	db $01 ; bitmask
	db $37, $38, $39, $3a, $3b, $3c, $3d, $3e, $3f, $40, $41, $42
.frame3
	db $02 ; bitmask
	db $43, $44, $45, $46, $47, $48, $49, $4a, $4b, $4c, $4d
.frame4
	db $03 ; bitmask
	db $4e, $45, $46, $4f, $50, $49, $4a, $51, $52, $4c, $4d
.frame5
	db $04 ; bitmask
	db $53, $54, $55
