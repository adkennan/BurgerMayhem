
; Game States
GS_TITLE        = $00
GS_START_GAME   = $01
GS_PRE_LEVEL    = $02
GS_RUNNING      = $03
GS_POST_LEVEL   = $04        
GS_GAME_OVER    = $05

FIRST_SPRITE    = $20

; Objects
OBJ_NONE        = $00
OBJ_BUN         = $03
OBJ_PLATE       = $04
OBJ_PLATE_FULL  = $05
OBJ_TOMATO      = $06
OBJ_TOM_CHOP    = $07
OBJ_LETTUCE     = $08
OBJ_LET_CHOP    = $09
OBJ_MEAT_RAW    = $0A
OBJ_MEAT_COOK   = $0B
OBJ_PAN         = $0C
OBJ_PAN_COOKING = $0D
OBJ_PAN_COOKED  = $27

; Status bar sprites
SB_0            = 42 + FIRST_SPRITE
SB_1            = 43 + FIRST_SPRITE
SB_2            = 44 + FIRST_SPRITE
SB_3            = 45 + FIRST_SPRITE
SB_4            = 46 + FIRST_SPRITE
SB_5            = 47 + FIRST_SPRITE
SB_6            = 48 + FIRST_SPRITE
SB_7            = 49 + FIRST_SPRITE
SB_8            = 50 + FIRST_SPRITE
SB_9            = 51 + FIRST_SPRITE
SB_BURGER       = 52 + FIRST_SPRITE
SB_CLOCK        = 53 + FIRST_SPRITE
SB_COLON        = 54 + FIRST_SPRITE

; Burger assembly state
BURG_NONE       = $00
BURG_BUN        = $01
BURG_TOMATO     = $02
BURG_LETTUCE    = $04
BURG_MEAT       = $08
BURG_ALL        = BURG_BUN + BURG_TOMATO + BURG_LETTUCE + BURG_MEAT

; Tile
TILE_FLOOR      = $00  ; 0000 0000
TILE_SLIDER_N   = $01  ; 0000 0001
TILE_SLIDER_S   = $02  ; 0000 0010
TILE_SLIDER_E   = $03  ; 0000 0011
TILE_SLIDER_W   = $04  ; 0000 0100
TILE_WALL       = $08  ; 0000 1000
TILE_PLATE      = $09  ; 0000 1001 
TILE_BUN        = $0A  ; 0000 1010 
TILE_MEAT       = $0B  ; 0000 1011
TILE_TOMATO     = $0C  ; 0000 1100
TILE_LETTUCE    = $0D  ; 0000 1101
TILE_SERVE      = $0E  ; 0000 1110
TILE_BIN        = $0F  ; 0000 1111
TILE_BLOCKER_0  = $20  ; 0001 0000
TILE_BLOCKER_1  = $21  ; 0001 0001
TILE_BLOCKER_2  = $22  ; 0001 0010
TILE_BLOCKER_3  = $23  ; 0001 0011
TILE_BENCH      = $40  ; 0100 0000 
TILE_STOVE      = $80  ; 1000 0000 
TILE_CHOP       = $C0  ; 1100 0000 
TILE_EOL        = $FF

TILE_WALL_MASK  = $F8
TILE_SLIDE_MASK = $07

; Activities
ACT_MOVE        = $00
ACT_CHOP        = $01
ACT_COOK        = $02

; Messages
MSG_NONE        = $00
MSG_OK          = $21
MSG_ERR         = $22
MSG_BUN         = $23
MSG_TOMATO      = $24
MSG_LETTUCE     = $25
MSG_MEAT_COOKED = $26
MSG_MEAT_RAW    = $28
MSG_GO          = $37
MSG_1_OF_4      = $38
MSG_2_OF_4      = $39
MSG_3_OF_4      = $3A

; Title screen constants
LOGO_BURGER_SPR = FIRST_SPRITE + $3B 
LOGO_MAYHEM_SPR = FIRST_SPRITE + $3F
LINE_1_START    = 0
LINE_1_STOP     = 52
LINE_2_START    = 252
LINE_2_STOP     = LINE_1_STOP + 46

FG_FADE_LENGTH  = 5
FG_FADE_FREQ    = 5

; Directions
DIR_NONE        = $00
DIR_S           = $04
DIR_N           = $08
DIR_E           = $10
DIR_W           = $20
DIR_SHRUG       = $29

; Level Offsets
LVL_MP_LO       = $00 ; Map Pointer Lo
LVL_MP_HI       = $01 ; Map Pointer Hi
LVL_TL_M        = $02 ; Time Limit Seconds
LVL_TL_S_HI     = $03 ; Time Limit Minutes
LVL_TL_S_LO     = $04
LVL_TARGET      = $05 ; Target
LVL_P1_X        = $06 ; Player 1 Start X
LVL_P1_Y        = $07 ; Player 1 Start Y
LVL_P2_X        = $08 ; Player 2 Start X
LVL_P2_Y        = $09 ; Player 2 Start Y
LVL_FLOOR_COL   = $0A ; Floor colour
LVL_SHADOW_COL  = $0B ; Shadow colour
LVL_WALL_BG     = $0C ; BG Colour index of wall
LVL_WALL_FG_COL = $0D ; FG Wall colour
LVL_WALL_CHAR   = $0E ; Wall character
LVL_DESC_LO     = $0F ; Description pointer
LVL_DESC_HI     = $10 
LVL_DATA_SIZE   = $11

FRAME_LINE_SIZE = $10 ; Number of bytes for per-line sprite data

FL_OBJY         = $0001 ; Y position of objects
FL_SP4X         = $0002 ; Sprite X and Y positions
FL_SP5X         = $0003
FL_SP6X         = $0004
FL_SP7X         = $0005
FL_MSIGX        = $0006 ; Bit 9 of sprite X positions
FL_SPENA        = $0007 ; Sprite Enable
FL_SP4COL       = $0008 ; Sprite colours
FL_SP5COL       = $0009
FL_SP6COL       = $000A
FL_SP7COL       = $000B
FL_SPRPTR4      = $000C ; Sprite 4 pointer
FL_SPRPTR5      = $000D ; Sprite 5 pointer
FL_SPRPTR6      = $000E ; Sprite 6 pointer
FL_SPRPTR7      = $000F ; Sprite 7 pointer
FL_END          = $0010 

SL_WAIT_Y       = $0000
SL_OBJY         = $0001 ; Y position of objects
SL_SP0X         = $0002 ; Sprite X and Y positions
SL_SP1X         = $0003
SL_SP2X         = $0004
SL_SP3X         = $0005
SL_SP4X         = $0006 
SL_SP5X         = $0007
SL_SP6X         = $0008
SL_SP7X         = $0009
SL_MSIGX        = $000A ; Bit 9 of sprite X positions
SL_SP0COL       = $000B ; Sprite colours
SL_SP1COL       = $000C
SL_SP2COL       = $000D
SL_SP3COL       = $000E 
SL_SP4COL       = $000F
SL_SP5COL       = $0010
SL_SP6COL       = $0011
SL_SP7COL       = $0012
SL_SPRPTR0      = $0013 ; Sprite frame pointers
SL_SPRPTR1      = $0014 
SL_SPRPTR2      = $0015 
SL_SPRPTR3      = $0016 
SL_SPRPTR4      = $0017 
SL_SPRPTR5      = $0018 
SL_SPRPTR6      = $0019 
SL_SPRPTR7      = $001A 

; Offsets into Player Data in zer o page
PL_DIR          = $00 ;  Direction  
PL_X_LO         = $01 ;  X pixel
PL_X_HI         = $02
PL_Y            = $03 ;  Y pixel
PL_FRAME        = $04 ;  Frame
PL_OBJ          = $05 ;  Object carried
PL_OBJ_VAL      = $06 ;  Value of carried object
PL_MP_LO        = $07 ;  Screen char position of East foot
PL_MP_HI        = $08 ;  
PL_FRAME_COUNT  = $09 ;  Counter until next frame change
PL_BUTTON       = $0A ;  State of button
PL_ACTIVITY     = $0B ;  Current Activity - none, chop or cook
PL_ACT_DIR      = $0C ;  Direction of Activity stick waggle
PL_ACT_INDEX    = $0D ;  Index of the object we're acting on.
PL_MSG          = $0E ;  Message sprite to display
PL_MSG_COUNT    = $0F ;  Time remaining to show message or $FF to keep it
PL_UPDATE_OBJ   = $10 ;  Index of object to update

P_DATA_SIZE     = $11  ; Size of player data

PLAYER_FRAME_MASK = $3

MAP_WIDTH       = 14

ANIM_FREQ       = $07 ; Frequency at which to change chef animation frames

PLAYER_LINE     = 54  ; Line at which to initialize player sprites

CHAR_ARROW_N    = CHAR_BASE + $68
CHAR_ARROW_S    = CHAR_ARROW_N + $8
CHAR_ARROW_E    = CHAR_ARROW_S + $8
CHAR_ARROW_W    = CHAR_ARROW_E + $8

CHAR_BLOCKER_0  = CHAR_BASE + $30
CHAR_BLOCKER_1  = CHAR_BLOCKER_0 + $8
CHAR_BLOCKER_2  = CHAR_BLOCKER_1 + $8
CHAR_BLOCKER_3  = CHAR_BLOCKER_2 + $8

BLOCKER_SEQ_SIZE = 6

LOOK_OFFSET_SIZE = 13