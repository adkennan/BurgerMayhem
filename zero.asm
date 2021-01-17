
; Game or Global data

G_LEVEL_NUM     = $10 ; Current level
G_PLAYER_COUNT    = $11
G_GAME_STATE    = $12

; Level data

L_CURR_LEVEL_LO = $20 ; Pointer to current level data
L_CURR_LEVEL_HI = $21

L_TIME_MINUTES  = $22 ; Minutes remaining
L_TIME_SECONDS_LO = $23 ; Seconds remaining
L_TIME_SECONDS_HI = $24
L_TIME_TICKS      = $2E

L_BURGERS_REQ     = $29 ; Number of burgers required
L_BURGER_COUNT_LO = $25 ; Burgers completed
L_BURGER_COUNT_HI = $26

L_MAP_LO          = $27 ; Map pointer
L_MAP_HI          = $28

; Per-frame player data
P_UPDATE_OBJECT   = $2B ; Indicates the object sprites need updating
P_PLAYER_LO       = $2C ; Pointer to current player data
P_PLAYER_HI       = $2D
P_MAP_POS_LO      = $50 ; Position in video memory of char
P_MAP_POS_HI      = $51 

                      ; Player 1
P1_DATA         = $30
P1_DIR          = $30 ;  Direction  
P1_X_LO         = $31 ;  X pixel
P1_X_HI         = $32
P1_Y            = $33 ;  Y pixel
P1_FRAME        = $34 ;  Frame
P1_OBJ          = $35 ;  Object carried
P1_OBJ_VAL      = $36 ;  Value of carried object
P1_MP_LO        = $37 ;  Screen char position of East foot
P1_MP_HI        = $38 ;  
P1_FRAME_COUNT  = $39 ;  Counter until next frame change
P1_BUTTON       = $3A ;  State of button
P1_ACTIVITY     = $3B ;  Current Activity - none, chop or cook
P1_ACT_DIR      = $3C ;  Direction of Activity stick waggle
P1_ACT_INDEX    = $3D ;  Index of the object we're acting on.
P1_MSG          = $3E ;  Message sprite to display
P1_MSG_COUNT    = $3F ;  Time remaining to show message or $FF to keep it
P1_UPDATE_OBJ   = $40 ;  Index of object sprite to update

                      ; Player 2
P2_DATA         = $A0
P2_DIR          = $A0 ;  Direction
P2_X_LO         = $A1 ;  X pixel
P2_X_HI         = $A2
P2_Y            = $A3 ;  Y pixel
P2_FRAME        = $A4 ;  Frame
P2_OBJ          = $A5 ;  Object carried
P2_OBJ_VAL      = $A6 ;  Value of carried object
P2_MP_LO        = $A7 ;  Screen char position of East foot
P2_MP_HI        = $A8 ;  
P2_FRAME_COUNT  = $A9 ;  Counter until next frame change
P2_BUTTON       = $AA ;  State of button
P2_ACTIVITY     = $AB ;  Current Activity - none, chop or cook
P2_ACT_DIR      = $AC ;  Direction of Activity stick waggle
P2_ACT_INDEX    = $AD ;  Index of the object we're acting on.
P2_MSG          = $AE ;  Message sprite to display
P2_MSG_COUNT    = $AF ;  Time remaining to show message or $FF to keep it
P2_UPDATE_OBJ   = $B0 ;  Index of object sprite to update

; Map drawing variables

M_MAP_POS_LO      = $50 ; Position in video memory of char
M_MAP_POS_HI      = $51 
M_COL_POS_LO      = $52 ; Position in colour memory of char
M_COL_POS_HI      = $53
M_ADJ_TILE_BM     = $54 ; Bitmap of all adjacent tiles
M_ADJ_TILE_BIT    = $55 ; Value of current adjacent tile

FRAME_LINE_LO   = $56 ; Line of sprites to draw
FRAME_LINE_HI   = $57

M_LVLMAP_POS_LO   = $58 ; Position in LVL_TILE_MAP
M_LVLMAP_POS_HI   = $59

F_FG_COL                = $50 ; Fade in colours
F_BG_COL                = $51

OBJ_INDEX       = $5A ; Index into LVL_OBJ_TYPE
CHAR_INDEX      = $5B
CHAR_COL        = $5C
CHAR_BG_COL     = $5D

P_TMP_X_LO      = $60 ; Storage for coords when moving
P_TMP_X_HI      = $61
P_TMP_Y         = $62
P_SPRITE_NUM    = $66 ; Number of the sprite for a chef/object
P_SPRITE_BIT    = $67 ; Bit of the sprite for a chef/object
P_DIR           = $68 ; Direction of a chef
P_FRAME         = $69 ; Sprite frame/object number
P_COLOUR        = $6A ; Player sprite colour
P_TMP_OBJ_TYPE  = $66
P_TMP_OBJ_VAL   = $67
P_MX            = $63
P_MY            = $64
P_INGR_BIT      = $68

P_OBJ_TYPE_LO   = $6B
P_OBJ_TYPE_HI   = $6C
P_OBJ_VAL_LO    = $6D
P_OBJ_VAL_HI    = $6E
P_FRAME_LINE_LO = $6D
P_FRAME_LINE_HI = $6E
P_LINE_NUM      = $64
P_OBJ_SPENA     = $65

LINE_NUM        = $70
LINE_PTR_LO     = $71
LINE_PTR_HI     = $72
LINE_VAL        = $73

P_MSIGX         = $80 ; MSIGX value for moving sprites
P_SPENA         = $81 ; SPENA value for moving sprites
P_SPRPTR0       = $82 
P_SPRPTR1       = $83
P_SPRPTR2       = $84 
P_SPRPTR3       = $85
P_SP0COL        = $86
P_SP1COL        = $87
P_SP2COL        = $88
P_SP3COL        = $89
P_SP0X          = $8A
P_SP0Y          = $8B
P_SP1X          = $8C
P_SP1Y          = $8D
P_SP2X          = $8E
P_SP2Y          = $8F
P_SP3X          = $90
P_SP3Y          = $91

M_FLOOR_COL     = $90
M_SHADOW_COL    = $91
M_WALL_BG       = $92
M_WALL_FG_COL   = $93
M_WALL_CHAR     = $94

P_STICK         = $BA
P_BUTTON        = $BB
P_TMP_DIR       = $BC

T_SLIDER_N      = $C0
T_SLIDER_S      = $C1
T_BLOCKER_N     = $C0
T_BLOCKER_SRC_LO = $C1
T_BLOCKER_SRC_HI = $C2
T_BLOCKER_DST_LO = $C3
T_BLOCKER_DST_HI = $C4
T_SLIDER_DIR    = $C3

L_SLIDER_TIME = $C5

P_LOOK_TILES    = $D0
P_N_1           = P_LOOK_TILES
P_N_2           = P_LOOK_TILES + 1
P_N_3           = P_LOOK_TILES + 2
P_W_1           = P_LOOK_TILES + 3
P_E_1           = P_LOOK_TILES + 4
P_W_2           = P_LOOK_TILES + 5
P_L             = P_LOOK_TILES + 6
P_M             = P_LOOK_TILES + 7
P_R             = P_LOOK_TILES + 8
P_E_2           = P_LOOK_TILES + 9
P_S_1           = P_LOOK_TILES + 10
P_S_2           = P_LOOK_TILES + 11
P_S_3           = P_LOOK_TILES + 12

TITLE_L1_Y      = $60
TITLE_L2_Y      = $61

FG_FADE_COUNT   = $62
FG_FADE_INDEX   = $63

TEXT_POS_LO     = $E0
TEXT_POS_HI     = $E1
TEXT_SRC_LO     = $E2
TEXT_SRC_HI     = $E3
TEXT_LEN        = $E4
TEXT_DST_LO     = $E5
TEXT_DST_HI     = $E6
TEXT_COL_1      = $E7
TEXT_COL_2      = $E8
TEXT_COL_LO     = $E9
TEXT_COL_HI     = $EA
TEXT_NUM        = $E2
