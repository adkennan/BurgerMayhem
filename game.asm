defm    time_on 
;        lda #COL_/1
;        sta EXTCOL
        endm

defm    time_off
;        lda #COL_BLACK
;        sta EXTCOL
        endm

defm    plda
        ldy #/1
        lda (P_PLAYER_LO),y
        endm

defm    psta
        ldy #/1
        sta (P_PLAYER_LO),y
        endm

START_GAME
        
        jsr FADE_OUT
        jsr CLEAR_SCREEN
        
        lda #$01
        sta G_LEVEL_NUM

        lda #GS_PRE_LEVEL
        sta G_GAME_STATE

        rts

INIT_LEVEL
        
        lda #<LEVEL_01
        sta L_CURR_LEVEL_LO
        lda #>LEVEL_01
        sta L_CURR_LEVEL_HI

        ldy G_LEVEL_NUM
@loop        
        cpy #$0
        beq @got_level

        lda L_CURR_LEVEL_LO
        adc #LVL_DATA_SIZE
        bcc @next
        inc L_CURR_LEVEL_HI
@next
        dey
        jmp @loop
        
@got_level

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

        ldy #LVL_FLOOR_COL      ; Level styling
        lda (L_CURR_LEVEL_LO),y
        sta M_FLOOR_COL

        ldy #LVL_SHADOW_COL
        lda (L_CURR_LEVEL_LO),y
        sta M_SHADOW_COL

        ldy #LVL_WALL_BG
        lda (L_CURR_LEVEL_LO),y
        sta M_WALL_BG

        ldy #LVL_WALL_FG_COL
        lda (L_CURR_LEVEL_LO),y
        sta M_WALL_FG_COL

        ldy #LVL_WALL_CHAR
        lda (L_CURR_LEVEL_LO),y
        sta M_WALL_CHAR

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

        lda #2
        sta G_PLAYER_COUNT

        jsr UPDATE_ALL_OBJECT_SPRITES

        jsr DRAW_MAP
        jsr FADE_IN
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
        lda #50
        psta PL_Y

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
        
        jmp TITLE

@start

        jsr FADE_OUT
        jsr CLEAR_SCREEN

        lda #GS_START_GAME
        sta G_GAME_STATE

        rts

PRE_LEVEL

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
        
        jmp PRE_LEVEL

@start

        jsr FADE_OUT
        jsr CLEAR_SCREEN

        jsr INIT_LEVEL

        lda #GS_RUNNING
        sta G_GAME_STATE

        rts

POST_LEVEL

        jsr FADE_OUT
        jsr CLEAR_SCREEN

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

        jsr FADE_OUT
        jsr CLEAR_SCREEN

        lda #GS_PRE_LEVEL
        sta G_GAME_STATE

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

        jsr FADE_OUT
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
        ora #FIRST_SPRITE
        sta (P_FRAME_LINE_LO),y
        and #FIRST_SPRITE - 1

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

