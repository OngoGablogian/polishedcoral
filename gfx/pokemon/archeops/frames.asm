	dw .frame1
	dw .frame2
	dw .frame3
	dw .frame4
.frame1
	db $00 ; bitmask
	db $31, $32, $33
.frame2
	db $01 ; bitmask
	db $34, $35, $36, $37, $38, $39, $3a, $3b, $3c, $3d, $3e, $31, $3f, $40, $33, $41, $42, $43, $44, $45, $46, $47, $48, $49, $4a, $4b, $4c, $4d, $4e, $4f
.frame3
	db $02 ; bitmask
	db $50, $51, $38, $39, $52, $53, $3d, $3e, $31, $32, $40, $33, $41, $45, $54, $55, $4a, $56, $57, $4f
.frame4
	db $03 ; bitmask
	db $38, $39, $3d, $3e, $40, $41
