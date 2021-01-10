
*=$5000

NUM_FLAG        ; Translates numbers to bits
        byte 1, 2, 4, 8, 16, 32, 64, 128

MAP_ADJACENT  ; Offsets of adjacent map positions
              ;  N    NW   W  SW  S   SE  E   NE 
        byte 0, -14, -15, -1, 13, 14, 15, 1, -13

        ; Adjacent map character lookups
CM_NW
        byte 32, 30, 25, 17, 19, 21, 19, 21
CM_N
        byte 32, 17
CM_NE
        byte 32, 18, 26, 18, 31, 22, 17, 22
CM_E
        byte 32, 18
CM_SE
        byte 32, 20, 27, 20, 18, 24, 18, 24
CM_S
        byte 32, 20
CM_SW
        byte 32, 19, 28, 19, 20, 23, 20, 23
CM_W 
        byte 32, 19


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
        byte COL_BROWN  ; Pan - Empty
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

LVL_TILE_MAP
        dcb 1000,TILE_FLOOR
          
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

; Title Line data.
; Sprite position, colours and frames for the timer and score      
STATUS_LINE
        BYTE 20                         ; 0 - Y position to wait for
        BYTE 26                         ; 1 - Y position to draw at
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
        BYTE 49                         ; 0 - Y position to wait for
        BYTE 52                         ; 1 - Y position to draw at
        BYTE 0, 0, 0, 0                 ; 2 - 5 - X position of fixed objects
        BYTE 0                          ; 6 - MSIGX
        BYTE $0                         ; 7 - SPENA
        BYTE 0, 0, 0, 0                 ; 8 - 11 - SP4COL - SP7COL 
        BYTE 0, 0, 0, 0                 ; 12 - 15 - SPRPTR4 - SPRPTR7

FRAME_LINE_1
        BYTE 73, 76, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

FRAME_LINE_2
        BYTE 97, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

FRAME_LINE_3
        BYTE 121, 124, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

FRAME_LINE_4
        BYTE 145, 148, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

FRAME_LINE_5
        BYTE 169, 172, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

FRAME_LINE_6
        BYTE 193, 196, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0

FRAME_LINE_7
        BYTE 217, 220, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
