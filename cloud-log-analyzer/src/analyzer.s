.equ SYS_read,   63
.equ SYS_write,  64
.equ SYS_exit,   93
.equ STDIN_FD,    0
.equ STDOUT_FD,   1

.section .bss
    .align 4
buffer:     .skip 4096
num_buf:    .skip 32
counts:     .skip 2400     // 600 * 4 bytes

.section .text
.global _start

_start:
    // Inicializar counts a 0
    adrp x0, counts
    add  x0, x0, :lo12:counts
    mov  x1, #600

init_loop:
    cmp x1, #0
    b.eq init_done
    str wzr, [x0], #4
    sub x1, x1, #1
    b init_loop

init_done:
    // Parser estado
    mov x22, #0      // numero_actual
    mov x23, #0      // tiene_digitos

leer_bloque:
    mov x0, #STDIN_FD
    adrp x1, buffer
    add x1, x1, :lo12:buffer
    mov x2, #4096
    mov x8, #SYS_read
    svc #0

    cmp x0, #0
    beq fin_lectura
    blt salida_error

    mov x24, #0
    mov x25, x0

procesar_byte:
    cmp x24, x25
    b.ge leer_bloque

    adrp x1, buffer
    add x1, x1, :lo12:buffer
    ldrb w26, [x1, x24]
    add x24, x24, #1

    cmp w26, #10
    b.eq fin_numero

    cmp w26, #'0'
    b.lt procesar_byte
    cmp w26, #'9'
    b.gt procesar_byte

    mov x27, #10
    mul x22, x22, x27
    sub w26, w26, #'0'
    uxtw x26, w26
    add x22, x22, x26
    mov x23, #1
    b procesar_byte

fin_numero:
    cbz x23, reiniciar_numero
    mov x0, x22
    bl clasificar_codigo

reiniciar_numero:
    mov x22, #0
    mov x23, #0
    b procesar_byte

fin_lectura:
    cbz x23, buscar_max
    mov x0, x22
    bl clasificar_codigo

buscar_max:
    mov w5, #0      // max
    mov w6, #0      // resultado
    mov w7, #0      // i

loop_max:
    cmp w7, #600
    b.ge imprimir

    lsl x8, x7, #2
    adrp x9, counts
    add x9, x9, :lo12:counts
    add x10, x9, x8

    ldr w11, [x10]

    cmp w11, w5
    b.le siguiente

    mov w5, w11
    mov w6, w7

siguiente:
    add w7, w7, #1
    b loop_max

imprimir:
    mov x0, x6
    bl print_uint

    mov x0, #0
    mov x8, #SYS_exit
    svc #0

salida_error:
    mov x0, #1
    mov x8, #SYS_exit
    svc #0

// ----------------------------------------
// counts[codigo]++
// ----------------------------------------
clasificar_codigo:
    cmp x0, #599
    b.gt fin_clas

    mov x1, x0
    lsl x1, x1, #2

    adrp x2, counts
    add x2, x2, :lo12:counts

    add x3, x2, x1
    ldr w4, [x3]
    add w4, w4, #1
    str w4, [x3]

fin_clas:
    ret

// ----------------------------------------
// imprimir entero en stdout
// ----------------------------------------
print_uint:
    adrp x1, num_buf
    add x1, x1, :lo12:num_buf
    add x2, x1, #31
    mov w3, #10
    mov w4, #'0'

    strb w4, [x2]
    sub x2, x2, #1

    mov x5, x0

convert_loop:
    mov x6, #10
    udiv x7, x5, x6
    msub x8, x7, x6, x5
    add w8, w8, #'0'
    strb w8, [x2]
    sub x2, x2, #1
    mov x5, x7
    cbnz x5, convert_loop

    add x2, x2, #1

    mov x0, #STDOUT_FD
    mov x1, x2
    adrp x3, num_buf
    add x3, x3, :lo12:num_buf
    add x3, x3, #31
    sub x2, x3, x2
    mov x8, #SYS_write
    svc #0

    ret
