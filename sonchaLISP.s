	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 13, 3	sdk_version 13, 3
	.globl	_findFunctionByName             ; -- Begin function findFunctionByName
	.p2align	2
_findFunctionByName:                    ; @findFunctionByName
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #112
	.cfi_def_cfa_offset 112
	stp	x29, x30, [sp, #96]             ; 16-byte Folded Spill
	add	x29, sp, #96
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	x8, [sp, #8]                    ; 8-byte Folded Spill
	stur	x0, [x29, #-8]
	stur	wzr, [x29, #-12]
	b	LBB0_1
LBB0_1:                                 ; =>This Inner Loop Header: Depth=1
	ldur	w8, [x29, #-12]
	adrp	x9, _allFunctionN@GOTPAGE
	ldr	x9, [x9, _allFunctionN@GOTPAGEOFF]
	ldr	w9, [x9]
	subs	w8, w8, w9
	cset	w8, ge
	tbnz	w8, #0, LBB0_6
	b	LBB0_2
LBB0_2:                                 ;   in Loop: Header=BB0_1 Depth=1
	ldursw	x9, [x29, #-12]
	adrp	x8, _allFunctions@GOTPAGE
	ldr	x8, [x8, _allFunctions@GOTPAGEOFF]
	add	x8, x8, x9, lsl #6
	ldr	x0, [x8, #8]
	ldur	x1, [x29, #-8]
	bl	_strcmp
	subs	w8, w0, #0
	cset	w8, ne
	tbnz	w8, #0, LBB0_4
	b	LBB0_3
LBB0_3:
	ldr	x0, [sp, #8]                    ; 8-byte Folded Reload
	ldursw	x9, [x29, #-12]
	adrp	x8, _allFunctions@GOTPAGE
	ldr	x8, [x8, _allFunctions@GOTPAGEOFF]
	add	x1, x8, x9, lsl #6
	mov	x2, #64
	bl	_memcpy
	b	LBB0_7
LBB0_4:                                 ;   in Loop: Header=BB0_1 Depth=1
	b	LBB0_5
LBB0_5:                                 ;   in Loop: Header=BB0_1 Depth=1
	ldur	w8, [x29, #-12]
	add	w8, w8, #1
	stur	w8, [x29, #-12]
	b	LBB0_1
LBB0_6:
	ldr	x0, [sp, #8]                    ; 8-byte Folded Reload
	add	x1, sp, #16
	mov	w8, #-1
	str	w8, [sp, #16]
	mov	x2, #64
	bl	_memcpy
	b	LBB0_7
LBB0_7:
	ldp	x29, x30, [sp, #96]             ; 16-byte Folded Reload
	add	sp, sp, #112
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_defineStdFunction              ; -- Begin function defineStdFunction
	.p2align	2
_defineStdFunction:                     ; @defineStdFunction
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #128
	.cfi_def_cfa_offset 128
	stp	x29, x30, [sp, #112]            ; 16-byte Folded Spill
	add	x29, sp, #112
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	stur	x1, [x29, #-16]
	stur	x2, [x29, #-24]
	add	x8, sp, #24
	str	x8, [sp, #16]                   ; 8-byte Folded Spill
	str	wzr, [sp, #24]
	ldur	x0, [x29, #-16]
	bl	_strlen
	mov	x8, #1
	str	x8, [sp]                        ; 8-byte Folded Spill
	add	x9, x0, #1
	mul	x0, x8, x9
	bl	_malloc
	str	x0, [sp, #32]
	ldur	x0, [x29, #-24]
	bl	_strlen
	ldr	x8, [sp]                        ; 8-byte Folded Reload
	add	x9, x0, #1
	mul	x0, x8, x9
	bl	_malloc
	str	x0, [sp, #40]
	ldr	x0, [sp, #32]
	ldur	x1, [x29, #-16]
	mov	x2, #-1
	str	x2, [sp, #8]                    ; 8-byte Folded Spill
	bl	___strcpy_chk
	ldr	x2, [sp, #8]                    ; 8-byte Folded Reload
	ldr	x0, [sp, #40]
	ldur	x1, [x29, #-24]
	bl	___strcpy_chk
	ldr	x1, [sp, #16]                   ; 8-byte Folded Reload
	ldur	x8, [x29, #-8]
	str	x8, [sp, #80]
	adrp	x10, _allFunctionN@GOTPAGE
	ldr	x10, [x10, _allFunctionN@GOTPAGEOFF]
	ldrsw	x9, [x10]
	mov	x8, x9
	add	w8, w8, #1
	str	w8, [x10]
	adrp	x8, _allFunctions@GOTPAGE
	ldr	x8, [x8, _allFunctions@GOTPAGEOFF]
	add	x0, x8, x9, lsl #6
	mov	x2, #64
	bl	_memcpy
	ldp	x29, x30, [sp, #112]            ; 16-byte Folded Reload
	add	sp, sp, #128
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_add                            ; -- Begin function add
	.p2align	2
_add:                                   ; @add
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #80
	.cfi_def_cfa_offset 80
	str	x0, [sp, #64]
	str	w1, [sp, #60]
	str	x2, [sp, #48]
	str	wzr, [sp, #44]
	str	wzr, [sp, #40]
	b	LBB2_1
LBB2_1:                                 ; =>This Inner Loop Header: Depth=1
	ldr	w8, [sp, #40]
	ldr	w9, [sp, #60]
	subs	w8, w8, w9
	cset	w8, ge
	tbnz	w8, #0, LBB2_8
	b	LBB2_2
LBB2_2:                                 ;   in Loop: Header=BB2_1 Depth=1
	ldr	x8, [sp, #64]
	ldrsw	x9, [sp, #40]
	mov	x10, #24
	mul	x9, x9, x10
	ldr	w8, [x8, x9]
	subs	w8, w8, #0
	cset	w8, eq
	tbnz	w8, #0, LBB2_4
	b	LBB2_3
LBB2_3:
	ldr	x9, [sp, #48]
	mov	w8, #-1
	str	w8, [x9]
	str	w8, [sp, #76]
	b	LBB2_9
LBB2_4:                                 ;   in Loop: Header=BB2_1 Depth=1
	ldr	x8, [sp, #64]
	ldrsw	x9, [sp, #40]
	mov	x10, #24
	mul	x9, x9, x10
	add	x8, x8, x9
	ldr	x8, [x8, #8]
	ldr	q0, [x8]
	str	q0, [sp, #16]
	ldr	w8, [sp, #16]
	subs	w8, w8, #0
	cset	w8, eq
	tbnz	w8, #0, LBB2_6
	b	LBB2_5
LBB2_5:
	ldr	x9, [sp, #48]
	mov	w8, #-2
	str	w8, [x9]
	mov	w8, #-1
	str	w8, [sp, #76]
	b	LBB2_9
LBB2_6:                                 ;   in Loop: Header=BB2_1 Depth=1
	ldr	w8, [sp, #20]
	str	w8, [sp, #12]
	ldr	w9, [sp, #12]
	ldr	w8, [sp, #44]
	add	w8, w8, w9
	str	w8, [sp, #44]
	b	LBB2_7
LBB2_7:                                 ;   in Loop: Header=BB2_1 Depth=1
	ldr	w8, [sp, #40]
	add	w8, w8, #1
	str	w8, [sp, #40]
	b	LBB2_1
LBB2_8:
	ldr	x8, [sp, #48]
	str	wzr, [x8]
	ldr	w8, [sp, #44]
	str	w8, [sp, #76]
	b	LBB2_9
LBB2_9:
	ldr	w0, [sp, #76]
	add	sp, sp, #80
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_sub                            ; -- Begin function sub
	.p2align	2
_sub:                                   ; @sub
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #80
	.cfi_def_cfa_offset 80
	str	x0, [sp, #64]
	str	w1, [sp, #60]
	str	x2, [sp, #48]
	str	wzr, [sp, #44]
	ldr	w8, [sp, #60]
	subs	w8, w8, #2
	cset	w8, ge
	tbnz	w8, #0, LBB3_2
	b	LBB3_1
LBB3_1:
	ldr	x9, [sp, #48]
	mov	w8, #-1
	str	w8, [x9]
	str	w8, [sp, #76]
	b	LBB3_14
LBB3_2:
	str	wzr, [sp, #40]
	b	LBB3_3
LBB3_3:                                 ; =>This Inner Loop Header: Depth=1
	ldr	w8, [sp, #40]
	ldr	w9, [sp, #60]
	subs	w8, w8, w9
	cset	w8, ge
	tbnz	w8, #0, LBB3_13
	b	LBB3_4
LBB3_4:                                 ;   in Loop: Header=BB3_3 Depth=1
	ldr	x8, [sp, #64]
	ldrsw	x9, [sp, #40]
	mov	x10, #24
	mul	x9, x9, x10
	ldr	w8, [x8, x9]
	subs	w8, w8, #0
	cset	w8, eq
	tbnz	w8, #0, LBB3_6
	b	LBB3_5
LBB3_5:
	ldr	x9, [sp, #48]
	mov	w8, #-1
	str	w8, [x9]
	str	w8, [sp, #76]
	b	LBB3_14
LBB3_6:                                 ;   in Loop: Header=BB3_3 Depth=1
	ldr	x8, [sp, #64]
	ldrsw	x9, [sp, #40]
	mov	x10, #24
	mul	x9, x9, x10
	add	x8, x8, x9
	ldr	x8, [x8, #8]
	ldr	q0, [x8]
	str	q0, [sp, #16]
	ldr	w8, [sp, #16]
	subs	w8, w8, #0
	cset	w8, eq
	tbnz	w8, #0, LBB3_8
	b	LBB3_7
LBB3_7:
	ldr	x9, [sp, #48]
	mov	w8, #-2
	str	w8, [x9]
	mov	w8, #-1
	str	w8, [sp, #76]
	b	LBB3_14
LBB3_8:                                 ;   in Loop: Header=BB3_3 Depth=1
	ldr	w8, [sp, #20]
	str	w8, [sp, #12]
	ldr	w8, [sp, #40]
	subs	w8, w8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB3_10
	b	LBB3_9
LBB3_9:                                 ;   in Loop: Header=BB3_3 Depth=1
	ldr	w9, [sp, #12]
	ldr	w8, [sp, #44]
	add	w8, w8, w9
	str	w8, [sp, #44]
	b	LBB3_11
LBB3_10:                                ;   in Loop: Header=BB3_3 Depth=1
	ldr	w9, [sp, #12]
	ldr	w8, [sp, #44]
	subs	w8, w8, w9
	str	w8, [sp, #44]
	b	LBB3_11
LBB3_11:                                ;   in Loop: Header=BB3_3 Depth=1
	b	LBB3_12
LBB3_12:                                ;   in Loop: Header=BB3_3 Depth=1
	ldr	w8, [sp, #40]
	add	w8, w8, #1
	str	w8, [sp, #40]
	b	LBB3_3
LBB3_13:
	ldr	x8, [sp, #48]
	str	wzr, [x8]
	ldr	w8, [sp, #44]
	str	w8, [sp, #76]
	b	LBB3_14
LBB3_14:
	ldr	w0, [sp, #76]
	add	sp, sp, #80
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_mult                           ; -- Begin function mult
	.p2align	2
_mult:                                  ; @mult
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #80
	.cfi_def_cfa_offset 80
	str	x0, [sp, #64]
	str	w1, [sp, #60]
	str	x2, [sp, #48]
	mov	w8, #1
	str	w8, [sp, #44]
	str	wzr, [sp, #40]
	b	LBB4_1
LBB4_1:                                 ; =>This Inner Loop Header: Depth=1
	ldr	w8, [sp, #40]
	ldr	w9, [sp, #60]
	subs	w8, w8, w9
	cset	w8, ge
	tbnz	w8, #0, LBB4_8
	b	LBB4_2
LBB4_2:                                 ;   in Loop: Header=BB4_1 Depth=1
	ldr	x8, [sp, #64]
	ldrsw	x9, [sp, #40]
	mov	x10, #24
	mul	x9, x9, x10
	ldr	w8, [x8, x9]
	subs	w8, w8, #0
	cset	w8, eq
	tbnz	w8, #0, LBB4_4
	b	LBB4_3
LBB4_3:
	ldr	x9, [sp, #48]
	mov	w8, #-1
	str	w8, [x9]
	str	w8, [sp, #76]
	b	LBB4_9
LBB4_4:                                 ;   in Loop: Header=BB4_1 Depth=1
	ldr	x8, [sp, #64]
	ldrsw	x9, [sp, #40]
	mov	x10, #24
	mul	x9, x9, x10
	add	x8, x8, x9
	ldr	x8, [x8, #8]
	ldr	q0, [x8]
	str	q0, [sp, #16]
	ldr	w8, [sp, #16]
	subs	w8, w8, #0
	cset	w8, eq
	tbnz	w8, #0, LBB4_6
	b	LBB4_5
LBB4_5:
	ldr	x9, [sp, #48]
	mov	w8, #-2
	str	w8, [x9]
	mov	w8, #-1
	str	w8, [sp, #76]
	b	LBB4_9
LBB4_6:                                 ;   in Loop: Header=BB4_1 Depth=1
	ldr	w8, [sp, #20]
	str	w8, [sp, #12]
	ldr	w9, [sp, #12]
	ldr	w8, [sp, #44]
	mul	w8, w8, w9
	str	w8, [sp, #44]
	b	LBB4_7
LBB4_7:                                 ;   in Loop: Header=BB4_1 Depth=1
	ldr	w8, [sp, #40]
	add	w8, w8, #1
	str	w8, [sp, #40]
	b	LBB4_1
LBB4_8:
	ldr	x8, [sp, #48]
	str	wzr, [x8]
	ldr	w8, [sp, #44]
	str	w8, [sp, #76]
	b	LBB4_9
LBB4_9:
	ldr	w0, [sp, #76]
	add	sp, sp, #80
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_divide                         ; -- Begin function divide
	.p2align	2
_divide:                                ; @divide
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #80
	.cfi_def_cfa_offset 80
	str	x0, [sp, #64]
	str	w1, [sp, #60]
	str	x2, [sp, #48]
	mov	w8, #1
	str	w8, [sp, #44]
	ldr	w8, [sp, #60]
	subs	w8, w8, #2
	cset	w8, ge
	tbnz	w8, #0, LBB5_2
	b	LBB5_1
LBB5_1:
	ldr	x9, [sp, #48]
	mov	w8, #-1
	str	w8, [x9]
	str	w8, [sp, #76]
	b	LBB5_14
LBB5_2:
	str	wzr, [sp, #40]
	b	LBB5_3
LBB5_3:                                 ; =>This Inner Loop Header: Depth=1
	ldr	w8, [sp, #40]
	ldr	w9, [sp, #60]
	subs	w8, w8, w9
	cset	w8, ge
	tbnz	w8, #0, LBB5_13
	b	LBB5_4
LBB5_4:                                 ;   in Loop: Header=BB5_3 Depth=1
	ldr	x8, [sp, #64]
	ldrsw	x9, [sp, #40]
	mov	x10, #24
	mul	x9, x9, x10
	ldr	w8, [x8, x9]
	subs	w8, w8, #0
	cset	w8, eq
	tbnz	w8, #0, LBB5_6
	b	LBB5_5
LBB5_5:
	ldr	x9, [sp, #48]
	mov	w8, #-1
	str	w8, [x9]
	str	w8, [sp, #76]
	b	LBB5_14
LBB5_6:                                 ;   in Loop: Header=BB5_3 Depth=1
	ldr	x8, [sp, #64]
	ldrsw	x9, [sp, #40]
	mov	x10, #24
	mul	x9, x9, x10
	add	x8, x8, x9
	ldr	x8, [x8, #8]
	ldr	q0, [x8]
	str	q0, [sp, #16]
	ldr	w8, [sp, #16]
	subs	w8, w8, #0
	cset	w8, eq
	tbnz	w8, #0, LBB5_8
	b	LBB5_7
LBB5_7:
	ldr	x9, [sp, #48]
	mov	w8, #-2
	str	w8, [x9]
	mov	w8, #-1
	str	w8, [sp, #76]
	b	LBB5_14
LBB5_8:                                 ;   in Loop: Header=BB5_3 Depth=1
	ldr	w8, [sp, #20]
	str	w8, [sp, #12]
	ldr	w8, [sp, #40]
	subs	w8, w8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB5_10
	b	LBB5_9
LBB5_9:                                 ;   in Loop: Header=BB5_3 Depth=1
	ldr	w9, [sp, #12]
	ldr	w8, [sp, #44]
	mul	w8, w8, w9
	str	w8, [sp, #44]
	b	LBB5_11
LBB5_10:                                ;   in Loop: Header=BB5_3 Depth=1
	ldr	w9, [sp, #12]
	ldr	w8, [sp, #44]
	sdiv	w8, w8, w9
	str	w8, [sp, #44]
	b	LBB5_11
LBB5_11:                                ;   in Loop: Header=BB5_3 Depth=1
	b	LBB5_12
LBB5_12:                                ;   in Loop: Header=BB5_3 Depth=1
	ldr	w8, [sp, #40]
	add	w8, w8, #1
	str	w8, [sp, #40]
	b	LBB5_3
LBB5_13:
	ldr	x8, [sp, #48]
	str	wzr, [x8]
	ldr	w8, [sp, #44]
	str	w8, [sp, #76]
	b	LBB5_14
LBB5_14:
	ldr	w0, [sp, #76]
	add	sp, sp, #80
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_eq                             ; -- Begin function eq
	.p2align	2
_eq:                                    ; @eq
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #96
	.cfi_def_cfa_offset 96
	str	x0, [sp, #80]
	str	w1, [sp, #76]
	str	x2, [sp, #64]
	ldr	w8, [sp, #76]
	subs	w8, w8, #2
	cset	w8, ge
	tbnz	w8, #0, LBB6_2
	b	LBB6_1
LBB6_1:
	ldr	x9, [sp, #64]
	mov	w8, #-3
	str	w8, [x9]
	mov	w8, #-1
	str	w8, [sp, #92]
	b	LBB6_9
LBB6_2:
	ldr	x8, [sp, #80]
	ldr	w8, [x8]
	subs	w8, w8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB6_4
	b	LBB6_3
LBB6_3:
	ldr	x8, [sp, #80]
	ldr	w8, [x8, #24]
	subs	w8, w8, #0
	cset	w8, eq
	tbnz	w8, #0, LBB6_5
	b	LBB6_4
LBB6_4:
	ldr	x9, [sp, #64]
	mov	w8, #-1
	str	w8, [x9]
	str	w8, [sp, #92]
	b	LBB6_9
LBB6_5:
	ldr	x8, [sp, #80]
	ldr	x8, [x8, #8]
	ldr	q0, [x8]
	str	q0, [sp, #32]
	ldr	x8, [sp, #80]
	ldr	x8, [x8, #32]
	ldr	q0, [x8]
	str	q0, [sp, #16]
	ldr	w8, [sp, #32]
	subs	w8, w8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB6_7
	b	LBB6_6
LBB6_6:
	ldr	w8, [sp, #16]
	subs	w8, w8, #0
	cset	w8, eq
	tbnz	w8, #0, LBB6_8
	b	LBB6_7
LBB6_7:
	ldr	x9, [sp, #64]
	mov	w8, #-2
	str	w8, [x9]
	mov	w8, #-1
	str	w8, [sp, #92]
	b	LBB6_9
LBB6_8:
	ldr	w8, [sp, #36]
	str	w8, [sp, #12]
	ldr	w8, [sp, #20]
	str	w8, [sp, #8]
	ldr	w8, [sp, #12]
	ldr	w9, [sp, #8]
	subs	w8, w8, w9
	cset	w8, eq
	and	w9, w8, #0x1
	mov	w8, #0
	ands	w9, w9, #0x1
	csinc	w8, w8, wzr, eq
	str	w8, [sp, #60]
	ldr	x8, [sp, #64]
	str	wzr, [x8]
	ldr	w8, [sp, #60]
	str	w8, [sp, #92]
	b	LBB6_9
LBB6_9:
	ldr	w0, [sp, #92]
	add	sp, sp, #96
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_cond                           ; -- Begin function cond
	.p2align	2
_cond:                                  ; @cond
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #112
	.cfi_def_cfa_offset 112
	str	x0, [sp, #96]
	str	w1, [sp, #92]
	str	x2, [sp, #80]
	ldr	w8, [sp, #92]
	subs	w8, w8, #3
	cset	w8, ge
	tbnz	w8, #0, LBB7_2
	b	LBB7_1
LBB7_1:
	ldr	x9, [sp, #80]
	mov	w8, #-1
	str	w8, [x9]
	str	w8, [sp, #108]
	b	LBB7_14
LBB7_2:
	ldr	x8, [sp, #96]
	ldr	w8, [x8]
	subs	w8, w8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB7_5
	b	LBB7_3
LBB7_3:
	ldr	x8, [sp, #96]
	ldr	w8, [x8, #24]
	subs	w8, w8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB7_5
	b	LBB7_4
LBB7_4:
	ldr	x8, [sp, #96]
	ldr	w8, [x8, #48]
	subs	w8, w8, #0
	cset	w8, eq
	tbnz	w8, #0, LBB7_6
	b	LBB7_5
LBB7_5:
	ldr	x9, [sp, #80]
	mov	w8, #-1
	str	w8, [x9]
	str	w8, [sp, #108]
	b	LBB7_14
LBB7_6:
	ldr	x8, [sp, #96]
	ldr	x8, [x8, #8]
	ldr	q0, [x8]
	str	q0, [sp, #48]
	ldr	x8, [sp, #96]
	ldr	x8, [x8, #32]
	ldr	q0, [x8]
	str	q0, [sp, #32]
	ldr	x8, [sp, #96]
	ldr	x8, [x8, #56]
	ldr	q0, [x8]
	str	q0, [sp, #16]
	ldr	w8, [sp, #48]
	subs	w8, w8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB7_9
	b	LBB7_7
LBB7_7:
	ldr	w8, [sp, #32]
	subs	w8, w8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB7_9
	b	LBB7_8
LBB7_8:
	ldr	w8, [sp, #16]
	subs	w8, w8, #0
	cset	w8, eq
	tbnz	w8, #0, LBB7_10
	b	LBB7_9
LBB7_9:
	ldr	x9, [sp, #80]
	mov	w8, #-2
	str	w8, [x9]
	mov	w8, #-1
	str	w8, [sp, #108]
	b	LBB7_14
LBB7_10:
	ldr	w8, [sp, #52]
	str	w8, [sp, #12]
	ldr	w8, [sp, #36]
	str	w8, [sp, #8]
	ldr	w8, [sp, #20]
	str	w8, [sp, #4]
	ldr	w8, [sp, #12]
	subs	w8, w8, #1
	cset	w8, ne
	tbnz	w8, #0, LBB7_12
	b	LBB7_11
LBB7_11:
	ldr	w8, [sp, #8]
	str	w8, [sp]                        ; 4-byte Folded Spill
	b	LBB7_13
LBB7_12:
	ldr	w8, [sp, #4]
	str	w8, [sp]                        ; 4-byte Folded Spill
	b	LBB7_13
LBB7_13:
	ldr	w8, [sp]                        ; 4-byte Folded Reload
	str	w8, [sp, #76]
	ldr	x8, [sp, #80]
	str	wzr, [x8]
	ldr	w8, [sp, #76]
	str	w8, [sp, #108]
	b	LBB7_14
LBB7_14:
	ldr	w0, [sp, #108]
	add	sp, sp, #112
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_less                           ; -- Begin function less
	.p2align	2
_less:                                  ; @less
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #96
	.cfi_def_cfa_offset 96
	str	x0, [sp, #80]
	str	w1, [sp, #76]
	str	x2, [sp, #64]
	ldr	w8, [sp, #76]
	subs	w8, w8, #2
	cset	w8, ge
	tbnz	w8, #0, LBB8_2
	b	LBB8_1
LBB8_1:
	ldr	x9, [sp, #64]
	mov	w8, #-1
	str	w8, [x9]
	str	w8, [sp, #92]
	b	LBB8_9
LBB8_2:
	ldr	x8, [sp, #80]
	ldr	w8, [x8]
	subs	w8, w8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB8_4
	b	LBB8_3
LBB8_3:
	ldr	x8, [sp, #80]
	ldr	w8, [x8, #24]
	subs	w8, w8, #0
	cset	w8, eq
	tbnz	w8, #0, LBB8_5
	b	LBB8_4
LBB8_4:
	ldr	x9, [sp, #64]
	mov	w8, #-1
	str	w8, [x9]
	str	w8, [sp, #92]
	b	LBB8_9
LBB8_5:
	ldr	x8, [sp, #80]
	ldr	x8, [x8, #8]
	ldr	q0, [x8]
	str	q0, [sp, #32]
	ldr	x8, [sp, #80]
	ldr	x8, [x8, #32]
	ldr	q0, [x8]
	str	q0, [sp, #16]
	ldr	w8, [sp, #32]
	subs	w8, w8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB8_7
	b	LBB8_6
LBB8_6:
	ldr	w8, [sp, #16]
	subs	w8, w8, #0
	cset	w8, eq
	tbnz	w8, #0, LBB8_8
	b	LBB8_7
LBB8_7:
	ldr	x9, [sp, #64]
	mov	w8, #-2
	str	w8, [x9]
	mov	w8, #-1
	str	w8, [sp, #92]
	b	LBB8_9
LBB8_8:
	ldr	w8, [sp, #36]
	str	w8, [sp, #12]
	ldr	w8, [sp, #20]
	str	w8, [sp, #8]
	ldr	w8, [sp, #12]
	ldr	w9, [sp, #8]
	subs	w8, w8, w9
	cset	w8, lt
	and	w9, w8, #0x1
	mov	w8, #0
	ands	w9, w9, #0x1
	csinc	w8, w8, wzr, eq
	str	w8, [sp, #60]
	ldr	x8, [sp, #64]
	str	wzr, [x8]
	ldr	w8, [sp, #60]
	str	w8, [sp, #92]
	b	LBB8_9
LBB8_9:
	ldr	w0, [sp, #92]
	add	sp, sp, #96
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_greater                        ; -- Begin function greater
	.p2align	2
_greater:                               ; @greater
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #96
	.cfi_def_cfa_offset 96
	str	x0, [sp, #80]
	str	w1, [sp, #76]
	str	x2, [sp, #64]
	ldr	w8, [sp, #76]
	subs	w8, w8, #2
	cset	w8, ge
	tbnz	w8, #0, LBB9_2
	b	LBB9_1
LBB9_1:
	ldr	x9, [sp, #64]
	mov	w8, #-1
	str	w8, [x9]
	str	w8, [sp, #92]
	b	LBB9_9
LBB9_2:
	ldr	x8, [sp, #80]
	ldr	w8, [x8]
	subs	w8, w8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB9_4
	b	LBB9_3
LBB9_3:
	ldr	x8, [sp, #80]
	ldr	w8, [x8, #24]
	subs	w8, w8, #0
	cset	w8, eq
	tbnz	w8, #0, LBB9_5
	b	LBB9_4
LBB9_4:
	ldr	x9, [sp, #64]
	mov	w8, #-1
	str	w8, [x9]
	str	w8, [sp, #92]
	b	LBB9_9
LBB9_5:
	ldr	x8, [sp, #80]
	ldr	x8, [x8, #8]
	ldr	q0, [x8]
	str	q0, [sp, #32]
	ldr	x8, [sp, #80]
	ldr	x8, [x8, #32]
	ldr	q0, [x8]
	str	q0, [sp, #16]
	ldr	w8, [sp, #32]
	subs	w8, w8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB9_7
	b	LBB9_6
LBB9_6:
	ldr	w8, [sp, #16]
	subs	w8, w8, #0
	cset	w8, eq
	tbnz	w8, #0, LBB9_8
	b	LBB9_7
LBB9_7:
	ldr	x9, [sp, #64]
	mov	w8, #-2
	str	w8, [x9]
	mov	w8, #-1
	str	w8, [sp, #92]
	b	LBB9_9
LBB9_8:
	ldr	w8, [sp, #36]
	str	w8, [sp, #12]
	ldr	w8, [sp, #20]
	str	w8, [sp, #8]
	ldr	w8, [sp, #12]
	ldr	w9, [sp, #8]
	subs	w8, w8, w9
	cset	w8, gt
	and	w9, w8, #0x1
	mov	w8, #0
	ands	w9, w9, #0x1
	csinc	w8, w8, wzr, eq
	str	w8, [sp, #60]
	ldr	x8, [sp, #64]
	str	wzr, [x8]
	ldr	w8, [sp, #60]
	str	w8, [sp, #92]
	b	LBB9_9
LBB9_9:
	ldr	w0, [sp, #92]
	add	sp, sp, #96
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_init                           ; -- Begin function init
	.p2align	2
_init:                                  ; @init
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 16
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	adrp	x0, _add@PAGE
	add	x0, x0, _add@PAGEOFF
	adrp	x1, l_.str@PAGE
	add	x1, x1, l_.str@PAGEOFF
	adrp	x2, l_.str.1@PAGE
	add	x2, x2, l_.str.1@PAGEOFF
	bl	_defineStdFunction
	adrp	x0, _sub@PAGE
	add	x0, x0, _sub@PAGEOFF
	adrp	x1, l_.str.2@PAGE
	add	x1, x1, l_.str.2@PAGEOFF
	adrp	x2, l_.str.3@PAGE
	add	x2, x2, l_.str.3@PAGEOFF
	bl	_defineStdFunction
	adrp	x0, _mult@PAGE
	add	x0, x0, _mult@PAGEOFF
	adrp	x1, l_.str.4@PAGE
	add	x1, x1, l_.str.4@PAGEOFF
	adrp	x2, l_.str.5@PAGE
	add	x2, x2, l_.str.5@PAGEOFF
	bl	_defineStdFunction
	adrp	x0, _divide@PAGE
	add	x0, x0, _divide@PAGEOFF
	adrp	x1, l_.str.6@PAGE
	add	x1, x1, l_.str.6@PAGEOFF
	adrp	x2, l_.str.7@PAGE
	add	x2, x2, l_.str.7@PAGEOFF
	bl	_defineStdFunction
	adrp	x0, _eq@PAGE
	add	x0, x0, _eq@PAGEOFF
	adrp	x1, l_.str.8@PAGE
	add	x1, x1, l_.str.8@PAGEOFF
	adrp	x2, l_.str.9@PAGE
	add	x2, x2, l_.str.9@PAGEOFF
	bl	_defineStdFunction
	adrp	x0, _cond@PAGE
	add	x0, x0, _cond@PAGEOFF
	adrp	x1, l_.str.10@PAGE
	add	x1, x1, l_.str.10@PAGEOFF
	adrp	x2, l_.str.11@PAGE
	add	x2, x2, l_.str.11@PAGEOFF
	bl	_defineStdFunction
	adrp	x0, _less@PAGE
	add	x0, x0, _less@PAGEOFF
	adrp	x1, l_.str.12@PAGE
	add	x1, x1, l_.str.12@PAGEOFF
	adrp	x2, l_.str.13@PAGE
	add	x2, x2, l_.str.13@PAGEOFF
	bl	_defineStdFunction
	adrp	x0, _greater@PAGE
	add	x0, x0, _greater@PAGEOFF
	adrp	x1, l_.str.14@PAGE
	add	x1, x1, l_.str.14@PAGEOFF
	adrp	x2, l_.str.15@PAGE
	add	x2, x2, l_.str.15@PAGEOFF
	bl	_defineStdFunction
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_newNumAtom                     ; -- Begin function newNumAtom
	.p2align	2
_newNumAtom:                            ; @newNumAtom
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48
	.cfi_def_cfa_offset 48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	ldur	x0, [x29, #-8]
	bl	_atoi
	stur	w0, [x29, #-12]
	mov	x0, #16
	bl	_malloc
	str	x0, [sp, #8]
	ldr	x8, [sp, #8]
	str	wzr, [x8]
	ldur	w8, [x29, #-12]
	ldr	x9, [sp, #8]
	str	w8, [x9, #4]
	ldr	x8, [sp, #8]
                                        ; kill: def $x9 killed $xzr
	str	xzr, [x8, #8]
	ldr	x0, [sp, #8]
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_newOpAtom                      ; -- Begin function newOpAtom
	.p2align	2
_newOpAtom:                             ; @newOpAtom
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48
	.cfi_def_cfa_offset 48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	ldur	x0, [x29, #-8]
	bl	_strlen
	mov	x8, x0
	stur	w8, [x29, #-12]
	mov	x0, #16
	bl	_malloc
	str	x0, [sp, #8]
	ldr	x9, [sp, #8]
	mov	w8, #1
	str	w8, [x9]
	ldur	w8, [x29, #-12]
	add	w9, w8, #1
                                        ; implicit-def: $x8
	mov	x8, x9
	sxtw	x9, w8
	mov	x8, #1
	mul	x0, x8, x9
	bl	_malloc
	ldr	x8, [sp, #8]
	str	x0, [x8, #8]
	ldr	x8, [sp, #8]
	ldr	x0, [x8, #8]
	ldur	x1, [x29, #-8]
	mov	x2, #-1
	bl	___strcpy_chk
	ldr	x9, [sp, #8]
	mov	w8, #-1
	str	w8, [x9, #4]
	ldr	x0, [sp, #8]
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_newAtomElement                 ; -- Begin function newAtomElement
	.p2align	2
_newAtomElement:                        ; @newAtomElement
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	x0, [sp, #8]
	mov	x0, #24
	bl	_malloc
	str	x0, [sp]
	ldr	x8, [sp]
	str	wzr, [x8]
	ldr	x8, [sp, #8]
	ldr	x9, [sp]
	str	x8, [x9, #8]
	ldr	x8, [sp]
                                        ; kill: def $x9 killed $xzr
	str	xzr, [x8, #16]
	ldr	x0, [sp]
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_newListElement                 ; -- Begin function newListElement
	.p2align	2
_newListElement:                        ; @newListElement
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	x0, [sp, #8]
	mov	x0, #24
	bl	_malloc
	str	x0, [sp]
	ldr	x9, [sp]
	mov	w8, #1
	str	w8, [x9]
	ldr	x8, [sp]
                                        ; kill: def $x9 killed $xzr
	str	xzr, [x8, #8]
	ldr	x8, [sp, #8]
	ldr	x9, [sp]
	str	x8, [x9, #16]
	ldr	x0, [sp]
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_parse                          ; -- Begin function parse
	.p2align	2
_parse:                                 ; @parse
	.cfi_startproc
; %bb.0:
	stp	x28, x27, [sp, #-32]!           ; 16-byte Folded Spill
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w27, -24
	.cfi_offset w28, -32
	mov	w9, #40160
	adrp	x16, ___chkstk_darwin@GOTPAGE
	ldr	x16, [x16, ___chkstk_darwin@GOTPAGEOFF]
	blr	x16
	sub	sp, sp, #9, lsl #12             ; =36864
	sub	sp, sp, #3296
	adrp	x8, ___stack_chk_guard@GOTPAGE
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
	ldr	x8, [x8]
	stur	x8, [x29, #-24]
	str	x0, [sp, #136]
	ldr	x0, [sp, #136]
	mov	x1, #5000
	bl	_strnlen
	mov	x8, x0
	str	w8, [sp, #132]
	ldr	w8, [sp, #132]
	add	w9, w8, #1
                                        ; implicit-def: $x8
	mov	x8, x9
	sxtw	x9, w8
	mov	x8, #1
	mul	x0, x8, x9
	bl	_malloc
	str	x0, [sp, #120]
	ldr	x0, [sp, #120]
	ldr	x1, [sp, #136]
	mov	x2, #-1
	bl	___strcpy_chk
	ldr	x8, [sp, #120]
	ldrsb	w8, [x8]
	subs	w8, w8, #40
	cset	w8, eq
	tbnz	w8, #0, LBB15_2
	b	LBB15_1
LBB15_1:
	adrp	x0, l_.str.16@PAGE
	add	x0, x0, l_.str.16@PAGEOFF
	bl	_printf
                                        ; kill: def $x8 killed $xzr
	str	xzr, [sp, #144]
	b	LBB15_70
LBB15_2:
	ldr	x8, [sp, #120]
	ldr	w9, [sp, #132]
	subs	w9, w9, #1
	ldrsb	w8, [x8, w9, sxtw]
	subs	w8, w8, #10
	cset	w8, ne
	tbnz	w8, #0, LBB15_4
	b	LBB15_3
LBB15_3:
	ldr	w8, [sp, #132]
	subs	w8, w8, #1
	str	w8, [sp, #132]
	b	LBB15_4
LBB15_4:
	ldr	x8, [sp, #120]
	ldr	w9, [sp, #132]
	subs	w9, w9, #1
	ldrsb	w11, [x8, w9, sxtw]
	ldr	x8, [sp, #120]
	ldr	w9, [sp, #132]
	subs	w9, w9, #1
	ldrsb	w10, [x8, w9, sxtw]
	mov	x9, sp
                                        ; implicit-def: $x8
	mov	x8, x11
	str	x8, [x9]
                                        ; implicit-def: $x8
	mov	x8, x10
	str	x8, [x9, #8]
	adrp	x0, l_.str.17@PAGE
	add	x0, x0, l_.str.17@PAGEOFF
	bl	_printf
	ldr	x8, [sp, #120]
	ldr	w9, [sp, #132]
	subs	w9, w9, #1
	ldrsb	w8, [x8, w9, sxtw]
	subs	w8, w8, #41
	cset	w8, ne
	tbnz	w8, #0, LBB15_6
	b	LBB15_5
LBB15_5:
	ldr	w8, [sp, #132]
	subs	w8, w8, #1
	str	w8, [sp, #132]
	b	LBB15_7
LBB15_6:
	adrp	x0, l_.str.18@PAGE
	add	x0, x0, l_.str.18@PAGEOFF
	bl	_printf
                                        ; kill: def $x8 killed $xzr
	str	xzr, [sp, #144]
	b	LBB15_70
LBB15_7:
	ldr	x8, [sp, #120]
	ldrsw	x9, [sp, #132]
	add	x8, x8, x9
	strb	wzr, [x8]
	ldr	x8, [sp, #120]
	add	x8, x8, #1
	str	x8, [sp, #120]
	ldr	x8, [sp, #120]
	mov	x9, sp
	str	x8, [x9]
	adrp	x0, l_.str.19@PAGE
	add	x0, x0, l_.str.19@PAGEOFF
	bl	_printf
	mov	x0, #16
	bl	_malloc
	str	x0, [sp, #112]
	str	wzr, [sp, #108]
	str	wzr, [sp, #104]
	ldr	w8, [sp, #132]
	add	w9, w8, #1
                                        ; implicit-def: $x8
	mov	x8, x9
	sxtw	x1, w8
	mov	x0, #1
	bl	_calloc
	str	x0, [sp, #96]
	ldr	x0, [sp, #120]
	adrp	x1, l_.str.20@PAGE
	add	x1, x1, l_.str.20@PAGEOFF
	bl	_strtok
	str	x0, [sp, #88]
	b	LBB15_8
LBB15_8:                                ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB15_44 Depth 2
                                        ;     Child Loop BB15_30 Depth 2
	ldr	x8, [sp, #88]
	subs	x8, x8, #0
	cset	w8, eq
	tbnz	w8, #0, LBB15_60
	b	LBB15_9
LBB15_9:                                ;   in Loop: Header=BB15_8 Depth=1
	ldr	x0, [sp, #88]
	bl	_strlen
	mov	x8, x0
	str	w8, [sp, #84]
	ldr	w8, [sp, #104]
                                        ; implicit-def: $x10
	mov	x10, x8
	ldr	x8, [sp, #88]
	mov	x9, sp
	str	x10, [x9]
	str	x8, [x9, #8]
	adrp	x0, l_.str.21@PAGE
	add	x0, x0, l_.str.21@PAGEOFF
	bl	_printf
	ldr	x8, [sp, #88]
	ldrsb	w8, [x8]
	subs	w8, w8, #40
	cset	w8, ne
	tbnz	w8, #0, LBB15_17
	b	LBB15_10
LBB15_10:                               ;   in Loop: Header=BB15_8 Depth=1
	ldr	w8, [sp, #104]
	add	w8, w8, #1
	str	w8, [sp, #104]
	ldr	x0, [sp, #96]
	ldr	x1, [sp, #88]
	mov	x2, #-1
	str	x2, [sp, #32]                   ; 8-byte Folded Spill
	bl	___strcat_chk
	ldr	x2, [sp, #32]                   ; 8-byte Folded Reload
	ldr	x0, [sp, #96]
	adrp	x1, l_.str.20@PAGE
	add	x1, x1, l_.str.20@PAGEOFF
	bl	___strcat_chk
	ldr	x8, [sp, #88]
	ldr	w9, [sp, #84]
	subs	w9, w9, #1
	ldrsb	w8, [x8, w9, sxtw]
	subs	w8, w8, #41
	cset	w8, ne
	tbnz	w8, #0, LBB15_16
	b	LBB15_11
LBB15_11:                               ;   in Loop: Header=BB15_8 Depth=1
	ldr	w8, [sp, #104]
	subs	w8, w8, #1
	str	w8, [sp, #104]
	ldr	w8, [sp, #104]
	subs	w8, w8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB15_15
	b	LBB15_12
LBB15_12:                               ;   in Loop: Header=BB15_8 Depth=1
	ldr	x0, [sp, #96]
	bl	_parse
	str	x0, [sp, #72]
	ldr	x8, [sp, #72]
	subs	x8, x8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB15_14
	b	LBB15_13
LBB15_13:
                                        ; kill: def $x8 killed $xzr
	str	xzr, [sp, #144]
	b	LBB15_70
LBB15_14:                               ;   in Loop: Header=BB15_8 Depth=1
	ldr	x0, [sp, #72]
	bl	_newListElement
	ldrsw	x9, [sp, #108]
	mov	x8, x9
	add	w8, w8, #1
	str	w8, [sp, #108]
	add	x8, sp, #152
	str	x0, [x8, x9, lsl #3]
	b	LBB15_15
LBB15_15:                               ;   in Loop: Header=BB15_8 Depth=1
	b	LBB15_16
LBB15_16:                               ;   in Loop: Header=BB15_8 Depth=1
	b	LBB15_59
LBB15_17:                               ;   in Loop: Header=BB15_8 Depth=1
	ldr	x8, [sp, #88]
	ldr	w9, [sp, #84]
	subs	w9, w9, #1
	ldrsb	w8, [x8, w9, sxtw]
	subs	w8, w8, #41
	cset	w8, ne
	tbnz	w8, #0, LBB15_24
	b	LBB15_18
LBB15_18:                               ;   in Loop: Header=BB15_8 Depth=1
	ldr	w8, [sp, #104]
	subs	w8, w8, #1
	str	w8, [sp, #104]
	ldr	x0, [sp, #96]
	ldr	x1, [sp, #88]
	mov	x2, #-1
	bl	___strcat_chk
	ldr	w8, [sp, #104]
	subs	w8, w8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB15_22
	b	LBB15_19
LBB15_19:                               ;   in Loop: Header=BB15_8 Depth=1
	ldr	x8, [sp, #96]
	mov	x9, sp
	str	x8, [x9]
	adrp	x0, l_.str.22@PAGE
	add	x0, x0, l_.str.22@PAGEOFF
	bl	_printf
	ldr	x0, [sp, #96]
	bl	_parse
	str	x0, [sp, #64]
	ldr	x8, [sp, #64]
	subs	x8, x8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB15_21
	b	LBB15_20
LBB15_20:
                                        ; kill: def $x8 killed $xzr
	str	xzr, [sp, #144]
	b	LBB15_70
LBB15_21:                               ;   in Loop: Header=BB15_8 Depth=1
	ldr	x0, [sp, #64]
	bl	_newListElement
	ldrsw	x9, [sp, #108]
	mov	x8, x9
	add	w8, w8, #1
	str	w8, [sp, #108]
	add	x8, sp, #152
	str	x0, [x8, x9, lsl #3]
	b	LBB15_23
LBB15_22:                               ;   in Loop: Header=BB15_8 Depth=1
	ldr	x0, [sp, #96]
	adrp	x1, l_.str.20@PAGE
	add	x1, x1, l_.str.20@PAGEOFF
	mov	x2, #-1
	bl	___strcat_chk
	b	LBB15_23
LBB15_23:                               ;   in Loop: Header=BB15_8 Depth=1
	b	LBB15_58
LBB15_24:                               ;   in Loop: Header=BB15_8 Depth=1
	ldr	w8, [sp, #104]
	subs	w8, w8, #0
	cset	w8, le
	tbnz	w8, #0, LBB15_26
	b	LBB15_25
LBB15_25:                               ;   in Loop: Header=BB15_8 Depth=1
	ldr	x0, [sp, #96]
	ldr	x1, [sp, #88]
	mov	x2, #-1
	str	x2, [sp, #24]                   ; 8-byte Folded Spill
	bl	___strcat_chk
	ldr	x2, [sp, #24]                   ; 8-byte Folded Reload
	ldr	x0, [sp, #96]
	adrp	x1, l_.str.20@PAGE
	add	x1, x1, l_.str.20@PAGEOFF
	bl	___strcat_chk
	b	LBB15_57
LBB15_26:                               ;   in Loop: Header=BB15_8 Depth=1
	ldr	x8, [sp, #88]
	ldrsb	w8, [x8]
	subs	w8, w8, #48
	cset	w8, lt
	tbnz	w8, #0, LBB15_28
	b	LBB15_27
LBB15_27:                               ;   in Loop: Header=BB15_8 Depth=1
	ldr	x8, [sp, #88]
	ldrsb	w8, [x8]
	subs	w8, w8, #57
	cset	w8, le
	tbnz	w8, #0, LBB15_29
	b	LBB15_28
LBB15_28:                               ;   in Loop: Header=BB15_8 Depth=1
	ldr	x8, [sp, #88]
	ldrsb	w8, [x8]
	subs	w8, w8, #45
	cset	w8, ne
	tbnz	w8, #0, LBB15_38
	b	LBB15_29
LBB15_29:                               ;   in Loop: Header=BB15_8 Depth=1
	str	wzr, [sp, #52]
	b	LBB15_30
LBB15_30:                               ;   Parent Loop BB15_8 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	w8, [sp, #52]
	ldr	w9, [sp, #84]
	subs	w8, w8, w9
	cset	w8, ge
	tbnz	w8, #0, LBB15_37
	b	LBB15_31
LBB15_31:                               ;   in Loop: Header=BB15_30 Depth=2
	ldr	x8, [sp, #88]
	ldrsw	x9, [sp, #52]
	ldrsb	w8, [x8, x9]
	subs	w8, w8, #48
	cset	w8, lt
	tbnz	w8, #0, LBB15_33
	b	LBB15_32
LBB15_32:                               ;   in Loop: Header=BB15_30 Depth=2
	ldr	x8, [sp, #88]
	ldrsw	x9, [sp, #52]
	ldrsb	w8, [x8, x9]
	subs	w8, w8, #57
	cset	w8, le
	tbnz	w8, #0, LBB15_35
	b	LBB15_33
LBB15_33:                               ;   in Loop: Header=BB15_30 Depth=2
	ldr	x8, [sp, #88]
	ldrsw	x9, [sp, #52]
	ldrsb	w8, [x8, x9]
	subs	w8, w8, #45
	cset	w8, ne
	tbnz	w8, #0, LBB15_35
	b	LBB15_34
LBB15_34:
	adrp	x0, l_.str.23@PAGE
	add	x0, x0, l_.str.23@PAGEOFF
	bl	_printf
                                        ; kill: def $x8 killed $xzr
	str	xzr, [sp, #144]
	b	LBB15_70
LBB15_35:                               ;   in Loop: Header=BB15_30 Depth=2
	b	LBB15_36
LBB15_36:                               ;   in Loop: Header=BB15_30 Depth=2
	ldr	w8, [sp, #52]
	add	w8, w8, #1
	str	w8, [sp, #52]
	b	LBB15_30
LBB15_37:                               ;   in Loop: Header=BB15_8 Depth=1
	ldr	x0, [sp, #88]
	bl	_newNumAtom
	str	x0, [sp, #56]
	b	LBB15_56
LBB15_38:                               ;   in Loop: Header=BB15_8 Depth=1
	ldr	x8, [sp, #88]
	ldrsb	w8, [x8]
	subs	w8, w8, #97
	cset	w8, lt
	tbnz	w8, #0, LBB15_40
	b	LBB15_39
LBB15_39:                               ;   in Loop: Header=BB15_8 Depth=1
	ldr	x8, [sp, #88]
	ldrsb	w8, [x8]
	subs	w8, w8, #122
	cset	w8, le
	tbnz	w8, #0, LBB15_43
	b	LBB15_40
LBB15_40:                               ;   in Loop: Header=BB15_8 Depth=1
	ldr	x8, [sp, #88]
	ldrsb	w8, [x8]
	subs	w8, w8, #65
	cset	w8, lt
	tbnz	w8, #0, LBB15_42
	b	LBB15_41
LBB15_41:                               ;   in Loop: Header=BB15_8 Depth=1
	ldr	x8, [sp, #88]
	ldrsb	w8, [x8]
	subs	w8, w8, #122
	cset	w8, le
	tbnz	w8, #0, LBB15_43
	b	LBB15_42
LBB15_42:                               ;   in Loop: Header=BB15_8 Depth=1
	ldr	x8, [sp, #88]
	ldrsb	w8, [x8]
	subs	w8, w8, #95
	cset	w8, ne
	tbnz	w8, #0, LBB15_54
	b	LBB15_43
LBB15_43:                               ;   in Loop: Header=BB15_8 Depth=1
	str	wzr, [sp, #48]
	b	LBB15_44
LBB15_44:                               ;   Parent Loop BB15_8 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	ldr	w8, [sp, #48]
	ldr	w9, [sp, #84]
	subs	w8, w8, w9
	cset	w8, ge
	tbnz	w8, #0, LBB15_53
	b	LBB15_45
LBB15_45:                               ;   in Loop: Header=BB15_44 Depth=2
	ldr	x8, [sp, #88]
	ldrsw	x9, [sp, #48]
	ldrsb	w8, [x8, x9]
	subs	w8, w8, #97
	cset	w8, lt
	tbnz	w8, #0, LBB15_47
	b	LBB15_46
LBB15_46:                               ;   in Loop: Header=BB15_44 Depth=2
	ldr	x8, [sp, #88]
	ldrsw	x9, [sp, #48]
	ldrsb	w8, [x8, x9]
	subs	w8, w8, #122
	cset	w8, le
	tbnz	w8, #0, LBB15_51
	b	LBB15_47
LBB15_47:                               ;   in Loop: Header=BB15_44 Depth=2
	ldr	x8, [sp, #88]
	ldrsw	x9, [sp, #48]
	ldrsb	w8, [x8, x9]
	subs	w8, w8, #65
	cset	w8, lt
	tbnz	w8, #0, LBB15_49
	b	LBB15_48
LBB15_48:                               ;   in Loop: Header=BB15_44 Depth=2
	ldr	x8, [sp, #88]
	ldrsw	x9, [sp, #48]
	ldrsb	w8, [x8, x9]
	subs	w8, w8, #122
	cset	w8, le
	tbnz	w8, #0, LBB15_51
	b	LBB15_49
LBB15_49:                               ;   in Loop: Header=BB15_44 Depth=2
	ldr	x8, [sp, #88]
	ldrsw	x9, [sp, #48]
	ldrsb	w8, [x8, x9]
	subs	w8, w8, #95
	cset	w8, eq
	tbnz	w8, #0, LBB15_51
	b	LBB15_50
LBB15_50:
	adrp	x0, l_.str.24@PAGE
	add	x0, x0, l_.str.24@PAGEOFF
	bl	_printf
                                        ; kill: def $x8 killed $xzr
	str	xzr, [sp, #144]
	b	LBB15_70
LBB15_51:                               ;   in Loop: Header=BB15_44 Depth=2
	b	LBB15_52
LBB15_52:                               ;   in Loop: Header=BB15_44 Depth=2
	ldr	w8, [sp, #48]
	add	w8, w8, #1
	str	w8, [sp, #48]
	b	LBB15_44
LBB15_53:                               ;   in Loop: Header=BB15_8 Depth=1
	ldr	x0, [sp, #88]
	bl	_newOpAtom
	str	x0, [sp, #56]
	b	LBB15_55
LBB15_54:
	adrp	x0, l_.str.25@PAGE
	add	x0, x0, l_.str.25@PAGEOFF
	bl	_printf
                                        ; kill: def $x8 killed $xzr
	str	xzr, [sp, #144]
	b	LBB15_70
LBB15_55:                               ;   in Loop: Header=BB15_8 Depth=1
	b	LBB15_56
LBB15_56:                               ;   in Loop: Header=BB15_8 Depth=1
	ldr	x0, [sp, #56]
	bl	_newAtomElement
	ldrsw	x9, [sp, #108]
	mov	x8, x9
	add	w8, w8, #1
	str	w8, [sp, #108]
	add	x8, sp, #152
	str	x0, [x8, x9, lsl #3]
	b	LBB15_57
LBB15_57:                               ;   in Loop: Header=BB15_8 Depth=1
	b	LBB15_58
LBB15_58:                               ;   in Loop: Header=BB15_8 Depth=1
	b	LBB15_59
LBB15_59:                               ;   in Loop: Header=BB15_8 Depth=1
	mov	x0, #0
	adrp	x1, l_.str.20@PAGE
	add	x1, x1, l_.str.20@PAGEOFF
	bl	_strtok
	str	x0, [sp, #88]
	b	LBB15_8
LBB15_60:
	ldr	x8, [sp, #88]
	subs	x8, x8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB15_62
	b	LBB15_61
LBB15_61:
	adrp	x0, l_.str.26@PAGE
	add	x0, x0, l_.str.26@PAGEOFF
	bl	_printf
	b	LBB15_63
LBB15_62:
	ldr	x8, [sp, #88]
	mov	x9, sp
	str	x8, [x9]
	adrp	x0, l_.str.27@PAGE
	add	x0, x0, l_.str.27@PAGEOFF
	bl	_printf
	b	LBB15_63
LBB15_63:
	ldr	w8, [sp, #104]
	subs	w8, w8, #0
	cset	w8, le
	tbnz	w8, #0, LBB15_65
	b	LBB15_64
LBB15_64:
	adrp	x0, l_.str.28@PAGE
	add	x0, x0, l_.str.28@PAGEOFF
	bl	_printf
                                        ; kill: def $x8 killed $xzr
	str	xzr, [sp, #144]
	b	LBB15_70
LBB15_65:
	mov	x0, #16
	bl	_malloc
	str	x0, [sp, #112]
	ldr	w8, [sp, #108]
	ldr	x9, [sp, #112]
	str	w8, [x9]
	ldrsw	x9, [sp, #108]
	mov	x8, #8
	mul	x0, x8, x9
	bl	_malloc
	ldr	x8, [sp, #112]
	str	x0, [x8, #8]
	str	wzr, [sp, #44]
	b	LBB15_66
LBB15_66:                               ; =>This Inner Loop Header: Depth=1
	ldr	w8, [sp, #44]
	ldr	w9, [sp, #108]
	subs	w8, w8, w9
	cset	w8, ge
	tbnz	w8, #0, LBB15_69
	b	LBB15_67
LBB15_67:                               ;   in Loop: Header=BB15_66 Depth=1
	ldrsw	x9, [sp, #44]
	add	x8, sp, #152
	ldr	x8, [x8, x9, lsl #3]
	ldr	x9, [sp, #112]
	ldr	x9, [x9, #8]
	ldrsw	x10, [sp, #44]
	str	x8, [x9, x10, lsl #3]
	b	LBB15_68
LBB15_68:                               ;   in Loop: Header=BB15_66 Depth=1
	ldr	w8, [sp, #44]
	add	w8, w8, #1
	str	w8, [sp, #44]
	b	LBB15_66
LBB15_69:
	ldr	x8, [sp, #112]
	str	x8, [sp, #144]
	b	LBB15_70
LBB15_70:
	ldr	x8, [sp, #144]
	str	x8, [sp, #16]                   ; 8-byte Folded Spill
	ldur	x9, [x29, #-24]
	adrp	x8, ___stack_chk_guard@GOTPAGE
	ldr	x8, [x8, ___stack_chk_guard@GOTPAGEOFF]
	ldr	x8, [x8]
	subs	x8, x8, x9
	cset	w8, eq
	tbnz	w8, #0, LBB15_72
	b	LBB15_71
LBB15_71:
	bl	___stack_chk_fail
LBB15_72:
	ldr	x0, [sp, #16]                   ; 8-byte Folded Reload
	add	sp, sp, #9, lsl #12             ; =36864
	add	sp, sp, #3296
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #32             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_evalSExpression                ; -- Begin function evalSExpression
	.p2align	2
_evalSExpression:                       ; @evalSExpression
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #240
	.cfi_def_cfa_offset 240
	stp	x29, x30, [sp, #224]            ; 16-byte Folded Spill
	add	x29, sp, #224
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-24]
	stur	x1, [x29, #-16]
	stur	x2, [x29, #-32]
	adrp	x0, l_.str.29@PAGE
	add	x0, x0, l_.str.29@PAGEOFF
	bl	_printf
	ldur	x0, [x29, #-24]
	ldur	x1, [x29, #-16]
	bl	_printList
	adrp	x0, l_.str.30@PAGE
	add	x0, x0, l_.str.30@PAGEOFF
	bl	_printf
	ldur	w8, [x29, #-24]
	subs	w8, w8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB16_2
	b	LBB16_1
LBB16_1:
	stur	wzr, [x29, #-4]
	b	LBB16_20
LBB16_2:
	ldur	x8, [x29, #-16]
	ldr	x8, [x8]
	ldr	q0, [x8]
	stur	q0, [x29, #-64]
	ldr	x8, [x8, #16]
	stur	x8, [x29, #-48]
	ldur	w8, [x29, #-64]
	subs	w8, w8, #1
	cset	w8, eq
	tbnz	w8, #0, LBB16_6
	b	LBB16_3
LBB16_3:
	ldur	x8, [x29, #-56]
	ldr	w8, [x8]
	subs	w8, w8, #1
	cset	w8, eq
	tbnz	w8, #0, LBB16_5
	b	LBB16_4
LBB16_4:
	adrp	x0, l_.str.31@PAGE
	add	x0, x0, l_.str.31@PAGEOFF
	bl	_printf
	ldur	x9, [x29, #-32]
	mov	w8, #-1
	str	w8, [x9]
	stur	w8, [x29, #-4]
	b	LBB16_20
LBB16_5:
	b	LBB16_6
LBB16_6:
	ldur	x8, [x29, #-56]
	ldr	x0, [x8, #8]
	add	x8, sp, #96
	bl	_findFunctionByName
	ldr	w8, [sp, #96]
	adds	w8, w8, #1
	cset	w8, ne
	tbnz	w8, #0, LBB16_8
	b	LBB16_7
LBB16_7:
	ldur	x8, [x29, #-56]
	ldr	x8, [x8, #8]
	mov	x9, sp
	str	x8, [x9]
	adrp	x0, l_.str.32@PAGE
	add	x0, x0, l_.str.32@PAGEOFF
	bl	_printf
	ldur	x9, [x29, #-32]
	mov	w8, #-2
	str	w8, [x9]
	mov	w8, #-1
	stur	w8, [x29, #-4]
	b	LBB16_20
LBB16_8:
	ldur	w8, [x29, #-24]
	subs	w8, w8, #1
	str	w8, [sp, #92]
	ldrsw	x9, [sp, #92]
	mov	x8, #24
	mul	x0, x8, x9
	bl	_malloc
	str	x0, [sp, #80]
	str	wzr, [sp, #76]
	b	LBB16_9
LBB16_9:                                ; =>This Inner Loop Header: Depth=1
	ldr	w8, [sp, #76]
	ldr	w9, [sp, #92]
	subs	w8, w8, w9
	cset	w8, ge
	tbnz	w8, #0, LBB16_17
	b	LBB16_10
LBB16_10:                               ;   in Loop: Header=BB16_9 Depth=1
	ldur	x8, [x29, #-16]
	ldr	w9, [sp, #76]
	add	w9, w9, #1
	ldr	x8, [x8, w9, sxtw #3]
	ldr	q0, [x8]
	str	q0, [sp, #48]
	ldr	x8, [x8, #16]
	str	x8, [sp, #64]
	ldr	w8, [sp, #48]
	subs	w8, w8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB16_12
	b	LBB16_11
LBB16_11:                               ;   in Loop: Header=BB16_9 Depth=1
	ldr	x8, [sp, #80]
	ldrsw	x9, [sp, #76]
	mov	x10, #24
	mul	x9, x9, x10
	add	x9, x8, x9
	ldr	q0, [sp, #48]
	str	q0, [x9]
	ldr	x8, [sp, #64]
	str	x8, [x9, #16]
	b	LBB16_15
LBB16_12:                               ;   in Loop: Header=BB16_9 Depth=1
	ldr	x8, [sp, #64]
	ldur	x2, [x29, #-32]
	ldr	x0, [x8]
	ldr	x1, [x8, #8]
	bl	_evalSExpression
	str	w0, [sp, #44]
	ldur	x8, [x29, #-32]
	ldr	w8, [x8]
	subs	w8, w8, #0
	cset	w8, eq
	tbnz	w8, #0, LBB16_14
	b	LBB16_13
LBB16_13:
	mov	w8, #-1
	stur	w8, [x29, #-4]
	b	LBB16_20
LBB16_14:                               ;   in Loop: Header=BB16_9 Depth=1
	ldr	x9, [sp, #80]
	ldrsw	x8, [sp, #76]
	mov	x10, #24
	str	x10, [sp, #16]                  ; 8-byte Folded Spill
	mul	x10, x8, x10
	mov	w8, #0
	str	w8, [x9, x10]
	mov	x0, #16
	bl	_malloc
	ldr	x11, [sp, #16]                  ; 8-byte Folded Reload
	ldr	x8, [sp, #80]
	ldrsw	x9, [sp, #76]
	mul	x9, x9, x11
	add	x8, x8, x9
	str	x0, [x8, #8]
	ldr	x8, [sp, #80]
	ldrsw	x9, [sp, #76]
	mul	x9, x9, x11
	add	x8, x8, x9
	ldr	x8, [x8, #8]
	str	wzr, [x8]
	ldr	w8, [sp, #44]
	ldr	x9, [sp, #80]
	ldrsw	x10, [sp, #76]
	mul	x10, x10, x11
	add	x9, x9, x10
	ldr	x9, [x9, #8]
	str	w8, [x9, #4]
	ldr	w9, [sp, #44]
                                        ; implicit-def: $x8
	mov	x8, x9
	mov	x9, sp
	str	x8, [x9]
	adrp	x0, l_.str.33@PAGE
	add	x0, x0, l_.str.33@PAGEOFF
	bl	_printf
	b	LBB16_15
LBB16_15:                               ;   in Loop: Header=BB16_9 Depth=1
	b	LBB16_16
LBB16_16:                               ;   in Loop: Header=BB16_9 Depth=1
	ldr	w8, [sp, #76]
	add	w8, w8, #1
	str	w8, [sp, #76]
	b	LBB16_9
LBB16_17:
	add	x2, sp, #36
	str	wzr, [sp, #36]
	ldr	x8, [sp, #152]
	str	x8, [sp, #24]
	ldr	x8, [sp, #24]
	ldr	x0, [sp, #80]
	ldr	w1, [sp, #92]
	blr	x8
	str	w0, [sp, #40]
	ldr	w8, [sp, #36]
	subs	w8, w8, #0
	cset	w8, eq
	tbnz	w8, #0, LBB16_19
	b	LBB16_18
LBB16_18:
	ldr	x8, [sp, #104]
	mov	x9, sp
	str	x8, [x9]
	adrp	x0, l_.str.34@PAGE
	add	x0, x0, l_.str.34@PAGEOFF
	bl	_printf
	ldr	w8, [sp, #36]
	ldur	x9, [x29, #-32]
	str	w8, [x9]
	mov	w8, #-1
	stur	w8, [x29, #-4]
	b	LBB16_20
LBB16_19:
	ldr	x0, [sp, #80]
	bl	_free
	ldr	w8, [sp, #40]
	stur	w8, [x29, #-4]
	b	LBB16_20
LBB16_20:
	ldur	w0, [x29, #-4]
	ldp	x29, x30, [sp, #224]            ; 16-byte Folded Reload
	add	sp, sp, #240
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_printList                      ; -- Begin function printList
	.p2align	2
_printList:                             ; @printList
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #64
	.cfi_def_cfa_offset 64
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-16]
	stur	x1, [x29, #-8]
	adrp	x0, l_.str.37@PAGE
	add	x0, x0, l_.str.37@PAGEOFF
	bl	_printf
	stur	wzr, [x29, #-20]
	b	LBB17_1
LBB17_1:                                ; =>This Inner Loop Header: Depth=1
	ldur	w8, [x29, #-20]
	ldur	w9, [x29, #-16]
	subs	w8, w8, w9
	cset	w8, ge
	tbnz	w8, #0, LBB17_6
	b	LBB17_2
LBB17_2:                                ;   in Loop: Header=BB17_1 Depth=1
	ldur	x8, [x29, #-8]
	ldursw	x9, [x29, #-20]
	ldr	x8, [x8, x9, lsl #3]
	ldr	q0, [x8]
	mov	x0, sp
	str	q0, [sp]
	ldr	x8, [x8, #16]
	str	x8, [sp, #16]
	bl	_printElem
	ldur	w8, [x29, #-20]
	ldur	w9, [x29, #-16]
	subs	w9, w9, #1
	subs	w8, w8, w9
	cset	w8, ge
	tbnz	w8, #0, LBB17_4
	b	LBB17_3
LBB17_3:                                ;   in Loop: Header=BB17_1 Depth=1
	adrp	x0, l_.str.20@PAGE
	add	x0, x0, l_.str.20@PAGEOFF
	bl	_printf
	b	LBB17_4
LBB17_4:                                ;   in Loop: Header=BB17_1 Depth=1
	b	LBB17_5
LBB17_5:                                ;   in Loop: Header=BB17_1 Depth=1
	ldur	w8, [x29, #-20]
	add	w8, w8, #1
	stur	w8, [x29, #-20]
	b	LBB17_1
LBB17_6:
	adrp	x0, l_.str.38@PAGE
	add	x0, x0, l_.str.38@PAGEOFF
	bl	_printf
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	add	sp, sp, #64
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_printAtom                      ; -- Begin function printAtom
	.p2align	2
_printAtom:                             ; @printAtom
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48
	.cfi_def_cfa_offset 48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	x0, [sp, #16]
	str	x1, [sp, #24]
	ldr	w8, [sp, #16]
	subs	w8, w8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB18_2
	b	LBB18_1
LBB18_1:
	ldr	w9, [sp, #20]
                                        ; implicit-def: $x8
	mov	x8, x9
	mov	x9, sp
	str	x8, [x9]
	adrp	x0, l_.str.35@PAGE
	add	x0, x0, l_.str.35@PAGEOFF
	bl	_printf
	b	LBB18_3
LBB18_2:
	ldr	x8, [sp, #24]
	mov	x9, sp
	str	x8, [x9]
	adrp	x0, l_.str.36@PAGE
	add	x0, x0, l_.str.36@PAGEOFF
	bl	_printf
	b	LBB18_3
LBB18_3:
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_printElem                      ; -- Begin function printElem
	.p2align	2
_printElem:                             ; @printElem
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	x0, [sp, #8]                    ; 8-byte Folded Spill
	ldr	w8, [x0]
	subs	w8, w8, #0
	cset	w8, ne
	tbnz	w8, #0, LBB19_2
	b	LBB19_1
LBB19_1:
	ldr	x8, [sp, #8]                    ; 8-byte Folded Reload
	ldr	x8, [x8, #8]
	ldr	x0, [x8]
	ldr	x1, [x8, #8]
	bl	_printAtom
	b	LBB19_3
LBB19_2:
	ldr	x8, [sp, #8]                    ; 8-byte Folded Reload
	ldr	x8, [x8, #16]
	ldr	x0, [x8]
	ldr	x1, [x8, #8]
	bl	_printList
	b	LBB19_3
LBB19_3:
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	_main                           ; -- Begin function main
	.p2align	2
_main:                                  ; @main
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #112
	.cfi_def_cfa_offset 112
	stp	x29, x30, [sp, #96]             ; 16-byte Folded Spill
	add	x29, sp, #96
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	mov	w8, #0
	str	w8, [sp, #36]                   ; 4-byte Folded Spill
	stur	wzr, [x29, #-4]
	stur	w0, [x29, #-8]
	stur	x1, [x29, #-16]
	bl	_init
	sub	x8, x29, #40
	str	x8, [sp, #16]                   ; 8-byte Folded Spill
	mov	x8, #5000
	stur	x8, [x29, #-40]
	ldur	x9, [x29, #-40]
	mov	x8, #1
	mul	x0, x8, x9
	bl	_malloc
	sub	x8, x29, #32
	str	x8, [sp, #24]                   ; 8-byte Folded Spill
	stur	x0, [x29, #-32]
	adrp	x0, l_.str.39@PAGE
	add	x0, x0, l_.str.39@PAGEOFF
	bl	_printf
	ldr	x1, [sp, #16]                   ; 8-byte Folded Reload
	ldr	x0, [sp, #24]                   ; 8-byte Folded Reload
	adrp	x8, ___stdinp@GOTPAGE
	ldr	x8, [x8, ___stdinp@GOTPAGEOFF]
	ldr	x2, [x8]
	bl	_getline
	str	x0, [sp, #48]
	ldur	x8, [x29, #-32]
	mov	x9, sp
	str	x8, [x9]
	adrp	x0, l_.str.40@PAGE
	add	x0, x0, l_.str.40@PAGEOFF
	bl	_printf
	ldur	x0, [x29, #-32]
	bl	_parse
	stur	x0, [x29, #-24]
	adrp	x0, l_.str.41@PAGE
	add	x0, x0, l_.str.41@PAGEOFF
	bl	_printf
	ldur	x8, [x29, #-24]
	ldr	x0, [x8]
	ldr	x1, [x8, #8]
	bl	_printList
	adrp	x0, l_.str.30@PAGE
	add	x0, x0, l_.str.30@PAGEOFF
	bl	_printf
	add	x2, sp, #44
	str	wzr, [sp, #44]
	ldur	x8, [x29, #-24]
	ldr	x0, [x8]
	ldr	x1, [x8, #8]
	bl	_evalSExpression
	str	w0, [sp, #40]
	ldr	w8, [sp, #40]
                                        ; implicit-def: $x10
	mov	x10, x8
	ldr	w9, [sp, #44]
                                        ; implicit-def: $x8
	mov	x8, x9
	mov	x9, sp
	str	x10, [x9]
	str	x8, [x9, #8]
	adrp	x0, l_.str.42@PAGE
	add	x0, x0, l_.str.42@PAGEOFF
	bl	_printf
	ldr	w0, [sp, #36]                   ; 4-byte Folded Reload
	ldp	x29, x30, [sp, #96]             ; 16-byte Folded Reload
	add	sp, sp, #112
	ret
	.cfi_endproc
                                        ; -- End function
	.comm	_allFunctionN,4,2               ; @allFunctionN
	.comm	_allFunctions,32000,3           ; @allFunctions
	.section	__TEXT,__cstring,cstring_literals
l_.str:                                 ; @.str
	.asciz	"add"

l_.str.1:                               ; @.str.1
	.asciz	"Add multiple arguments"

l_.str.2:                               ; @.str.2
	.asciz	"sub"

l_.str.3:                               ; @.str.3
	.asciz	"Subtract the 2nd argument and after from the 1st argument"

l_.str.4:                               ; @.str.4
	.asciz	"mult"

l_.str.5:                               ; @.str.5
	.asciz	"Multiply the arguments"

l_.str.6:                               ; @.str.6
	.asciz	"div"

l_.str.7:                               ; @.str.7
	.asciz	"Divide the 1st argument by each consecutive arguments"

l_.str.8:                               ; @.str.8
	.asciz	"eq"

l_.str.9:                               ; @.str.9
	.asciz	"Return 1 if argument 1 and argument 2 is the same value. Return 0 if not."

l_.str.10:                              ; @.str.10
	.asciz	"cond"

l_.str.11:                              ; @.str.11
	.asciz	"Return the 2nd argument if argument 1 and argument 2 is the same value. Return 0 if not."

l_.str.12:                              ; @.str.12
	.asciz	"less"

l_.str.13:                              ; @.str.13
	.asciz	"Return 1 if argument 1 is less than argument 2"

l_.str.14:                              ; @.str.14
	.asciz	"greater"

l_.str.15:                              ; @.str.15
	.asciz	"Return 1 if argument 1 is greater than argument 2"

l_.str.16:                              ; @.str.16
	.asciz	"Parse Error! Expression does not begin with an opening parenthesis '('\n"

l_.str.17:                              ; @.str.17
	.asciz	"lastCharacter: %c %d \n"

l_.str.18:                              ; @.str.18
	.asciz	"Parse Error! Expression does not end with a closing parenthesis ')'\n"

l_.str.19:                              ; @.str.19
	.asciz	"expStrCopy: %s\n"

l_.str.20:                              ; @.str.20
	.asciz	" "

l_.str.21:                              ; @.str.21
	.asciz	"parenthesisDepth: %d    token: %s\n"

l_.str.22:                              ; @.str.22
	.asciz	"Nested List, sending %s!\n"

l_.str.23:                              ; @.str.23
	.asciz	"Parsing Error! Integer Tokens cannot have non-number characters!\n"

l_.str.24:                              ; @.str.24
	.asciz	"Parsing Error! Functions or Variable Names can only have alphabet([a-zA-Z]) or underscore('_')!\n"

l_.str.25:                              ; @.str.25
	.asciz	"Parsing Error! Unrecognized Character!\n"

l_.str.26:                              ; @.str.26
	.asciz	"token is NULL!\n"

l_.str.27:                              ; @.str.27
	.asciz	"token is \"%s\"\n"

l_.str.28:                              ; @.str.28
	.asciz	"Parsing Error! Unclosed Parenthesis!\n"

l_.str.29:                              ; @.str.29
	.asciz	"Evaluating List :"

l_.str.30:                              ; @.str.30
	.asciz	"\n"

l_.str.31:                              ; @.str.31
	.asciz	"Eval Error! The first element of the S-Expression is not a function/operator!\n"

l_.str.32:                              ; @.str.32
	.asciz	"Eval Error! The first element of the S-Expression is not recognized! Keyword: %s\n"

l_.str.33:                              ; @.str.33
	.asciz	"subExpVal: %d\n"

l_.str.34:                              ; @.str.34
	.asciz	"Eval Error! Error while running function %s!\n"

l_.str.35:                              ; @.str.35
	.asciz	"%d<I>"

l_.str.36:                              ; @.str.36
	.asciz	"%s<K>"

l_.str.37:                              ; @.str.37
	.asciz	"("

l_.str.38:                              ; @.str.38
	.asciz	")<L>"

l_.str.39:                              ; @.str.39
	.asciz	"Input LISP Expression: "

l_.str.40:                              ; @.str.40
	.asciz	"parsing test expression: %s\n"

l_.str.41:                              ; @.str.41
	.asciz	"Running Print List!\n"

l_.str.42:                              ; @.str.42
	.asciz	"evalResult: %d    signal:%d\n"

.subsections_via_symbols
