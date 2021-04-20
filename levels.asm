;
; 0 - Map Pointer Lo
; 1 - Map Pointer Hi
; 2 - Time Limit Minutes
; 3 - Time Limit Seconds Hi
; 4 - Time Limit Seconds Lo
; 5 - Target
; 6 - Player 1 Start X
; 7 - Player 1 Start Y
; 8 - Player 2 Start X
; 9 - Player 2 Start Y
; 10 - Theme Pointer Lo
; 11 - Theme Pointer Hi
; 12 - Description Pointer Lo
; 13 - Description Pointer Hi
;

LVL_KITCHEN_01
        BYTE <MAP_KITCHEN_01, >MAP_KITCHEN_01           ; Map pointer
        BYTE 5, 0, 0                    ; Time limit
        BYTE 5                         ; Target
        BYTE 5, 3                       ; Player 1 start pos
        BYTE 7, 3                       ; Player 2 start pos
        BYTE <THEME_KITCHEN, >THEME_KITCHEN ; Theme 
        BYTE <STR_NOT_TOO_HARD, >STR_NOT_TOO_HARD ; Description

LVL_KITCHEN_02
        BYTE <MAP_KITCHEN_02, >MAP_KITCHEN_02           ; Map pointer
        BYTE 5, 0, 0                    ; Time limit
        BYTE 5                         ; Target
        BYTE 10, 3                       ; Player 1 start pos
        BYTE 2, 3                       ; Player 2 start pos
        BYTE <THEME_KITCHEN, >THEME_KITCHEN ; Theme 
        BYTE <STR_TIGHT_CORNERS, >STR_TIGHT_CORNERS ; Description

LVL_FOREST_01
        BYTE <MAP_FOREST_01, >MAP_FOREST_01           ; Map pointer
        BYTE 5, 0, 0                    ; Time limit
        BYTE 5                         ; Target
        BYTE 5, 4                       ; Player 1 start pos
        BYTE 7, 4                       ; Player 2 start pos
        BYTE <THEME_FOREST, >THEME_FOREST ; Theme 
        BYTE <STR_LOST_IN_THE_WOODS, >STR_LOST_IN_THE_WOODS ; Description

LVL_FOREST_02
        BYTE <MAP_FOREST_02, >MAP_FOREST_02           ; Map pointer
        BYTE 5, 0, 0                    ; Time limit
        BYTE 5                         ; Target
        BYTE 6, 3                       ; Player 1 start pos
        BYTE 7, 3                       ; Player 2 start pos
        BYTE <THEME_FOREST, >THEME_FOREST ; Theme 
        BYTE <STR_TWO_CLEARINGS, >STR_TWO_CLEARINGS ; Description

LVL_FOREST_03
        BYTE <MAP_FOREST_03, >MAP_FOREST_03           ; Map pointer
        BYTE 5, 0, 0                    ; Time limit
        BYTE 5                         ; Target
        BYTE 2, 3                       ; Player 1 start pos
        BYTE 10, 3                       ; Player 2 start pos
        BYTE <THEME_FOREST, >THEME_FOREST ; Theme 
        BYTE <STR_WAIT_YOUR_TURN, >STR_WAIT_YOUR_TURN ; Description

LVL_FOREST_04
        BYTE <MAP_FOREST_04, >MAP_FOREST_04           ; Map pointer
        BYTE 5, 0, 0                    ; Time limit
        BYTE 5                         ; Target
        BYTE 5, 3                       ; Player 1 start pos
        BYTE 7, 4                       ; Player 2 start pos
        BYTE <THEME_FOREST, >THEME_FOREST ; Theme 
        BYTE <STR_WHO_PUT_THAT_THERE, >STR_WHO_PUT_THAT_THERE ; Description

LVL_FOREST_05
        BYTE <MAP_FOREST_05, >MAP_FOREST_05           ; Map pointer
        BYTE 5, 0, 0                    ; Time limit
        BYTE 5                         ; Target
        BYTE 9, 6                       ; Player 1 start pos
        BYTE 4, 6                       ; Player 2 start pos
        BYTE <THEME_FOREST, >THEME_FOREST ; Theme 
        BYTE <STR_TWISTY_TURNY, >STR_TWISTY_TURNY ; Description

LVL_CASTLE_01
        BYTE <MAP_CASTLE_01, >MAP_CASTLE_01           ; Map pointer
        BYTE 5, 0, 0                    ; Time limit
        BYTE 5                         ; Target
        BYTE 6, 1                       ; Player 1 start pos
        BYTE 9, 6                       ; Player 2 start pos
        BYTE <THEME_CASTLE, >THEME_CASTLE ; Theme 
        BYTE <STR_HARDER_THAN_IT_LOOKS, >STR_HARDER_THAN_IT_LOOKS ; Description

LVL_SPACE_01
        BYTE <MAP_SPACE_01, >MAP_SPACE_01           ; Map pointer
        BYTE 5, 0, 0                    ; Time limit
        BYTE 5                         ; Target
        BYTE 2, 3                       ; Player 1 start pos
        BYTE 2, 4                       ; Player 2 start pos
        BYTE <THEME_SPACE, >THEME_SPACE ; Theme 
        BYTE <STR_IN_SPAAAACE, >STR_IN_SPAAAACE ; Description

LVL_SPACE_02
        BYTE <MAP_SPACE_02, >MAP_SPACE_02           ; Map pointer
        BYTE 5, 0, 0                    ; Time limit
        BYTE 5                         ; Target
        BYTE 9, 6                       ; Player 1 start pos
        BYTE 3, 2                      ; Player 2 start pos
        BYTE <THEME_SPACE, >THEME_SPACE ; Theme 
        BYTE <STR_BURGER_LANDER, >STR_BURGER_LANDER ; Description

LVL_SPACE_03
        BYTE <MAP_SPACE_03, >MAP_SPACE_03           ; Map pointer
        BYTE 5, 0, 0                    ; Time limit
        BYTE 5                         ; Target
        BYTE 1, 2                       ; Player 1 start pos
        BYTE 10, 1                      ; Player 2 start pos
        BYTE <THEME_SPACE, >THEME_SPACE ; Theme 
        BYTE <STR_AIRLOCKS, >STR_AIRLOCKS ; Description
