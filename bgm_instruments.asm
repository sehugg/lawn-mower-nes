env_default
	.byte $c0,$7f,$00
env_vol0
	.byte $cf,$7f,$00
env_vol1
	.byte $c7,$c6,$c6,$c5,$c5,$c4,$c4,$c3,$06,$c2,$10,$c1,$0c,$c0,$7f,$0d
env_vol2
	.byte $ca,$c3,$c2,$c1,$04,$c0,$7f,$05
env_vol3
	.byte $c9,$c7,$c6,$c5,$c4,$c4,$c3,$c3,$c2,$08,$c1,$07,$c0,$7f,$0c
env_vol4
	.byte $c4,$c3,$c2,$05,$c1,$08,$c0,$7f,$06
env_vol5
	.byte $c0,$05,$7f,$01
env_vol6
	.byte $c9,$c9,$c8,$03,$c7,$05,$c6,$07,$c5,$08,$c4,$0a,$c3,$0e,$c2,$0f
	.byte $c1,$0e,$c0,$7f,$12
env_vol7
	.byte $cf,$cf,$c0,$7f,$02
env_vol8
	.byte $c3,$03,$c4,$03,$c2,$07,$c1,$0a,$c0,$7f,$08
env_vol9
	.byte $cf,$03,$c0,$7f,$02
env_vol10
	.byte $c5,$c5,$c4,$c4,$c3,$c3,$c2,$04,$c1,$05,$c0,$7f,$0a
env_vol11
	.byte $c2,$07,$c1,$08,$c0,$7f,$04
env_vol12
	.byte $c4,$03,$c0,$7f,$02
env_vol13
	.byte $cf,$7f,$00
env_vol14
	.byte $c1,$08,$c2,$08,$c3,$08,$c2,$08,$c1,$08,$c0,$7f,$0a
env_vol15
	.byte $c4,$c5,$c6,$c6,$c5,$c4,$c3,$c2,$04,$c1,$04,$c0,$7f,$0b
env_arp0
	.byte $c6,$c0,$7f,$01
env_arp1
	.byte $cc,$ce,$c0,$7f,$02
env_arp2
	.byte $d2,$cc,$c0,$7f,$02
env_pitch0
	.byte $c1,$0b,$c2,$c2,$c3,$c3,$c4,$c4,$c3,$c3,$c2,$c2,$c1,$c1,$7f,$02
env_pitch1
	.byte $c0,$10,$c1,$c2,$c3,$c4,$c5,$c6,$c5,$c4,$c3,$c2,$c1,$c0,$7f,$02
env_pitch2
	.byte $c4,$7f,$00
env_pitch3
	.byte $c1,$c1,$c2,$c2,$c1,$c1,$c0,$c0,$7f,$00
bgm_instruments
	.word env_default,env_default,env_default
	.byte $30,$00
	.word env_vol0,env_default,env_pitch1
	.byte $30,$00
	.word env_vol1,env_default,env_default
	.byte $70,$00
	.word env_vol6,env_default,env_pitch0
	.byte $b0,$00
	.word env_vol2,env_default,env_default
	.byte $30,$00
	.word env_vol3,env_default,env_default
	.byte $30,$00
	.word env_vol4,env_default,env_pitch1
	.byte $b0,$00
	.word env_vol6,env_default,env_pitch0
	.byte $30,$00
	.word env_vol7,env_arp0,env_default
	.byte $30,$00
	.word env_vol8,env_arp1,env_default
	.byte $30,$00
	.word env_vol4,env_default,env_default
	.byte $30,$00
	.word env_vol9,env_default,env_default
	.byte $30,$00
	.word env_vol10,env_default,env_default
	.byte $70,$00
	.word env_vol11,env_default,env_default
	.byte $70,$00
	.word env_vol12,env_arp1,env_default
	.byte $30,$00
	.word env_vol6,env_default,env_default
	.byte $b0,$00
	.word env_vol4,env_default,env_default
	.byte $70,$00
	.word env_vol1,env_default,env_pitch2
	.byte $70,$00
	.word env_vol13,env_arp2,env_default
	.byte $30,$00
	.word env_vol15,env_default,env_default
	.byte $30,$00