
Anw01 ldr R0, =Variable a
  Lädt die Speicheradresse der Variable Variable a in das Register R0

Anw02 ldrb R2, [R0]
  Liest das erste Byte ab der Adresse R0 in das Register R2. Da die Variable im Code mit DCW 0xbeef definiert ist liegt das niederwertige Byte 0xEF an der kleineren Adresse. In R2 steht daher 0x000000EF

Anw03 ldrb R3, [R0, #1]
  Liest das Byte an der Adresse R0 + 1 in das Register R3. Hier liegt das hochwertige Byte 0xBE, R3 erhält den Wert 0x000000BE

Anw04 (lsl R2, #8)
  Führt eine Verschiebung nach links um 8 Bit auf dem Register R2 aus. Aus 0x000000EF wird dadurch 0x0000EF00

Anw05 (orr R2, R3)
  Verknüpft die Register R2 0x0000EF00 und R3 0x000000BE bitweise per OR. In R2 steht danach der zusammengesetzte 16-Bit-Wert 0x0000EFBE. Die beiden ursprünglichen Bytes wurden somit vertauscht.

Anw06 (strh R2, [R0])
  Schreibt das 16-Bit-Halbwort aus R2 0xEFBE zurück an die Speicheradresse R0. Durch die Little-Endian-Speicherung steht im Memory an der kleineren Adresse nun das Byte 0xBE und an der höheren Adresse 0xEF. Im Memory ist der Wert 0xBEEF somit in der Bytereihenfolge zu beef bzw. ef be umgeordnet worden.

In R0 wird die Speicheradresse von VariableC abgelegt. Der Befehl STRH liest ein Halbwort (2 Bytes,16 Bit) aus dem Register R5 und schreibt es an die Adresse, auf die R0 zeigt. Weil R5 den Wert 0xAFFE enthält, landen genau diese 2 Bytes im Speicher bei VariableC (im Memory Browser als FE AF sichtbar wegen Little-Endian)

