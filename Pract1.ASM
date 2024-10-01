.MODEL SMALL
.STACK 100H

.DATA
    MSJ_INGRESO1 DB 'INGRESE EL PRIMER DIGITO (0-9): $'
    MSJ_INGRESO2 DB 10, 13, 'INGRESE EL SEGUNDO DIGITO (0-9): $'
    MSJ_VALIDO DB 10, 13, 'LA SUMA ES: $'
    MSJ_INVALIDO DB 10, 13, 'DIGITO INVALIDO, INTENTE DE NUEVO.$'
    DIGITO1 DB ?
    DIGITO2 DB ?
    RESULTADO DB ?   ; Almacenar el resultado de la suma (un solo dígito)
    ASCVAL DB 5 DUP(00H), '$' ; Espacio para convertir el resultado a ASCII

.CODE
    ORG 100H

MAIN:
    CALL SEG_DAT

PEDIR_DIGITO1:
    ; Mostrar mensaje de ingreso del primer dígito
    MOV DX, OFFSET MSJ_INGRESO1
    CALL IMPRIMIR

    ; Leer el primer carácter desde el teclado
    CALL LEER_CARACTER
    MOV DIGITO1, AL  ; Guardar el carácter ingresado

    ; Validar si el primer carácter es un número entre '0' y '9'
    CMP AL, '0'
    JB MENSAJE_INVALIDO    ; Si es menor que '0', no es un número
    CMP AL, '9'
    JA MENSAJE_INVALIDO    ; Si es mayor que '9', no es un número

PEDIR_DIGITO2:
    ; Mostrar mensaje de ingreso del segundo dígito
    MOV DX, OFFSET MSJ_INGRESO2
    CALL IMPRIMIR

    ; Leer el segundo carácter desde el teclado
    CALL LEER_CARACTER
    MOV DIGITO2, AL  ; Guardar el carácter ingresado

    ; Validar si el segundo carácter es un número entre '0' y '9'
    CMP AL, '0'
    JB MENSAJE_INVALIDO    ; Si es menor que '0', no es un número
    CMP AL, '9'
    JA MENSAJE_INVALIDO    ; Si es mayor que '9', no es un número

    ; Convertir los caracteres a valores numéricos (de ASCII a decimal)
    MOV AL, DIGITO1
    SUB AL, '0'
    MOV BL, AL

    MOV AL, DIGITO2
    SUB AL, '0'
    ADD AL, BL  ; Sumar los dos dígitos
    MOV RESULTADO, AL

    ; Convertir el resultado a ASCII para imprimirlo
    ADD AL, '0'
    MOV ASCVAL, AL

    ; Mostrar el mensaje de resultado
    MOV DX, OFFSET MSJ_VALIDO
    CALL IMPRIMIR
    MOV DX, OFFSET ASCVAL
    CALL IMPRIMIR

    ; Terminar el programa
    JMP FIN

MENSAJE_INVALIDO:
    ; Mostrar mensaje de "DIGITO INVALIDO, INTENTE DE NUEVO"
    MOV DX, OFFSET MSJ_INVALIDO
    CALL IMPRIMIR
    JMP PEDIR_DIGITO1   ; Volver a pedir los dígitos desde el principio

FIN:
    ; Terminar el programa
    MOV AH, 4CH
    INT 21H

; Rutina para imprimir un mensaje (usa INT 21h, función 09h)
IMPRIMIR PROC
    MOV AH, 09H
    INT 21H
    RET
IMPRIMIR ENDP

; Rutina para leer un carácter desde el teclado (usa INT 21h, función 01h)
LEER_CARACTER PROC
    MOV AH, 01H
    INT 21H
    RET
LEER_CARACTER ENDP

SEG_DAT PROC
    MOV AX, @DATA
    MOV DS, AX
    RET
SEG_DAT ENDP

END MAIN
