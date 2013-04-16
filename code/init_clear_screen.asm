;============================================================
; clear screen
; a loop instead of kernal routine to save cycles
;============================================================

init_screen      ldx #$00     ; start of loop
                 stx $d021            ; border
                 stx $d020            ; background

clear            lda #$20     ; #$20 is the spacebar screencode
                 sta $0400,x  ; fill four areas with 256 spacebar characters
                 sta $0500,x 
                 sta $0600,x 
                 sta $06e8,x 
                 lda #$00     ; puts black into the associated Color Ram ..
                 sta $d800,x  
                 sta $d900,x
                 sta $da00,x
                 sta $dae8,x
                 inx         
                 bne clear   
                 rts 