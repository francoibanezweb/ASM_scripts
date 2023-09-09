TITLE LIMPIAR
;********************************************************************
; Nombre del programa   :   LIMPIAR
; Fecha de creaci¢n     :   AGOSTO 04 de 1998
; Autor                 :   ING. GERARDO R. LESKIW
; Objetivo              :   Procedimiento que borra pantalla.         
;********************************************************************
; COMANDO DE ENSAMBLE   : Masm LIMPIAR.ASM;
; COMANDO DE ENLACE     : Link LIMPIAR.OBJ;
; COMANDO DE EJECUCION  : LIMPIAR.EXE
;*********************************************************************
;NOTA: Se procura usar SOLO las instrucciones que se han visto o explicado.
;      El objetivo es educativo y NO de optimizaci¢n o eficiencia.
;*********************************************************************
;-------------------------------------------------------
PILA  SEGMENT PARA STACK 'STACK'
           DB      64 DUP ('STACK   ')
PILA  ENDS
;--------------------------------------------------------
CSEG  SEGMENT PARA PUBLIC 'CODE'
PRINCIPAL PROC  FAR
        ASSUME CS:CSEG, SS:PILA
        MOV AH,06H
        MOV AL,00H
        MOV CX,0000H
        MOV DX,184FH
        MOV BH,7
        INT 10H
PRINCIPAL ENDP
CSEG    ENDS
        END
