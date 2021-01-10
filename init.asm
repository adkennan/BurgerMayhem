
INIT_SYSTEM
        lda #GS_TITLE
        sta G_GAME_STATE

        jsr FADE_OUT
        jsr CLEAR_SCREEN
        
        sei
        
        ; Disable Kernal and Basic ROM
        lda #CPUPORT_VAL
        sta CPUPORT             

        ; Set up our own interrupt handler
        lda #<IRQ
        sta NMISR
        sta ISR
        lda #>IRQ
        sta NMISR
        sta ISR

        ; Clear CIA timers
        lda #DXICR_CLEAR
        sta D1ICR
        sta D2ICR
        lda D1ICR
        lda D2ICR

        cli

        lda #VMCSB_VAL
        sta VMCSB
        lda #SCROLY_VAL
        sta SCROLY

        ; Hide border garbage
        lda #$FF        
        sta BORDER_PAT_LOC

        jsr BLACK_SCREEN
        
        rts

IRQ
        rti