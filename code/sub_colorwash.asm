colwash   ldx #$27        ; load x-register with #$27 to work through 0-39 iterations
          lda color+$27   ; init accumulator with the last color from first color table
cycle1    ldy color-1,x   ; use y-register to remember color at next position in iteration
          sta color-1,x   ; write the stored color from accumulator to that location
          sta $d990,x     ; put it into Color Ram
          tya             ; transfer our remembered color back to accumulator
          dex             ; decrement x-Register to go to next iteration
          bne cycle1      ; repeat if there are iterations left
          sta color+$27   ; otherwise store te final color into accumulator
          sta $d990       ; ... and into Color Ram
                          ; do the reverse for the second line of text in the intro
colwash2  ldx #$00        ; load x-register with #$00 to track iterations
          lda color2+$27  ; load the last color from the second table
cycle2    ldy color2,x    ; remember previously used color of second table in y-register
          sta color2,x    ; store that color into accumulator
          sta $d9e0,x     ; ... and write it to Color Ram
          tya             ; transfer our remembered color back to accumulator 
          inx             ; increment x-register to go to next iteraton
          cpx #$26        ; have we gone through 39 iterations yet?
          bne cycle2      ; if no, repeat
          sta color2+$27  ; if yes, store the final color into accumulator
          sta $d9e0+$27   ; and write it into Color Ram
          rts             ; return from subroutine