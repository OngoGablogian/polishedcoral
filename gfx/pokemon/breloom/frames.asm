	dw .frame1
	dw .frame2
	dw .frame3
	dw .frame4
	dw .frame5
.frame1
	db $00 ; bitmask
	db $31
.frame2
	db $01 ; bitmask
	db $31, $32, $33, $34, $35, $36, $37, $38
.frame3
	db $02 ; bitmask
	db $39, $3a, $3b, $3c, $3d, $3e, $3f, $40, $41, $42, $43, $44, $45, $46, $33, $47, $48, $49, $4a, $4b, $35, $36, $4c, $4d, $4e, $4f, $50, $37, $38
.frame4
	db $03 ; bitmask
	db $39, $3a, $02, $3d, $3e, $3f, $51, $52, $42, $43, $44, $45, $53, $54, $47, $48, $49, $55, $56, $35, $36, $4c, $4d, $4e, $4f, $50, $37, $38
.frame5
	db $04 ; bitmask
	db $57, $58, $59, $5a
