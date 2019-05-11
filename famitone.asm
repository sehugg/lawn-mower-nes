;FamiTone audio library v1.23
;by Shiru (shiru@mail.ru) 05'11
;The name is suggested by Memblers from NesDev
;Feel free to do anything you want with this code, consider it Public Domain






;aliases for APU registers

APU_PL1_VOL		equ $4000
APU_PL1_SWEEP	equ $4001
APU_PL1_LO		equ $4002
APU_PL1_HI		equ $4003
APU_PL2_VOL		equ $4004
APU_PL2_SWEEP	equ $4005
APU_PL2_LO		equ $4006
APU_PL2_HI		equ $4007
APU_TRI_LINEAR	equ $4008
APU_TRI_LO		equ $400a
APU_TRI_HI		equ $400b
APU_NOISE_VOL	equ $400c
APU_NOISE_LO	equ $400e
APU_NOISE_HI	equ $400f
APU_DMC_FREQ	equ $4010
APU_DMC_RAW		equ $4011
APU_DMC_START	equ $4012
APU_DMC_LEN		equ $4013
APU_SND_CHN		equ $4015

;all the FamiTone variables take 112+15*FT_SFX_STREAMS bytes in a RAM page

FT_FRAME_CNT		equ FT_BASE_ADR
FT_SONG_SPEED		equ FT_BASE_ADR+1
FT_INSTRUMENT_L		equ FT_BASE_ADR+2
FT_INSTRUMENT_H		equ FT_BASE_ADR+3
FT_PULSE1_PREV		equ FT_BASE_ADR+4
FT_PULSE2_PREV		equ FT_BASE_ADR+5
FT_CHANNELS			equ FT_BASE_ADR+6
FT_CH1_VARS			equ FT_CHANNELS
FT_CH2_VARS			equ FT_CHANNELS+9
FT_CH3_VARS			equ FT_CHANNELS+18
FT_CH4_VARS			equ FT_CHANNELS+27
FT_CH5_VARS			equ FT_CHANNELS+36
FT_ENVELOPES		equ FT_BASE_ADR+51
FT_CH1_ENVS			equ FT_ENVELOPES	;three envelopes (5*3 bytes) for pulse and triangle
FT_CH2_ENVS			equ FT_ENVELOPES+15
FT_CH3_ENVS			equ FT_ENVELOPES+30
FT_CH4_ENVS			equ FT_ENVELOPES+45	;only two envelopes (5*2 bytes) for noise
FT_DPCM_TABLE_L		equ FT_BASE_ADR+106
FT_DPCM_TABLE_H		equ FT_BASE_ADR+107
FT_DPCM_EFFECT		equ FT_BASE_ADR+108
FT_SFX_ADR_L		equ FT_BASE_ADR+109
FT_SFX_ADR_H		equ FT_BASE_ADR+110
FT_PAL_ADJUST		equ FT_BASE_ADR+111

;envelope variables offsets, every envelope uses 5 bytes

FT_ENV_STRUCT_SIZE	equ 5
FT_ENV_VALUE		equ FT_BASE_ADR+0
FT_ENV_REPEAT		equ FT_BASE_ADR+1
FT_ENV_ADR_L		equ FT_BASE_ADR+2
FT_ENV_ADR_H		equ FT_BASE_ADR+3
FT_ENV_PTR			equ FT_BASE_ADR+4

;channels variables offsets, every channel uses 9 bytes

FT_CHN_STRUCT_SIZE	equ 9
FT_CHN_REPEAT		equ FT_BASE_ADR+0
FT_CHN_NOTE			equ FT_BASE_ADR+1
FT_CHN_INSTRUMENT	equ FT_BASE_ADR+2
FT_CHN_DUTY			equ FT_BASE_ADR+3
FT_CHN_PTR_L		equ FT_BASE_ADR+4
FT_CHN_PTR_H		equ FT_BASE_ADR+5
FT_CHN_RETURN_L		equ FT_BASE_ADR+6
FT_CHN_RETURN_H		equ FT_BASE_ADR+7
FT_CHN_REF_LEN		equ FT_BASE_ADR+8

;aliases for outputs

FT_CH1_NOTE			equ FT_CH1_VARS+<(FT_CHN_NOTE)
FT_CH2_NOTE			equ FT_CH2_VARS+<(FT_CHN_NOTE)
FT_CH3_NOTE			equ FT_CH3_VARS+<(FT_CHN_NOTE)
FT_CH4_NOTE			equ FT_CH4_VARS+<(FT_CHN_NOTE)
FT_CH5_NOTE			equ FT_CH5_VARS+<(FT_CHN_NOTE)
FT_CH1_VOLUME		equ FT_CH1_ENVS+<(FT_ENV_VALUE)
FT_CH2_VOLUME		equ FT_CH2_ENVS+<(FT_ENV_VALUE)
FT_CH3_VOLUME		equ FT_CH3_ENVS+<(FT_ENV_VALUE)
FT_CH4_VOLUME		equ FT_CH4_ENVS+<(FT_ENV_VALUE)
FT_CH1_NOTE_OFF		equ FT_CH1_ENVS+<(FT_ENV_VALUE)+FT_ENV_STRUCT_SIZE
FT_CH2_NOTE_OFF		equ FT_CH2_ENVS+<(FT_ENV_VALUE)+FT_ENV_STRUCT_SIZE
FT_CH3_NOTE_OFF		equ FT_CH3_ENVS+<(FT_ENV_VALUE)+FT_ENV_STRUCT_SIZE
FT_CH4_NOTE_OFF		equ FT_CH4_ENVS+<(FT_ENV_VALUE)+FT_ENV_STRUCT_SIZE
FT_CH1_PITCH_OFF	equ FT_CH1_ENVS+<(FT_ENV_VALUE)+FT_ENV_STRUCT_SIZE*2
FT_CH2_PITCH_OFF	equ FT_CH2_ENVS+<(FT_ENV_VALUE)+FT_ENV_STRUCT_SIZE*2
FT_CH3_PITCH_OFF	equ FT_CH3_ENVS+<(FT_ENV_VALUE)+FT_ENV_STRUCT_SIZE*2
FT_CH1_DUTY			equ FT_CH1_VARS+<(FT_CHN_DUTY)
FT_CH2_DUTY			equ FT_CH2_VARS+<(FT_CHN_DUTY)
FT_CH3_DUTY			equ FT_CH3_VARS+<(FT_CHN_DUTY)
FT_CH4_DUTY			equ FT_CH4_VARS+<(FT_CHN_DUTY)

;output buffer, used then sound effects are enabled

FT_OUT_BUF			equ FT_BASE_ADR+112	;11 bytes

;aliases for APU registers for music FamiTone

	IFNCONST FT_SFX_ENABLE			;if sound effects are disabled, just write to APU
FT_MR_PULSE1_V		equ APU_PL1_VOL
FT_MR_PULSE1_L		equ APU_PL1_LO
FT_MR_PULSE1_H		equ APU_PL1_HI
FT_MR_PULSE2_V		equ APU_PL2_VOL
FT_MR_PULSE2_L		equ APU_PL2_LO
FT_MR_PULSE2_H		equ APU_PL2_HI
FT_MR_TRI_V			equ APU_TRI_LINEAR
FT_MR_TRI_L			equ APU_TRI_LO
FT_MR_TRI_H			equ APU_TRI_HI
FT_MR_NOISE_V		equ APU_NOISE_VOL
FT_MR_NOISE_F		equ APU_NOISE_LO
	.else							;otherwise write to output buffer
FT_MR_PULSE1_V		equ FT_OUT_BUF
FT_MR_PULSE1_L		equ FT_OUT_BUF+1
FT_MR_PULSE1_H		equ FT_OUT_BUF+2
FT_MR_PULSE2_V		equ FT_OUT_BUF+3
FT_MR_PULSE2_L		equ FT_OUT_BUF+4
FT_MR_PULSE2_H		equ FT_OUT_BUF+5
FT_MR_TRI_V			equ FT_OUT_BUF+6
FT_MR_TRI_L			equ FT_OUT_BUF+7
FT_MR_TRI_H			equ FT_OUT_BUF+8
FT_MR_NOISE_V		equ FT_OUT_BUF+9
FT_MR_NOISE_F		equ FT_OUT_BUF+10
	.endif

;sound effect stream variables, 15 bytes per stream

FT_SFX_BASE_ADR		equ FT_BASE_ADR+123

FT_SFX_STRUCT_SIZE	equ 15
FT_SFX_REPEAT		equ FT_SFX_BASE_ADR
FT_SFX_PTR_L		equ FT_SFX_BASE_ADR+1
FT_SFX_PTR_H		equ FT_SFX_BASE_ADR+2
FT_SFX_OFF			equ FT_SFX_BASE_ADR+3
FT_SFX_BUF			equ FT_SFX_BASE_ADR+4	;11 bytes

;aliases for channels to use in user calls

FT_SFX_CH0			equ 0
FT_SFX_CH1			equ FT_SFX_STRUCT_SIZE
FT_SFX_CH2			equ FT_SFX_STRUCT_SIZE*2
FT_SFX_CH3			equ FT_SFX_STRUCT_SIZE*3



;reset APU, initialize FamiTone
;in: A 0 for PAL, not 0 for NTSC

FamiToneInit subroutine
	cmp #0
	beq .pal
	lda #$ff
.pal
	sta FT_PAL_ADJUST
	lda #$0f			;enable channels, stop DMC
	sta APU_SND_CHN
	lda #$81			;disable triangle length counter
	sta APU_TRI_LINEAR
	lda #$01			;load noise length
	sta APU_NOISE_HI

	lda #$30			;volumes to 0
	sta APU_PL1_VOL
	sta APU_PL2_VOL
	sta APU_NOISE_VOL
	lda #$08			;no sweep
	sta APU_PL1_SWEEP
	sta APU_PL2_SWEEP

	lda #$ff
	sta FT_PULSE1_PREV
	sta FT_PULSE2_PREV



;stop music that currently plays (it is a part of FamiToneInit as well)

FamiToneMusicStop subroutine
	ldy #0					;reset all the channels variables
	ldx #<(FT_CHANNELS)
	lda #5
	sta FT_TEMP+2
.setChannels
	lda #0
	sta FT_CHN_PTR_L,x
	sta FT_CHN_PTR_H,x
	sta FT_CHN_REPEAT,x
	sta FT_CHN_REF_LEN,x
	sta FT_CHN_INSTRUMENT,x
	lda #63
	sta FT_CHN_NOTE,x
	lda #$30
	sta FT_CHN_DUTY,x
	txa
	clc
	adc #FT_CHN_STRUCT_SIZE
	tax
	dec <FT_TEMP+2
	bne .setChannels

	lda #0					;reset volumes
	sta FT_CH1_VOLUME
	sta FT_CH2_VOLUME
	sta FT_CH3_VOLUME
	sta FT_CH4_VOLUME
	sta FT_DPCM_EFFECT		;no DPCM effect playing
	sta FT_SONG_SPEED		;no music playing

	rts



;start playing a music
;in: X,Y address of the module (LSB,MSB)

FamiToneMusicPlay subroutine
	stx <FT_TEMP
	sty <FT_TEMP+1
	
	lda FT_PAL_ADJUST
	cmp #$ff
	beq .noSetAdjust
	lda #0
	sta FT_PAL_ADJUST
.noSetAdjust

	ldy #0
	ldx #<(FT_CHANNELS)
	lda #5
	sta FT_TEMP+2
.setChannels
	lda (FT_TEMP),y
	sta FT_CHN_PTR_L,x
	iny
	lda (FT_TEMP),y
	sta FT_CHN_PTR_H,x
	iny

	lda #0
	sta FT_CHN_REPEAT,x
	sta FT_CHN_REF_LEN,x
	sta FT_CHN_INSTRUMENT,x
	lda #63
	sta FT_CHN_NOTE,x
	lda #$30
	sta FT_CHN_DUTY,x

	txa
	clc
	adc #FT_CHN_STRUCT_SIZE
	tax
	dec <FT_TEMP+2
	bne .setChannels

	lda (FT_TEMP),y
	iny
	sta FT_INSTRUMENT_L
	lda (FT_TEMP),y
	iny
	sta FT_INSTRUMENT_H

	lda (FT_TEMP),y
	sta FT_SONG_SPEED
	lda #0
	sta FT_FRAME_CNT

	lda #4
	sta <FT_TEMP+6
	ldx #<(FT_ENVELOPES)
.setEnvelopes
	txa
	pha
	lda #0
	jsr setInstrument
	pla
	adc #FT_ENV_STRUCT_SIZE*3
	tax
	dec <FT_TEMP+6
	bne .setEnvelopes

	rts



;pause and unpause current music
;in: A 0 or not 0 to play or pause

FamiToneMusicPause subroutine
	tax
	lda FT_SONG_SPEED
	cpx #0
	beq .play
	ora #$80
	bne .set
.play
	and #$7f
.set
	sta FT_SONG_SPEED
	rts
	
	
;update FamiTone state, should be called every TV frame

FamiToneUpdate subroutine
	ldx FT_PAL_ADJUST			;for PAL mode count 0..4
	bmi .noAdjust
	inx
	cpx #5
	bne .noSkip
	ldx #0
.noSkip
	stx FT_PAL_ADJUST
.noAdjust

	lda FT_SONG_SPEED
	beq .noMusic
	bmi .noMusic				;music paused
	
	lda FT_FRAME_CNT			;check TV frame counter
	bne .noRow					;if it is non-zero, it is a middle of a row

	lda #<(FT_CHANNELS)		;start of a row, updating all the channels
	sta <FT_TEMP+4
	lda #<(FT_ENVELOPES)
	sta <FT_TEMP+5
	lda #4						;process pulse, triangle, and noise channels
	sta <FT_TEMP+6
	ldy #0
.processChns
	ldx <FT_TEMP+4
	jsr channelStep
	bcs .noNewNote				;check if there was a new note
	ldx <FT_TEMP+4				;setting up a new note with current instrument
	lda FT_CHN_INSTRUMENT,x
	ldx <FT_TEMP+5
	jsr setInstrument
	ldx <FT_TEMP+4
	sta FT_CHN_DUTY,x
.noNewNote
	lda <FT_TEMP+4				;next channel
	clc
	adc #FT_CHN_STRUCT_SIZE
	sta <FT_TEMP+4
	lda <FT_TEMP+5				;next envelopes block
	clc
	adc #FT_ENV_STRUCT_SIZE*3
	sta <FT_TEMP+5
	dec <FT_TEMP+6
	bne .processChns

	ldx #<(FT_CH5_VARS)		;hack to process Fxx in separate channel
	jsr channelStep				;other DPCM code is excluded

	IFNCONST FT_DPCM_ENABLE

	ldx #<(FT_CH5_VARS)
	jsr channelStep
	bcs .ch5done
	cmp #63
	bne .ch5note
	jsr FamiToneSampleStop
	jmp .ch5done
.ch5note
	lda FT_CH5_NOTE
	jsr FamiToneSampleStartM
.ch5done

	.endif

	lda FT_SONG_SPEED			;set TV frame counter
	sta FT_FRAME_CNT

.noRow
	lda #11						;now process all the envelopes (11 because noise has no pitch)
	sta <FT_TEMP+2
	ldx #<(FT_ENVELOPES)
.processEnvs
	txa
	pha
	jsr envelopeStep
	pla
	clc
	adc #FT_ENV_STRUCT_SIZE
	tax
	dec <FT_TEMP+2
	bne .processEnvs

.noMusic

	lda FT_SONG_SPEED
	bpl .noPause
	lda #$30
	sta FT_MR_PULSE1_V
	sta FT_MR_PULSE2_V
	sta FT_MR_NOISE_V
	lda #$80
	sta FT_MR_TRI_V
	jmp .noSkipM
.noPause

;converting output values and sending them to the APU or into output buffer

	lda FT_CH1_NOTE
	cmp #63
	bne .ch1note
	lda #0
	jmp .ch1cut
.ch1note
	clc
	adc FT_CH1_NOTE_OFF
	asl
	tax
	lda FT_CH1_PITCH_OFF
	pha
	adc noteTable,x
	sta FT_MR_PULSE1_L
	pla
	ora #$7f
	bmi .ch1sign
	lda #0
.ch1sign
	adc noteTable+1,x

	IFNCONST FT_SFX_ENABLE
	cmp FT_PULSE1_PREV
	beq .ch1prev
	sta FT_PULSE1_PREV
	.endif

	sta FT_MR_PULSE1_H
.ch1prev
	lda FT_CH1_VOLUME
.ch1cut
	ora FT_CH1_DUTY
	sta FT_MR_PULSE1_V

	lda FT_CH2_NOTE
	cmp #63
	bne .ch2note
	lda #0
	jmp .ch2cut
.ch2note
	clc
	adc FT_CH2_NOTE_OFF
	asl
	tax
	lda FT_CH2_PITCH_OFF
	pha
	adc noteTable,x
	sta FT_MR_PULSE2_L
	pla
	ora #$7f
	bmi .ch2sign
	lda #0
.ch2sign
	adc noteTable+1,x

	IFNCONST FT_SFX_ENABLE
	cmp FT_PULSE2_PREV
	beq .ch2prev
	sta FT_PULSE2_PREV
	.endif

	sta FT_MR_PULSE2_H
.ch2prev
	lda FT_CH2_VOLUME
.ch2cut
	ora FT_CH2_DUTY
	sta FT_MR_PULSE2_V

	lda FT_CH3_NOTE
	cmp #63
	bne .ch3note
	lda #0
	jmp .ch3cut
.ch3note
	clc
	adc FT_CH3_NOTE_OFF
	asl
	tax
	lda FT_CH3_PITCH_OFF
	pha
	adc noteTable,x
	sta FT_MR_TRI_L
	pla
	ora #$7f
	bmi .ch3sign
	lda #0
.ch3sign
	adc noteTable+1,x
	sta FT_MR_TRI_H
	lda FT_CH3_VOLUME
.ch3cut
	ora #$80
	sta FT_MR_TRI_V

	lda FT_CH4_NOTE
	cmp #63
	bne .ch4note
	lda #0
	jmp .ch4cut
.ch4note
	clc
	adc FT_CH4_NOTE_OFF
	and #$0f
	eor #$0f
	sta <FT_TEMP
	lda FT_CH4_DUTY
	asl
	and #$80
	ora <FT_TEMP
	sta FT_MR_NOISE_F
	lda FT_CH4_VOLUME
.ch4cut
	ora #$f0
	sta FT_MR_NOISE_V

	dec FT_FRAME_CNT
	lda FT_PAL_ADJUST		;for PAL mode decrease row length every fifth frame
	bne .noSkipM
	dec FT_FRAME_CNT
.noSkipM

	IFNCONST FT_SFX_ENABLE

	rts

	.else

	ldx #FT_SFX_CH0			;process all the sound effects streams
	lda #FT_SFX_STREAMS
	sta <FT_TEMP+3
.updateSfxChannels
	jsr FamiToneSfxUpdate
	txa
	clc
	adc #FT_SFX_STRUCT_SIZE
	tax
	dec <FT_TEMP+3
	bne .updateSfxChannels

	lda FT_OUT_BUF			;now send data from output buffer to the APU
	sta APU_PL1_VOL
	lda FT_OUT_BUF+1
	sta APU_PL1_LO
	lda FT_OUT_BUF+2
	cmp FT_PULSE1_PREV
	beq .noUpdatePulse1
	sta FT_PULSE1_PREV
	sta APU_PL1_HI
.noUpdatePulse1
	lda FT_OUT_BUF+3
	sta APU_PL2_VOL
	lda FT_OUT_BUF+4
	sta APU_PL2_LO
	lda FT_OUT_BUF+5
	cmp FT_PULSE2_PREV
	beq .noUpdatePulse2
	sta FT_PULSE2_PREV
	sta APU_PL2_HI
.noUpdatePulse2
	lda FT_OUT_BUF+6
	sta APU_TRI_LINEAR
	lda FT_OUT_BUF+7
	sta APU_TRI_LO
	lda FT_OUT_BUF+8
	sta APU_TRI_HI

	lda FT_OUT_BUF+9
	sta APU_NOISE_VOL
	lda FT_OUT_BUF+10
	sta APU_NOISE_LO

	rts

.endif



;set envelopes of an instrument
;in:  A instrument number 0..31
;     X is offset of block of envelopes in the FamiTone's RAM page
;out: Y 0

setInstrument subroutine
	asl					;A*8, every instrument takes 8 bytes
	asl
	asl
	clc
	adc FT_INSTRUMENT_L		;get instrument address into FT_TEMP
	sta <FT_TEMP
	lda #0
	adc FT_INSTRUMENT_H
	sta <FT_TEMP+1

	lda #3					;three envelopes for pulse and triangle channels
	cpx #<(FT_CH4_ENVS)
	bne .noNoise
	lda #2					;only two envelopes for noise, no pitch
.noNoise
	sta <FT_TEMP+2

	ldy #0
	clc
.loop
	lda (FT_TEMP),y			;get LSB of an envelope
	sta FT_ENV_ADR_L,x
	iny
	lda (FT_TEMP),y			;get MSB
	sta FT_ENV_ADR_H,x
	iny
	lda #0
	sta FT_ENV_REPEAT,x		;reset repeat counter
	sta FT_ENV_PTR,x		;reset envelope pointer
	txa
	adc #FT_ENV_STRUCT_SIZE
	tax
	dec <FT_TEMP+2
	bne .loop

	ldy #6
	lda (FT_TEMP),y			;duty cycle
	ldy #0
	rts



;process channel
;in:  X is offset of channel variables in the FamiTone's RAM page
;     Y 0
;out: Carry is reset if the was new note

channelStep subroutine
	lda FT_CHN_REF_LEN,x	;check reference rows counter
	beq .noRef				;if it is zero, there is no reference
	dec FT_CHN_REF_LEN,x	;decrease rows counter
	bne .noRef
	lda FT_CHN_RETURN_L,x	;end of reference, return to previous pointer
	sta <FT_TEMP
	lda FT_CHN_RETURN_H,x
	sta <FT_TEMP+1
	jmp .noRepeatR
.noRef
	lda FT_CHN_REPEAT,x		;check pause counter
	beq .noRepeat
	dec FT_CHN_REPEAT,x		;decrease pause counter
	sec						;no new note
	rts
.noRepeat
	lda FT_CHN_PTR_L,x		;load channel pointer into temp
	sta <FT_TEMP
	lda FT_CHN_PTR_H,x
	sta <FT_TEMP+1
.noRepeatR

.readByte
	lda (FT_TEMP),y			;read byte of the channel
	inc <FT_TEMP			;increase pointer
	bne .1
	inc <FT_TEMP+1
.1
	cmp #%01000000			;if bits 7 or 6 are set, it is instrument, tag, or effect
	bcs .special
	sta FT_CHN_NOTE,x		;remember note code

.return
	lda <FT_TEMP			;store pointer from temp to the variable
	sta FT_CHN_PTR_L,x
	lda <FT_TEMP+1
	sta FT_CHN_PTR_H,x
	rts

.special
	cmp #%11000000			;check if it is special tag
	bcs .noInstr
	cmp #%10000000			;check if it is instrument
	bcc .noPause
	and #$3f
	sta FT_CHN_REPEAT,x		;set up pause counter
	jmp .return				;no new note, because Carry is set

.noPause
	and #$3f
	sta FT_CHN_INSTRUMENT,x	;remember instrument number
	jmp .readByte			;and read next byte

.noInstr
	cmp #%11111111			;check if it is reference
	bne .noEof
	clc						;remember return address+3
	lda <FT_TEMP
	adc #3
	sta FT_CHN_RETURN_L,x
	lda <FT_TEMP+1
	adc #0
	sta FT_CHN_RETURN_H,x
	lda (FT_TEMP),y			;read length of the reference (how many rows)
	sta FT_CHN_REF_LEN,x
	iny
	lda (FT_TEMP),y			;read 16-bit absolute address of the reference
	sta <FT_TEMP+2			;remember in temp
	iny
	lda (FT_TEMP),y
	sta <FT_TEMP+1
	lda <FT_TEMP+2
	sta <FT_TEMP
	ldy #0
	jmp .readByte			;and read next byte

.noEof
	cmp #%11111110			;check if it is end of the channel
	bne .effect
	lda (FT_TEMP),y			;read two next bytes
	sta <FT_TEMP+2
	iny
	lda (FT_TEMP),y
	dey
	sta <FT_TEMP+1			;and set current pointer
	lda <FT_TEMP+2
	sta <FT_TEMP
	jmp .readByte			;and read next byte

.effect
	and #$3f				;speed change
	sta FT_SONG_SPEED
	jmp .readByte



;process an envelope
;it does not matter which type an envelope is
;in:  X offset of the envelope variables in the FamiTone's RAM page

envelopeStep subroutine
	lda FT_ENV_REPEAT,x		;check envelope repeat counter
	beq .noRepeat			;if it is zero, process the envelope
	dec FT_ENV_REPEAT,x		;otherwise decrement the counter
	rts
.noRepeat
	lda FT_ENV_ADR_L,x		;load envelope address into temp
	sta <FT_TEMP
	lda FT_ENV_ADR_H,x
	sta <FT_TEMP+1
	ldy FT_ENV_PTR,x		;load envelope pointer

.readByte
	lda (FT_TEMP),y			;read byte of the envelope
	iny						;increase pointer
	ora #0
	bpl .special			;if it is below 127, it is special code
	clc						;otherwise it is an output value+192
	adc #-192
	sta FT_ENV_VALUE,x
	tya
	sta FT_ENV_PTR,x		;remember the pointer and return
	rts
.special
	cmp #127				;if it is 127, it is end of an envelope
	beq .loop
	sta FT_ENV_REPEAT,x		;otherwise it is a value for repeat counter
	tya
	sta FT_ENV_PTR,x		;remember the value and return
	rts
.loop
	lda (FT_TEMP),y			;load loop pointer
	tay
	jmp .readByte			;and read next byte


	IFCONST FT_DPCM_ENABLE

;set sample table pointer, only needed if DMC is used
;in: X,Y is address of a table that holds parameters for 12 samples

FamiToneSampleInit subroutine
	stx FT_DPCM_TABLE_L
	sty FT_DPCM_TABLE_H
	rts



;stop DMC sample if it plays

FamiToneSampleStop subroutine
	lda #%00001111
	sta APU_SND_CHN
	rts



;play DMC sample from table, used by music player and could be used externally
;in: A is number of sample, 0..11

FamiToneSampleStartM		;for music (low priority)
	ldx FT_DPCM_EFFECT
	beq FamiToneSampleStartS
	tax
	lda APU_SND_CHN
	and #16
	beq .noEffect
	rts
.noEffect
	sta FT_DPCM_EFFECT
	txa
	jmp FamiToneSampleStartS

FamiToneSampleStart		;for sound effects (high priority)
	ldx #1
	stx FT_DPCM_EFFECT

FamiToneSampleStartS
	asl				;get address in sample table
	asl
	adc FT_DPCM_TABLE_L
	sta <FT_TEMP
	lda #0
	adc FT_DPCM_TABLE_H
	sta <FT_TEMP+1

	lda #%00001111		;stop DMC
	sta APU_SND_CHN

	ldy #0
	lda (FT_TEMP),y		;sample offset
	sta APU_DMC_START
	iny
	lda (FT_TEMP),y		;sample length
	sta APU_DMC_LEN
	iny
	lda (FT_TEMP),y		;pitch and loop
	sta APU_DMC_FREQ

	lda #32				;reset DAC counter
	sta APU_DMC_RAW
	lda #%00011111		;start DMC
	sta APU_SND_CHN

	rts

	ENDIF



	IFCONST FT_SFX_ENABLE

;init sound effects player, set pointer to data
;in: X,Y is address of sound effects data

FamiToneSfxInit subroutine
	stx FT_SFX_ADR_L		;remember pointer to the data
	sty FT_SFX_ADR_H
	ldx #FT_SFX_CH0			;init all the streams
	lda #FT_SFX_STREAMS
	sta <FT_TEMP
.1
	lda #0
	sta FT_SFX_REPEAT,x
	sta FT_SFX_PTR_L,x
	sta FT_SFX_PTR_H,x
	jsr FamiToneSfxClearBuf
	txa
	clc
	adc #FT_SFX_STRUCT_SIZE
	tax
	dec <FT_TEMP
	bne .1

	rts



;play a sound effect
;in: A is a number of the sound effect
;    X is offset of sound effect stream, should be FT_SFX_CH0..FT_SFX_CH3

FamiToneSfxPlay subroutine
	asl					;get address in effects list
	tay
	lda FT_SFX_ADR_L
	sta <FT_TEMP
	lda FT_SFX_ADR_H
	sta <FT_TEMP+1
	lda (FT_TEMP),y			;read effect pointer from the table
	sta FT_SFX_PTR_L,x		;and remember it
	iny
	lda (FT_TEMP),y
	sta FT_SFX_PTR_H,x
	lda #0
	sta FT_SFX_REPEAT,x		;reset repeat counter and pointer offset
	sta FT_SFX_OFF,x

FamiToneSfxClearBuf			;clear effect output buffer
	lda #$30
	sta FT_SFX_BUF,x
	sta FT_SFX_BUF+3,x
	sta FT_SFX_BUF+9,x
	lda #$00
	sta FT_SFX_BUF+1,x
	sta FT_SFX_BUF+2,x
	sta FT_SFX_BUF+4,x
	sta FT_SFX_BUF+5,x
	sta FT_SFX_BUF+6,x
	sta FT_SFX_BUF+7,x
	sta FT_SFX_BUF+8,x
	sta FT_SFX_BUF+10,x
	rts



;update one sound effect stream
;in: X is offset of sound effect stream

FamiToneSfxUpdate
	lda FT_SFX_REPEAT,x		;check if repeat counter is not zero
	beq .noRepeat
	dec FT_SFX_REPEAT,x		;decrement and return
	jmp .updateBuf			;just mix with output buffer
.noRepeat
	lda FT_SFX_PTR_H,x		;check if MSB of pointer is not zero
	bne .sfxActive
	rts						;return otherwise, no active effect
.sfxActive
	sta <FT_TEMP+1			;load effect pointer into temp
	lda FT_SFX_PTR_L,x
	sta <FT_TEMP
	ldy FT_SFX_OFF,x
.readByte
	lda (FT_TEMP),y			;read byte of effect
	iny
	cmp #$10				;if it is less than $10, it is register write
	bcc .getData
	cmp #$ff				;if it is $ff, it is end of the effect
	bcs .eof
	adc #-$10				;otherwise it is number of repeats +$10
	sta FT_SFX_REPEAT,x
	tya
	sta FT_SFX_OFF,x
	jmp .updateBuf
.eof
	lda #0
	sta FT_SFX_PTR_H,x
	jmp .updateBuf
.getData
	stx <FT_TEMP+2			;it is register write
	adc <FT_TEMP+2			;get offset in the effect output buffer
	tax
	lda (FT_TEMP),y			;read value
	iny
	sta FT_SFX_BUF,x		;store into output buffer
	ldx <FT_TEMP+2
	jmp .readByte			;and read next byte

.updateBuf
	lda FT_OUT_BUF			;now compare effect output buffer with main output buffer
	and #$0f				;if volume of pulse 1 of effect is higher than of main buffer
	sta <FT_TEMP			;overwrite pulse 1 of main buffer with one from effect buffer
	lda FT_SFX_BUF,x
	and #$0f
	cmp <FT_TEMP
	bcc .noPulse1
	lda FT_SFX_BUF,x
	sta FT_OUT_BUF
	lda FT_SFX_BUF+1,x
	sta FT_OUT_BUF+1
	lda FT_SFX_BUF+2,x
	sta FT_OUT_BUF+2
.noPulse1
	lda FT_OUT_BUF+3		;same for pulse 2
	and #$0f
	sta <FT_TEMP
	lda FT_SFX_BUF+3,x
	and #$0f
	cmp <FT_TEMP
	bcc .noPulse2
	lda FT_SFX_BUF+3,x
	sta FT_OUT_BUF+3
	lda FT_SFX_BUF+4,x
	sta FT_OUT_BUF+4
	lda FT_SFX_BUF+5,x
	sta FT_OUT_BUF+5
.noPulse2
	lda FT_SFX_BUF+6,x		;overwrite triangle of main output buffer if it is active
	beq .noTriangle
	sta FT_OUT_BUF+6
	lda FT_SFX_BUF+7,x
	sta FT_OUT_BUF+7
	lda FT_SFX_BUF+8,x
	sta FT_OUT_BUF+8
.noTriangle
	lda FT_SFX_BUF+9,x		;same as for pulse 1 and 2, but for noise
	and #$0f
	sta <FT_TEMP
	lda FT_OUT_BUF+9
	and #$0f
	cmp <FT_TEMP
	bcs .noNoise
	lda FT_SFX_BUF+9,x
	sta FT_OUT_BUF+9
	lda FT_SFX_BUF+10,x
	sta FT_OUT_BUF+10
.noNoise
	rts

	.endif



noteTable	;NTSC, 11-bit dividers, octaves 1-5
	.word $6ad,$64d,$5f2,$59d,$54c,$500,$4b8,$474,$434,$3f7,$3be,$388
	.word $356,$326,$2f8,$2ce,$2a5,$27f,$25b,$239,$219,$1fb,$1de,$1c3
	.word $1aa,$192,$17b,$166,$152,$13f,$12d,$11c,$10c,$0fd,$0ee,$0e1
	.word $0d4,$0c8,$0bd,$0b2,$0a8,$09f,$096,$08d,$085,$07e,$076,$070
	.word $069,$063,$05e,$058,$053,$04f,$04a,$046,$042,$03e,$03a,$037
	.word 0,0,0,0
