.model small
.stack 100h

.data 
msg db 'Hola Mundo!','$'

 .code 
 start:
     mov ah, 09h
     lea dx, msg 
     int 21h 
     mov ax, 4c00h 
     int 21h 

end start
;Esta modifaci¢n no estaba antes
;Esta tampoco estaba antes
