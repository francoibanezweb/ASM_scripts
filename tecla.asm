PAGE 60,132
TITLE LEER TECLA PULSADA
;******************************************************************************
; Nombre del programa   :   TECLA.ASM
; Fecha de creación     :   AGOSTO 2023
; Autor                 :   Franco Ibañez
; Objetivo              :   Lee tecla pulsada.
;                           Imprime en pantalla, fila 10 y columna 20
;                           " La tecla pulsada es "
;                           Imprime en pantalla, fila 23 y columna 17
;                           'Presione cualquier tecla para SALIR '
;                           
;******************************************************************************
; COMANDO DE ENSAMBLE   : Masm TECLA.ASM;
; COMANDO DE ENLACE     : Link TECLA.OBJ;
; COMANDO DE EJECUCION  : TECLA.exe [Enter]
;******************************************************************************

;-------------------------------------------------------
PILA  SEGMENT PARA STACK 'STACK'
           DB      64 DUP ('STACK   ')
PILA  ENDS

DATOS SEGMENT PARA PUBLIC 'DATA'

      MENSAJ1  DB  'Se ha pulsado la tecla: ', '$'
      MENSAJ2  DB  'Presione cualquier tecla para SALIR ', '$'

DATOS ENDS

;--------------------------------------------------------

CSEG  SEGMENT PARA PUBLIC 'CODE'

PRINCIPAL PROC   FAR
;
       ASSUME CS:CSEG,SS:PILA,DS:DATOS
       MOV AX,SEG DATOS
       MOV DS,AX

                           
; =================================
; Limpia la pantalla
; =================================
        MOV AH,06H
        MOV AL,00H
        MOV CX,0000H    ; Rutina para limpiar la pantalla
        MOV DX,184FH
        MOV BH,7
        INT 10H

; ==================================
; Posiciona el cursor
;===================================
        MOV AH,02h
        MOV BH,00
        MOV DH,10      ; Rutina de posicionamiento del cursor (f=10,c=20)
        MOV DL,20
        INT 10h

; ==================================
; Imprime mensaje 1
; ==================================
       MOV AH,09H
       LEA DX,MENSAJ1   ;Rutina que imprime MENSAJ1
       INT 21H

; ==================================
; Lee tecla pulsada y la muestra
; ==================================
       MOV AH, 0        ; Lee tecla (código ASCII en AH)
       INT 16h          ; Interrupción del teclado
       MOV AH, 0Ah      ; Escribe carácter
       MOV BH, 0        ; Página de video 0
       MOV CX, 1        ; Imprime carácter en AL
       INT 10h          ; Interrupción del video
              
; ==================================
; Posciona el cursor para mensaje 2
; ==================================
        MOV AH,02h
        MOV BH,00
        MOV DH,23      ; Rutina de posicionamiento del cursor (f=23,c=17)
        MOV DL,17
        INT 10h

; ==================================
; Imprime mensaje 2
; ==================================
       MOV AH,09H
       LEA DX,MENSAJ2   ;Rutina que imprime MENSAJ2
       INT 21H

; ==================================
; Espera tecla y sale al DOS
; ==================================
        MOV AH,01H    ; Espera que se presione cualquier tecla
        INT 21H       


        MOV AX,4c00h     ; Salida al DOS.
        INT 21h

        
PRINCIPAL ENDP
CSEG    ENDS
        END  principal
