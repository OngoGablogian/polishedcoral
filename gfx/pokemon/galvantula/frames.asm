	dw .frame1
	dw .frame2
	dw .frame3
.frame1
	db $00 ; bitmask
	db $31, $32, $33, $34, $35, $36, $37, $38, $39, $3a, $3b, $3c, $3d, $3e, $3f, $40, $00, $41, $42, $43, $44, $45, $46
.frame2
	db $01 ; bitmask
	db $47, $48, $49, $4a, $4b, $4c, $4d, $3a, $3b, $4e, $4f, $50, $51, $52, $53
.frame3
	db $02 ; bitmask
	db $54, $55, $56, $57, $58, $59, $5a, $5b, $5c, $5d, $5e, $5f, $60
