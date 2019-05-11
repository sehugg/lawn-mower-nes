bgm_outoffuel_module subroutine
	.word .chn0,.chn1,.chn2,.chn3,.chn4,bgm_instruments
	.byte $06

.chn0
.chn0_0
	.byte $4c,$07,$4d,$07,$4c,$07,$4d,$07,$4c,$05,$4d,$05,$4c,$07,$4d,$07
	.byte $4c,$05,$4d,$05,$4c,$05,$4d,$05,$4c,$04,$4d,$04,$4c,$05,$4d,$05
	.byte $4c,$00,$82,$4d,$00,$82,$4c,$00,$82,$4d,$00,$82
.chn0_loop
.chn0_1
	.byte $9f
	.byte $fe
	.word .chn0_loop

.chn1
.chn1_0
	.byte $43,$17,$46,$17,$43,$17,$46,$17,$43,$15,$46,$17,$43,$17,$46,$15
	.byte $43,$15,$46,$17,$43,$15,$46,$15,$43,$13,$46,$15,$43,$15,$46,$13
	.byte $43,$10,$82,$46,$10,$8a
.chn1_loop
.chn1_1
	.byte $9f
	.byte $fe
	.word .chn1_loop

.chn2
.chn2_0
	.byte $4b,$13,$80,$13,$80,$48,$18,$80,$4b,$13,$80,$11,$80,$11,$80,$48
	.byte $18,$80,$4b,$11,$80,$0c,$86,$41,$0c,$82,$3f,$82
.chn2_loop
.chn2_1
	.byte $9f
	.byte $fe
	.word .chn2_loop

.chn3
.chn3_0
	.byte $44,$0f,$80,$0f,$80,$49,$0f,$80,$44,$0f,$80,$0f,$80,$0f,$80,$49
	.byte $0f,$80,$44,$0f,$80,$0f,$8e
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
