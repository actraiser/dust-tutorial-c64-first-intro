;============================================================
; color washer routine
;============================================================

colwash    lda color+$00      ; load the current first color from table
           sta color+$28      ; store in in last position of table to reset the cycle
           ldx #$00           ; init X with zero

cycle1     lda color+1,x      ; Start cycle by fetching next color in the table...
           sta color,x        ; ...and store it in the current active position.
           sta $d990,x        ; put into Color Ram
           inx                ; increment X-Register
           cpx #$28           ; have we done 40 iterations yet?
           bne cycle1         ; if no, continue

colwash2   lda color2+$28     ; load current last color from second table
           sta color2+$00     ; store in in first position of table to reset the cycle
           ldx #$28
cycle2     lda color2-1,x     ; Start cycle by fetching previous color in the table...
           sta color2,x       ; ...and store it in the current active position.
           sta $d9df,x        ; put into Color Ram
           dex                ; decrease iterator
           bne cycle2         ; if x not zero yet, continue

           rts                ; return from subroutine