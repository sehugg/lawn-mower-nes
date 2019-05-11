bgm_levelclear_module subroutine
	.word .chn0,.chn1,.chn2,.chn3,.chn4,bgm_instruments
	.byte $06

.chn0
.chn0_0
	.byte $4c,$00,$4d,$00,$4c,$00,$4d,$00,$4c,$00,$4d,$00,$4c,$00,$4d,$00
	.byte $4c,$05,$4d,$05,$4c,$05,$4d,$05,$4c,$05,$4d,$05,$4c,$05,$4d,$05
	.byte $4c,$09,$4d,$09,$4c,$09,$4d,$09,$4c,$07,$4d,$07,$4c,$00,$80,$4d
	.byte $00,$86
.chn0_loop
.chn0_1
	.byte $9f
	.byte $fe
	.word .chn0_loop

.chn1
.chn1_0
	.byte $47,$0c,$4a,$0c,$47,$18,$4a,$0c,$47,$1f,$4a,$18,$47,$24,$4a,$1f
	.byte $47,$11,$4a,$24,$47,$1d,$4a,$11,$47,$21,$4a,$1d,$47,$24,$4a,$21
	.byte $47,$28,$4a,$24,$47,$26,$4a,$28,$47,$23,$4a,$26,$47,$24,$82,$4a
	.byte $24,$84
.chn1_loop
.chn1_1
	.byte $9f
	.byte $fe
	.word .chn1_loop

.chn2
.chn2_0
	.byte $4b,$0c,$80,$0c,$80,$48,$18,$80,$4b,$0c,$80,$11,$80,$11,$80,$48
	.byte $18,$80,$4b,$11,$80,$15,$80,$15,$80,$48,$18,$80,$41,$0c,$82,$3f
	.byte $84
.chn2_loop
.chn2_1
	.byte $9f
	.byte $fe
	.word .chn2_loop

.chn3
.chn3_0
	.byte $44,$0f,$80,$0f,$80,$49,$0f,$80,$44,$0f,$80,$0f,$80,$0f,$80,$49
	.byte $0f,$80,$44,$0f,$80,$0f,$80,$0f,$80,$49,$0f,$80,$44,$0f,$88
.chn3_loop
.chn3_1
	.byte $9f
	.byte $fe
	.word .chn3_loop

.chn4
.chn4_0
	.byte $c6,$81,$c4,$81,$c6,$81,$c4,$81,$c6,$81,$c4,$81,$c6,$81,$c4,$81
	.byte $c6,$81,$c4,$81,$c6,$81,$c4,$81,$c6,$81,$c4,$81,$c6,$81,$c4,$81
.chn4_loop
.chn4_1
	.byte $9f
	.byte $fe
	.word .chn4_loop
