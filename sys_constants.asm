
; VIC Registers

SP0X            = $D000 ; Sprite X and Y positions
SP0Y            = $D001
SP1X            = $D002
SP1Y            = $D003
SP2X            = $D004
SP2Y            = $D005
SP3X            = $D006
SP3Y            = $D007
SP4X            = $D008
SP4Y            = $D009
SP5X            = $D00A
SP5Y            = $D00B
SP6X            = $D00C
SP6Y            = $D00D
SP7X            = $D00E
SP7Y            = $D00F
MSIGX           = $D010 ; Bit 9 of sprite X positions
SCROLY          = $D011 ; Vert smooth scroll and control
RASTER          = $D012 ; Raster compare register
LPENX           = $D013 ; Light pen position
LPENY           = $D014
SPENA           = $D015 ; Sprite Enable
SCROLX          = $D016 ; Horiz smooth scroll and control
YXPAND          = $D017 ; Sprite vertical expansion
VMCSB           = $D018 ; Screen and char base address
VICIRQ          = $D019 ; Interrupt status register
IRQMSK          = $D01A ; Interrupt enable register
SPBGPR          = $D01B ; Sprite-foreground priority
SPMC            = $D01C ; Sprite multicolour mode
XXPAND          = $D01D ; Sprite horizontal expansion
SPSPCL          = $D01E ; Sprite-sprite collision
SPFGCL          = $D01F ; Sprite-foreground collision
EXTCOL          = $D020 ; Border colour
BGCOL0          = $D021 ; Background colour 0
BGCOL1          = $D022 ; Background colour 1
BGCOL2          = $D023 ; Background colour 2
BGCOL3          = $D024 ; Background colour 3
SPMC0           = $D025 ; Sprite multicolour 0
SPMC1           = $D026 ; Sprite multicolour 1
SP0COL          = $D027 ; Sprite colours
SP1COL          = $D028
SP2COL          = $D029
SP3COL          = $D02A
SP4COL          = $D02B
SP5COL          = $D02C
SP6COL          = $D02D
SP7COL          = $D02E

; CIA Registers
D1PRA           = $DC00
D1PRB           = $DC01
D1ICR           = $DC0D
D2ICR           = $DD0D

; Sprite Pointers
SPRPTR0         = $07F8 ; Sprite 0 pointer
SPRPTR1         = $07F9 ; Sprite 1 pointer
SPRPTR2         = $07FA ; Sprite 2 pointer
SPRPTR3         = $07FB ; Sprite 3 pointer
SPRPTR4         = $07FC ; Sprite 4 pointer
SPRPTR5         = $07FD ; Sprite 5 pointer
SPRPTR6         = $07FE ; Sprite 6 pointer
SPRPTR7         = $07FF ; Sprite 7 pointer

; IRQ Addresses
NMISR           = $FFFA
ISR             = $FFFE

; Colours
COL_BLACK       = $0
COL_WHITE       = $1
COL_RED         = $2
COL_CYAN        = $3
COL_PURPLE      = $4
COL_GREEN       = $5
COL_BLUE        = $6
COL_YELLOW      = $7
COL_ORANGE      = $8
COL_BROWN       = $9
COL_LRED        = $A
COL_DGREY       = $B
COL_MGREY       = $C
COL_LGREEN      = $D
COL_LBLUE       = $E
COL_LGREY       = $F

BG_COL_0        = $00
BG_COL_1        = $40
BG_COL_2        = $80
BG_COL_3        = $C0

; Flags
VMCSB_CHARS     = $0E ; Character set location, $3800
VMCSB_SCREEN    = $10 ; Screen memory location, $0400
VMCSB_VAL       = VMCSB_CHARS OR VMCSB_SCREEN

SCROLY_VPOS     = $03 ; Vertical fine scrolling position
SCROLY_HEIGHT   = $08 ; 25 char/200 pixel screen height
SCROLY_ENABLE   = $10 ; Enable display
SCROLY_EXTBG    = $40 ; Enable extended background colour mode
SCROLY_VAL      = SCROLY_VPOS OR SCROLY_HEIGHT OR SCROLY_ENABLE OR SCROLY_EXTBG

SPMC_ON         = $FF ; All multicolour

; Border pattern location
BORDER_PAT_LOC  = $39FF ; Location of byte shown in place of top and bottom borders.

; CPU Port
CPUPORT         = $01

CPUPORT_RAM     = $07 ; Hide Kernal and Basic ROM
CPUPORT_DS_OFF  = $30 ; Datasette off

CPUPORT_VAL     = CPUPORT_RAM OR CPUPORT_DS_OFF

DXICR_CLEAR     = $7F

; Screen Memory
SCREEN_0        = $0400
SCREEN_1        = $0500
SCREEN_2        = $0600
SCREEN_3        = $0700

SCREEN_WIDTH    = 40
SCREEN_WIDTH_X2 = SCREEN_WIDTH * 2
SCREEN_WIDTH_X3 = SCREEN_WIDTH * 3
SCREEN_WIDTH_X4 = SCREEN_WIDTH * 4

COLOUR_RAM      = $C000
COLOUR_RAM_0    = $C000
COLOUR_RAM_1    = $C100
COLOUR_RAM_2    = $C200
COLOUR_RAM_3    = $C300

REAL_COLOUR_RAM      = $D800
REAL_COLOUR_RAM_0    = $D800
REAL_COLOUR_RAM_1    = $D900
REAL_COLOUR_RAM_2    = $DA00
REAL_COLOUR_RAM_3    = $DB00

; Input
JOY_UP                  = 1
JOY_DOWN                = 2
JOY_LEFT                = 4
JOY_RIGHT               = 8
JOY_FIRE                = 16


