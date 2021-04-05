
NUM_FLAG        ; Translates numbers to bits
        byte 1, 2, 4, 8, 16, 32, 64, 128

MAP_ADJACENT  ; Offsets of adjacent map positions
              ;  N    NW   W  SW  S   SE  E   NE 
        byte 0, -14, -15, -1, 13, 14, 15, 1, -13

        ; Adjacent map character lookups
CM_NW
        byte CH_BLANK,CH_SHAD_N_NW,CH_SHAD_NW,CH_SHAD_N,CH_SHAD_W,CH_SHAD_N_NW_W,CH_SHAD_W,CH_SHAD_N_NW_W

CM_N
        byte CH_BLANK,CH_SHAD_N

CM_NE
        byte CH_BLANK,CH_SHAD_E,CH_SHAD_NE,CH_SHAD_E,CH_SHAD_N_NE,CH_SHAD_N_NE_E,CH_SHAD_N,CH_SHAD_N_NE_E

CM_E
        byte CH_BLANK,CH_SHAD_E

CM_SE
        byte CH_BLANK,CH_SHAD_S,CH_SHAD_SE,CH_SHAD_S,CH_SHAD_E,CH_SHAD_S_SE_E,CH_SHAD_E,CH_SHAD_S_SE_E

CM_S
        byte CH_BLANK,CH_SHAD_S

CM_SW
        byte CH_BLANK,CH_SHAD_W,CH_SHAD_SW,CH_SHAD_W,CH_SHAD_S,CH_SHAD_S_SW_W,CH_SHAD_S,CH_SHAD_S_SW_W

CM_W 
        byte CH_BLANK,CH_SHAD_W


PLAYER_LOOK_OFFSET
        byte 0, 1, 1                            ;    N1 N2 N3
        byte SCREEN_WIDTH - 3, 4                ; W1          E1
        byte SCREEN_WIDTH - 4, 1, 1, 1, 1       ; W1  L  M  R E2
        byte SCREEN_WIDTH - 3, 1, 1             ;    S1 S2 S3


PLAYER_FRAME_SEQS
        byte 0, 0, 0, 0
FRAME_SEQ_S
        byte 0, 1, 0, 2
FRAME_SEQ_N
        byte 14, 15, 14, 16
        byte 0, 0, 0, 0
FRAME_SEQ_E
        byte 17, 18, 17, 19        
        byte 0, 0, 0, 0
        byte 0, 0, 0, 0
        byte 0, 0, 0, 0
FRAME_SEQ_W
        byte 20, 21, 20, 22

CHOP_FRAME_SEQ
        byte 23, 23, 23, 23, 24, 24, 24, 24, 25, 25, 25, 25, 26, 26, 26, 26, 27, 27, 27, 27, 27

COOK_FRAME_SEQ
        byte 28, 28, 28, 28, 29, 29, 29, 29, 30, 30, 30, 30, 31, 31, 31, 31, 32, 32, 32, 32, 32

SPRITE_COLOURS
        byte 0, 0, 0
        byte COL_ORANGE ; Bun
        byte COL_BROWN  ; Plate - Empty
        byte COL_ORANGE ; Plate - Burger
        byte COL_RED    ; Tomato
        byte COL_RED    ; Tomato - Chopped
        byte COL_GREEN  ; Lettuce
        byte COL_GREEN  ; Lettuce - Chopped
        byte COL_LRED   ; Meat - Raw
        byte COL_BROWN  ; Meat - Cooked
        byte COL_DGREY  ; Pan - Empty
        byte COL_LRED   ; Pan - Cooking
        byte 0, 0, 0
        byte 0, 0, 0
        byte 0, 0, 0
        byte COL_GREEN  ; Chop 1
        byte COL_GREEN  ; Chop 2
        byte COL_GREEN  ; Chop 3
        byte COL_GREEN  ; Chop 4
        byte COL_GREEN  ; Chop 5
        byte COL_GREEN  ; Cook 1
        byte COL_GREEN  ; Cook 2
        byte COL_GREEN  ; Cook 3
        byte COL_GREEN  ; Cook 4
        byte COL_GREEN  ; Cook 5
        byte COL_GREEN  ; OK
        byte COL_RED    ; Error
        byte COL_ORANGE ; Err - Bun
        byte COL_RED    ; Err - Tomato
        byte COL_GREEN  ; Err - Lettuce
        byte COL_BROWN  ; Err - Meat Cooked
        byte COL_BROWN  ; Pan - Cooked
        byte COL_LRED   ; Err - Meat Raw
        byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
        byte COL_GREEN  ; GO
        byte COL_RED, COL_RED, COL_RED ; 1/4, 2/4, 3/4
        byte COL_ORANGE, COL_ORANGE, COL_ORANGE, COL_ORANGE ; Big burger colours
        byte COL_GREEN, COL_GREEN, COL_LRED, COL_LRED, COL_BROWN, COL_BROWN

; The Type of object currently at that position
LVL_OBJ_TYPE
        dcb 32, OBJ_NONE
        
; The Value of the object at that position - "how cooked" or "how chopped"
LVL_OBJ_VAL
        dcb 32, 0

LVL_OBJ_FRAME_LINES
        byte <FRAME_LINE_0, >FRAME_LINE_0
        byte <FRAME_LINE_1, >FRAME_LINE_1
        byte <FRAME_LINE_2, >FRAME_LINE_2
        byte <FRAME_LINE_3, >FRAME_LINE_3
        byte <FRAME_LINE_4, >FRAME_LINE_4
        byte <FRAME_LINE_5, >FRAME_LINE_5
        byte <FRAME_LINE_6, >FRAME_LINE_6
        byte <FRAME_LINE_7, >FRAME_LINE_7
          
; State of blocker tiles
LVL_BLOCK_STATE
        byte 0, 1, 2, 3

LVL_BLOCK_TIME
        byte 199, 1, 19, 151

BLOCKER_SEQ
        byte 0, 1, 2, 3, 2, 1

BLOCKER_TIMES
        byte 100, 5, 5, 100

BLOCKER_SRC_LO
        byte <BLOCKER_CHAR_SRC_0, <BLOCKER_CHAR_SRC_1, <BLOCKER_CHAR_SRC_2, <BLOCKER_CHAR_SRC_3
BLOCKER_SRC_HI
        byte >BLOCKER_CHAR_SRC_0, >BLOCKER_CHAR_SRC_1, >BLOCKER_CHAR_SRC_2, >BLOCKER_CHAR_SRC_3

BLOCKER_DST_LO
        byte <CHAR_BLOCKER_0, <CHAR_BLOCKER_1, <CHAR_BLOCKER_2, <CHAR_BLOCKER_3
BLOCKER_DST_HI
        byte >CHAR_BLOCKER_0, >CHAR_BLOCKER_1, >CHAR_BLOCKER_2, >CHAR_BLOCKER_3

; Title Burger
; Sprite positions for the big burger sprites on the title screen
TITLE_BURGER
        BYTE 0, 0, 0, 0, 0, 0, 0, 0

; Status Line data.
; Sprite position, colours and frames for the timer and score      
STATUS_LINE
        BYTE 28                         ; 0 - Y position to wait for
        BYTE 34                         ; 1 - Y position to draw at
        BYTE 24, 46, 57, 69, 86, 21, 43, 61 ; 2 - 9 - X position sprites
        BYTE $E0                          ; 10 - MSIGX
        BYTE COL_WHITE, COL_WHITE, COL_WHITE, COL_WHITE, COL_WHITE, COL_ORANGE, COL_WHITE, COL_WHITE ; 11 - 18 - SP0COL - SP7COL 
        BYTE SB_CLOCK, SB_1, SB_COLON, SB_2, SB_3, SB_BURGER, SB_0, SB_0      ; 19 - 26 - SPRPTR0 - SPRPTR7

; Frame Data

; Sprite position, colours and frames are calculated for each row of the map and stored
; in this table.
; As the display is drawn the VIC registers and sprite pointers are updated from these
; values.

FRAME_LINE_0
        BYTE 57                         ; 0 - Y position to wait for
        BYTE 60                         ; 1 - Y position to draw at
        BYTE 0, 0, 0, 0                 ; 2 - 5 - X position of fixed objects
        BYTE 0                          ; 6 - MSIGX
        BYTE 0                          ; 7 - SPENA
        BYTE 0, 0, 0, 0                 ; 8 - 11 - SP4COL - SP7COL 
        BYTE 0, 0, 0, 0                 ; 12 - 15 - SPRPTR4 - SPRPTR7

FRAME_LINE_1
        BYTE 81, 84, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

FRAME_LINE_2
        BYTE 105, 108, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

FRAME_LINE_3
        BYTE 129, 132, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

FRAME_LINE_4
        BYTE 153, 156, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

FRAME_LINE_5
        BYTE 177, 180, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

FRAME_LINE_6
        BYTE 201, 204, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

FRAME_LINE_7
        BYTE 225, 228, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

BB_LINE_1
        BYTE 0 ; Countdown until shown
        BYTE 0 ; Y Pos
        BYTE BB_TOP_STOP ; Stop Y Pos
        BYTE 1 ; Sprite Y reg offset
BB_LINE_2
        BYTE 0, 0, BB_LET_STOP, 5
BB_LINE_3
        BYTE 0, 0, BB_TOM_STOP, 9
BB_LINE_4
        BYTE 0, 0, BB_MEAT_STOP, 13
BB_LINE_5
        BYTE 0, 0, BB_BOT_STOP, 1

TITLE_LINE_X
        BYTE 89,137,185,233,91,139,187,235
TITLE_COLS_1
        BYTE COL_YELLOW, COL_YELLOW, COL_YELLOW, COL_YELLOW, COL_RED, COL_RED, COL_RED, COL_RED
TITLE_COLS_2
        BYTE COL_GREEN, COL_GREEN, COL_GREEN, COL_GREEN, COL_PURPLE, COL_PURPLE, COL_PURPLE, COL_PURPLE

FG_FADE_COLS
        BYTE COL_BLACK, COL_DGREY, COL_MGREY, COL_LGREY, $FF

THEME_FLOOR_TILE_OFFSETS
        BYTE THEME_F0_CHARS, THEME_F1_CHARS, THEME_F2_CHARS, THEME_F3_CHARS
THEME_FLOOR_FG_OFFSETS
        BYTE THEME_F0_FG, THEME_F1_FG, THEME_F2_FG, THEME_F3_FG
THEME_FLOOR_BG_OFFSETS
        BYTE THEME_F0_BG, THEME_F1_BG, THEME_F2_BG, THEME_F3_BG

LEVEL_SEQUENCE
        BYTE 0, 0
ZONE_KITCHEN
        BYTE <LVL_KITCHEN_01, >LVL_KITCHEN_01
        BYTE <LVL_KITCHEN_02, >LVL_KITCHEN_02

ZONE_FOREST
        BYTE <LVL_FOREST_01, >LVL_FOREST_01
        BYTE <LVL_FOREST_02, >LVL_FOREST_02
        BYTE <LVL_FOREST_03, >LVL_FOREST_03
        BYTE <LVL_FOREST_04, >LVL_FOREST_04
        BYTE <LVL_FOREST_05, >LVL_FOREST_05

ZONE_CASTLE
        BYTE <LVL_CASTLE_01, >LVL_CASTLE_01

ZONE_SPACE
        BYTE <LVL_SPACE_01, >LVL_SPACE_01
        BYTE <LVL_SPACE_02, >LVL_SPACE_02
        BYTE <LVL_SPACE_03, >LVL_SPACE_03



