
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

RUN_PLAYER_1
        ldx #$0                 ; Store joystick to check in X
        lda #<P1_DATA           ; Player 1 data pointer
        sta P_PLAYER_LO
        lda #>P1_DATA
        sta P_PLAYER_HI

        jmp RUN_PLAYER

RUN_PLAYER_2
        ldx #$1                 ; Store joystick to check in X
        lda #<P2_DATA           ; Player 1 data pointer
        sta P_PLAYER_LO
        lda #>P2_DATA
        sta P_PLAYER_HI

        jmp RUN_PLAYER
        
RUN_PLAYER

        plda PL_MSG             ; Are we showing a message?
        cmp #MSG_NONE
        beq @no_msg

        plda PL_MSG_COUNT
        cmp #$FF                ; Is it fixed?
        beq @no_msg     
        sec                     ; Decrement the counter
        sbc #$1

        psta PL_MSG_COUNT
        cmp #$0                 ; Hide when done
        bne @msg_shown
        lda #MSG_NONE
        psta PL_MSG
        lda #DIR_S
        psta PL_DIR

        jmp @no_msg
@msg_shown
        jmp @done

@no_msg

        jsr CHECK_JOYSTICK      

        lda P_BUTTON            ; Has the button state changed?
        pcmp PL_BUTTON
        beq @no_button_change
        jsr P_BUTTON_CHANGE     ; Yes, so deal with it.

        lda P_BUTTON
        psta PL_BUTTON

        jmp @done

@no_button_change

        plda PL_ACTIVITY        ; What activity is the player performing?
        cmp #ACT_MOVE
        bne @is_chop
        jsr MOVE_PLAYER         ; Activity - moving
       
        jsr SLIDE_PLAYER        ; Are we on a slider?
        cmp #$0
        bne @check_blocked

        lda L_TIME_TICKS        ; On every second frame...
        and #$1
        cmp #$0
        beq @check_blocked
        jsr MOVE_PLAYER         ; ... move the player a second time
        
@check_blocked
        jsr IS_BLOCKED          ; Are we stuck on a blocker?
        jmp @done
@is_chop
        cmp #ACT_CHOP
        bne @is_cook
        jsr CHOP_PLAYER         ; Chopping lettuce or tomato.
        jmp @done
@is_cook
        cmp #ACT_COOK
        bne @is_blocked
        jsr COOK_PLAYER         ; Cooking a patty

@is_blocked
        cmp #ACT_BLOCKED
        bne @done
        jsr BLOCKED_PLAYER

@done
        lda P_UPDATE_OBJECT      ; Do we need to update an object sprite?  
        cmp #$0
        beq @no_update
        
        jsr UPDATE_OBJECT_SPRITES       

        lda #$0
        sta P_UPDATE_OBJECT

@no_update
        rts

BLOCKED_PLAYER

        lda #DIR_SHRUG
        psta PL_DIR

        jsr IS_BLOCKED

        plda PL_ACTIVITY
        cmp #ACT_BLOCKED
        beq @still_blocked
                
        lda #DIR_S
        psta PL_DIR

@still_blocked
        rts

MOVE_PLAYER

        lda P_STICK             ; Is the joystick pointing anywhere?
        cmp #DIR_NONE
        beq @reset_frame        ; No
  
@move_east

        lda P_STICK
        and #DIR_E
        cmp #DIR_E
        bne @move_west
        jsr P_MOVE_E
        jmp @move_north

@move_west
        lda P_STICK
        and #DIR_W
        cmp #DIR_W
        bne @move_north
        jsr P_MOVE_W

@move_north
        lda P_STICK
        and #DIR_N
        cmp #DIR_N
        bne @move_south
        jsr P_MOVE_N
        jmp @update_frame

@move_south
        lda P_STICK
        and #DIR_S
        cmp #DIR_S
        bne @update_frame
        jsr P_MOVE_S

@update_frame
        plda PL_FRAME_COUNT     ; Is it time to change the chef's frame?
        clc 
        adc #$1
        psta PL_FRAME_COUNT
        and #ANIM_FREQ
        cmp #ANIM_FREQ
        bne @done
        
        plda PL_FRAME
        clc
        adc #$1
        and #PLAYER_FRAME_MASK
        psta PL_FRAME

        jmp @done

@reset_frame
        lda #0
        psta PL_FRAME           ; Reset to a standing frame

@done
        rts

CHOP_PLAYER

        lda P_STICK         
        pcmp PL_ACT_DIR         ; Has the stick moved?
        beq @show_progress
        psta PL_ACT_DIR
            
        pldx PL_ACT_INDEX
        lda LVL_OBJ_VAL,x       ; Get the current object value
        clc
        adc #$1
        sta LVL_OBJ_VAL,x
        cmp #20                 ; Finished?
        bne @show_progress
        
        inc LVL_OBJ_TYPE,x      ; Change to Chopped type
        lda #0
        sta LVL_OBJ_VAL,x       ; Reset value

        lda #ACT_MOVE           ; Switch back to Moving
        psta PL_ACTIVITY

        plda PL_ACT_INDEX
        jsr UPDATE_OBJECT

        lda #MSG_OK             ; Show message
        jmp P_SHOW_MSG

@show_progress

        pldx PL_ACT_INDEX       ; Display progress
        ldy LVL_OBJ_VAL,x 

        lda CHOP_FRAME_SEQ,y    ; Look up progress message
        psta PL_MSG
        lda #$FF
        psta PL_MSG_COUNT
 
        rts

COOK_PLAYER
        
        lda P_STICK
        pcmp PL_ACT_DIR         ; Has the stick moved?
        beq @show_progress
        psta PL_ACT_DIR
            
        pldx PL_ACT_INDEX
        lda LVL_OBJ_VAL,x       ; Get the current object value
        clc
        adc #$1
        sta LVL_OBJ_VAL,x
        cmp #20                 ; Finished?
        bne @show_progress
        
        lda #OBJ_PAN_COOKED
        sta LVL_OBJ_TYPE,x      ; Change to Pan - Cooked type
        lda #0
        sta LVL_OBJ_VAL,x       ; Reset value

        lda #ACT_MOVE           ; Switch back to Moving
        psta PL_ACTIVITY

        plda PL_ACT_INDEX
        jsr UPDATE_OBJECT
        
        lda #MSG_OK             ; Show message
        jmp P_SHOW_MSG

@show_progress

        pldx PL_ACT_INDEX       ; Display progress
        ldy LVL_OBJ_VAL,x 

        lda COOK_FRAME_SEQ,y    ; Look up progress message
        psta PL_MSG
        lda #$FF
        psta PL_MSG_COUNT

        rts

P_BUTTON_CHANGE

        lda P_BUTTON
        cmp #$0
        beq @button_up          ; Button was released
        rts

@button_up  
        lda #ACT_BLOCKED
        pcmp PL_ACTIVITY
        bne @is_moving
        rts

@is_moving
        lda #ACT_MOVE           ; If the chef was chopping or cooking
        pcmp PL_ACTIVITY        ; switch back to moving
        beq @act_moving        
        psta PL_ACTIVITY
        lda #MSG_NONE
        psta Pl_MSG
        rts

@act_moving
        plda PL_OBJ
        cmp #OBJ_NONE           ; Carrying an object?
        beq @pick_up
       
        jsr P_GET_ACTIVITY_TILE ; What are we trying to put something 
                                ; down on?
        lda P_FRAME
  
        cmp #TILE_BIN
        bne @is_serve
        jmp P_PUT_IN_BIN        ; Trash
        
@is_serve
        cmp #TILE_SERVE
        bne @others

        jmp P_DO_SERVE          ; Serve

@others                         ; Plain bench, Chopping board or Stove.
        lda OBJ_INDEX
        cmp #$ff                ; Make sure we can place an object there
        beq @put_down_done
        jmp P_SWAP_OBJ          

@put_down_done
        rts

@pick_up
        jsr P_GET_ACTIVITY_TILE ; What are we trying to pick something
                                ; up from?        
        lda P_FRAME

        cmp #TILE_BENCH         ; Plain bench
        bne @chopping_board
        jmp P_SWAP_OBJ


@chopping_board
        cmp #TILE_CHOP
        bne @stove
        jsr P_PICK_UP_OR_CHOP   ; Chopping board
        rts

@stove
        cmp #TILE_STOVE
        bne @get_tomato
        jmp P_PICK_UP_STOVE     ; Stove

@get_tomato
        cmp #TILE_TOMATO
        bne @get_lettuce
        lda #OBJ_TOMATO         ; Tomato box
        jmp @pick_up_done

@get_lettuce
        cmp #TILE_LETTUCE
        bne @get_bun
        lda #OBJ_LETTUCE        ; Lettuce box
        jmp @pick_up_done

@get_bun
        cmp #TILE_BUN
        bne @get_meat
        lda #OBJ_BUN            ; Bun box
        jmp @pick_up_done

@get_meat
        cmp #TILE_MEAT
        bne @get_plate
        lda #OBJ_MEAT_RAW       ; Patty box
        jmp @pick_up_done

@get_plate
        cmp #TILE_PLATE
        bne @done              ; Plate box
        lda #OBJ_PLATE

@pick_up_done
        psta PL_OBJ             ; Add object to player
        lda #$0
        psta PL_OBJ_VAL

@done
        rts

P_SHOW_MSG

        psta PL_MSG             ; Message passed in A
        lda #50                 ; Show for ~1 second
        psta PL_MSG_COUNT
        lda #DIR_SHRUG          ; Change chef frame
        psta PL_DIR
        rts

; Handle a button press when facing a bin
P_PUT_IN_BIN
        plda PL_OBJ
                
        cmp #OBJ_PAN            ; Can't bin an empty pan
        bne @is_full_pan
        
        lda #MSG_ERR
        jmp P_SHOW_MSG

@is_full_pan

        cmp #OBJ_PAN_COOKING    ; Is the object a pan with something in it?
        beq @empty_pan
        cmp #OBJ_PAN_COOKED
        beq @empty_pan

        lda #0                  ; Throw object
        psta PL_OBJ
        psta PL_OBJ_VAL

        rts

@empty_pan
        lda #OBJ_PAN            ; Throw pan contents
        psta PL_OBJ
        lda #0        
        psta PL_OBJ_VAL

        rts

; Handle a button press when facing a stove
P_PICK_UP_STOVE

        plda PL_OBJ
        cmp #OBJ_NONE           ; Are hands empty?
        beq @not_empty
        jmp P_SWAP_OBJ          ; Pick up pan

@not_empty             
        ldy OBJ_INDEX
        lda LVL_OBJ_TYPE,y
        
        cmp #OBJ_PAN            ;  Pan - Empty on stove?
        beq @no_cook
        
        cmp #OBJ_PAN_COOKED     ;  Pan - Cooked on stove?
        beq @no_cook

        cmp #OBJ_PAN_COOKING    ;  Pan - Cooking on stove?        
        bne @no_cook

        lda #ACT_COOK           ;  Start cooking
        psta PL_ACTIVITY

        plda PL_DIR             ; Remember which direction we were facing
        psta PL_ACT_DIR        

        lda OBJ_INDEX           ; Remember which object we're acting on
        psta PL_ACT_INDEX

        ldy #$0                 ; Show the progress message
        lda COOK_FRAME_SEQ,y
        psta PL_MSG
        lda #$FF
        psta PL_MSG_COUNT
        
        rts
@no_cook
        jmp P_SWAP_OBJ          ; Treat it like a bench


; Handle a button press when facing a chopping board
P_PICK_UP_OR_CHOP

        plda PL_OBJ             ; Are hands empty?
        cmp #OBJ_NONE
        beq @no_swap
        jmp P_SWAP_OBJ          ; Something in our hands so just act like
                                ; the tile is a bench

@no_swap
        ldy OBJ_INDEX
        lda LVL_OBJ_TYPE,y

        cmp #OBJ_TOMATO         ; Is there a tomato or lettuce on the board?
        beq @start_chopping
        cmp #OBJ_LETTUCE
        beq @start_chopping
        jmp P_SWAP_OBJ

@start_chopping                 
        lda #ACT_CHOP           ; Insert Dinosaur Jr joke
        psta PL_ACTIVITY
        
        plda PL_DIR             ; Remember which direction we were facing
        psta PL_ACT_DIR        
        
        lda OBJ_INDEX           ; Remember which object we're acting on
        psta PL_ACT_INDEX
        
        ldy #$0                 ; Show the progress message
        lda CHOP_FRAME_SEQ,y
        psta PL_MSG
        lda #$FF
        psta PL_MSG_COUNT
        rts

; Handle a button press when facing a bench with a plate on it
P_DO_PLATE
        plda PL_OBJ
        
        cmp #OBJ_NONE           ; Are hands empty?
        bne @hands_full
        jmp P_JUST_SWAP         ; Yes, so just pick up the plate

@hands_full
        cmp #OBJ_BUN            ; Are we holding one of the required objects?
        beq @do_bun
        cmp #OBJ_TOM_CHOP
        beq @do_tomato
        cmp #OBJ_LET_CHOP
        beq @do_lettuce
        cmp #OBJ_PAN_COOKED
        beq @do_meat

        jmp @show_error         ; Don't need whatever we're holding

@do_bun                         ; Put the ingredient into X
        ldx #BURG_BUN
        jmp @do_ingredient

@do_tomato
        ldx #BURG_TOMATO
        jmp @do_ingredient

@do_lettuce
        ldx #BURG_LETTUCE
        jmp @do_ingredient

@do_meat
        ldx #BURG_MEAT
        jmp @do_ingredient

@do_ingredient
        txa

        ldy OBJ_INDEX   
        and LVL_OBJ_VAL,y       ; Have we already got the ingredient?
        bne @show_error

        txa
        ora LVL_OBJ_VAL,y       ; No, so add it
        sta LVL_OBJ_VAL,y

        lda #OBJ_PLATE_FULL     ; Change image to a full plate
        sta LVL_OBJ_TYPE,y

        lda OBJ_INDEX           ; Need to change the object sprite
        jsr UPDATE_OBJECT
        
        lda #$0                 ; Remove ingredient from hands
        psta PL_OBJ_VAL
        
        txa                     ; If we just added meat 
        cmp #BURG_MEAT
        bne @not_meat
        lda #OBJ_PAN            ; Change the held object to an empty pan
        jmp @store_obj
@not_meat
        lda #OBJ_NONE

@store_obj
        psta PL_OBJ             
        
        jmp @show_count

@show_error                     ; We end up here by either trying to drop
                                ; a non-ingredient or an ingredient we already 
                                ; have on the plate

        ldy OBJ_INDEX           ; What ingredients do we need?   
        
        lda LVL_OBJ_VAL,y 
        and #BURG_BUN
        beq @show_missing_bun
        
        lda LVL_OBJ_VAL,y 
        and #BURG_TOMATO
        beq @show_missing_tomato

        lda LVL_OBJ_VAL,y 
        and #BURG_LETTUCE
        beq @show_missing_lettuce

        lda LVL_OBJ_VAL,y 
        and #BURG_MEAT
        beq @show_missing_meat

        lda #MSG_ERR
        jmp @show_missing

@show_missing_bun
        lda #MSG_BUN
        jmp @show_missing

@show_missing_tomato
        lda #MSG_TOMATO
        jmp @show_missing

@show_missing_lettuce
        lda #MSG_LETTUCE
        jmp @show_missing

@show_missing_meat
        lda #MSG_MEAT_COOKED
        jmp @show_missing

@show_missing
        jmp P_SHOW_MSG          

@show_count
                                ; After successfully dropping an ingredient
                                ; on the plate, indicate how many more are
                                ; required

        ldx #0                  ; X stores the ingredient count
        lda #BURG_BUN
        sta P_INGR_BIT          ; P_INGR_BIT is the ingredient we are testing
        ldy OBJ_INDEX           
@loop
        lda LVL_OBJ_VAL,y       
        and P_INGR_BIT          ; Do we already have the ingredient?
        cmp #0
        beq @skip
        inx                     ; Yes, increment X
@skip
        asl P_INGR_BIT          ; Shift to the next ingredient
        lda P_INGR_BIT
        
        cmp #BURG_MEAT + 1      ; Are we done?
        bcc @loop

        txa                     ; Do we have all ingredients?
        cmp #$4
        beq @has_all

        clc                     ; No, show appropriate message
        adc #MSG_1_OF_4 - 1
        jmp @show
@has_all        
        lda #MSG_OK             ; Yes, show OK message
        
@show
        jmp P_SHOW_MSG
        

; Handle a button press when facing a Serve tile
P_DO_SERVE

        plda PL_OBJ             ; Only a Full Plate is valid to drop here
        cmp #OBJ_PLATE_FULL
        bne @show_generic_error 

        plda PL_OBJ_VAL         ; Is the burger complete?
        cmp #BURG_ALL
        bne @show_error         ; No, show missing ingredient


                                ; Yes, increment the score
        lda L_BURGER_COUNT_LO     ; Increment the lo digit
        cmp #9
        beq @inc_hi
        clc
        adc #$1
        sta L_BURGER_COUNT_LO

        clc                     ; Update the lo digit status bar sprite
        adc #SB_0
        ldy #SL_SPRPTR7
        sta STATUS_LINE,y
        jmp @done_score
@inc_hi                         ; Increment the hi digit

        lda #$0                 ; Reset lo digit to 0 and update sprite
        sta L_BURGER_COUNT_LO

        ldy #SL_SPRPTR7
        sta STATUS_LINE,y

        lda L_BURGER_COUNT_HI     ; Add one to the hi digit
        clc
        adc #1
        sta L_BURGER_COUNT_HI

        clc                     ; Update hi digit sprite
        adc #SB_0
        ldy #SL_SPRPTR6
        sta STATUS_LINE,y

@done_score
        
        lda #$0                 ; Remove object from hands
        psta PL_OBJ_VAL
        lda #OBJ_NONE
        psta PL_OBJ

        rts

@show_error                     ; Decide which ingredient is missing
        
        plda PL_OBJ_VAL
        and #BURG_BUN
        beq @show_missing_bun
        
        plda PL_OBJ_VAL
        and #BURG_TOMATO
        beq @show_missing_tomato

        plda PL_OBJ_VAL
        and #BURG_LETTUCE
        beq @show_missing_lettuce

        plda PL_OBJ_VAL
        and #BURG_MEAT
        beq @show_missing_meat

@show_generic_error
        lda #MSG_ERR
        jmp @show_missing

@show_missing_bun
        lda #MSG_BUN
        jmp @show_missing

@show_missing_tomato
        lda #MSG_TOMATO
        jmp @show_missing

@show_missing_lettuce
        lda #MSG_LETTUCE
        jmp @show_missing

@show_missing_meat
        lda #MSG_MEAT_COOKED
        jmp @show_missing

@show_missing
        jmp P_SHOW_MSG

; Handles picking up and putting down objects
P_SWAP_OBJ
        ldy OBJ_INDEX           ; Temp storage for swapping objects
        lda LVL_OBJ_TYPE,y
        sta P_TMP_OBJ_TYPE      

        lda LVL_OBJ_VAL,y
        sta P_TMP_OBJ_VAL

        lda P_TMP_OBJ_TYPE      ; Trying to put something in empty pan?
        cmp #OBJ_PAN
        beq @do_pan

        cmp #OBJ_PLATE          ; Trying to put something on a plate?
        beq @do_plate

        cmp #OBJ_PLATE_FULL
        beq @do_plate

        jmp P_JUST_SWAP         ; Just swap
@do_plate
        jmp P_DO_PLATE
@do_pan
        plda PL_OBJ             ; Nothing in hands, pick up pan
        cmp #OBJ_NONE
        beq P_JUST_SWAP

        cmp #OBJ_MEAT_RAW       ; Holding raw patty?
        bne @show_meat_err
        
        lda #OBJ_PAN_COOKING    ; Put meat patty in pan
        ldy OBJ_INDEX
        sta LVL_OBJ_TYPE,y
        lda #$0
        sta LVL_OBJ_VAL,y
        
        psta PL_OBJ_VAL         ; Remove from hands
        lda #OBJ_NONE
        psta PL_OBJ
        
        lda OBJ_INDEX           ; Update object sprite
        jsr UPDATE_OBJECT 

        rts

@show_meat_err
        lda #MSG_MEAT_RAW       ; Show raw meat patty message
        jmp P_SHOW_MSG


P_JUST_SWAP                     ; Swap objects between hands and tile
        plda PL_OBJ
        ldy OBJ_INDEX
        sta LVL_OBJ_TYPE,y

        plda PL_OBJ_VAL
        ldy OBJ_INDEX
        sta LVL_OBJ_VAL,y

        lda P_TMP_OBJ_TYPE
        psta PL_OBJ

        lda P_TMP_OBJ_VAL
        psta PL_OBJ_VAL

        lda OBJ_INDEX
        jsr UPDATE_OBJECT 

        rts

; Looks for a tile that can be used in an activity
;
; Returns:
; 
;       P_FRAME         - The TILE_XXX type
;       OBJ_INDEX       - The index into the LVL_OBJ_TYPE table if the tile can store an
;                         object
;
P_GET_ACTIVITY_TILE
          
        jsr P_RESET_MAP_POS    

        plda PL_DIR             ; Which direction are we facing?
        
        cmp #DIR_N
        bne @is_south

        lda P_MAP_POS_LO
        sec
        sbc #SCREEN_WIDTH - 1
        sta P_MAP_POS_LO
        bcs @check_tile
        dec P_MAP_POS_HI

        jmp @check_tile

@is_south
        cmp #DIR_S
        bne @is_east

        lda P_MAP_POS_LO
        clc
        adc #SCREEN_WIDTH_X3 + 1
        sta P_MAP_POS_LO
        bcc @check_tile
        inc P_MAP_POS_HI
        jmp @check_tile

@is_east
        cmp #DIR_E
        bne @is_west

        lda P_MAP_POS_LO
        clc
        adc #SCREEN_WIDTH + 3
        sta P_MAP_POS_LO
        bcc @check_tile
        inc P_MAP_POS_HI
        jmp @check_tile

@is_west
        cmp #DIR_W
        bne @done

        lda P_MAP_POS_LO
        clc
        adc #SCREEN_WIDTH - 1
        sta P_MAP_POS_LO
        bcc @check_tile
        inc P_MAP_POS_HI

@check_tile

        ldy #0                  ; Decided where to look, what is there?
        lda (P_MAP_POS_LO),y
        
        tax

        cmp #TILE_BENCH         ; Is this somewhere we can store an object?

        ; Tiles that can store an object contain both the tile type and an
        ; index into the LVL_OBJ_TYPE array. The first 5 bits are the index
        ; and the top two are the type:
        ;
        ;   10 0 10110
        ;   |  |   |
        ;   |  |   \- Index into LVL_OBJ_TYPE
        ;   |  \----- Used for blocker tiles
        ;   \-------- Tile type
        ;
        ; Tiles that cannot store an object do not use the top two bits.

        bcc @no_obj_space       ;  No

        and #$1F                ;  Yes, get index to object array
        sta OBJ_INDEX
        
        txa
        and #TILE_CHOP          ;  Get tile type
        sta P_FRAME
        
        jmp @done

@no_obj_space                   ; Tile does not store object
        lda #$FF
        sta OBJ_INDEX
        stx P_FRAME
@done       
        rts

; Loads the current player's map position 
P_RESET_MAP_POS
        lda #<LVL_TILE_MAP
        clc
        padc PL_MP_LO
        sta P_MAP_POS_LO
        lda #>LVL_TILE_MAP
        padc PL_MP_HI
        sta P_MAP_POS_HI
        rts

P_MOVE_N
        lda #DIR_N
        psta PL_DIR

        plda PL_Y                ; Are we on the edge of a char
        ;clc
        ;adc #$5                 ; Adjust coord to line feet up with char
        and #$7
        cmp #$0
        beq @check
        plda PL_Y                ;  No, so moving is OK
        sec
        sbc #1
        psta PL_Y
        lda #$1
        rts
@check                          ;  Yes, so look at where we're moving to
        jsr P_RESET_MAP_POS

        lda P_MAP_POS_LO
        sec
        sbc #SCREEN_WIDTH
        sta P_MAP_POS_LO
        bcs @cc_1
        dec P_MAP_POS_HI
@cc_1

        ldy #0                  ; Char under East foot
        lda (P_MAP_POS_LO),y
        sta P_R_FOOT_TILE
        ;jsr SHOW_FOOT

        lda P_MAP_POS_LO
        clc
        adc #$2                 ; Char under West foot
        sta P_MAP_POS_LO
        bcc @cc_2
        dec P_MAP_POS_HI
@cc_2
        ldy #0
        lda (P_MAP_POS_LO),y
        sta P_L_FOOT_TILE
        ;jsr SHOW_FOOT

        jsr IS_FOOT_ON_WALL
        beq @no_move
                                ; Move successful
        plda PL_Y               ; Update player Y coord
        sec
        sbc #1
        psta PL_Y

        plda PL_MP_LO           ; Update map position
        sec
        sbc #SCREEN_WIDTH
        psta PL_MP_LO
        plda PL_MP_HI
        sbc #$0
        psta PL_MP_HI
        
        lda P_L_FOOT_TILE
        psta PL_L_FOOT_TILE
        lda P_R_FOOT_TILE
        psta PL_R_FOOT_TILE

        lda #$1
        rts
@no_move
        
        lda #$0
        rts


P_MOVE_S
        lda #DIR_S
        psta PL_DIR        

        plda PL_Y                ; Are we on the edge of a char
        ;clc
        ;adc #5
        and #$7
        cmp #$7

        beq @check
        plda PL_Y                ;  No, so moving is OK
        clc
        adc #1
        psta PL_Y
        lda #$1
        rts
@check                          ;  Yes, so look at where we're moving to
        jsr P_RESET_MAP_POS

        lda P_MAP_POS_LO
        clc
        adc #SCREEN_WIDTH_X2 + 2       ; Char under West foot
        sta P_MAP_POS_LO
        bcc @cc_1
        inc P_MAP_POS_HI
@cc_1
        ldy #0
        lda (P_MAP_POS_LO),y
        sta P_L_FOOT_TILE
        ;jsr SHOW_FOOT

        lda P_MAP_POS_LO
        sec
        sbc #$2                 ; Char under East foot
        sta P_MAP_POS_LO
        bcs @cs_1
        dec P_MAP_POS_HI
@cs_1
        ldy #0
        lda (P_MAP_POS_LO),y
        sta P_R_FOOT_TILE
        ;jsr SHOW_FOOT

        jsr IS_FOOT_ON_WALL
        beq @no_move
        
        plda PL_Y                ;  Move successful
        clc
        adc #1
        psta PL_Y

        plda PL_MP_LO
        clc
        adc #SCREEN_WIDTH
        psta PL_MP_LO
        plda PL_MP_HI
        adc #$0
        psta PL_MP_HI        
        
        lda P_L_FOOT_TILE
        psta PL_L_FOOT_TILE
        lda P_R_FOOT_TILE
        psta PL_R_FOOT_TILE

        lda #$1
        rts
@no_move
        
        lda #$0
        rts


P_MOVE_E
        lda #DIR_E
        psta PL_DIR

        plda PL_X_LO             ; Are we on the edge of a char
        ;clc
        ;adc #3
        and #$7
        cmp #$7
        beq @check
        plda PL_X_LO             ;  No, so moving is OK
        clc 
        adc #$1
        psta PL_X_LO
        plda PL_X_HI
        adc #$0
        psta PL_X_HI
        lda #$1
        rts
@check                          ;  Yes, so look at where we're moving to
        jsr P_RESET_MAP_POS

        lda P_MAP_POS_LO
        clc
        adc #SCREEN_WIDTH + 3   ; Char under East foot
        sta P_MAP_POS_LO
        bcc @cc_2
        inc P_MAP_POS_HI
@cc_2
        ldy #0
        lda (P_MAP_POS_LO),y
        sta P_R_FOOT_TILE

;        lda P_MAP_POS_LO        ; Char under West foot
;        clc
;        adc #SCREEN_WIDTH
;        sta P_MAP_POS_LO
;        bcc @cc_3
;        inc P_MAP_POS_HI
;@cc_3
;        ldy #0
;        lda (P_MAP_POS_LO),y
        sta P_L_FOOT_TILE
        jsr SHOW_FOOT

        jsr IS_FOOT_ON_WALL
        beq @no_move
        
        plda PL_X_LO             ;  Move successful
        clc 
        adc #$1
        psta PL_X_LO
        plda PL_X_HI
        adc #$0
        psta PL_X_HI

        plda PL_MP_LO
        clc
        adc #$1
        psta PL_MP_LO
        plda PL_MP_HI
        adc #$0
        psta PL_MP_HI

        lda P_L_FOOT_TILE
        psta PL_L_FOOT_TILE
        lda P_R_FOOT_TILE
        psta PL_R_FOOT_TILE

        lda #$1
        rts
@no_move
        
        lda #$0
        rts

P_MOVE_W
        lda #DIR_W
        psta PL_DIR

        plda PL_X_LO             ; Are we on the edge of a char        
        ;clc
        ;adc #3
        and #$7
        cmp #$0
        beq @check
        plda PL_X_LO             ;  No, so moving is OK
        sec 
        sbc #$1
        psta PL_X_LO
        plda PL_X_HI
        sbc #$0
        psta PL_X_HI
        lda #$1
        rts
@check                          ;  Yes, so look at where we're moving to
        jsr P_RESET_MAP_POS

        lda P_MAP_POS_LO
        clc
        adc #SCREEN_WIDTH - 1   ; Char under East foot
        sta P_MAP_POS_LO
        bcc @cc_1
        inc P_MAP_POS_HI
@cc_1
        ldy #0
        lda (P_MAP_POS_LO),y
        sta P_L_FOOT_TILE
        
;        lda P_MAP_POS_LO        ; Char under West foot
;        clc
;        adc #SCREEN_WIDTH
;        sta P_MAP_POS_LO
;        bcc @cc_2
;        inc P_MAP_POS_HI
;@cc_2
;        ldy #0
;        lda (P_MAP_POS_LO),y
        sta P_R_FOOT_TILE
        
        jsr IS_FOOT_ON_WALL
        beq @no_move

        plda PL_X_LO             ;  Move successful
        sec 
        sbc #$1
        psta PL_X_LO
        plda PL_X_HI
        sbc #$0
        psta PL_X_HI

        plda PL_MP_LO
        sec
        sbc #$1
        psta PL_MP_LO
        plda PL_MP_HI
        sbc #$0
        psta PL_MP_HI

        lda P_L_FOOT_TILE
        psta PL_L_FOOT_TILE
        lda P_R_FOOT_TILE
        psta PL_R_FOOT_TILE

        lda #$1
        rts
@no_move
        lda #$0
        rts

SHOW_FOOT
        lda P_MAP_POS_LO
        sec
        sbc #<LVL_TILE_MAP
        sta $F0
        lda P_MAP_POS_HI
        sbc #>LVL_TILE_MAP
        sta $F1

        lda $F0
        clc
        adc #$00
        sta $F0
        lda $F1
        adc #$04
        sta $F1

        lda #45
        ldy #0
        sta ($F0),y

        rts

SLIDE_PLAYER
        plda PL_DIR
        sta T_SLIDER_DIR
        
        plda PL_L_FOOT_TILE
        cmp #TILE_SLIDER_W
        bcc @is_north
        plda PL_R_FOOT_TILE
        cmp #$0
        beq @not_sliding  
        
@is_north
        cmp #TILE_SLIDER_N
        bne @is_south
        jsr P_MOVE_N
        jmp @sliding

@is_south
        cmp #TILE_SLIDER_S
        bne @is_east
        jsr P_MOVE_S
        jmp @sliding

@is_east
        cmp #TILE_SLIDER_E
        bne @is_west
        jsr P_MOVE_E
        jmp @sliding

@is_west
        cmp #TILE_SLIDER_W
        bne @not_sliding
        jsr P_MOVE_W
        jmp @sliding

@not_sliding
        
        lda T_SLIDER_DIR
        psta PL_DIR

        lda #$0

        rts

@sliding

        lda T_SLIDER_DIR
        psta PL_DIR

        lda #$1

        rts


IS_BLOCKED

        plda PL_L_FOOT_TILE
        tax
        and #TILE_BLOCKER_0
        cmp #$0
        bne @on_blocker

        plda PL_R_FOOT_TILE
        tax
        and #TILE_BLOCKER_0
        cmp #$0
        beq @not_blocked

@on_blocker

        txa
        and #$3
        tay
        ldx LVL_BLOCK_STATE,y
        lda BLOCKER_SEQ,x
        beq @not_blocked

        lda #ACT_BLOCKED
        psta PL_ACTIVITY

        jmp @done

@not_blocked
        lda #ACT_MOVE
        psta PL_ACTIVITY
@done
        rts

IS_FOOT_ON_WALL

        lda P_L_FOOT_TILE
        jsr IS_ON_WALL
        cmp #$0
        beq @done

        lda P_R_FOOT_TILE
        jsr IS_ON_WALL
        
@done
        rts

IS_ON_WALL
        tax
        and #TILE_WALL_MASK        
        cmp #$0
        beq @not_wall

        txa
        and #TILE_BLOCKER_0
        cmp #$0
        beq @is_wall

        txa
        and #$3
        tay
        ldx LVL_BLOCK_STATE,y
        lda BLOCKER_SEQ,x
        beq @not_wall

@is_wall
        lda #$0
        rts
@not_wall

        lda #$1
        rts
IS_WALL

        ldy #$0
        lda (P_MAP_POS_LO),y

        jmp IS_ON_WALL


UPDATE_PLAYER_SPRITES

        ; The sprite used for each Chef and his carried Object
        ; depends on the direction he's facing and which one is
        ; higher on the screen.

        ; Push the sprite numbers onto the stack in order of
        ; 1 - P1 Chef, 2 - P2 Object, 3 - P2 Chef, 4 - P2 Object

        lda P1_Y                ; Which player is higer on the screen?
        cmp P2_Y
        bcs @p2_hi

                                ; P1 Higher
        lda P1_DIR              ; Facing North?
        cmp #DIR_N
        bne @p1_hi_not_n

        lda #2                  ; Sprite 2 for Chef 1
        pha
        lda #3                  ; Sprite 3 for Object
        pha
        jmp @p1_hi_p2

@p1_hi_not_n

        lda #3                  ; Sprite 3 for Chef 1
        pha
        lda #2                  ; Sprite 2 for Object
        pha

@p1_hi_p2

        lda P2_DIR              ; P2 Direction?
        cmp #DIR_N
        bne @p1_hi_p2_not_n

        lda #0                  ; Sprite 0 for Chef 2
        pha
        lda #1                  ; Sprite 1 for Object
        pha

        jmp @set_sprites

@p1_hi_p2_not_n

        lda #1                  ; Sprite 0 for Chef 2
        pha
        lda #0                  ; Sprite 1 for Object
        pha

        jmp @set_sprites

@p2_hi
                                ; P2 Higher
        lda P1_DIR              ; P1 Facing North?
        cmp #DIR_N
        bne @p2_hi_not_n

        lda #0                  ; Sprite 0 for Chef 1
        pha
        lda #1                  ; Sprite 1 for Object
        pha
        jmp @p2_hi_p2

@p2_hi_not_n

        lda #1                  ; Sprite 1 for Chef 1
        pha
        lda #0                  ; Sprite 0 for Object
        pha

@p2_hi_p2

        lda P2_DIR              ; P2 Direction?
        cmp #DIR_N
        bne @p2_hi_p2_not_n

        lda #2                  ; Sprite 2 for Chef 2
        pha
        lda #3                  ; Sprite 3 for Object
        pha

        jmp @set_sprites

@p2_hi_p2_not_n

        lda #3                  ; Sprite 3 for Chef 2
        pha
        lda #2                  ; Sprite 2 for Object
        pha

@set_sprites

        lda #$0                 ; Clear the enable/HI X bit fields
        sta P_SPENA
        sta P_MSIGX

        ; Pop the sprite numbers from the stack

        lda G_PLAYER_COUNT
        cmp #$2
        beq @m2
        pla
        pla
        jmp @m1

@m2
        lda #<P2_DATA
        sta P_PLAYER_LO
        lda #>P2_DATA
        sta P_PLAYER_HI

        lda #COL_LRED
        sta P_COLOUR

        ; P2 Message
        pla
        sta P_SPRITE_NUM

        plda PL_MSG
        cmp #MSG_NONE
        beq @o2
        jsr SET_MSG_SPRITE
        jmp @p2
@o2
        ; P2 Object
        plda PL_OBJ
        cmp #OBJ_NONE
        beq @p2
        jsr SET_OBJ_SPRITE
@p2
        ; Player 2

        pla
        sta P_SPRITE_NUM        
        jsr SET_PLAYER_SPRITE

@m1
        lda #<P1_DATA
        sta P_PLAYER_LO
        lda #>P1_DATA
        sta P_PLAYER_HI

        lda #COL_BROWN
        sta P_COLOUR

        ; P1 Message
        
        pla
        sta P_SPRITE_NUM

        plda PL_MSG
        cmp #MSG_NONE
        beq @o1
        jsr SET_MSG_SPRITE
        jmp @p1
@o1
        ; P1 Object
        plda PL_OBJ
        cmp #OBJ_NONE
        beq @p1
        jsr SET_OBJ_SPRITE
@p1
        ; Player 1

        pla
        sta P_SPRITE_NUM        
        jsr SET_PLAYER_SPRITE

        rts

SET_MSG_SPRITE
        lda P_SPRITE_NUM
        tay

        jsr SET_BIT
        sta P_SPRITE_BIT

        ora P_SPENA             ; Enable the sprite
        sta P_SPENA
        
        plda PL_MSG             ; Set sprite image
        tax
        clc                     
        adc #FIRST_SPRITE
        ldy P_SPRITE_NUM
        sta P_SPRPTR0,y
        
        lda SPRITE_COLOURS,x    ; Set sprite colour
        sta P_SP0COL,y

        lda P_SPRITE_NUM        ; Set sprite position
        asl
        tax

        plda PL_X_LO            
        sec
        sbc #20
        sta P_SP0X,x
        plda PL_X_HI
        sbc #$0
        cmp #$0
        beq @x_done
        
        lda P_MSIGX
        ora P_SPRITE_BIT
        sta P_MSIGX
@x_done       
        
        plda PL_Y       
        sec
        sbc #10
        sta P_SP0Y,x
        rts

SET_PLAYER_SPRITE

        lda P_SPRITE_NUM
        
        jsr SET_BIT
        sta P_SPRITE_BIT

        ora P_SPENA             ; Enable the sprite
        sta P_SPENA

        plda PL_DIR               ; Set the sprite image
        cmp #DIR_SHRUG
        beq @no_add_frame
        ;lsr
        clc
        padc PL_FRAME                     
        tax        
        lda PLAYER_FRAME_SEQS,x
@no_add_frame
        clc                   
        adc #FIRST_SPRITE
        ldx P_SPRITE_NUM
        sta P_SPRPTR0,x

        lda P_COLOUR          ; Set sprite colour
        sta P_SP0COL,x

        txa                   ; Set sprite LO X and Y
        asl
        tax
        plda PL_X_LO
        sta P_SP0X,x
        plda PL_Y
        sta P_SP0Y,x        

        plda PL_X_HI          ; Set the HI X bit
        cmp #$0
        beq @done
        lda P_MSIGX
        ora P_SPRITE_BIT
        sta P_MSIGX

@done
        rts

SET_OBJ_SPRITE

        lda P_SPRITE_NUM
  
        jsr SET_BIT
        sta P_SPRITE_BIT

        ora P_SPENA             ; Enable the sprite
        sta P_SPENA
        
        plda PL_OBJ              ; Set sprite image
        tax
        clc                     
        adc #FIRST_SPRITE
        ldy P_SPRITE_NUM
        sta P_SPRPTR0,y
        
        lda SPRITE_COLOURS,x    ; Set sprite colour
        sta P_SP0COL,y

        lda P_SPRITE_NUM        ; Set sprite position
        asl
        tax

        plda PL_DIR               ; For E or W, adjust X position
        cmp #DIR_W                ; of Object
        bne @is_east
        
        plda PL_X_LO
        sec
        sbc #16
        sta P_SP0X,x
        plda PL_X_HI
        sbc #$0
        cmp #$0
        bne @hi_x
        jmp @x_adjust_done
        
@is_east
        cmp #DIR_E
        bne @is_n_or_s

        plda PL_X_LO
        clc
        adc #16
        sta P_SP0X,x
        plda PL_X_HI
        adc #$0
        cmp #$0
        bne @hi_x
        jmp @x_adjust_done

@is_n_or_s
        plda PL_X_LO
        sta P_SP0X,x
        plda PL_X_HI
        cmp #$0
        beq @x_adjust_done

@hi_x
        lda P_MSIGX
        ora P_SPRITE_BIT
        sta P_MSIGX

@x_adjust_done
        
        plda PL_Y
        sta P_SP0Y,x        
@done
        rts

; Checks the value of a joystick port
; Port # stored in X
; Direction returned in A
; Button state returned in X
CHECK_JOYSTICK
        lda #$0
        sta P_STICK
        sta P_BUTTON

        lda D1PRA,x
        and #$1F
        eor #$1F

        tay
        and #JOY_FIRE
        beq @no_button
        ldx #$1
        jmp @check_up
@no_button
        ldx #$0

@check_up

        stx P_BUTTON

        tya
        and #JOY_UP
        cmp #JOY_UP
        bne @check_down
        lda P_STICK
        ora #DIR_N
        sta P_STICK
        jmp @check_left

@check_down
        tya
        and #JOY_DOWN
        cmp #JOY_DOWN
        bne @check_left
        lda P_STICK
        ora #DIR_S
        sta P_STICK

@check_left
        tya
        and #JOY_LEFT
        cmp #JOY_LEFT
        bne @check_right
        lda P_STICK
        ora #DIR_W
        sta P_STICK
        jmp @done

@check_right
        tya
        and #JOY_RIGHT
        cmp #JOY_RIGHT
        bne @done
        lda P_STICK
        ora #DIR_E
        sta P_STICK
        jmp @done

        lda #DIR_NONE
        sta P_STICK
@done
        rts

; Indicates a particular fixed object needs updating
UPDATE_OBJECT
        psta PL_UPDATE_OBJ
        lda #$1
        sta P_UPDATE_OBJECT
        
        rts

; Updates a line of fixed object sprites
UPDATE_OBJECT_SPRITES
        
        plda PL_UPDATE_OBJ
        tax
        
        and #$3                         ; Index into FRAME_LINE
        sta P_SPRITE_NUM

        clc                             ; Bit for MSIGX and SPENA
        adc #$4
        jsr SET_BIT
        sta P_SPRITE_BIT

        txa                             ; Get FRAME_LINE
        and #$1C
        lsr
        tay

        lda LVL_OBJ_FRAME_LINES,y
        sta P_FRAME_LINE_LO
        iny
        lda LVL_OBJ_FRAME_LINES,y
        sta P_FRAME_LINE_HI

        txa
        tay

        lda LVL_OBJ_TYPE,y              ; Do we have an object?
        cmp #OBJ_NONE
        beq @no_obj

        tay
        
        ora #FIRST_SPRITE               ; Get frame
        sta P_FRAME
                                             ; Look up colour        
        lda SPRITE_COLOURS,y
        sta P_COLOUR
        
        lda P_SPRITE_NUM                ; Set sprite frame 
        ora #FL_SPRPTR4
        tay

        lda P_FRAME                     
        sta (P_FRAME_LINE_LO),y
        
        lda P_SPRITE_NUM               ; Where to put it
        ora #FL_SP4COL
        tay
                                        ; Set the colour
        lda P_COLOUR
        sta (P_FRAME_LINE_LO),y 

        ldy #FL_SPENA                   ; Enable the sprite
        lda (P_FRAME_LINE_LO),y
        ora P_SPRITE_BIT
        sta (P_FRAME_LINE_LO),y

        rts
@no_obj

        lda P_SPRITE_BIT                ; Disable sprite
        eor #$ff
        ldy #FL_SPENA
        and (P_FRAME_LINE_LO),y
        sta (P_FRAME_LINE_LO),y

        rts
