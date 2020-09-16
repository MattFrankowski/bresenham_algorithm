;               --Mateusz Frankowski--
;   --Bresenham's Algorithm, angle < 45 degrees--


section .text
global bresenhamAlgorithm

bresenhamAlgorithm:
    ; prologue
    push ebp
    mov ebp, esp
    push ebx
    push esi

    ; calculate x differential
    mov eax, [ebp+16]
    sub eax, [ebp+8]
    push eax                ; local variable dx in [ebp-12]

    ; calculate y differential
    mov eax, [ebp+20]
    sub eax, [ebp+12]
    push eax                ; local variable dy in [ebp-16]

    ; calculate rowSize of BMP file
    mov eax, [ebp+24]       ;get pInfo argument passed
    mov eax, [eax]
    add eax, 31
    shr eax, 5              ; shift right by 5 positions
    shl eax, 2              ; shift left by 2 positions
    push eax                ; store local variable rowSize in [ebp-20]

    ; change starting point to black - (x1, y1)
    mov ebx, [ebp+12]       ; y1 cposition passed as an argument
    mul ebx                 ; multiply eax by ebx, which means multiply y1 by rowSize - getting the desired y position on the picture
    mov ebx, [ebp+8]        ; x1 position passed as an argument
    mov cl, bl
    shr cl, 3               ; logical shift right - divide by 8 - move in X axis
    shr bl, 3              ; shift right logical by 3
    add eax, ebx            ; row size + byte offset = pixel
    mov bl, 0x7F            ; pixel bitmask - 01111111
    mov esi, eax            ; address offset
    mov edx, [ebp+24]       ; move pInfo argument into edx
    add esi, [edx+8]        ; add starting location and offset
    and BYTE[esi], bl       ; set starting pixel black

    mov eax, [ebp-16]       ; move dy to eax
    shl eax, 1              ; 2*dy
    mov edx, [ebp-12]       ; move dx to edx
    sub eax, edx            ; error = 2*dy-dx
    mov ecx, [ebp-12]       ; loop until decremented dx reaches 0
    dec ecx
setPixel:
    ror bl, 1               ; rotate right bl by 1
    mov dl, bl
    add dl, 1
    not dl                  ; dl negation
    shr dl, 6               ; shift right dl by 6
    add esi, edx            ; increment if mask=1
    and BYTE[esi], bl       ; set pixel
calcErrorIfGreaterThan0:
    cmp eax, 0
    jle elseCalcLowerThan0  ; if error < 0 then jump to elseCalclowerThan0
    mov edx, [ebp-12]       ; move dx variable to edx
    shl edx, 1              ; multiply dx * 2
    sub eax, edx            ; error -= 2*dx
    add esi, [ebp-20]       ; add rowsize = increment in y direction
elseCalcLowerThan0:
    mov edx, [ebp-16]       ; move dy variable to edx
    shl edx, 1              ; multiply dy * 2
    add eax, edx            ; error += 2*dy
    loop setPixel

    ; epilogue
    mov esp, ebp
    pop ebp
    ret