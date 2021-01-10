*=$4400

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
; 10 - Floor Colour
; 11 - Shadow Colour
; 12 - Wall FG Colour
; 13 - Wall BG Colour
; 14 - Wall Char
;

LEVEL_01
        BYTE <MAP_02, >MAP_02, 2, 2, 0, 10, 1, 1, 10, 1, COL_GREEN, COL_BROWN, BG_COL_3, COL_ORANGE, 10