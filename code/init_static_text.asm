;============================================================
; write the two line of text to screen center
;============================================================


init_text  ldx #$00          ; init X-Register with $00
loop_text  lda line1,x      ; read characters from line1 table of text...
           sta $0590,x      ; ...and store in screen ram near the center
           lda line2,x      ; read characters from line1 table of text...
           sta $05e0,x      ; ...and put 2 rows below line1

           inx 
           cpx #$28         ; finished when all 40 cols of a line are processed
           bne loop_text    ; loop if we are not done yet
           rts