
; Writes spaces to all screen positions
CLEAR_SCREEN
        
        ldx #$0
        
@loop
        lda #$1D
        sta SCREEN_0,x
        sta SCREEN_1,x
        sta SCREEN_2,x
        sta SCREEN_3,x
        lda #COL_BLACK
        sta REAL_COLOUR_RAM_0,x
        sta REAL_COLOUR_RAM_1,x
        sta REAL_COLOUR_RAM_2,x
        sta REAL_COLOUR_RAM_3,x
        sta COLOUR_RAM_0,x
        sta COLOUR_RAM_1,x
        sta COLOUR_RAM_2,x
        sta COLOUR_RAM_3,x
        dex
        bne @loop

        rts

DRAW_MAP
        ; Start position in screen memory
        lda #<SCREEN_0
        clc
        adc #SCREEN_WIDTH
        sta M_MAP_POS_LO
        lda #>SCREEN_0
        adc #$0
        sta M_MAP_POS_HI

        ; Start position in colour memory
        lda #<COLOUR_RAM
        clc
        adc #SCREEN_WIDTH
        sta M_COL_POS_LO
        lda #>COLOUR_RAM
        adc #$0
        sta M_COL_POS_HI

        ; Start position in LVL_TILE_MAP
        lda #<LVL_TILE_MAP
        clc
        adc #SCREEN_WIDTH
        sta M_LVLMAP_POS_LO
        lda #>LVL_TILE_MAP
        adc #$0
        sta M_LVLMAP_POS_HI

        ; Index of first object in LVL_OBJ_TYPE
        lda #$0
        sta OBJ_INDEX

        ; Object sprite data
        lda #0 
        sta OBJ_INDEX
        sta P_SPRITE_NUM
        sta P_TMP_X_HI
        lda #24
        sta P_TMP_X_LO
        lda #$10        
        sta P_SPRITE_BIT

        ; Curent frame line
        lda #<FRAME_LINE_0
        sta P_FRAME_LINE_LO
        lda #>FRAME_LINE_0
        sta P_FRAME_LINE_HI

        ; Object type
        lda #<LVL_OBJ_TYPE
        sta P_OBJ_TYPE_LO
        lda #>LVL_OBJ_TYPE
        sta P_OBJ_TYPE_HI

        ; Y holds the position in the map
        ldy #$0
@loop1
        lda (L_MAP_LO),y
        cmp #TILE_EOL                   
        beq @next_line

        jsr DRAW_LVLMAP
        lda (L_MAP_LO),y        

        cmp #TILE_FLOOR                 
        bne @draw_tile
        
        jsr DRAW_FLOOR
        jmp @next_tile

@draw_tile
        jsr DRAW_TILE

@next_tile
        jsr NEXT_TILE
        jmp @loop2

@next_line
        jsr NEXT_LINE

@loop2        

        iny
        cpy #112 ; 112 tiles in a map
        bne @loop1

        rts

NEXT_TILE
        ; Move to the character position of the next tile

        lda M_MAP_POS_LO
        clc
        adc #3
        sta M_MAP_POS_LO
        bcc @bcc_1
        inc M_MAP_POS_HI

@bcc_1
        lda M_COL_POS_LO
        clc
        adc #3
        sta M_COL_POS_LO
        bcc @bcc_2
        inc M_COL_POS_HI

@bcc_2
        lda M_LVLMAP_POS_LO
        clc
        adc #3
        sta M_LVLMAP_POS_LO
        bcc @bcc_3
        inc M_LVLMAP_POS_HI
@bcc_3

        lda P_TMP_X_LO
        clc
        adc #24
        sta P_TMP_X_LO
        bcc @bcc_4
        inc P_TMP_X_HI
@bcc_4

        rts

NEXT_LINE
         ; Move to the character position of the first tile
        ; of the next line.

        lda #$0
        sta P_SPRITE_NUM
        sta P_TMP_X_HI
        lda #24
        sta P_TMP_X_LO
        lda #$10        
        sta P_SPRITE_BIT
        lda OBJ_INDEX
        clc
        adc #$4
        sta OBJ_INDEX

        lda M_MAP_POS_LO
        clc
        adc #81
        sta M_MAP_POS_LO
        bcc @bcc_1
        inc M_MAP_POS_HI

@bcc_1
        lda M_COL_POS_LO
        clc
        adc #81
        sta M_COL_POS_LO
        bcc @bcc_2
        inc M_COL_POS_HI

@bcc_2
        lda M_LVLMAP_POS_LO
        clc
        adc #81
        sta M_LVLMAP_POS_LO
        bcc @bcc_3
        inc M_LVLMAP_POS_HI

@bcc_3
        lda P_FRAME_LINE_LO
        clc
        adc #FRAME_LINE_SIZE
        sta P_FRAME_LINE_LO
        bcc @bcc_4
        inc P_FRAME_LINE_HI
@bcc_4

        lda P_OBJ_TYPE_LO
        clc
        adc #$4
        sta P_OBJ_TYPE_LO
        bcc @bcc_5
        inc P_OBJ_TYPE_HI

@bcc_5
        rts

DRAW_TILE     
        cmp #TILE_BENCH
        bne @is_stove
        jsr DRAW_BENCH
        rts
@is_stove
        cmp #TILE_STOVE
        bne @is_chop
        jsr DRAW_STOVE
        rts
@is_chop
        cmp #TILE_CHOP
        bne @is_plate
        jsr DRAW_CHOP
        rts
@is_plate
        cmp #TILE_PLATE
        bne @is_bun
        jsr DRAW_PLATE
        rts
@is_bun
        cmp #TILE_BUN
        bne @is_meat
        jsr DRAW_BUN
        rts
@is_meat
        cmp #TILE_MEAT
        bne @is_tomato
        jsr DRAW_MEAT
        rts
@is_tomato
        cmp #TILE_TOMATO
        bne @is_lettuce
        jsr DRAW_TOMATO

        rts
@is_lettuce
        cmp #TILE_LETTUCE
        bne @is_serve
        jsr DRAW_LETTUCE

        rts
@is_serve
        cmp #TILE_SERVE
        bne @is_bin
        jsr DRAW_SERVE
        rts
@is_bin
        cmp #TILE_BIN
        bne @is_wall
        jsr DRAW_BIN
        rts
@is_wall
        cmp #TILE_WALL
        bne @is_slider_n
        jsr DRAW_WALL
        rts

@is_slider_n
        cmp #TILE_SLIDER_N
        bne @is_slider_s
        jsr DRAW_SLIDER_N
        rts

@is_slider_s
        cmp #TILE_SLIDER_S
        bne @is_slider_e
        jsr DRAW_SLIDER_S
        rts

@is_slider_e
        cmp #TILE_SLIDER_E
        bne @is_slider_w
        jsr DRAW_SLIDER_E
        rts

@is_slider_w
        cmp #TILE_SLIDER_W
        bne @is_blocker_0
        jsr DRAW_SLIDER_W
        rts

@is_blocker_0
        cmp #TILE_BLOCKER_0
        bne @is_blocker_1
        jsr DRAW_BLOCKER
        rts

@is_blocker_1
        cmp #TILE_BLOCKER_1
        bne @is_blocker_2
        jsr DRAW_BLOCKER
        rts

@is_blocker_2
        cmp #TILE_BLOCKER_2
        bne @is_blocker_3
        jsr DRAW_BLOCKER
        rts

@is_blocker_3
        cmp #TILE_BLOCKER_3
        bne @done
        jsr DRAW_BLOCKER
@done
        rts

ADD_SPRITE_POS
        tya
        pha

        ldy P_SPRITE_NUM                ; Object 
        lda P_FRAME
        sta (P_OBJ_TYPE_LO),y
                
                                        ; X coord low 8 bits
        tya
        clc
        adc #FL_SP4X
        tay
        lda P_TMP_X_LO
        sta (P_FRAME_LINE_LO),y

        lda P_TMP_X_HI                  ; X coord 9th bit
        cmp #$0
        beq @no_msigx
        ldy #FL_MSIGX
        lda (P_FRAME_LINE_LO),y
        ora P_SPRITE_BIT
        sta (P_FRAME_LINE_LO),y
        
@no_msigx

        inc P_SPRITE_NUM
        asl P_SPRITE_BIT

        pla
        tay
        rts

DRAW_TOMATO

        lda #48
        sta CHAR_INDEX
        lda #BG_COL_3
        sta CHAR_BG_COL
        lda #COL_RED
        sta CHAR_COL

        jsr DRAW_BOX

        rts

DRAW_LETTUCE

        lda #49
        sta CHAR_INDEX
        lda #BG_COL_3
        sta CHAR_BG_COL
        lda #COL_GREEN
        sta CHAR_COL

        jsr DRAW_BOX

        rts

DRAW_MEAT
        lda #50
        sta CHAR_INDEX
        lda #BG_COL_3
        sta CHAR_BG_COL
        lda #COL_LRED
        sta CHAR_COL

        jsr DRAW_BOX

        rts

DRAW_BUN
        lda #51
        sta CHAR_INDEX
        lda #BG_COL_3
        sta CHAR_BG_COL
        lda #COL_ORANGE
        sta CHAR_COL

        jsr DRAW_BOX

        rts

DRAW_PLATE
        lda #52
        sta CHAR_INDEX
        lda #BG_COL_3
        sta CHAR_BG_COL
        lda #COL_WHITE
        sta CHAR_COL

        jsr DRAW_BOX

        rts

DRAW_BENCH

        lda #32
        sta CHAR_INDEX
        ora #BG_COL_0
        lda #COL_MGREY
        sta CHAR_COL

        jsr DRAW_9
        
        lda #OBJ_NONE
        sta P_FRAME
        jsr ADD_SPRITE_POS

        rts

DRAW_STOVE

        tya
        pha

        lda #BG_COL_3
        sta CHAR_BG_COL
        lda #COL_RED
        sta CHAR_COL
        
        jsr DRAW_BOX

        lda #45
        ora #BG_COL_3
        ldy #$29
        sta (M_MAP_POS_LO),y

        lda #OBJ_PAN
        sta P_FRAME
        jsr ADD_SPRITE_POS

        pla
        tay
        rts

DRAW_CHOP
        tya
        pha

        ldy #$0
        lda #53
        ora #BG_COL_3
        sta (M_MAP_POS_LO),y
        lda #COL_YELLOW
        sta (M_COL_POS_LO),y
        iny
        lda #57
        ora #BG_COL_3        
        sta (M_MAP_POS_LO),y
        lda #COL_YELLOW
        sta (M_COL_POS_LO),y
        iny
        lda #54
        ora #BG_COL_3
        sta (M_MAP_POS_LO),y
        lda #COL_YELLOW
        sta (M_COL_POS_LO),y
        ldy #$28
        lda #56
        ora #BG_COL_3
        sta (M_MAP_POS_LO),y
        lda #COL_YELLOW
        sta (M_COL_POS_LO),y
        iny
        lda #59
        ora #BG_COL_3
        sta (M_MAP_POS_LO),y
        lda #COL_YELLOW
        sta (M_COL_POS_LO),y
        iny
        lda #55
        ora #BG_COL_3
        sta (M_MAP_POS_LO),y
        lda #COL_YELLOW
        sta (M_COL_POS_LO),y
        
        ldy #$50
        lda #42
        sta (M_MAP_POS_LO),y
        lda #COL_BLACK
        sta (M_COL_POS_LO),y
        iny
        lda #43
        sta (M_MAP_POS_LO),y
        lda #COL_BLACK
        sta (M_COL_POS_LO),y
        iny
        lda #44
        sta (M_MAP_POS_LO),y
        lda #COL_BLACK
        sta (M_COL_POS_LO),y       

        lda #OBJ_NONE
        sta P_FRAME
        jsr ADD_SPRITE_POS

        pla
        tay
        rts

DRAW_BIN
        tya
        pha

        lda #BG_COL_3
        sta CHAR_BG_COL
        lda #COL_BLACK
        sta CHAR_COL
        
        jsr DRAW_BOX_2

        lda #61
        ora #BG_COL_2
        ldy #$29
        sta (M_MAP_POS_LO),y

        pla
        tay
        rts

DRAW_SERVE
        tya
        pha

        lda #BG_COL_1
        sta CHAR_BG_COL
        lda #COL_BLUE
        sta CHAR_COL
        
        jsr DRAW_BOX_2

        lda #47        
        ldy #$29
        sta (M_MAP_POS_LO),y

        pla
        tay
        rts


DRAW_WALL

        lda M_WALL_CHAR
        ora M_WALL_BG
        
        sta CHAR_INDEX

        lda M_WALL_FG_COL
        sta CHAR_COL

        jsr DRAW_9

        rts

DRAW_SLIDER_N
        lda #$0D
        ora #BG_COL_3
        sta CHAR_INDEX
        
        lda #COL_MGREY
        sta CHAR_COL

        jmp DRAW_9


DRAW_SLIDER_S

        lda #$0E
        ora #BG_COL_3
        sta CHAR_INDEX
        
        lda #COL_MGREY
        sta CHAR_COL

        jmp DRAW_9

DRAW_SLIDER_E

        lda #$0F
        ora #BG_COL_3
        sta CHAR_INDEX
        
        lda #COL_MGREY
        sta CHAR_COL

        jmp DRAW_9

DRAW_SLIDER_W

        lda #$10
        ora #BG_COL_3
        sta CHAR_INDEX
        
        lda #COL_MGREY
        sta CHAR_COL

        jmp DRAW_9


DRAW_BLOCKER
       
        lda (L_MAP_LO),y        
        and #$3
        clc
        adc #$6
        ora #BG_COL_1
        sta CHAR_INDEX

        lda M_WALL_FG_COL
        sta CHAR_COL

        jmp DRAW_9       

DRAW_9
        tya
        pha

        lda CHAR_INDEX

        ldy #$0
        sta (M_MAP_POS_LO),y
        iny
        sta (M_MAP_POS_LO),y
        iny
        sta (M_MAP_POS_LO),y
        ldy #$28
        sta (M_MAP_POS_LO),y
        iny
        sta (M_MAP_POS_LO),y
        iny
        sta (M_MAP_POS_LO),y
        ldy #$50
        sta (M_MAP_POS_LO),y
        iny
        sta (M_MAP_POS_LO),y
        iny
        sta (M_MAP_POS_LO),y

        lda CHAR_COL

        ldy #$0
        sta (M_COL_POS_LO),y
        iny
        sta (M_COL_POS_LO),y
        iny
        sta (M_COL_POS_LO),y
        ldy #$28
        sta (M_COL_POS_LO),y
        iny
        sta (M_COL_POS_LO),y
        iny
        sta (M_COL_POS_LO),y
        ldy #$50
        sta (M_COL_POS_LO),y
        iny
        sta (M_COL_POS_LO),y
        iny
        sta (M_COL_POS_LO),y

        pla
        tay
        rts

DRAW_BOX
        tya
        pha

        ldy #$0
        lda #33
        ora CHAR_BG_COL
        sta (M_MAP_POS_LO),y
        iny
        lda #37
        ora CHAR_BG_COL        
        sta (M_MAP_POS_LO),y
        iny
        lda #34
        ora CHAR_BG_COL
        sta (M_MAP_POS_LO),y
        ldy #$28
        lda #40
        ora CHAR_BG_COL
        sta (M_MAP_POS_LO),y
        iny
        lda CHAR_INDEX
        ora CHAR_BG_COL
        sta (M_MAP_POS_LO),y
        iny
        lda #38
        ora CHAR_BG_COL
        sta (M_MAP_POS_LO),y
        ldy #$50
        lda #36
        ora CHAR_BG_COL
        sta (M_MAP_POS_LO),y
        iny
        lda #39
        ora CHAR_BG_COL
        sta (M_MAP_POS_LO),y
        iny
        lda #35
        ora CHAR_BG_COL
        sta (M_MAP_POS_LO),y

        lda CHAR_COL

        ldy #$0
        sta (M_COL_POS_LO),y
        iny
        sta (M_COL_POS_LO),y
        iny
        sta (M_COL_POS_LO),y
        ldy #$28
        sta (M_COL_POS_LO),y
        iny
        sta (M_COL_POS_LO),y
        iny
        sta (M_COL_POS_LO),y
        ldy #$50
        sta (M_COL_POS_LO),y
        iny
        sta (M_COL_POS_LO),y
        iny
        sta (M_COL_POS_LO),y

        pla
        tay
        rts

DRAW_BOX_2
        tya
        pha

        ldy #$0
        lda #53
        ora CHAR_BG_COL
        sta (M_MAP_POS_LO),y
        iny
        lda #57
        ora CHAR_BG_COL        
        sta (M_MAP_POS_LO),y
        iny
        lda #54
        ora CHAR_BG_COL
        sta (M_MAP_POS_LO),y
        ldy #$28
        lda #60
        ora CHAR_BG_COL
        sta (M_MAP_POS_LO),y
        iny
        lda CHAR_INDEX
        ora CHAR_BG_COL
        sta (M_MAP_POS_LO),y
        iny
        lda #58
        ora CHAR_BG_COL
        sta (M_MAP_POS_LO),y
        ldy #$50
        lda #56
        ora CHAR_BG_COL
        sta (M_MAP_POS_LO),y
        iny
        lda #59
        ora CHAR_BG_COL
        sta (M_MAP_POS_LO),y
        iny
        lda #55
        ora CHAR_BG_COL
        sta (M_MAP_POS_LO),y

        lda CHAR_COL

        ldy #$0
        sta (M_COL_POS_LO),y
        iny
        sta (M_COL_POS_LO),y
        iny
        sta (M_COL_POS_LO),y
        ldy #$28
        sta (M_COL_POS_LO),y
        iny
        sta (M_COL_POS_LO),y
        iny
        sta (M_COL_POS_LO),y
        ldy #$50
        sta (M_COL_POS_LO),y
        iny
        sta (M_COL_POS_LO),y
        iny
        sta (M_COL_POS_LO),y

        pla
        tay
        rts

DRAW_LVLMAP
        tya
        pha
       
        lda (L_MAP_LO),y        
        tax

        and #TILE_CHOP
        beq @no_obj

        clc
        adc OBJ_INDEX
        clc
        adc P_SPRITE_NUM
                
        jmp @draw
@no_obj
        txa
@draw
        ldy #$0
        sta (M_LVLMAP_POS_LO),y
        iny
        sta (M_LVLMAP_POS_LO),y
        iny
        sta (M_LVLMAP_POS_LO),y
        ldy #$28
        sta (M_LVLMAP_POS_LO),y
        iny
        sta (M_LVLMAP_POS_LO),y
        iny
        sta (M_LVLMAP_POS_LO),y
        ldy #$50
        sta (M_LVLMAP_POS_LO),y
        iny
        sta (M_LVLMAP_POS_LO),y
        iny
        sta (M_LVLMAP_POS_LO),y

        pla
        tay
        rts

DRAW_FLOOR

        tya
        pha

        tax ; GET_ADJACENT wants map pos in X
        jsr GET_ADJACENT

        jsr DRAW_CHAR_NW
        jsr DRAW_CHAR_N
        jsr DRAW_CHAR_NE
        jsr DRAW_CHAR_E       
        jsr DRAW_CHAR_SE
        jsr DRAW_CHAR_S       
        jsr DRAW_CHAR_SW       
        jsr DRAW_CHAR_W 
        jsr DRAW_CHAR_C

        pla
        tay
        rts

; Gets a bitmap of all adjacent tiles
; Each bit of the value placed in M_ADJ_TILE_BM represents one of the tiles
; adjacent to the current tile. If the adjacent tile is floor the bit is 0
; otherwise it is 1.
;
; The bits are ordered NE,E,SE,S,SW,W,NW,N
;
; The DRAW_CHAR_xx routines can then rotate and mask ADJ_TITLE_BM to get an
; index into the CM_xx lookup tables for the appropriate character to draw.

GET_ADJACENT

        ldy #8
        lda #0
        sta M_ADJ_TILE_BM
@loop
        tya
        pha

        txa
        clc
        adc MAP_ADJACENT,y      ; Get adjacent map postion        

        tay                     ; Put map position in y
        lda (L_MAP_LO),y          ; Load adjacent tile        
        cmp #TILE_WALL
        bcc @not_floor          ; Is it floor?

        lda #1
        jmp @next
@not_floor      
        lda #0        
@next
        sta M_ADJ_TILE_BIT
        lda M_ADJ_TILE_BM          ; Add to tile bitmap
        asl
        ora M_ADJ_TILE_BIT
        sta M_ADJ_TILE_BM

        pla
        tay
        dey
        bne @loop               ; Next adjacent
           
        rts


DRAW_CHAR_C
        lda #$20
        ora #BG_COL_1
        ldy #41
        sta (M_MAP_POS_LO),y
        lda M_SHADOW_COL
        sta (M_COL_POS_LO),y
        rts
DRAW_CHAR_NW
        lda M_ADJ_TILE_BM
        and #7
        tay
        lda CM_NW,y
        ora #BG_COL_1
        ldy #0
        sta (M_MAP_POS_LO),y
        lda M_SHADOW_COL
        sta (M_COL_POS_LO),y
        rts
DRAW_CHAR_N
        lda M_ADJ_TILE_BM
        and #1
        tay
        lda CM_N,y
        ora #BG_COL_1
        ldy #1
        sta (M_MAP_POS_LO),y
        lda M_SHADOW_COL
        sta (M_COL_POS_LO),y
        rts
DRAW_CHAR_NE
        lda M_ADJ_TILE_BM
        asl
        adc #0
        asl
        adc #0
        sta M_ADJ_TILE_BM
        and #7
        tay
        lda CM_NE,y
        ora #BG_COL_1
        ldy #2
        sta (M_MAP_POS_LO),y
        lda M_SHADOW_COL
        sta (M_COL_POS_LO),y
        rts
DRAW_CHAR_E
        lda M_ADJ_TILE_BM
        and #1
        tay
        lda CM_E,y
        ora #BG_COL_1
        ldy #42
        sta (M_MAP_POS_LO),y
        lda M_SHADOW_COL
        sta (M_COL_POS_LO),y
        rts
DRAW_CHAR_SE
        lda M_ADJ_TILE_BM
        asl
        adc #0
        asl
        adc #0
        sta M_ADJ_TILE_BM
        and #7
        tay
        lda CM_SE,y
        ora #BG_COL_1
        ldy #82
        sta (M_MAP_POS_LO),y
        lda M_SHADOW_COL
        sta (M_COL_POS_LO),y
        rts
DRAW_CHAR_S
        lda M_ADJ_TILE_BM
        and #1
        tay
        lda CM_S,y
        ora #BG_COL_1
        ldy #81
        sta (M_MAP_POS_LO),y
        lda M_SHADOW_COL
        sta (M_COL_POS_LO),y
        rts
DRAW_CHAR_SW
        lda M_ADJ_TILE_BM
        asl
        adc #0
        asl
        adc #0
        sta M_ADJ_TILE_BM
        and #7
        tay
        lda CM_SW,y
        ora #BG_COL_1
        ldy #80
        sta (M_MAP_POS_LO),y
        lda M_SHADOW_COL
        sta (M_COL_POS_LO),y
        rts
DRAW_CHAR_W
        lda M_ADJ_TILE_BM
        and #1
        tay
        lda CM_W,y
        ora #BG_COL_1
        ldy #40
        sta (M_MAP_POS_LO),y
        lda M_SHADOW_COL
        sta (M_COL_POS_LO),y
        rts

TEXT_SCREEN
        lda #VMCSB_TEXT
        sta VMCSB

        lda #SCROLY_TEXT
        sta SCROLY

        rts

GFX_SCREEN
        lda #$0
        sta XXPAND
        sta YXPAND

        lda #VMCSB_GFX
        sta VMCSB

        lda #SCROLY_GFX
        sta SCROLY

        rts

DRAW_PLAYERS
        
        lda #PLAYER_LINE 
        cmp RASTER
        bne DRAW_PLAYERS

        time_on RED

        lda #COL_BLACK
        sta SPMC0
        lda #COL_WHITE
        sta SPMC1
        lda #$ff
        sta SPMC

        lda P_SP0X
        sta SP0X
        lda P_SP0Y
        sta SP0Y
        lda P_SP1X
        sta SP1X
        lda P_SP1Y
        sta SP1Y
        lda P_SP2X
        sta SP2X
        lda P_SP2Y
        sta SP2Y
        lda P_SP3X
        sta SP3X
        lda P_SP3Y
        sta SP3Y
                
        lda P_MSIGX
        sta MSIGX

        lda P_SPENA
        sta SPENA

        lda P_SP0COL
        sta SP0COL
        lda P_SP1COL
        sta SP1COL
        lda P_SP2COL
        sta SP2COL
        lda P_SP3COL
        sta SP3COL

        lda P_SPRPTR0
        sta SPRPTR0
        lda P_SPRPTR1
        sta SPRPTR1
        lda P_SPRPTR2
        sta SPRPTR2
        lda P_SPRPTR3
        sta SPRPTR3

        time_off

        rts


DRAW_STATUS

        ldy #SL_WAIT_Y        
@loop1
        lda STATUS_LINE,y
        cmp RASTER
        bne @loop1

        lda SCROLY
        and #$80
        bne @loop1

        time_on WHITE

        lda #COL_GREEN
        sta SPMC0
        lda #COL_RED
        sta SPMC1
        lda #$21
        sta SPMC
        lda #$ff
        sta SPENA
                
        ldy #SL_OBJY
        lda STATUS_LINE,y
        sta SP0Y
        sta SP1Y
        sta SP2Y
        sta SP3Y
        sta SP4Y
        sta SP5Y
        sta SP6Y
        sta SP7Y
                
        ; Set sprite X positions
        ldy #SL_SP0X
        lda STATUS_LINE,y
        sta SP0X
        iny
        lda STATUS_LINE,y
        sta SP1X
        iny
        lda STATUS_LINE,y
        sta SP2X
        iny
        lda STATUS_LINE,y
        sta SP3X
        iny
        lda STATUS_LINE,y
        sta SP4X
        iny
        lda STATUS_LINE,y
        sta SP5X
        iny
        lda STATUS_LINE,y
        sta SP6X
        iny
        lda STATUS_LINE,y
        sta SP7X
        iny

        lda STATUS_LINE,y
        sta MSIGX
        iny

        lda STATUS_LINE,y ; Sprite colours
        sta SP0COL
        iny
        lda STATUS_LINE,y
        sta SP1COL
        iny
        lda STATUS_LINE,y
        sta SP2COL
        iny
        lda STATUS_LINE,y
        sta SP3COL
        iny
        lda STATUS_LINE,y
        sta SP4COL
        iny
        lda STATUS_LINE,y
        sta SP5COL
        iny
        lda STATUS_LINE,y
        sta SP6COL
        iny
        lda STATUS_LINE,y
        sta SP7COL
        iny

        
        lda STATUS_LINE,y  ; Sprite frames
        sta SPRPTR0
        iny
        lda STATUS_LINE,y  
        sta SPRPTR1
        iny
        lda STATUS_LINE,y  
        sta SPRPTR2
        iny
        lda STATUS_LINE,y  
        sta SPRPTR3
        iny
        lda STATUS_LINE,y 
        sta SPRPTR4
        iny
        lda STATUS_LINE,y  
        sta SPRPTR5
        iny
        lda STATUS_LINE,y  
        sta SPRPTR6
        iny
        lda STATUS_LINE,y  
        sta SPRPTR7
        iny

        time_off

        rts

;
; Waits for the next line of tiles in the display and
; sets up sprites for the fixed objects on that line
;
DRAW_OBJECTS

        ldy #0
        lda (FRAME_LINE_LO),y   ; Get the line to wait for
@loop1
        cmp RASTER              ; Have we reached it?
        bne @loop1

        time_on CYAN

        ldy #FL_OBJY
        lda (FRAME_LINE_LO),y
        sta SP4Y
        sta SP5Y
        sta SP6Y
        sta SP7Y
        
        ; Set sprite X positions
        ldy #FL_SP4X
        lda (FRAME_LINE_LO),y
        sta SP4X
        iny
        lda (FRAME_LINE_LO),y
        sta SP5X
        iny
        lda (FRAME_LINE_LO),y
        sta SP6X
        iny
        lda (FRAME_LINE_LO),y
        sta SP7X
        iny
        
        lda (FRAME_LINE_LO),y
        ora P_MSIGX
        sta MSIGX
        iny
        
        lda (FRAME_LINE_LO),y   ; Enable/disable sprites
        ora P_SPENA
        sta SPENA
        iny
        
        lda (FRAME_LINE_LO),y   ; Sprite colours
        sta SP4COL
        iny
        lda (FRAME_LINE_LO),y  
        sta SP5COL
        iny
        lda (FRAME_LINE_LO),y  
        sta SP6COL
        iny
        lda (FRAME_LINE_LO),y  
        sta SP7COL
        iny

        lda (FRAME_LINE_LO),y  ; Sprite frames
        sta SPRPTR4
        iny
        lda (FRAME_LINE_LO),y  
        sta SPRPTR5
        iny
        lda (FRAME_LINE_LO),y  
        sta SPRPTR6
        iny
        lda (FRAME_LINE_LO),y  
        sta SPRPTR7
        iny
        
        time_off

        rts

FADE_IN
        jsr FADE_WAIT

        lda #0
        sta SPENA

        lda #COL_DGREY
        sta F_FG_COL
        lda #COL_BLACK
        sta F_BG_COL

        jsr FADE_WAIT
        jsr DO_FADE

        lda #COL_MGREY
        sta F_FG_COL
        lda #COL_DGREY
        sta F_BG_COL

        jsr FADE_WAIT
        jsr DO_FADE

        lda #COL_LGREY
        sta F_FG_COL
        lda #COL_MGREY
        sta F_BG_COL

        jsr FADE_WAIT
        jsr DO_FADE

        jsr FADE_WAIT

        lda #COL_LGREY
        sta BGCOL0
        lda M_FLOOR_COL
        sta BGCOL1
        lda #COL_WHITE
        sta BGCOL2
        lda #COL_DGREY
        sta BGCOL3
        lda #COL_BLACK
        sta EXTCOL
        lda #COL_BLACK
        sta SPMC0
        lda #COL_WHITE
        sta SPMC1

        ldx #$0
        
@loop
        lda COLOUR_RAM_0,x
        sta REAL_COLOUR_RAM_0,x
        lda COLOUR_RAM_1,x
        sta REAL_COLOUR_RAM_1,x
        lda COLOUR_RAM_2,x
        sta REAL_COLOUR_RAM_2,x
        lda COLOUR_RAM_3,x
        sta REAL_COLOUR_RAM_3,x
        dex
        bne @loop

        rts


FADE_FG_IN_INIT
        lda #$0
        sta FG_FADE_INDEX
        lda #FG_FADE_FREQ
        sta FG_FADE_COUNT
        rts

FADE_FG_IN
        jsr FG_FADE_WAIT

        lda FG_FADE_INDEX
        cmp #FG_FADE_LENGTH
        bne @incomplete
        rts

@incomplete
        lda FG_FADE_COUNT
        sec
        sbc #$1
        sta FG_FADE_COUNT
        beq @do_fade
        rts

@do_fade
        ldy FG_FADE_INDEX
        lda FG_FADE_COLS,y
        
        cmp #$FF
        beq @copy_colours
        
        jsr DO_FG_FADE

        jmp @done

@copy_colours
        ldx #$0
        
@loop
        lda COLOUR_RAM_0,x
        sta REAL_COLOUR_RAM_0,x
        lda COLOUR_RAM_1,x
        sta REAL_COLOUR_RAM_1,x
        lda COLOUR_RAM_2,x
        sta REAL_COLOUR_RAM_2,x
        lda COLOUR_RAM_3,x
        sta REAL_COLOUR_RAM_3,x
        dex
        bne @loop

@done
        lda #FG_FADE_FREQ
        sta FG_FADE_COUNT

        inc FG_FADE_INDEX
        rts


FADE_OUT
        jsr FADE_WAIT

        lda #0
        sta SPENA
        sta YXPAND
        sta XXPAND
        
        lda #COL_LGREY
        sta F_FG_COL
        lda #COL_MGREY
        sta F_BG_COL

        jsr FADE_WAIT
        jsr DO_FADE

        lda #COL_MGREY
        sta F_FG_COL
        lda #COL_DGREY
        sta F_BG_COL

        jsr FADE_WAIT
        jsr DO_FADE

        lda #COL_DGREY
        sta F_FG_COL
        lda #COL_BLACK
        sta F_BG_COL

        jsr FADE_WAIT
        jsr DO_FADE

        jsr FADE_WAIT

        lda #COL_BLACK
        sta BGCOL0
        sta BGCOL1
        sta BGCOL2
        sta BGCOL3
        sta EXTCOL
        sta SPMC0
        sta SPMC1

        ldx #$0
        
@loop
        sta REAL_COLOUR_RAM_0,x
        sta REAL_COLOUR_RAM_1,x
        sta REAL_COLOUR_RAM_2,x
        sta REAL_COLOUR_RAM_3,x
        dex
        bne @loop

        rts

FADE_FG_OUT_INIT
        lda #FG_FADE_LENGTH
        sta FG_FADE_INDEX
        lda #FG_FADE_FREQ
        sta FG_FADE_COUNT
        rts

FADE_FG_OUT
        jsr FG_FADE_WAIT

        lda FG_FADE_INDEX
        cmp #$0
        bne @incomplete
        rts

@incomplete
        lda FG_FADE_COUNT
        sec
        sbc #$1
        sta FG_FADE_COUNT
        beq @do_fade

        lda #$1
        rts

@do_fade
        dec FG_FADE_INDEX

        ldy FG_FADE_INDEX
        lda FG_FADE_COLS,y
        
        jsr DO_FG_FADE

        lda #FG_FADE_FREQ
        sta FG_FADE_COUNT

        lda #$1
        rts

FG_FADE_WAIT
        lda #180
@loop
        cmp RASTER
        bne @loop
        rts

FADE_WAIT
        
        ldx #5
        lda #251
@loop1
        sec
        sbc #1
@loop2
        cmp RASTER
        bne @loop2

        dex
        bne @loop1

        rts

DO_FADE
        lda F_BG_COL
        sta BGCOL0
        sta BGCOL1
        sta BGCOL2
        sta BGCOL3
        lda #COL_BLACK
        sta EXTCOL
        ldx #$0
     
        lda F_FG_COL   
@loop
        sta REAL_COLOUR_RAM_0,x
        sta REAL_COLOUR_RAM_1,x
        sta REAL_COLOUR_RAM_2,x
        sta REAL_COLOUR_RAM_3,x
        dex
        bne @loop

        rts


DO_FG_FADE

        ldx #$0        
        lda F_FG_COL
@loop
        sta REAL_COLOUR_RAM_0,x
        sta REAL_COLOUR_RAM_1,x
        sta REAL_COLOUR_RAM_2,x
        sta REAL_COLOUR_RAM_3,x
        dex
        bne @loop

        rts

WRITE_NUMBER
        lda TEXT_POS_LO
        clc
        adc #<SCREEN_0
        sta TEXT_DST_LO
        lda TEXT_POS_HI
        adc #>SCREEN_0
        sta TEXT_DST_HI

        lda TEXT_POS_LO
        clc
        adc #<COLOUR_RAM
        sta TEXT_COL_LO
        lda TEXT_POS_HI
        adc #>COLOUR_RAM
        sta TEXT_COL_HI

        ldy #$0
        ldx #$0
        lda TEXT_NUM

@loop_10s
        cmp #10
        bcc @write_10s
        sec
        sbc #10
        inx
        jmp @loop_10s

@write_10s
        sta TEXT_NUM
        txa
        cmp #$0
        beq @skip_zero
        jsr WRITE_DIGIT_A_Y
        iny
@skip_zero
        lda TEXT_NUM
        jsr WRITE_DIGIT_A_Y

        rts
        
WRITE_DIGIT
        lda TEXT_POS_LO
        clc
        adc #<SCREEN_0
        sta TEXT_DST_LO
        lda TEXT_POS_HI
        adc #>SCREEN_0
        sta TEXT_DST_HI

        lda TEXT_POS_LO
        clc
        adc #<COLOUR_RAM
        sta TEXT_COL_LO
        lda TEXT_POS_HI
        adc #>COLOUR_RAM
        sta TEXT_COL_HI

        ldy #$0
        lda TEXT_NUM
        
WRITE_DIGIT_A_Y
                
        clc 
        adc #48
        tax

        sta (TEXT_DST_LO),y
        
        lda TEXT_COL_1
        sta (TEXT_COL_LO),y

        tya
        clc
        adc #SCREEN_WIDTH
        tay

        txa 
        clc
        adc #128        
        sta (TEXT_DST_LO),y

        lda TEXT_COL_2
        sta (TEXT_COL_LO),y

        tya
        sec
        sbc #SCREEN_WIDTH
        tay

        rts

WRITE_TEXT_CENTER

        lda #SCREEN_WIDTH
        ldy #$0
        sec
        sbc (TEXT_SRC_LO),y
        lsr
        
        clc
        adc TEXT_POS_LO
        sta TEXT_POS_LO
        lda TEXT_POS_HI
        adc #$0
        sta TEXT_POS_HI        

        ; Fall throught to WRITE_TEXT

WRITE_TEXT
        
        lda TEXT_POS_LO
        clc
        adc #<SCREEN_0
        sta TEXT_DST_LO
        lda TEXT_POS_HI
        adc #>SCREEN_0
        sta TEXT_DST_HI

        lda TEXT_POS_LO
        clc
        adc #<COLOUR_RAM
        sta TEXT_COL_LO
        lda TEXT_POS_HI
        adc #>COLOUR_RAM
        sta TEXT_COL_HI

        ldy #$0
        lda (TEXT_SRC_LO),y
        sta TEXT_LEN

@loop1
        iny

        lda (TEXT_SRC_LO),y
        sta (TEXT_DST_LO),y

        lda TEXT_COL_1
        sta (TEXT_COL_LO),y

        cpy TEXT_LEN
        bne @loop1

        lda TEXT_DST_LO
        clc
        adc #SCREEN_WIDTH
        sta TEXT_DST_LO
        lda TEXT_DST_HI
        adc #$0
        sta TEXT_DST_HI

        lda TEXT_COL_LO
        clc
        adc #SCREEN_WIDTH
        sta TEXT_COL_LO
        lda TEXT_COL_HI
        adc #$0
        sta TEXT_COL_HI

        ldy #$0
@loop2
        iny

        lda (TEXT_SRC_LO),y
        clc
        adc #128        
        sta (TEXT_DST_LO),y

        lda TEXT_COL_2
        sta (TEXT_COL_LO),y

        cpy TEXT_LEN
        bne @loop2

        rts
        

