colwash   ldx #$27        ; load x-register with #$27 to work through 0-39 iterations
          lda color+$27   ; init accumulator with the last color from first color table

cycle1    ldy color-1,x   ; remember the current color in color table in this iteration
          sta color-1,x   ; overwrite that location with color from accumulator
          sta $d990,x     ; put it into Color Ram into column x
          tya             ; transfer our remembered color back to accumulator
          dex             ; decrement x-register to go to next iteration
          bne cycle1      ; repeat if there are iterations left
          sta color+$27   ; otherwise store te last color from accu into color table
          sta $d990       ; ... and into Color Ram
                          
colwash2  ldx #$00        ; load x-register with #$00
          lda color2+$27  ; load the last color from the second color table

cycle2    ldy color2,x    ; remember color at currently looked color2 table location
          sta color2,x    ; overwrite location with color from accumulator
          sta $d9e0,x     ; ... and write it to Color Ram
          tya             ; transfer our remembered color back to accumulator 
          inx             ; increment x-register to go to next iteraton
          cpx #$26        ; have we gone through 39 iterations yet?
          bne cycle2      ; if no, repeat
          sta color2+$27  ; if yes, store the final color from accu into color2 table
          sta $d9e0+$27   ; and write it into Color Ram
 
          rts             ; return from subroutine