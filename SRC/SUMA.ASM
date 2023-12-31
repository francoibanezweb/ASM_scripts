PAGE 60,132
TITLE SUMA
;******************************************************************************
; Nombre del programa   :   SUMA.ASM (CON OTRA VARIANTE )
; Fecha de creaci�n     :   SEPTIEMBRE 16, 2022
; Autor                 :   ING. Hugo Mazzeo
; Objetivo              :   Lee un byte de la posici�n 00FAh. A dicho valor 
;                           le calcula el factorial y lo almacena en la
;                           direcci�n 0AAAh.
;                           Imprime en pantalla, fila 10 y columna 20
;                           "LA SUMA ES "
;                           Imprime en pantalla, fila 23 y columna 17
;                           'Presione cualquier tecla para SALIR '
;                           
;******************************************************************************
; COMANDO DE ENSAMBLE   : Masm PRODUCTO.ASM;
; COMANDO DE ENLACE     : Link PRODUCTO.OBJ;
; COMANDO DE EJECUCION  : PRODUCTO.exe [Enter]
;******************************************************************************
; NOTA : Se procura usar SOLO las instrucciones que se han visto o explicado.
;        El objetivo es educativo y NO de optimizaci�n o eficiencia.
;        
;******************************************************************************

;-------------------------------------------------------
PILA  SEGMENT PARA STACK 'STACK'
           DB      64 DUP ('STACK   ')
PILA  ENDS

DATOS SEGMENT PARA PUBLIC 'DATA'

      MENSAJ1  DB  'LA SUMA ES (EN HEXA): ', '$'
      MENSAJ2  DB  'Presione cualquier tecla para SALIR ', '$'

DATOS ENDS

;--------------------------------------------------------

CSEG  SEGMENT PARA PUBLIC 'CODE'

PRINCIPAL PROC   FAR
;
       ASSUME CS:CSEG,SS:PILA,DS:DATOS
       MOV AX,SEG DATOS
       MOV DS,AX

       MOV Ax,0004h  ;      ;cargar un valor entre 1 y 8 decimal.
       MOV CS:[00FAh],Ax  ;se supone que ya estaria cargado. 
                           
; =================================

        MOV Ax,CS:[00FAh]       ; Leer valor de memoria
        MOV Bx,0005h            ; Cargo otro sumando en BX
        ADD Bx,Ax               ; instrucci�n que calcula la suma
        
; ===================================
 SALTO: MOV DS:[0AAAh],BX   ; Almacena valor de la suma en memoria.
        MOV AH,06H
        MOV AL,00H
        MOV CX,0000H        ; Rutina para limpiar la pantalla
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
       LEA DX,MENSAJ1      ;Rutina que imprime MENSAJ1
       INT 21H
; ====================================
       MOV AX,DS:[0AAAh]   ; Cargo el resultado obtenido en AX
       AND AX,00F0h        ; Aplico m�scara para obtener 1er. d�gito hexa
       MOV BL,AL           ; Lo guardo en BL
       MOV CL,04H
       SHR BL,CL           ; Lo corro 4 bits a la derecha antes de convertir
       OR BL,30H           ; Para convertir el 1er. d�gito hexa en ASCII
       MOV AX,DS:[0AAAh]   ; Vuelvo a cargar el resultado
       AND AX,000Fh        ; Aplico m�scara para obtener 2do. d�gito
       MOV BH,AL
       OR BH,30H           ; Convierte 2do. d�gito en ASCII
       MOV AH,2
       MOV DL,BL
       INT 21H             ; Imprimo primer d�gito
       MOV DL,BH
       INT 21H             ; Imprimo segundo d�gito

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
