
START_GAME

        lda #$01
        sta G_LEVEL_NUM
        
        jsr TITLE_INIT
        
@loop_title_in
        jsr TITLE_IN
        cmp #$1
        bne @loop_title_in
        
        jsr @show_lines

        lda #<920
        sta TEXT_POS_LO
        lda #>920
        sta TEXT_POS_HI
        jsr FADE_LINE_INIT

@loop
        jsr TITLE_HOLD

        jsr FADE_LINE_IN
        cmp #$1
        bne @no_reset

        lda #<920
        sta TEXT_POS_LO
        lda #>920
        sta TEXT_POS_HI
        jsr FADE_LINE_INIT

@no_reset

        jsr TITLE_HOLD

        ldx #$0
        jsr CHECK_JOYSTICK
        lda P_BUTTON
        cmp #$1
        beq @start
        jsr @check_stick

        ldx #$1
        jsr CHECK_JOYSTICK
        lda P_BUTTON
        cmp #$1
        beq @start
        jsr @check_stick

        jmp @loop

@start
        jsr FADE_FG_OUT_INIT

@loop_fade_out
        jsr TITLE_HOLD

        jsr FADE_FG_OUT
        cmp #$0
        bne @loop_fade_out

@title_slide_out
        jsr TITLE_OUT
        cmp #$1
        bne @title_slide_out

        jsr CLEAR_SCREEN
 
        lda #GS_PRE_LEVEL
        sta G_GAME_STATE

        lda #2
        sta G_PLAYER_COUNT

        rts

@check_stick
        lda P_STICK
        and #DIR_E
        cmp #DIR_E

        bne @check_left

        lda G_LEVEL_NUM
        cmp #LEVEL_COUNT
        beq @no_change

        clc
        adc #1

        jmp @new_level

@check_left
        lda P_STICK
        and #DIR_W
        cmp #DIR_W

        bne @no_change

        lda G_LEVEL_NUM
        cmp #1
        beq @no_change

        sec 
        sbc #1

@new_level

        sta G_LEVEL_NUM

        lda #$1

        jsr @hide_lines
        jsr @show_lines

        rts

@no_change
        lda #$0

        rts

@hide_lines
        lda #<600
        sta TEXT_POS_LO
        lda #>600
        sta TEXT_POS_HI

        jsr CLEAR_LINE

        lda #<720
        sta TEXT_POS_LO
        lda #>720
        sta TEXT_POS_HI

        jsr CLEAR_LINE

        lda #<920
        sta TEXT_POS_LO
        lda #>920
        sta TEXT_POS_HI

        jsr CLEAR_LINE

        rts

@show_lines
        print STR_WHERE_TO_START, 446, COL_LBLUE, COL_BLUE

        print STR_LEVEL, 615, COL_ORANGE, COL_RED            

        lda G_LEVEL_NUM
        print_num 623, COL_ORANGE, COL_RED

        lda G_LEVEL_NUM
        asl
        tay
        
        lda LEVEL_SEQUENCE,y
        sta L_CURR_LEVEL_LO

        iny
        lda LEVEL_SEQUENCE,y
        sta L_CURR_LEVEL_HI
                
        ldy #LVL_DESC_LO
        print_ptr_y_ctr L_CURR_LEVEL_LO, 720, COL_LGREEN, COL_GREEN   

        print STR_PRESS_FIRE, 934, COL_LBLUE, COL_BLUE       

        lda #<440
        sta TEXT_POS_LO
        lda #>440
        sta TEXT_POS_HI
        jsr FADE_LINE_INIT

@show_line_0
        jsr TITLE_HOLD

        jsr FADE_LINE_IN
        cmp #$1
        bne @show_line_0

        lda #<600
        sta TEXT_POS_LO
        lda #>600
        sta TEXT_POS_HI
        jsr FADE_LINE_INIT

@show_line_1
        jsr TITLE_HOLD

        jsr FADE_LINE_IN
        cmp #$1
        bne @show_line_1

        lda #<720
        sta TEXT_POS_LO
        lda #>720
        sta TEXT_POS_HI
        jsr FADE_LINE_INIT

@show_line_2
        jsr TITLE_HOLD

        jsr FADE_LINE_IN
        cmp #$1
        bne @show_line_2

        lda #<920
        sta TEXT_POS_LO
        lda #>920
        sta TEXT_POS_HI
        jsr FADE_LINE_INIT

        rts

INIT_LEVEL

        lda G_LEVEL_NUM
        asl
        tay
        
        lda LEVEL_SEQUENCE,y
        sta L_CURR_LEVEL_LO

        iny
        lda LEVEL_SEQUENCE,y
        sta L_CURR_LEVEL_HI

        ldy #LVL_MP_LO           ; Copy the pointer to the map
        lda (L_CURR_LEVEL_LO),y
        sta L_MAP_LO
        ldy #LVL_MP_HI
        lda (L_CURR_LEVEL_LO),y
        sta L_MAP_HI
        
        ldy #LVL_TL_M            ; Copy the time limit
        lda (L_CURR_LEVEL_LO),y
        sta L_TIME_MINUTES
        
        clc
        adc #SB_0
        ldy #SL_SPRPTR1
        sta STATUS_LINE,y

        ldy #LVL_TL_S_HI
        lda (L_CURR_LEVEL_LO),y
        sta L_TIME_SECONDS_HI
        
        clc
        adc #SB_0
        ldy #SL_SPRPTR3
        sta STATUS_LINE,y

        ldy #LVL_TL_S_LO
        lda (L_CURR_LEVEL_LO),y
        sta L_TIME_SECONDS_LO

        clc
        adc #SB_0
        ldy #SL_SPRPTR4
        sta STATUS_LINE,y
        

        ldy #LVL_TARGET          ; Required # of burgers
        lda (L_CURR_LEVEL_LO),y
        sta L_BURGERS_REQ
        lda #$0
        sta L_BURGER_COUNT_LO
        sta L_BURGER_COUNT_HI
        sta L_BURGER_COUNT

        lda #SB_0               ; Reset counter display
        ldy #SL_SPRPTR6
        sta STATUS_LINE,y
        ldy #SL_SPRPTR7
        sta STATUS_LINE,y

        ldy #LVL_THEME_LO       ; Level Theme
        lda (L_CURR_LEVEL_LO),y
        sta L_THEME_LO

        ldy #LVL_THEME_HI
        lda (L_CURR_LEVEL_LO),y
        sta L_THEME_HI

        ldy #THEME_SHADOW_COL
        lda (L_THEME_LO),y
        sta L_FLOOR_FG_COL

        jsr COPY_THEME_CHARS

        ldy #LVL_P1_X           ; Set up player 1
        lda (L_CURR_LEVEL_LO),y
        sta P_MX
        ldy #LVL_P1_Y
        lda (L_CURR_LEVEL_LO),y
        sta P_MY

        lda #<P1_DATA
        sta P_PLAYER_LO
        lda #>P1_DATA
        sta P_PLAYER_HI
                
        lda #1
        sta P_FRAME

        jsr INIT_PLAYER

        ldy #LVL_P2_X           ; Set up player 2
        lda (L_CURR_LEVEL_LO),y
        sta P_MX
        ldy #LVL_P2_Y
        lda (L_CURR_LEVEL_LO),y
        sta P_MY

        lda #<P2_DATA
        sta P_PLAYER_LO
        lda #>P2_DATA
        sta P_PLAYER_HI

        lda #2
        sta P_FRAME
                
        jsr INIT_PLAYER

                                ; Clear the object table
        ldx #32         
        lda #0        
@clear_obj_type_loop

        sta LVL_OBJ_TYPE,x
        
        dex
        bne @clear_obj_type_loop

        rts

COPY_THEME_CHARS

        ldy #$0
        
        lda #$0
        sta L_CHAR_DST_HI

        lda #CH_THEME_00                            ; Get the pointer to the dest char
        sta L_CHAR_DST_LO        
        asl L_CHAR_DST_LO
        rol L_CHAR_DST_HI
        asl L_CHAR_DST_LO
        rol L_CHAR_DST_HI
        asl L_CHAR_DST_LO
        rol L_CHAR_DST_HI
        lda L_CHAR_DST_LO
        clc 
        adc #<CHAR_BASE
        sta L_CHAR_DST_LO
        lda L_CHAR_DST_HI
        adc #>CHAR_BASE
        sta L_CHAR_DST_HI

@loop_char
        lda #$0
        sta L_CHAR_SRC_HI

        tya
        tax

        clc
        adc #THEME_SRC_CHARS
        tay
        lda (L_THEME_LO),y                      ; Get the pointer to the source char
        sta L_CHAR_SRC_LO        
        asl L_CHAR_SRC_LO
        rol L_CHAR_SRC_HI
        asl L_CHAR_SRC_LO
        rol L_CHAR_SRC_HI
        asl L_CHAR_SRC_LO
        rol L_CHAR_SRC_HI
        lda L_CHAR_SRC_LO
        clc 
        adc #<CHAR_BASE
        sta L_CHAR_SRC_LO
        lda L_CHAR_SRC_HI
        adc #>CHAR_BASE
        sta L_CHAR_SRC_HI
        
        ldy #$0                                 ; Copy the char
@loop_byte     
        lda (L_CHAR_SRC_LO),y
        sta (L_CHAR_DST_LO),y
           
        iny
        cpy #$8
        bne @loop_byte

        lda L_CHAR_DST_LO
        clc
        adc #$8
        sta L_CHAR_DST_LO
        lda L_CHAR_DST_HI
        adc #$0
        sta L_CHAR_DST_HI

        txa
        tay

        iny
        cpy #THEME_SRC_CHAR_COUNT
        bne @loop_char

        rts

        

INIT_PLAYER

        lda #0                          ; Clear any existing player data
        ldy #P_DATA_SIZE
@clear_data
        sta (P_PLAYER_LO),y
        dey
        bne @clear_data

        lda #24
        psta PL_X_LO
        lda #58
        psta PL_Y

        plda PL_MP_LO
        clc
        adc #SCREEN_WIDTH
        psta PL_MP_LO
        plda PL_MP_HI
        adc #$0
        psta PL_MP_HI
        
        ldx P_MY

@set_y
        cpx #0
        beq @next_1

        plda PL_Y
        clc
        adc #24
        psta PL_Y

        plda PL_MP_LO
        clc
        adc #SCREEN_WIDTH_X3
        psta PL_MP_LO
        plda PL_MP_HI
        adc #$0
        psta PL_MP_HI
  
        lda #DIR_S
        psta PL_DIR

        lda P_FRAME
        cmp #$2
        beq @show_go
        lda #MSG_OK
        jmp @msg_done
@show_go
        lda #MSG_GO
@msg_done
        psta PL_MSG
        lda #100
        psta PL_MSG_COUNT

        dex
        jmp @set_y
        
@next_1
        ldx P_MX
@set_x
        cpx #0
        beq @next_2

        plda PL_X_LO
        clc
        adc #24
        psta PL_X_LO
        plda PL_X_HI
        adc #$0
        psta PL_X_HI

        plda PL_MP_LO
        clc
        adc #3
        psta PL_MP_LO
        plda PL_MP_HI
        adc #$0
        psta PL_MP_HI
  
        dex
        jmp @set_x
@next_2
        rts

TITLE
        jsr TEXT_SCREEN

        jsr TITLE_INIT

        jsr BIG_BURGER_INIT

        print STR_COPYRIGHT, 926, COL_LBLUE, COL_BLUE

@loop_in
        jsr TITLE_IN
        cmp #$0
        beq @loop_in

        lda #<920
        sta TEXT_POS_LO
        lda #>920
        sta TEXT_POS_HI
        jsr FADE_LINE_INIT

@loop
        jsr TITLE_HOLD

        jsr BIG_BURGER_IN

        jsr FADE_LINE_IN
        cmp #$1
        bne @no_reset

        lda #<920
        sta TEXT_POS_LO
        lda #>920
        sta TEXT_POS_HI
        jsr FADE_LINE_INIT

@no_reset

        ldx #$0
        jsr CHECK_JOYSTICK
        lda P_BUTTON
        cmp #$1
        beq @loop_out
        
        ldx #$1
        jsr CHECK_JOYSTICK
        lda P_BUTTON
        cmp #$1
        beq @loop_out
        
        jmp @loop

@loop_out
        jsr TITLE_OUT
        cmp #$0
        beq @loop_out
     
        jsr FADE_FG_OUT
        jsr CLEAR_SCREEN

        lda #GS_START_GAME
        sta G_GAME_STATE

        rts

BIG_BURGER_INIT

        lda #$0
        sta BB_LINE_1
        clc
        adc #10
        sta BB_LINE_2
        clc 
        adc #10
        sta BB_LINE_3
        clc
        adc #10
        sta BB_LINE_4
        clc
        adc #10
        sta BB_LINE_5

        ldx #1

        lda #BB_TOP_START
        sta BB_LINE_1 + 1


        lda #BB_LET_START
        sta BB_LINE_2 + 1


        lda #BB_TOM_START
        sta BB_LINE_3 + 1


        lda #BB_MEAT_START
        sta BB_LINE_4 + 1


        lda #BB_BOT_START
        sta BB_LINE_5 + 1

        rts

BIG_BURGER_IN
        
        lda #130
@wait_1
        cmp RASTER
        bne @wait_1

        time_on RED

        ldy #0
        ldx #4
        lda #<BB_LINE_1
        sta BB_LINE_LO
        lda #>BB_LINE_1
        sta BB_LINE_HI
@loop
        dex

        ;lda (BB_LINE_LO),y
        ;cmp #0
        ;beq @moving

        ;sec
        ;sbc #1
        ;sta (BB_LINE_LO),y
        ;jmp @stopped

@moving
        ldy #1
        lda (BB_LINE_LO),y
        sta BB_Y

        ldy #3
        lda (BB_LINE_LO),y
        tay

        lda BB_Y
        sta SP0X,y
        iny
        iny
        sta SP0X,y
                
        ldy #2
        cmp (BB_LINE_LO),y
        beq @stopped

        sec
        sbc #2
        ldy #1
        sta (BB_LINE_LO),y

@stopped

        lda BB_LINE_LO
        clc
        adc #4
        sta BB_LINE_LO
        bcc @no_inc
        inc BB_LINE_HI
@no_inc

        cpx #0
        bne @loop
        
        time_on GREEN

        lda #COL_YELLOW
        sta SPMC0
        lda #COL_RED
        sta SPMC1

        lda #COL_ORANGE
        sta SP0COL
        sta SP1COL
        lda #COL_GREEN
        sta SP2COL
        sta SP3COL
        lda #COL_LRED
        sta SP4COL
        sta SP5COL
        lda #COL_BROWN
        sta SP6COL
        sta SP7COL        

        lda #TSB_TOP_BUN_1
        sta SPRPTR0
        lda #TSB_TOP_BUN_2
        sta SPRPTR1
        lda #TSB_LETTUCE_1
        sta SPRPTR2
        lda #TSB_LETTUCE_2
        sta SPRPTR3
        lda #TSB_TOMATO_1
        sta SPRPTR4
        lda #TSB_TOMATO_2
        sta SPRPTR5
        lda #TSB_MEAT_1
        sta SPRPTR6
        lda #TSB_MEAT_2
        sta SPRPTR7

        lda #BB_LEFT_X
        sta SP0X
        sta SP2X
        sta SP4X
        sta SP6X
        lda #BB_RIGHT_X
        sta SP1X
        sta SP3X
        sta SP5X
        sta SP7X

        lda #$ff
        sta SPENA
        sta SPMC

        time_off
        
        rts

TITLE_INIT
        lda #LINE_1_START
        sta TITLE_L1_Y
        lda #LINE_2_START
        sta TITLE_L2_Y
        rts

TITLE_HOLD
        lda #50
@wait_1
        cmp RASTER
        bne @wait_1

        jsr TITLE_L1_UPDATE

        lda #LINE_2_STOP - 4
@wait_2
        cmp RASTER
        bne @wait_2

        jsr TITLE_L2_UPDATE
        rts

TITLE_IN

@loop
        lda #$ff
@wait_1
        cmp RASTER
        bne @wait_1

        jsr TITLE_L1_UPDATE
        
        lda TITLE_L1_Y
        cmp #LINE_1_STOP
        beq @line_1_in_stop
        clc
        adc #$2
        sta TITLE_L1_Y

        lda #$0
        rts

@line_1_in_stop        

        lda #LINE_2_STOP - 2
@wait_2
        cmp RASTER
        bne @wait_2

        jsr TITLE_L2_UPDATE
        
        lda TITLE_L1_Y
        cmp #LINE_1_STOP
        bne @line_2_in_stop
        
        lda TITLE_L2_Y
        cmp #LINE_2_STOP
        beq @line_2_in_stop
        sec
        sbc #$4
        sta TITLE_L2_Y

        lda #$0
        rts
        
@line_2_in_stop        

        lda #$1
        rts

TITLE_OUT
        lda #$ff
@wait_1
        cmp RASTER
        bne @wait_1

        jsr TITLE_L1_UPDATE

        lda #LINE_2_STOP - 2
@wait_2
        cmp RASTER
        bne @wait_2

        jsr TITLE_L2_UPDATE
        
        lda TITLE_L1_Y
        cmp #LINE_1_START
        beq @line_1_out_stop
        sec
        sbc #$4
        sta TITLE_L1_Y

@line_1_out_stop

        lda TITLE_L2_Y
        cmp #LINE_2_START
        beq @line_2_out_stop
        clc
        adc #$4
        sta TITLE_L2_Y
        
        lda #$0
        rts

@line_2_out_stop   
        lda #$1        
        rts

TITLE_L1_UPDATE
        lda #$0
        sta SPMC
        lda #$FF
        sta SPENA

        lda TITLE_L1_Y        
        sta SP0Y
        sta SP1Y
        sta SP2Y
        sta SP3Y
        clc
        adc #$2
        sta SP4Y
        sta SP5Y
        sta SP6Y
        sta SP7Y
        
        ldy #0
        ldx #0
        lda TITLE_LINE_X,y
        sta SP0X
        lda TITLE_COLS_1,y
        sta SP0COL
        tya
        clc
        adc #LOGO_BURGER_SPR
        sta SPRPTR0

        iny
        lda TITLE_LINE_X,y
        sta SP1X
        lda TITLE_COLS_1,y
        sta SP1COL
        tya
        clc
        adc #LOGO_BURGER_SPR
        sta SPRPTR1

        iny
        lda TITLE_LINE_X,y
        sta SP2X
        lda TITLE_COLS_1,y
        sta SP2COL
        tya
        clc
        adc #LOGO_BURGER_SPR
        sta SPRPTR2

        iny
        lda TITLE_LINE_X,y
        sta SP3X
        lda TITLE_COLS_1,y
        sta SP3COL
        tya
        clc
        adc #LOGO_BURGER_SPR
        sta SPRPTR3

        iny
        lda TITLE_LINE_X,y
        sta SP4X
        lda TITLE_COLS_1,y
        sta SP4COL
        txa
        clc
        adc #LOGO_BURGER_SPR
        sta SPRPTR4

        inx
        iny
        lda TITLE_LINE_X,y
        sta SP5X
        lda TITLE_COLS_1,y
        sta SP5COL
        txa
        clc
        adc #LOGO_BURGER_SPR
        sta SPRPTR5

        inx
        iny
        lda TITLE_LINE_X,y
        sta SP6X
        lda TITLE_COLS_1,y
        sta SP6COL
        txa
        clc
        adc #LOGO_BURGER_SPR
        sta SPRPTR6

        inx
        iny
        lda TITLE_LINE_X,y
        sta SP7X
        lda TITLE_COLS_1,y
        sta SP7COL
        txa
        clc
        adc #LOGO_BURGER_SPR
        sta SPRPTR7
        
        lda #$ff
        sta YXPAND
        sta XXPAND
        sta SPENA 
        lda #$0
        sta MSIGX

        rts

TITLE_L2_UPDATE
        
        lda TITLE_L2_Y        
        sta SP0Y
        sta SP1Y
        sta SP2Y
        sta SP3Y
        clc
        adc #$2
        sta SP4Y
        sta SP5Y
        sta SP6Y
        sta SP7Y
        
        ldy #0
        ldx #0
        lda TITLE_LINE_X,y
        sta SP0X
        lda TITLE_COLS_2,y
        sta SP0COL
        tya
        clc
        adc #LOGO_MAYHEM_SPR
        sta SPRPTR0

        iny
        lda TITLE_LINE_X,y
        sta SP1X
        lda TITLE_COLS_2,y
        sta SP1COL
        tya
        clc
        adc #LOGO_MAYHEM_SPR
        sta SPRPTR1

        iny
        lda TITLE_LINE_X,y
        sta SP2X
        lda TITLE_COLS_2,y
        sta SP2COL
        tya
        clc
        adc #LOGO_MAYHEM_SPR
        sta SPRPTR2

        iny
        lda TITLE_LINE_X,y
        sta SP3X
        lda TITLE_COLS_2,y
        sta SP3COL
        tya
        clc
        adc #LOGO_MAYHEM_SPR
        sta SPRPTR3

        iny
        lda TITLE_LINE_X,y
        sta SP4X
        lda TITLE_COLS_2,y
        sta SP4COL
        txa
        clc
        adc #LOGO_MAYHEM_SPR
        sta SPRPTR4

        inx
        iny
        lda TITLE_LINE_X,y
        sta SP5X
        lda TITLE_COLS_2,y
        sta SP5COL
        txa
        clc
        adc #LOGO_MAYHEM_SPR
        sta SPRPTR5

        inx
        iny
        lda TITLE_LINE_X,y
        sta SP6X
        lda TITLE_COLS_2,y
        sta SP6COL
        txa
        clc
        adc #LOGO_MAYHEM_SPR
        sta SPRPTR6

        inx
        iny
        lda TITLE_LINE_X,y
        sta SP7X
        lda TITLE_COLS_2,y
        sta SP7COL
        txa
        clc
        adc #LOGO_MAYHEM_SPR
        sta SPRPTR7
        
        lda #$ff
        sta YXPAND
        sta XXPAND
        sta SPENA 
        lda #$0
        sta MSIGX
        rts

PRE_LEVEL
        
        jsr TITLE_INIT
        
@loop_title_in
        jsr TITLE_IN
        cmp #$1
        bne @loop_title_in

        jsr INIT_LEVEL

        print STR_LEVEL, 455, COL_ORANGE, COL_RED                       
        print STR_TIME_LIMIT, 685, COL_ORANGE, COL_RED                  
        print STR_BURGERS_REQUIRED, 760, COL_ORANGE, COL_RED            
        print STR_PRESS_FIRE, 934, COL_LBLUE, COL_BLUE                  

        lda G_LEVEL_NUM
        print_num 463, COL_ORANGE, COL_RED

        ldy #LVL_TL_M
        print_num_ptr_y L_CURR_LEVEL_LO, 697, COL_ORANGE, COL_RED

        ldy #LVL_TL_S_HI
        print_num_ptr_y L_CURR_LEVEL_LO, 699, COL_ORANGE, COL_RED
        ldy #LVL_TL_S_LO
        print_num_ptr_y L_CURR_LEVEL_LO, 700, COL_ORANGE, COL_RED

        print STR_COLON, 697, COL_ORANGE, COL_RED

        ldy #LVL_TARGET
        print_num_ptr_y L_CURR_LEVEL_LO, 777, COL_ORANGE, COL_RED

        ldy #LVL_DESC_LO
        print_ptr_y_ctr L_CURR_LEVEL_LO, 560, COL_LGREEN, COL_GREEN     

        lda #<440
        sta TEXT_POS_LO
        lda #>440
        sta TEXT_POS_HI
        jsr FADE_LINE_INIT

@text_in_1
        jsr TITLE_HOLD

        jsr FADE_LINE_IN
        cmp #$1
        bne @text_in_1

        lda #<560
        sta TEXT_POS_LO
        lda #>560
        sta TEXT_POS_HI
        jsr FADE_LINE_INIT

@text_in_2
        jsr TITLE_HOLD

        jsr FADE_LINE_IN
        cmp #$1
        bne @text_in_2

        lda #<680
        sta TEXT_POS_LO
        lda #>680
        sta TEXT_POS_HI
        jsr FADE_LINE_INIT

@text_in_3
        jsr TITLE_HOLD

        jsr FADE_LINE_IN
        cmp #$1
        bne @text_in_3

        lda #<760
        sta TEXT_POS_LO
        lda #>760
        sta TEXT_POS_HI
        jsr FADE_LINE_INIT

@text_in_4
        jsr TITLE_HOLD

        jsr FADE_LINE_IN
        cmp #$1
        bne @text_in_4

        lda #<920
        sta TEXT_POS_LO
        lda #>920
        sta TEXT_POS_HI
        jsr FADE_LINE_INIT

@loop
        jsr TITLE_HOLD

        jsr FADE_LINE_IN
        cmp #$1
        bne @no_reset

        lda #<920
        sta TEXT_POS_LO
        lda #>920
        sta TEXT_POS_HI
        jsr FADE_LINE_INIT

@no_reset


        ldx #$0
        jsr CHECK_JOYSTICK
        lda P_BUTTON
        cmp #$1
        beq @start
        
        ldx #$1
        jsr CHECK_JOYSTICK
        lda P_BUTTON
        cmp #$1
        beq @start
        
        jmp @loop

@start
        jsr FADE_FG_OUT_INIT

@loop_fade_out
        jsr TITLE_HOLD

        jsr FADE_FG_OUT
        cmp #$0
        bne @loop_fade_out

@title_slide_out
        jsr TITLE_OUT
        cmp #$1
        bne @title_slide_out
        
        jsr CLEAR_SCREEN

        jsr GFX_SCREEN

        jsr DRAW_MAP
        
        jsr FADE_IN

        jsr UPDATE_ALL_OBJECT_SPRITES

        lda #GS_RUNNING
        sta G_GAME_STATE

        rts

POST_LEVEL

        jsr FADE_OUT
        jsr CLEAR_SCREEN
        jsr TEXT_SCREEN

        jsr TITLE_INIT
        
@loop_title_in
        lda #CHOICE_CONTINUE
        sta G_CHOICE

        jsr TITLE_IN
        cmp #$1
        bne @loop_title_in

        print STR_LEVEL, 455, COL_ORANGE, COL_RED
        lda G_LEVEL_NUM
        print_num 463, COL_ORANGE, COL_RED
        ldy #LVL_DESC_LO
        print_ptr_y_ctr L_CURR_LEVEL_LO, 520, COL_LGREEN, COL_GREEN

        print STR_YOU_MADE, 649, COL_ORANGE, COL_RED
        print STR_BURGERS, 661, COL_ORANGE, COL_RED

        lda L_BURGER_COUNT
        print_num 659, COL_ORANGE, COL_RED
        
        print STR_YOU_NEEDED, 732, COL_ORANGE, COL_RED
        ldy #LVL_TARGET
        print_num_ptr_y L_CURR_LEVEL_LO, 744, COL_ORANGE, COL_RED

        ldy #LVL_TARGET
        lda (L_CURR_LEVEL_LO),y
        cmp L_BURGER_COUNT
        bcc @success

        print STR_BETTER_LUCK, 809, COL_LBLUE, COL_BLUE

        jmp @fade_in

@success
        print STR_WELL_DONE, 814, COL_LBLUE, COL_BLUE 

@fade_in
        lda #<440
        sta TEXT_POS_LO
        lda #>440
        sta TEXT_POS_HI
        jsr FADE_LINE_INIT

@text_in_1
        jsr TITLE_HOLD

        jsr FADE_LINE_IN
        cmp #$1
        bne @text_in_1

        lda #<520
        sta TEXT_POS_LO
        lda #>520
        sta TEXT_POS_HI
        jsr FADE_LINE_INIT

@text_in_2
        jsr TITLE_HOLD

        jsr FADE_LINE_IN
        cmp #$1
        bne @text_in_2

        lda #<640
        sta TEXT_POS_LO
        lda #>640
        sta TEXT_POS_HI
        jsr FADE_LINE_INIT

@text_in_3
        jsr TITLE_HOLD

        jsr FADE_LINE_IN
        cmp #$1
        bne @text_in_3

        lda #<720
        sta TEXT_POS_LO
        lda #>720
        sta TEXT_POS_HI
        jsr FADE_LINE_INIT

@text_in_4
        jsr TITLE_HOLD

        jsr FADE_LINE_IN
        cmp #$1
        bne @text_in_4

        lda #<800
        sta TEXT_POS_LO
        lda #>800
        sta TEXT_POS_HI

        jsr @draw_choice

        jsr FADE_LINE_INIT

@loop
        jsr TITLE_HOLD

        jsr FADE_LINE_IN
        cmp #$1
        bne @no_reset

        lda #<920
        sta TEXT_POS_LO
        lda #>920
        sta TEXT_POS_HI
        jsr FADE_LINE_INIT

@no_reset

        ldx #$0
        jsr CHECK_JOYSTICK
        lda P_BUTTON
        cmp #$1
        beq @start
        jsr @change_choice
        
        ldx #$1
        jsr CHECK_JOYSTICK
        lda P_BUTTON
        cmp #$1
        beq @start
        jsr @change_choice

        jmp @loop

@start
        jsr FADE_FG_OUT_INIT

@loop_fade_out
        jsr TITLE_HOLD

        jsr FADE_FG_OUT
        cmp #$0
        bne @loop_fade_out

@title_slide_out
        jsr TITLE_OUT
        cmp #$1
        bne @title_slide_out

        jsr CLEAR_SCREEN

        lda G_CHOICE
        cmp #CHOICE_QUIT
        bne @continue_game

        lda #GS_GAME_OVER
        sta G_GAME_STATE
        rts

@continue_game

        lda #GS_PRE_LEVEL
        sta G_GAME_STATE

        ldy #LVL_TARGET
        lda (L_CURR_LEVEL_LO),y
        cmp L_BURGER_COUNT
        bcc @next_level

        rts ; Retry current level

@next_level

        lda G_LEVEL_NUM
        cmp #LEVEL_COUNT
        beq @reset_level

        clc
        adc #1
        jmp @done

@reset_level

        lda #1

@done
        sta G_LEVEL_NUM
        rts

@change_choice
        
        lda P_STICK
        and #DIR_W
        cmp #DIR_W

        bne @check_e

        lda G_CHOICE
        cmp #CHOICE_CONTINUE
        beq @no_change
        
        lda #CHOICE_CONTINUE

        jmp @change

@check_e
        lda P_STICK
        and #DIR_E
        cmp #DIR_E
        bne @no_change

        lda G_CHOICE
        cmp #CHOICE_QUIT
        beq @no_change

        lda #CHOICE_QUIT

@change
        sta G_CHOICE    

        jsr @draw_choice
        
@no_change
        rts

@draw_choice
        lda #<920
        sta TEXT_POS_LO
        lda #>920
        sta TEXT_POS_HI

        jsr CLEAR_LINE

        lda G_CHOICE
        cmp #CHOICE_QUIT
        bne @check_continue

        print STR_QUIT, 938, COL_LBLUE, COL_BLUE
        jsr FADE_LINE_INIT
        rts

@check_continue

        ldy #LVL_TARGET
        lda (L_CURR_LEVEL_LO),y
        cmp L_BURGER_COUNT
        bcc @continue

        print STR_TRY_AGAIN, 933, COL_LBLUE, COL_BLUE
        jsr FADE_LINE_INIT
        rts

@continue

        print STR_CONTINUE, 936, COL_LBLUE, COL_BLUE
        jsr FADE_LINE_INIT
        rts

GAME_OVER

@loop
        ldx #$0
        jsr CHECK_JOYSTICK
        lda P_BUTTON
        cmp #$1
        beq @start
        
        ldx #$1
        jsr CHECK_JOYSTICK
        lda P_BUTTON
        cmp #$1
        beq @start
        
        jmp @loop

@start

        jsr FADE_FG_OUT
        jsr CLEAR_SCREEN

        lda #GS_TITLE
        sta G_GAME_STATE

        rts



RUN_LEVEL       
        jsr DRAW_STATUS
        
        jsr DRAW_PLAYERS
        
        lda #<FRAME_LINE_0
        sta FRAME_LINE_LO
        lda #>FRAME_LINE_0
        sta FRAME_LINE_HI
        
        ldx #$8
@loop
        jsr DRAW_OBJECTS
     
        lda FRAME_LINE_LO
        clc
        adc #FRAME_LINE_SIZE
        sta FRAME_LINE_LO
        bcc @next
        inc FRAME_LINE_HI

@next
        dex
        bne @loop
        
        lda #$F9
@wait_for_F9
        cmp RASTER
        bne @wait_for_F9

        lda SCROLY
        and #$F7
        sta SCROLY

        lda #$FC
@wait_for_FC
        cmp RASTER
        bne @wait_for_FC

        lda SCROLY
        ora #$8
        sta SCROLY
        
        time_on PURPLE
        jsr RUN_PLAYER_1                
        time_off

        time_on GREEN
        jsr RUN_PLAYER_2
        time_off

        time_on BLUE
        jsr UPDATE_PLAYER_SPRITES
        time_off

        time_on YELLOW
        jsr UPDATE_TIME
        time_off

        lda G_GAME_STATE
        cmp #GS_RUNNING
        beq RUN_LEVEL

        rts

UPDATE_ALL_OBJECT_SPRITES
       
        lda #<LVL_OBJ_TYPE
        sta P_OBJ_TYPE_LO
        lda #>LVL_OBJ_TYPE
        sta P_OBJ_TYPE_HI

        lda #<FRAME_LINE_0
        sta P_FRAME_LINE_LO
        lda #>FRAME_LINE_0
        sta P_FRAME_LINE_HI

        lda #$8

@loop1                          ; Each row
        sta P_LINE_NUM
        
        lda #$0                 ; Clear SPENA
        sta P_OBJ_SPENA

        ldx #$0        
        lda #$10
        sta P_SPRITE_BIT
@loop2                          ; Each column

        txa
        tay
        lda (P_OBJ_TYPE_LO),y   ; Do we have an object?
        cmp #OBJ_NONE
        beq @no_obj
        sta P_SPRITE_NUM

        txa                     ; Set the sprite frame
        clc
        adc #FL_SPRPTR4
        tay

        lda P_SPRITE_NUM
        clc
        adc #FIRST_SPRITE
        sta (P_FRAME_LINE_LO),y
        sec
        sbc #FIRST_SPRITE

        tay                     ; Look up colour        
        lda SPRITE_COLOURS,y
        sta P_COLOUR

        txa                     ; Where to put it
        ora #FL_SP4COL
        tay
                                ; Set the colour
        lda P_COLOUR
        sta (P_FRAME_LINE_LO),y        
        
        lda P_OBJ_SPENA         ; Enable sprite
        ora P_SPRITE_BIT
        sta P_OBJ_SPENA
@no_obj        
        lda P_SPRITE_BIT        
        asl 
        sta P_SPRITE_BIT

        inx
        cpx #$4
        bne @loop2

        ldy #FL_SPENA           ; Enable sprites
        lda P_OBJ_SPENA
        sta (P_FRAME_LINE_LO),y

        lda P_OBJ_TYPE_LO       ; Move to the next row
        clc
        adc #$4
        sta P_OBJ_TYPE_LO
        bcc @cc_1
        inc P_OBJ_TYPE_HI
@cc_1

        lda P_FRAME_LINE_LO
        clc
        adc #FRAME_LINE_SIZE
        sta P_FRAME_LINE_LO
        bcc @cc_2
        inc P_FRAME_LINE_HI
@cc_2

        lda P_LINE_NUM
        sec
        sbc #$1
        bne @loop1
        
        rts

UPDATE_TIME

        lda L_TIME_TICKS        
        and #1
        cmp #0
        bne @check_blockers
        jsr UPDATE_SLIDERS
        jmp @check_seconds

@check_blockers
        jsr UPDATE_BLOCKERS

@check_seconds
        lda L_TIME_TICKS
        cmp #50
        beq @update_seconds_lo
        clc
        adc #$1
        sta L_TIME_TICKS
        
        jmp @flash_colours

@update_seconds_lo

        lda #$0
        sta L_TIME_TICKS

        lda L_TIME_SECONDS_LO
        cmp #$0
        beq @update_seconds_hi
        sec
        sbc #$1
        sta L_TIME_SECONDS_LO

        clc
        adc #SB_0
        ldy #SL_SPRPTR4
        sta STATUS_LINE,y

        jmp @flash_colours

@update_seconds_hi

        lda #$9
        sta L_TIME_SECONDS_LO

        lda #SB_9
        ldy #SL_SPRPTR4
        sta STATUS_LINE,y

        lda L_TIME_SECONDS_HI
        cmp #$0
        beq @update_minutes
        sec
        sbc #$1
        sta L_TIME_SECONDS_HI

        clc
        adc #SB_0
        ldy #SL_SPRPTR3
        sta STATUS_LINE,y

        jmp @flash_colours

@update_minutes

        lda #$5
        sta L_TIME_SECONDS_HI

        lda #SB_5
        ldy #SL_SPRPTR3
        sta STATUS_LINE,y

        lda L_TIME_MINUTES
        cmp #$0
        beq @time_up
        sec
        sbc #$1
        sta L_TIME_MINUTES

        clc
        adc #SB_0
        ldy #SL_SPRPTR1
        sta STATUS_LINE,y

@flash_colours
 
        lda L_TIME_MINUTES
        cmp #0
        bne @white_time
        lda L_TIME_SECONDS_HI
        cmp #2
        bcs @white_time

        lda L_TIME_TICKS
        ror
        ror
        ror
        and #1
        cmp #0
        beq @white_time
        lda #COL_RED
        jmp @set_colours
@white_time
        lda #COL_WHITE
@set_colours
        ldy #SL_SP1COL
        sta STATUS_LINE,y
        iny
        sta STATUS_LINE,y
        iny
        sta STATUS_LINE,y
        iny
        sta STATUS_LINE,y

        rts

@time_up
        lda #GS_POST_LEVEL
        sta G_GAME_STATE
        rts

UPDATE_BLOCKERS

        ldy #$4
@loop1
        dey

        lda LVL_BLOCK_TIME,y
        sec
        sbc #$1
        sta LVL_BLOCK_TIME,y
        bne @next

        lda LVL_BLOCK_STATE,y
        clc
        adc #$1
        cmp #BLOCKER_SEQ_SIZE
        bne @no_reset
        lda #$0
@no_reset
        sta LVL_BLOCK_STATE,y

        tax
        lda BLOCKER_SEQ,x
        tax
        lda BLOCKER_TIMES,x
        sta LVL_BLOCK_TIME,y        

        sty T_BLOCKER_N

        lda BLOCKER_SRC_LO,x    
        sta T_BLOCKER_SRC_LO
        lda BLOCKER_SRC_HI,x
        sta T_BLOCKER_SRC_HI

        lda BLOCKER_DST_LO,y
        sta T_BLOCKER_DST_LO
        lda BLOCKER_DST_HI,y
        sta T_BLOCKER_DST_HI
       

        ldy #$8
@loop2
        dey
                
        lda (T_BLOCKER_SRC_LO),y
        sta (T_BLOCKER_DST_LO),y

        cpy #$0
        bne @loop2

        ldy T_BLOCKER_N

@next
        cpy #$0
        bne @loop1

        rts

UPDATE_SLIDERS

        lda L_SLIDER_TIME
        cmp #$0
        beq @update
        sec
        sbc #$1
        sta L_SLIDER_TIME
        rts
@update
        lda #$2
        sta L_SLIDER_TIME 

        ldy #0
        lda CHAR_ARROW_N,y
        sta T_SLIDER_N

        ldy #7
        lda CHAR_ARROW_S,y
        sta T_SLIDER_S

        ldy #8
@loop1

        dey

        lda CHAR_ARROW_W,y
        asl
        adc #$0
        sta CHAR_ARROW_W,y

        lda CHAR_ARROW_E,y
        lsr
        bcc @no_carry
        ora #$80
@no_carry
        sta CHAR_ARROW_E,y

        lda CHAR_ARROW_N,y
        tax
        lda T_SLIDER_N
        sta CHAR_ARROW_N,y
        stx T_SLIDER_N

        tya
        eor #$7
        tay
        lda CHAR_ARROW_S,y
        tax
        lda T_SLIDER_S
        sta CHAR_ARROW_S,y
        stx T_SLIDER_S
        tya
        eor #$7
        tay
        
        cpy #0
        bne @loop1

        rts

