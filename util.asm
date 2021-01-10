
WRITE_HEX
        sta LINE_VAL
        stx LINE_NUM

        pha
        tya
        pha
        txa
        pha
           
        ldx LINE_NUM
        lda #<SCREEN_0
        sta LINE_PTR_LO
        lda #>SCREEN_0
        sta LINE_PTR_HI
@loop
        clc
        adc #$28
        sta LINE_PTR_LO
        bcc @got_line
        inc LINE_PTR_HI
@got_line
        dex
        bne @loop
    
        lda LINE_VAL
        ldy #1
        jsr SHOW_DIGIT
        
        lda LINE_VAL
        ror
        ror
        ror
        ror
        ldy #0
        jsr SHOW_DIGIT
        
        pla
        tax
        pla
        tay
        pla
        rts

SHOW_DIGIT
        pha

        and #$0f
        cmp #$0a
        bcc @show
        clc
        adc #1        
@show
        sta (LINE_PTR_LO),y
    
        pla
        rts

SET_BIT        
        tay
        lda NUM_FLAG,y
        rts