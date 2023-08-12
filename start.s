 .syntax unified

.thumb_func
.global main
main:
    @ Store RCC base address in r0
    movw r0, #0x3800
    movt r0, #0x4002

    @ Turn on GPIOF clock by setting bit 5 in AHB1ENR register
    movw r1, #0x20
    str  r1, [r0, #0x30]

    @ Store start address of GPIOF registers
    movw r0, #0x1400
    movt r0, #0x4002

    @ Use GPIOF_MODER to make GPIOF9 an output
    movw r1, #0x0000
    movt r1, #0xA804
    str  r1, [r0]

.loop:
    @ Set BR8 field in GPIOF_BSRR, to clear GPIOF9
    movw r1, #0x0000
    movt r1, #0x0200
    str  r1, [r0, #0x18]

    @ Delay
    movw r2, #0x3500
    movt r2, #0x000c
.L1:
    subs r2, #0x0001
    bne .L1

    @ Set BS8 field in GPIOF_BSRR, to set GPIOF9
    movw r1, #0x0200
    str  r1, [r0, #0x18]

    @ Delay
    movw r2, #0x3500
    movt r2, #0x000c
.L2:
    subs r2, #0x0001
    bne .L2

    b .loop

.section .vector_table.reset_vector
.word main
