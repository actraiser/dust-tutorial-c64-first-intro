;============================================================
; color washer routine
;============================================================


; during the control of the color washing routine, 
; we take the byte, which is at color+00 and then 
; we place it at color+$28, then we call a continuous loop 
; which makes the data table cycle by subtracting each piece of data in the data table by one
; and read the calculations 40 times ($28). Therefore the data table pulls each byte of data. 
; Also inside our loop, the colors are read from the data table and put into color RAM, 
; which starts at $D800.

colwash    lda color+$00      ; load first color
           sta color+$28      ; store in column 40 ($28 = #40) - this resets the table for the next color cycle
           ldx #$00           ; init counter
           sta $d9df,x
cycle1     lda color+$01,x    ; CYCLE iterates once(!) by moving color by 1 in table
           sta color+$00,x 
           lda color,x        ; load current color
           sta $d990,x        ; put into color ram for one of the 40 positions
           inx                ; inc iterator
           cpx #$28           ; have we done 40 iterations yet?
           bne cycle1         ; if no, continue

colwash2   lda color2+$28     ; load last color
           sta color2+$00     ; store in column 00 this resets the table for the next color cycle
           ldx #$28
cycle2     lda color2-$01,x   ; CYCLE iterates once(!) by moving color by 1 in table in reverse order
           sta color2+$00,x 
           lda color2,x       ; load current color
           sta $d9df,x        ; put into color ram for one of the 40 positions
           dex                ; decrease iterator
           bne cycle2         ; if x not zero yet, continue

           rts                ; return 