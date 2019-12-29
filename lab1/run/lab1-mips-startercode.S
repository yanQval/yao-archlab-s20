.data
	.globl	n
	.align	2
n:
	.space	4
	.globl	m
	.align	2
m:
	.space	4
	.globl	img
	.align	2
img:
	.space	500000
	.globl	kernel
	.align	2
kernel:
	.half	0
	.half	1
	.half	0
	.half	1
	.half	2
	.half	1
	.half	0
	.half	1
	.half	0

.text
_printf_num:    # print($4)
    li $v0, 1
	  add $a0, $4, $zero
	  syscall
    j   $31
    nop

_scanf_num: # $4 = read()
    li $v0, 5
	  syscall
	  add $4, $v0, $zero
    j   $31
    nop

_printf_char: # print($4)
    li $v0, 11
    add $a0, $4, $zero
    syscall
    j   $31
    nop

    .globl  main
    .ent    main
main:
    addiu   $sp, $sp, -32
    sw  $31, 28($sp)

	# TODO: There are two samples for outputing. Remove them. 
    # print a '2'
    li  $4, 2
    jal _printf_num
    nop

    # print a '\n'
    li  $4, 10
    jal _printf_char
    nop

    # read n
	  la	$5, n
    jal	_scanf_num
    nop
    sw  $4, 0($5)

    # read m
	  la	$6, m
    jal	_scanf_num
    nop
    sw  $4, 0($6)

    # TODO: Read img[n][m]

    # TODO: Process img[n][m]

    # print n
    la  $6, n
    lw  $4, 0($6)
    jal _printf_num
    nop

    # print <space>
    li  $4, 32
    jal _printf_char
    nop

    # ImgOutput
    # print m
    la  $5, m
    lw  $4, 0($5)
    jal _printf_num
    nop

    # print \n
    li  $4, 10
    jal _printf_char
    nop

    # print img[i][j]
	  la	$5, n
	  la	$6, m
    lw  $17, 0($5)
    lw  $18, 0($6)
    la  $7, img
    move    $16, $0
$PrintImg_External:
    move    $15, $0
$PrintImg_Internal:
    lhu $4, 0($7)
    jal _printf_num
    nop
    li  $4, 32
    jal _printf_char
    nop
    addiu   $7, $7, 2
    addiu   $15, $15, 1
    bne     $18, $15, $PrintImg_Internal
    nop
    li  $4, 10
    jal _printf_char
    nop
    addiu   $16, $16, 1
    bne     $17, $16, $PrintImg_External
    nop

    lw  $31, 28($sp)
    j   $31
    addiu   $sp, $sp, 32
    .end main

