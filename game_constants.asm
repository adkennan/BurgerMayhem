
; Game States
GS_TITLE        = $00
GS_START_GAME   = $01
GS_PRE_LEVEL    = $02
GS_RUNNING      = $03
GS_POST_LEVEL   = $04        
GS_GAME_OVER    = $05

FIRST_SPRITE    = $20

LEVEL_COUNT     = 11

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

; Title screen burger parts
TSB_TOP_BUN_1   = 59 + FIRST_SPRITE
TSB_BOTTOM_BUN_1   = 60  + FIRST_SPRITE
TSB_LETTUCE_1   = 61 + FIRST_SPRITE
TSB_TOMATO_1   = 62 + FIRST_SPRITE
TSB_MEAT_1   = 63 + FIRST_SPRITE

; Burger assembly state
BURG_NONE       = $00
BURG_BUN        = $01
BURG_TOMATO     = $02
BURG_LETTUCE    = $04
BURG_MEAT       = $08
BURG_ALL        = BURG_BUN + BURG_TOMATO + BURG_LETTUCE + BURG_MEAT

; Tile
TILE_FLOOR_0    = $00  ; 0000 0000
TILE_FLOOR_1    = $01  ; 0000 0001
TILE_FLOOR_2    = $02  ; 0000 0010
TILE_FLOOR_3    = $03  ; 0000 0011

TILE_SLIDER_N   = $04  ; 0000 0100
TILE_SLIDER_S   = $05  ; 0000 0101
TILE_SLIDER_E   = $06  ; 0000 0110
TILE_SLIDER_W   = $07  ; 0000 0111

TILE_VOID       = $08  ; 0000 1000
TILE_PLATE      = $09  ; 0000 1001 
TILE_BUN        = $0A  ; 0000 1010 
TILE_MEAT       = $0B  ; 0000 1011
TILE_TOMATO     = $0C  ; 0000 1100
TILE_LETTUCE    = $0D  ; 0000 1101
TILE_SERVE      = $0E  ; 0000 1110
TILE_BIN        = $0F  ; 0000 1111

TILE_BLOCKER_0  = $10  ; 0001 0000
TILE_BLOCKER_1  = $11  ; 0001 0001
TILE_BLOCKER_2  = $12  ; 0001 0010
TILE_BLOCKER_3  = $13  ; 0001 0011

TILE_WALL_0     = $20  ; 0010 0000
TILE_WALL_1     = $21  ; 0010 0001
TILE_WALL_2     = $22  ; 0010 0010
TILE_WALL_3     = $23  ; 0010 0011

TILE_BENCH      = $40  ; 0100 0000 
TILE_STOVE      = $80  ; 1000 0000 
TILE_CHOP       = $C0  ; 1100 0000 
TILE_EOL        = $FF

TILE_SLIDE_MASK = $07
TILE_BLOCKER_MASK = $F0

FIRST_WALL_TILE = TILE_VOID

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
LOGO_BURGER_SPR = FIRST_SPRITE + $40
LOGO_MAYHEM_SPR = FIRST_SPRITE + $44
LINE_1_START    = 0
LINE_1_STOP     = 52
LINE_2_START    = 252
LINE_2_STOP     = LINE_1_STOP + 48

BB_LEFT_X       = 156

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
LVL_THEME_LO    = $0A ; Theme pointer
LVL_THEME_HI    = $0B
LVL_DESC_LO     = $0C ; Description pointer
LVL_DESC_HI     = $0D 
LVL_DATA_SIZE   = $0E

LVL_TILE_MAP    = $C400 ; Expanded map of tiles.

THEME_BG_COL_2  = $00
THEME_BG_COL_3  = $01
THEME_SHADOW_COL = $02
THEME_SRC_CHARS = $03
THEME_W0_CHARS  = $1B
THEME_W0_FG     = $24
THEME_W0_BG     = $2D
THEME_W1_CHARS  = $36
THEME_W1_FG     = $3F
THEME_W1_BG     = $48
THEME_W2_CHARS  = $51
THEME_W2_FG     = $5A
THEME_W2_BG     = $63
THEME_W3_CHARS  = $6C
THEME_W3_FG     = $75
THEME_W3_BG     = $7E
THEME_F0_CHARS  = $87
THEME_F0_FG     = $90
THEME_F0_BG     = $99
THEME_F1_CHARS  = $A2
THEME_F1_FG     = $AB
THEME_F1_BG     = $B4
THEME_F2_CHARS  = $BD
THEME_F2_FG     = $C6
THEME_F2_BG     = $CF
THEME_F3_CHARS  = $D8
THEME_F3_FG     = $E1
THEME_F3_BG     = $EA

THEME_SRC_CHAR_COUNT = 24


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

CHAR_ARROW_N    = CHAR_BASE + (8 * CH_SLIDER_N)
CHAR_ARROW_S    = CHAR_ARROW_N + $8
CHAR_ARROW_E    = CHAR_ARROW_S + $8
CHAR_ARROW_W    = CHAR_ARROW_E + $8

CHAR_BLOCKER_0  = CHAR_BASE + (8 * CH_BLOCKER_1)
CHAR_BLOCKER_1  = CHAR_BLOCKER_0 + $8
CHAR_BLOCKER_2  = CHAR_BLOCKER_1 + $8
CHAR_BLOCKER_3  = CHAR_BLOCKER_2 + $8

CHAR_WALL       = CHAR_BASE + (8 * 40)

BLOCKER_SEQ_SIZE = 6

LOOK_OFFSET_SIZE = 13

CHOICE_CONTINUE  = 0
CHOICE_QUIT      = 1

; Graphics Characters
CH_BLANK                = $00
CH_FILLED               = $01
CH_BLOCKER_1            = $02
CH_BLOCKER_2            = $03
CH_BLOCKER_3            = $04
CH_BLOCKER_4            = $05

CH_SLIDER_N             = $06
CH_SLIDER_S             = $07
CH_SLIDER_E             = $08
CH_SLIDER_W             = $09

CH_BOX_TOP_LEFT         = $0A
CH_BOX_TOP_RIGHT        = $0B
CH_BOX_BOTTOM_RIGHT     = $0C
CH_BOX_BOTTOM_LEFT      = $0D
CH_BOX_TOP              = $0E
CH_BOX_RIGHT            = $0F
CH_BOX_BOTTOM           = $10
CH_BOX_LEFT             = $11

CH_SHAD_N               = $12
CH_SHAD_E               = $13
CH_SHAD_W               = $14
CH_SHAD_S               = CH_BOX_BOTTOM
CH_SHAD_N_NW_W          = $15
CH_SHAD_N_NE_E          = $16
CH_SHAD_S_SW_W          = $17
CH_SHAD_S_SE_E          = $18
CH_SHAD_NW              = $19
CH_SHAD_NE              = $1A
CH_SHAD_SE              = $1B
CH_SHAD_SW              = $1C
CH_SHAD_N_NW            = $1D
CH_SHAD_N_NE            = $1E

CH_KNIFE                = $1F
CH_STOVE                = $20
CH_SERVE                = $21
CH_TOMATO               = $22
CH_LETTUCE              = $23
CH_PATTY                = $24
CH_BUN                  = $25
CH_PLATE                = $26
CH_BIN                  = $27

CH_THEME_00             = $28
CH_THEME_01             = $29
CH_THEME_02             = $2A
CH_THEME_03             = $2B
CH_THEME_04             = $2C
CH_THEME_05             = $2D
CH_THEME_06             = $2E
CH_THEME_07             = $2F
CH_THEME_08             = $30
CH_THEME_09             = $31
CH_THEME_10             = $32
CH_THEME_11             = $33
CH_THEME_12             = $34
CH_THEME_13             = $35
CH_THEME_14             = $36
CH_THEME_15             = $37
CH_THEME_16             = $38
CH_THEME_17             = $39
CH_THEME_18             = $3A
CH_THEME_19             = $3B
CH_THEME_20             = $3C
CH_THEME_21             = $3D
CH_THEME_22             = $3E
CH_THEME_23             = $3F

SRC_BUSH_00             = $40
SRC_BUSH_01             = $41
SRC_BUSH_02             = $42
SRC_BUSH_03             = $43
SRC_BUSH_04             = $44
SRC_BUSH_05             = $45
SRC_BUSH_06             = $46
SRC_BUSH_07             = $47
SRC_BUSH_08             = $48
SRC_ROCK_00             = $49
SRC_ROCK_01             = $4A
SRC_ROCK_02             = $4B
SRC_ROCK_03             = $4C
SRC_ROCK_04             = $4D
SRC_ROCK_05             = $4E
SRC_ROCK_06             = $4F
SRC_ROCK_07             = $50
SRC_ROCK_08             = $51
SRC_HOLE_00             = $52
SRC_HOLE_01             = $53
SRC_HOLE_02             = $54
SRC_HOLE_03             = $55
SRC_HOLE_04             = $56
SRC_HOLE_05             = $57
SRC_HOLE_06             = $58
SRC_HOLE_07             = $59
SRC_HOLE_08             = $5A
SRC_GRASS_00            = $5B
SRC_GRASS_01            = $5C
SRC_GRASS_02            = $5D
SRC_WALL_00             = $5E
SRC_WALL_01             = $5F
SRC_WALL_02             = $60
SRC_WALL_03             = $61
SRC_WALL_04             = $62
SRC_WALL_05             = $63
SRC_WALL_06             = $64
SRC_WALL_07             = $65
SRC_WALL_08             = $66
SRC_WINDOW_00           = $67
SRC_WINDOW_01           = $68
SRC_WINDOW_02           = $69
SRC_WINDOW_03           = $6A
SRC_WINDOW_04           = $6B
SRC_WINDOW_05           = $6C
SRC_WINDOW_06           = $6D
SRC_WINDOW_07           = $6E
SRC_WINDOW_08           = $6F
SRC_SAND_00             = $70
SRC_SAND_01             = $71
SRC_SAND_02             = $72
SRC_SAND_03             = $73
SRC_SAND_04             = $74
SRC_SAND_05             = $75
SRC_SAND_06             = $76
SRC_SAND_07             = $77
SRC_SAND_08             = $78
SRC_TREE_00             = $79
SRC_TREE_01             = $7A
SRC_TREE_02             = $7B
SRC_TREE_03             = $7C
SRC_TREE_04             = $7D
SRC_TREE_05             = $7E
SRC_TREE_06             = $7F
SRC_TREE_07             = $80
SRC_TREE_08             = $81
SRC_WOOD_00             = $82
SRC_WOOD_01             = $83
SRC_WOOD_02             = $84
SRC_WOOD_03             = $85
SRC_WOOD_04             = $86
SRC_WOOD_05             = $87
SRC_WOOD_06             = $88
SRC_WOOD_07             = $89
SRC_WOOD_08             = $8A
SRC_CHECK_00            = $8B
SRC_CHECK_01            = $8C
SRC_CHECK_02            = $8D
SRC_WALL_09             = $8E
SRC_WALL_10             = $8F
SRC_WALL_11             = $90
SRC_WALL_12             = $91
SRC_WALL_13             = $92
SRC_WALL_14             = $93
SRC_WALL_15             = $94
SRC_WALL_16             = $95
SRC_WALL_17             = $96
SRC_COBBLE_00           = $97
SRC_COBBLE_01           = $98
SRC_COBBLE_02           = $99
SRC_COBBLE_03           = $9A
SRC_COBBLE_04           = $9B
SRC_COBBLE_05           = $9C
SRC_PUDDLE_LG_00        = $9D
SRC_PUDDLE_LG_01        = $9E
SRC_PUDDLE_SM_00        = $9F
SRC_PUDDLE_LG_02        = $A0
SRC_PUDDLE_LG_03        = $A1
SRC_PUDDLE_SM_01        = $A2
SRC_CACTUS_00           = $A3
SRC_CACTUS_01           = $A4
SRC_CACTUS_02           = $A5
SRC_CACTUS_03           = $A6
; UNUSED                  = $A7
; UNUSED                  = $A8
SRC_SPACE_WINDOW_00     = $A9
SRC_SPACE_WINDOW_01     = $AA
SRC_SPACE_WINDOW_02     = $AB
SRC_SPACE_WINDOW_03     = $AC
SRC_SPACE_WINDOW_04     = $AD
SRC_SPACE_WINDOW_05     = $AE
SRC_SPACE_WINDOW_06     = $AF
SRC_SPACE_WINDOW_07     = $B0
SRC_SPACE_WINDOW_08     = $B1
SRC_SPACE_WALL_00       = $B2
SRC_SPACE_WALL_01       = $B3
SRC_SPACE_WALL_02       = $B4
SRC_SPACE_WALL_03       = $B5
SRC_LINE_00             = $B6
SRC_LINE_01             = $B7
SRC_LINE_02             = $B8
SRC_LINE_03             = $B9
SRC_LINE_04             = $BA
SRC_LINE_05             = $BB
SRC_LINE_06             = $BC
SRC_LINE_07             = $BD
SRC_LINE_08             = $BE
SRC_LINE_09             = $BF
SRC_LINE_10             = $C0
