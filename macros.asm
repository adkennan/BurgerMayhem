__SHOW_TIMING__ = 1

defm    time_on 
ifdef __SHOW_TIMING__
        lda #COL_/1
        sta EXTCOL
endif        
        endm

defm    time_off
ifdef __SHOW_TIMING__
        lda #COL_BLACK
        sta EXTCOL
endif
        endm

defm    plda
        ldy #/1
        lda (P_PLAYER_LO),y
        endm

defm    pldy
        ldy #/1
        lda (P_PLAYER_LO),y
        tay
        endm

defm    pldx
        ldy #/1
        lda (P_PLAYER_LO),y
        tax
        endm

defm    psta
        ldy #/1
        sta (P_PLAYER_LO),y
        endm

defm    padc
        ldy #/1
        adc (P_PLAYER_LO),y
        endm

defm    psbc
        ldy #/1
        sbc (P_PLAYER_LO),y
        endm

defm    pcmp
        ldy #/1
        cmp (P_PLAYER_LO),y
        endm

defm    print

        lda #</1
        sta TEXT_SRC_LO
        lda #>/1
        sta TEXT_SRC_HI

        lda #</2
        sta TEXT_POS_LO
        lda #>/2
        sta TEXT_POS_HI

        lda #/3
        sta TEXT_COL_1

        lda #/4
        sta TEXT_COL_2

        jsr WRITE_TEXT

        endm

defm    print_num

        sta TEXT_NUM

        lda #</1
        sta TEXT_POS_LO
        lda #>/1
        sta TEXT_POS_HI

        lda #/2
        sta TEXT_COL_1

        lda #/3
        sta TEXT_COL_2

        jsr WRITE_NUMBER

        endm

defm    print_num_ptr_y

        lda (/1),y
        sta TEXT_NUM

        lda #</2
        sta TEXT_POS_LO
        lda #>/2
        sta TEXT_POS_HI

        lda #/3
        sta TEXT_COL_1

        lda #/4
        sta TEXT_COL_2

        jsr WRITE_NUMBER

        endm

defm    print_ptr_y

        lda (/1),y
        sta TEXT_SRC_LO
        iny
        lda (/1),y
        sta TEXT_SRC_HI

        lda #</2
        sta TEXT_POS_LO
        lda #>/2
        sta TEXT_POS_HI

        lda #/3
        sta TEXT_COL_1

        lda #/4
        sta TEXT_COL_2

        jsr WRITE_TEXT

        endm

defm    print_ptr_y_ctr

        lda (/1),y
        sta TEXT_SRC_LO
        iny
        lda (/1),y
        sta TEXT_SRC_HI

        lda #</2
        sta TEXT_POS_LO
        lda #>/2
        sta TEXT_POS_HI

        lda #/3
        sta TEXT_COL_1

        lda #/4
        sta TEXT_COL_2

        jsr WRITE_TEXT_CENTER

        endm

