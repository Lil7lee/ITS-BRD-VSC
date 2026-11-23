;************************************************
;* Beginn der globalen Daten *
;************************************************
                   AREA MyData, DATA, align = 2
Base
VariableA          DCW 0x1234
VariableB          DCW 0x4711

VariableC          DCD  0

MeinHalbwortFeld   DCW 0x22 , 0x3e , -52, 78 , 0x27 , 0x45

MeinWortFeld       DCD 0x12345678 , 0x9dca5986
                   DCD -872415232 , 1308622848
                   DCD 0x27000000
                   DCD 0x45000000

MeinTextFeld       DCB "ABab0123",0

                   EXPORT VariableA
                   EXPORT VariableB
                   EXPORT VariableC
                   EXPORT MeinHalbwortFeld
                   EXPORT MeinWortFeld
                   EXPORT MeinTextFeld

;***********************************************
;* Beginn des Programms *
;************************************************
    AREA |.text|, CODE, READONLY, ALIGN = 3
; ----- S t a r t des Hauptprogramms -----
                EXPORT main
                EXTERN initITSboard
main            PROC
                bl    initITSboard                 ; HW Initialisieren

; Laden von Konstanten in Register
                mov   r0,#0x12                      ; Anw-01 Lädt den Wert 0x12 in das Register r0
                mov   r1,#-128                      ; Anw-02 Lädt den Wert -128 in das Register r1
                ldr   r2,=0x12345678                ; Anw-03 Lädt die Adresse des Wertes 0x12345678 in das Register r2

; Zugriff auf Variable
                ldr   r0,=VariableA                 ; Anw-04 Lädt die Adresse von VariableA in r0
                ldrh  r1,[r0]                       ; Anw-05 Lädt den Wert von VariableA in r1
                ldr   r2,[r0]                       ; Anw-06 Lädt den Wert von VariableA in r2
                str   r2,[r0,#VariableC-VariableA]  ; Anw-07 Speichert den Wert von r2 in VariableC

; Zugriff auf Felder (Speicherzellen)
                ldr   r0,=MeinHalbwortFeld          ; Anw-08 Lädt die Adresse von MeinHalbwortFeld in r0
                ldrh  r1,[r0]                       ; Anw-09 Lädt den ersten Wert von MeinHalbwortFeld in r1
                ldrh  r2,[r0,#2]                    ; Anw-10 Lädt den zweiten Wert von MeinHalbwortFeld in r2
                mov   r3,#10                        ; Anw-11 Lädt den Wert 10 in r3
                ldrh  r4,[r0,r3]                    ; Anw-12 Lädt den Wert von MeinHalbwortFeld[10] in r4

                ldrh  r5,[r0,#2]!                   ; Anw-13 Lädt den Wert von MeinHalbwortFeld[2] in r5 und inkrementiert r0 um 2
                ldrh  r6,[r0,#2]!                   ; Anw-14 Lädt den Wert von MeinHalbwortFeld[4] in r6 und inkrementiert r0 um 2
                strh  r6,[r0,#2]!                   ; Anw-15 Lädt den Wert von r6 in MeinHalbwortFeld[6] und inkrementiert r0 um 2

; Addition und Subtraktion von unsigned / signed Integer-Werten
                ldr  r0,=MeinWortFeld               ; Anw-16 Lädt die Adresse von MeinWortFeld in r0
                ldr  r1,[r0]                        ; Anw-17 Lädt den ersten Wert von MeinWortFeld in r1
                ldr  r2,[r0,#4]                     ; Anw-18 Lädt den zweiten Wert von MeinWortFeld in r2
                adds r3,r1,r2                       ; Anw-19 Addiert die Werte in r1 und r2 und speichert das Ergebnis in r3

                ldr  r4,[r0,#8]                     ; Anw-20 Lädt den dritten Wert von MeinWortFeld in r4
                ldr  r5,[r0,#12]                    ; Anw-21 Lädt den vierten Wert von MeinWortFeld in r5
                subs r6,r4,r5                       ; Anw-22 Lädt den Wert in r5 von dem Wert in r4 ab und speichert das Ergebnis in r6

                ldr  r7,[r0,#16]                    ; Anw-23 Lädt den fünften Wert von MeinWortFeld in r7
                ldr  r8,[r0,#20]                    ; Anw-24 Lädt den sechsten Wert von MeinWortFeld in r8
                subs r9,r7,r8                       ; Anw-25 Lädt den Wert in r8 von dem Wert in r7 ab und speichert das Ergebnis in r9

forever         b   forever                         ; Anw-26 Lädt eine Endlosschleife, um das Programm am Laufen zu halten
                ENDP
                END
