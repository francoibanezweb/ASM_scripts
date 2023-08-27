PAGE 60,132
TITLE FACTORIAL
;******************************************************************************
; Nombre del programa   :   CONTAR NUMEROS POSITIVOS Y NEGATIVOS EN LA PAGINA 2
; Fecha de creación     :   AGOSTO 2023
; Autor                 :   Franco Ibañez
; Objetivo              :   Lee pagina 2 de memoria y detecta si un  
;                           numero es negativo. Los negativos los guarda
;                           en DX y los positivos en BX.
;                           Imprime en pantalla, fila 10 y columna 20
;                           " OPERACION BUSCAR CONCLUIDA "
;                           Imprime en pantalla, fila 23 y columna 17
;                           'Presione cualquier tecla para SALIR '
;                           
;******************************************************************************
; COMANDO DE ENSAMBLE   : Masm FACTOR.ASM;
; COMANDO DE ENLACE     : Link FACTOR.OBJ;
; COMANDO DE EJECUCION  : FACTOR.exe [Enter]
;******************************************************************************

;-------------------------------------------------------
PILA  SEGMENT PARA STACK 'STACK'
           DB      64 DUP ('STACK   ')
PILA  ENDS

DATOS SEGMENT PARA PUBLIC 'DATA'

      MENSAJ1  DB  'OPERACION BUSCAR CONCLUIDA ', '$'
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

       MOV SI,0200h   
       MOV BX,0000h  
       MOV DX,0000h  
       MOV CX,0100h  
ETIQ3: MOV AL,[SI]
       AND AL,80h     
       CMP AL,80h       
       JNE ETIQ1   
       INC DX            ; guarda en DX los números negativos
       JMP ETIQ2 
ETIQ1: INC BX            ; guarda en BX los números positivos
ETIQ2: INC SI 
       LOOP ETIQ3 

; ===================================
        MOV AH,06H
        MOV AL,00H
        MOV CX,0000H    ; Rutina para limpiar la pantalla
        MOV DX,184FH
        MOV BH,7
        INT 10H
; ====================================
        MOV AH,02h
        MOV BH,00
        MOV DH,10      ; Rutina de posicionamiento del cursor (f=10,c=20)
        MOV DL,20
        INT 10h
; ====================================
       MOV AH,09H
       LEA DX,MENSAJ1   ;Rutina que imprime MENSAJ1
       INT 21H
; ====================================
        MOV AH,02h
        MOV BH,00
        MOV DH,23      ; Rutina de posicionamiento del cursor (f=23,c=17)
        MOV DL,17
        INT 10h
; ====================================
       MOV AH,09H
       LEA DX,MENSAJ2   ;Rutina que imprime MENSAJ2
       INT 21H

;     ----------------
        MOV AH,01H    ; Espera que se presione cualquier tecla
        INT 21H       
;     ----------------
        MOV AX,4c00h     ; Salida al DOS.
        INT 21h
;     ------------------
PRINCIPAL ENDP
CSEG    ENDS
        END  principal
