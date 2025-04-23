.include "p33FJ128MC802.inc"

; -----------------------------
; Configuration Bits
; -----------------------------
.section .config

.pword __FOSCSEL, FNOSC_FRC
.pword __FOSC, POSCMD_NONE & OSCIOFNC_OFF & FCKSM_CSDCMD
.pword __FWDT, FWDTEN_OFF
.pword __FICD, ICS_PGD1 & JTAGEN_OFF

; -----------------------------
; Code principal
; -----------------------------
.section .text
.global _main

_main:
    bclr    TRISA, #0        ; Configure RA0 comme sortie

loop:
    bset    LATA, #0         ; Allume la LED
    call    delay500ms

    bclr    LATA, #0         ; Éteint la LED
    call    delay500ms

    bra     loop             ; Boucle infinie

; -----------------------------
; Délai ~500 ms
; -----------------------------
delay500ms:
    mov     #400, w0
d1:
    mov     #1000, w1
d2:
    dec     w1, w1
    bra     nz, d2
    dec     w0, w0
    bra     nz, d1
    return