	dw .frame1
	dw .frame2
	dw .frame3
	dw .frame4
	dw .frame5
	dw .frame6
	dw .frame7
.frame1
	db $00 ; bitmask
	db $15, $31, $32, $33, $34, $35, $36, $37, $38, $39, $3a, $15, $3b, $3c, $3d, $3e, $3f, $40, $41, $42, $43, $44, $45, $46, $47, $48
.frame2
	db $01 ; bitmask
	db $49, $4a, $4b, $15, $4c, $32, $33, $4d, $4e, $4f, $50, $51, $35, $36, $15, $52, $53, $37, $38, $54, $55, $39, $3a, $15, $3b, $3c, $3d, $3e, $3f, $40, $41, $42, $43, $15, $56, $46, $47, $48
.frame3
	db $02 ; bitmask
	db $57, $58, $15, $15, $31, $32, $33, $59, $5a, $5b, $34, $35, $36, $5c, $5d, $5e, $37, $38, $39, $3a, $15, $3b, $3c, $3d, $3e, $5f, $60, $41, $42, $43, $44, $45, $46, $47, $48
.frame4
	db $03 ; bitmask
	db $49, $4a, $4b, $4d, $4e, $4f, $15, $52, $61, $54, $55
.frame5
	db $04 ; bitmask
	db $57, $58, $15, $59, $5a, $5b, $5c, $5d, $5e
.frame6
	db $05 ; bitmask
	db $15, $4c, $32, $33, $50, $51, $35, $36, $37, $38, $39, $3a, $15, $3b, $3c, $3d, $3e, $3f, $40, $41, $42, $43, $15, $56, $46, $47, $48
.frame7
	db $00 ; bitmask
	db $15, $31, $32, $33, $34, $35, $36, $37, $38, $39, $3a, $15, $3b, $3c, $3d, $3e, $5f, $60, $41, $42, $43, $44, $45, $46, $47, $48
