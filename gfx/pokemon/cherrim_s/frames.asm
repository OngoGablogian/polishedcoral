	dw .frame1
	dw .frame2
	dw .frame3
	dw .frame4
	dw .frame5
	dw .frame6
.frame1
	db $00 ; bitmask
	db $24, $25, $26, $27, $28, $29, $2a, $2b
.frame2
	db $01 ; bitmask
	db $00, $2c, $2d, $2e, $2f, $30, $31, $32, $33, $34, $35, $36, $37, $38, $39, $3a, $00, $3b, $3c, $3d, $3e, $00, $3f, $40
.frame3
	db $02 ; bitmask
	db $00, $2c, $2d, $2e, $2f, $30, $31, $32, $33, $34, $41, $37, $38, $39, $42, $00, $3b, $3c, $00, $3f, $40
.frame4
	db $01 ; bitmask
	db $00, $2c, $2d, $2e, $2f, $30, $31, $32, $33, $34, $41, $36, $37, $38, $39, $3a, $00, $3b, $3c, $3d, $3e, $00, $3f, $40
.frame5
	db $03 ; bitmask
	db $43
.frame6
	db $04 ; bitmask
	db $44, $45, $27, $46
