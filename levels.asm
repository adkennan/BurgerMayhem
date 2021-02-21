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

LEVEL_01
        BYTE <MAP_03, >MAP_03           ; Map pointer
        BYTE 3, 0, 0                    ; Time limit
        BYTE 10                         ; Target
        BYTE 1, 1                       ; Player 1 start pos
        BYTE 10, 1                      ; Player 2 start pos
        BYTE <THEME_SPACE, >THEME_SPACE ; Theme 
        BYTE <STR_WORK_TOGETHER, >STR_WORK_TOGETHER ; Description


    