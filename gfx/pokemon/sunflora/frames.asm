	dw .frame1
	dw .frame2
	dw .frame3
	dw .frame4
.frame1
	db $00 ; bitmask
	db $24, $25, $26, $27, $28, $29, $2a, $2b, $2c, $2d, $2e, $2f, $30, $31, $32, $33, $34
.frame2
	db $01 ; bitmask
	db $24, $35, $36, $37, $38, $29, $39, $3a, $2b, $3b, $3c, $2d, $2e, $3d, $3e, $31, $32, $3f, $40, $41
.frame3
	db $02 ; bitmask
	db $39, $3c
.frame4
	db $03 ; bitmask
	db $42, $43
