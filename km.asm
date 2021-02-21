
incasm "macros.asm"
incasm "sys_constants.asm"
incasm "game_constants.asm"
incasm "zero.asm"

*=$0801
        BYTE $0E, $08, $0A, $00, $9E, $20, $28, $32
        BYTE $33, $30, $34, $29, $00, $00, $00

*=$0900

        jsr INIT_SYSTEM
LOOP

@is_title
        lda G_GAME_STATE
        cmp #GS_TITLE
        bne @is_start_game
        jsr TITLE

@is_start_game
        lda G_GAME_STATE
        cmp #GS_START_GAME
        bne @is_pre_level
        jsr START_GAME

@is_pre_level
        lda G_GAME_STATE
        cmp #GS_PRE_LEVEL
        bne @is_running
        jsr PRE_LEVEL

@is_running
        lda G_GAME_STATE
        cmp #GS_RUNNING
        bne @is_post_level
        jsr RUN_LEVEL
        
@is_post_level
        lda G_GAME_STATE
        cmp #GS_POST_LEVEL
        bne @is_game_over
        jsr POST_LEVEL
          
@is_game_over
        lda G_GAME_STATE
        cmp #GS_GAME_OVER
        bne @done
        jsr GAME_OVER

@done
        jmp LOOP      
          
incasm "game.asm"
incasm "init.asm"
incasm "player.asm"
incasm "screen.asm"
incasm "util.asm"

*=$3000
incasm "levels.asm"
incasm "themes.asm"
incasm "maps.asm"
incasm "strings.asm"
incasm "lookup.asm"

*=$4800
incasm "sprites.asm"
*=$6800
incasm "chars.asm"
