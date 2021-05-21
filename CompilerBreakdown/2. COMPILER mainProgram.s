	.arch armv6
	.eabi_attribute 28, 1
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 6
	.eabi_attribute 34, 1
	.eabi_attribute 18, 4
	.file	"mainProgram.c"
	.text
	.section	.rodata
	.align	2
.LC0:
	.ascii	"Program is starting ... \000"
	.align	2
.LC1:
	.ascii	"Using pin%d\012\000"
	.align	2
.LC2:
	.ascii	"led turned on >>>\000"
	.align	2
.LC3:
	.ascii	"led turned off <<<\000"
	.text
	.align	2
	.global	blink
	.arch armv6
	.syntax unified
	.arm
	.fpu vfp
	.type	blink, %function
blink:
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	ldr	r0, .L3
	bl	puts
	mov	r1, #1
	mov	r0, #3
	bl	pinMode
	mov	r1, #3
	ldr	r0, .L3+4
	bl	printf
.L2:
	mov	r1, #1
	mov	r0, #3
	bl	digitalWrite
	ldr	r0, .L3+8
	bl	puts
	mov	r0, #1000
	bl	delay
	mov	r1, #0
	mov	r0, #3
	bl	digitalWrite
	ldr	r0, .L3+12
	bl	puts
	mov	r0, #1000
	bl	delay
	b	.L2
.L4:
	.align	2
.L3:
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.size	blink, .-blink
	.global	pcf8574_address
	.data
	.align	2
	.type	pcf8574_address, %object
	.size	pcf8574_address, 4
pcf8574_address:
	.word	39
	.comm	lcdhd,4,4
	.section	.rodata
	.align	2
.LC4:
	.ascii	"r\000"
	.align	2
.LC5:
	.ascii	"/sys/class/thermal/thermal_zone0/temp\000"
	.align	2
.LC6:
	.ascii	"CPU's temperature : %.2f \012\000"
	.align	2
.LC7:
	.ascii	"CPU:%.2fC\000"
	.text
	.align	2
	.global	printCPUTemperature
	.syntax unified
	.arm
	.fpu vfp
	.type	printCPUTemperature, %function
printCPUTemperature:
	@ args = 0, pretend = 0, frame = 24
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #24
	ldr	r1, .L6+8
	ldr	r0, .L6+12
	bl	fopen
	str	r0, [fp, #-8]
	sub	r3, fp, #28
	ldr	r2, [fp, #-8]
	mov	r1, #15
	mov	r0, r3
	bl	fgets
	sub	r3, fp, #28
	mov	r0, r3
	bl	atof
	vmov.f64	d5, d0
	vldr.64	d6, .L6
	vdiv.f64	d7, d5, d6
	vcvt.f32.f64	s15, d7
	vstr.32	s15, [fp, #-12]
	vldr.32	s15, [fp, #-12]
	vcvt.f64.f32	d7, s15
	vmov	r2, r3, d7
	ldr	r0, .L6+16
	bl	printf
	ldr	r3, .L6+20
	ldr	r3, [r3]
	mov	r2, #0
	mov	r1, #0
	mov	r0, r3
	bl	lcdPosition
	ldr	r3, .L6+20
	ldr	r0, [r3]
	vldr.32	s15, [fp, #-12]
	vcvt.f64.f32	d7, s15
	vmov	r2, r3, d7
	ldr	r1, .L6+24
	bl	lcdPrintf
	ldr	r0, [fp, #-8]
	bl	fclose
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L7:
	.align	3
.L6:
	.word	0
	.word	1083129856
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.word	lcdhd
	.word	.LC7
	.size	printCPUTemperature, .-printCPUTemperature
	.section	.rodata
	.align	2
.LC8:
	.ascii	"%s \012\000"
	.align	2
.LC9:
	.ascii	"Time:%02d:%02d:%02d\000"
	.text
	.align	2
	.global	printDataTime
	.syntax unified
	.arm
	.fpu vfp
	.type	printDataTime, %function
printDataTime:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	sub	r3, fp, #12
	mov	r0, r3
	bl	time
	sub	r3, fp, #12
	mov	r0, r3
	bl	localtime
	str	r0, [fp, #-8]
	ldr	r0, [fp, #-8]
	bl	asctime
	mov	r3, r0
	mov	r1, r3
	ldr	r0, .L9
	bl	printf
	ldr	r3, .L9+4
	ldr	r3, [r3]
	mov	r2, #1
	mov	r1, #0
	mov	r0, r3
	bl	lcdPosition
	ldr	r3, .L9+4
	ldr	r0, [r3]
	ldr	r3, [fp, #-8]
	ldr	r2, [r3, #8]
	ldr	r3, [fp, #-8]
	ldr	r1, [r3, #4]
	ldr	r3, [fp, #-8]
	ldr	r3, [r3]
	str	r3, [sp]
	mov	r3, r1
	ldr	r1, .L9+8
	bl	lcdPrintf
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L10:
	.align	2
.L9:
	.word	.LC8
	.word	lcdhd
	.word	.LC9
	.size	printDataTime, .-printDataTime
	.section	.rodata
	.align	2
.LC10:
	.ascii	"Error address : 0x%x \012\000"
	.align	2
.LC11:
	.ascii	"Not found device in address 0x%x \012\000"
	.align	2
.LC12:
	.ascii	"Found device in address 0x%x \012\000"
	.text
	.align	2
	.global	detectI2C
	.syntax unified
	.arm
	.fpu vfp
	.type	detectI2C, %function
detectI2C:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	str	r0, [fp, #-16]
	ldr	r0, [fp, #-16]
	bl	wiringPiI2CSetup
	str	r0, [fp, #-8]
	ldr	r3, [fp, #-8]
	cmp	r3, #0
	bge	.L12
	ldr	r1, [fp, #-16]
	ldr	r0, .L15
	bl	printf
	mov	r3, #0
	b	.L13
.L12:
	mov	r1, #0
	ldr	r0, [fp, #-8]
	bl	wiringPiI2CWrite
	mov	r3, r0
	cmp	r3, #0
	bge	.L14
	ldr	r1, [fp, #-16]
	ldr	r0, .L15+4
	bl	printf
	mov	r3, #0
	b	.L13
.L14:
	ldr	r1, [fp, #-16]
	ldr	r0, .L15+8
	bl	printf
	mov	r3, #1
.L13:
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L16:
	.align	2
.L15:
	.word	.LC10
	.word	.LC11
	.word	.LC12
	.size	detectI2C, .-detectI2C
	.section	.rodata
	.align	2
.LC13:
	.ascii	"%02hhX \000"
	.text
	.align	2
	.global	print_bytes
	.syntax unified
	.arm
	.fpu vfp
	.type	print_bytes, %function
print_bytes:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	str	r0, [fp, #-16]
	str	r1, [fp, #-20]
	ldr	r3, [fp, #-16]
	str	r3, [fp, #-12]
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L18
.L19:
	ldr	r3, [fp, #-8]
	ldr	r2, [fp, #-12]
	add	r3, r2, r3
	ldrb	r3, [r3]	@ zero_extendqisi2
	mov	r1, r3
	ldr	r0, .L20
	bl	printf
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L18:
	ldr	r2, [fp, #-8]
	ldr	r3, [fp, #-20]
	cmp	r2, r3
	blt	.L19
	mov	r0, #10
	bl	putchar
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L21:
	.align	2
.L20:
	.word	.LC13
	.size	print_bytes, .-print_bytes
	.align	2
	.global	printbits
	.syntax unified
	.arm
	.fpu vfp
	.type	printbits, %function
printbits:
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #16
	mov	r3, r0
	strb	r3, [fp, #-13]
	mov	r3, #8
	str	r3, [fp, #-8]
	b	.L23
.L24:
	ldrb	r2, [fp, #-13]	@ zero_extendqisi2
	ldr	r3, [fp, #-8]
	sub	r3, r3, #1
	asr	r3, r2, r3
	and	r3, r3, #1
	add	r3, r3, #48
	mov	r0, r3
	bl	putchar
	ldr	r3, [fp, #-8]
	sub	r3, r3, #1
	str	r3, [fp, #-8]
.L23:
	ldr	r3, [fp, #-8]
	cmp	r3, #0
	bne	.L24
	nop
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
	.size	printbits, .-printbits
	.section	.rodata
	.align	2
.LC14:
	.ascii	"\012Hallo Welt!\000"
	.align	2
.LC15:
	.ascii	"We're gonna scribe the shit out of this week.\000"
	.align	2
.LC16:
	.ascii	"Please enter the number for the command you want to"
	.ascii	" execute. \000"
	.align	2
.LC17:
	.ascii	"1.: GPIO control \000"
	.align	2
.LC18:
	.ascii	"2.: Memory Demo \000"
	.align	2
.LC19:
	.ascii	"0.: Exit Program \000"
	.align	2
.LC20:
	.ascii	"%d\000"
	.text
	.align	2
	.global	mainMenu
	.syntax unified
	.arm
	.fpu vfp
	.type	mainMenu, %function
mainMenu:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #8
	ldr	r0, .L30
	bl	puts
	ldr	r0, .L30+4
	bl	puts
	mov	r0, #10
	bl	putchar
	ldr	r0, .L30+8
	bl	puts
	mov	r0, #10
	bl	putchar
	ldr	r0, .L30+12
	bl	puts
	ldr	r0, .L30+16
	bl	puts
	ldr	r0, .L30+20
	bl	puts
	mov	r0, #10
	bl	putchar
	sub	r3, fp, #8
	mov	r1, r3
	ldr	r0, .L30+24
	bl	__isoc99_scanf
	ldr	r3, [fp, #-8]
	cmp	r3, #1
	bne	.L26
	bl	piMenu
	b	.L27
.L26:
	ldr	r3, [fp, #-8]
	cmp	r3, #2
	bne	.L28
	bl	hexMenu
	b	.L27
.L28:
	ldr	r3, [fp, #-8]
	cmp	r3, #0
	bne	.L27
	mov	r3, #0
	b	.L25
.L27:
.L25:
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L31:
	.align	2
.L30:
	.word	.LC14
	.word	.LC15
	.word	.LC16
	.word	.LC17
	.word	.LC18
	.word	.LC19
	.word	.LC20
	.size	mainMenu, .-mainMenu
	.section	.rodata
	.align	2
.LC21:
	.ascii	"1.: Turn LED on \000"
	.align	2
.LC22:
	.ascii	"2.: Turn LED off \000"
	.align	2
.LC23:
	.ascii	"3.: Write LCD Line 1 \000"
	.align	2
.LC24:
	.ascii	"4.: Write LCD Line 2 \000"
	.align	2
.LC25:
	.ascii	"5.: Clear Display \000"
	.align	2
.LC26:
	.ascii	"6.: Write CPU Temperature and Time \000"
	.align	2
.LC27:
	.ascii	"0. Back to main menu \000"
	.align	2
.LC28:
	.ascii	"LED turned on \000"
	.align	2
.LC29:
	.ascii	"LED turned off \000"
	.align	2
.LC30:
	.ascii	"Please enter up to 16 letters: \000"
	.align	2
.LC31:
	.ascii	"%s\000"
	.align	2
.LC32:
	.ascii	"Line One was set to: %s.\000"
	.align	2
.LC33:
	.ascii	"Line Two was set to: %s.\000"
	.align	2
.LC34:
	.ascii	"                \000"
	.align	2
.LC35:
	.ascii	"Display cleared \000"
	.align	2
.LC36:
	.ascii	"CPU Temp and Time written to LCD.\000"
	.text
	.align	2
	.global	piMenu
	.syntax unified
	.arm
	.fpu vfp
	.type	piMenu, %function
piMenu:
	@ args = 0, pretend = 0, frame = 40
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #40
	ldr	r0, .L40
	bl	puts
	ldr	r0, .L40+4
	bl	puts
	ldr	r0, .L40+8
	bl	puts
	ldr	r0, .L40+12
	bl	puts
	ldr	r0, .L40+16
	bl	puts
	ldr	r0, .L40+20
	bl	puts
	ldr	r0, .L40+24
	bl	puts
	mov	r0, #10
	bl	putchar
	sub	r3, fp, #8
	mov	r1, r3
	ldr	r0, .L40+28
	bl	__isoc99_scanf
	ldr	r3, [fp, #-8]
	cmp	r3, #1
	bne	.L33
	mov	r1, #1
	mov	r0, #3
	bl	digitalWrite
	ldr	r0, .L40+32
	bl	puts
	bl	piMenu
	b	.L34
.L33:
	ldr	r3, [fp, #-8]
	cmp	r3, #2
	bne	.L35
	mov	r1, #0
	mov	r0, #3
	bl	digitalWrite
	ldr	r0, .L40+36
	bl	puts
	bl	piMenu
	b	.L34
.L35:
	ldr	r3, [fp, #-8]
	cmp	r3, #3
	bne	.L36
	bl	getchar
	ldr	r0, .L40+40
	bl	puts
	ldr	r3, .L40+44
	ldr	r2, [r3]
	sub	r3, fp, #24
	mov	r1, #16
	mov	r0, r3
	bl	fgets
	sub	r3, fp, #24
	mov	r0, r3
	bl	strlen
	mov	r3, r0
	sub	r3, r3, #1
	sub	r2, fp, #4
	add	r3, r2, r3
	mov	r2, #0
	strb	r2, [r3, #-20]
	ldr	r3, .L40+48
	ldr	r3, [r3]
	mov	r2, #0
	mov	r1, #0
	mov	r0, r3
	bl	lcdPosition
	ldr	r3, .L40+48
	ldr	r3, [r3]
	sub	r2, fp, #24
	ldr	r1, .L40+52
	mov	r0, r3
	bl	lcdPrintf
	sub	r3, fp, #24
	mov	r1, r3
	ldr	r0, .L40+56
	bl	printf
	bl	piMenu
	b	.L34
.L36:
	ldr	r3, [fp, #-8]
	cmp	r3, #4
	bne	.L37
	bl	getchar
	ldr	r0, .L40+40
	bl	puts
	ldr	r3, .L40+44
	ldr	r2, [r3]
	sub	r3, fp, #40
	mov	r1, #16
	mov	r0, r3
	bl	fgets
	sub	r3, fp, #40
	mov	r0, r3
	bl	strlen
	mov	r3, r0
	sub	r3, r3, #1
	sub	r2, fp, #4
	add	r3, r2, r3
	mov	r2, #0
	strb	r2, [r3, #-36]
	ldr	r3, .L40+48
	ldr	r3, [r3]
	mov	r2, #1
	mov	r1, #0
	mov	r0, r3
	bl	lcdPosition
	ldr	r3, .L40+48
	ldr	r3, [r3]
	sub	r2, fp, #40
	ldr	r1, .L40+52
	mov	r0, r3
	bl	lcdPrintf
	sub	r3, fp, #40
	mov	r1, r3
	ldr	r0, .L40+60
	bl	printf
	bl	piMenu
	b	.L34
.L37:
	ldr	r3, [fp, #-8]
	cmp	r3, #5
	bne	.L38
	ldr	r3, .L40+48
	ldr	r3, [r3]
	mov	r2, #0
	mov	r1, #0
	mov	r0, r3
	bl	lcdPosition
	ldr	r3, .L40+48
	ldr	r3, [r3]
	ldr	r1, .L40+64
	mov	r0, r3
	bl	lcdPrintf
	ldr	r3, .L40+48
	ldr	r3, [r3]
	mov	r2, #1
	mov	r1, #0
	mov	r0, r3
	bl	lcdPosition
	ldr	r3, .L40+48
	ldr	r3, [r3]
	ldr	r1, .L40+64
	mov	r0, r3
	bl	lcdPrintf
	ldr	r0, .L40+68
	bl	puts
	bl	piMenu
	b	.L34
.L38:
	ldr	r3, [fp, #-8]
	cmp	r3, #6
	bne	.L34
	bl	printCPUTemperature
	bl	printDataTime
	ldr	r0, .L40+72
	bl	printf
	bl	piMenu
.L34:
	ldr	r3, [fp, #-8]
	cmp	r3, #0
	bne	.L39
	bl	mainMenu
.L39:
	nop
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L41:
	.align	2
.L40:
	.word	.LC21
	.word	.LC22
	.word	.LC23
	.word	.LC24
	.word	.LC25
	.word	.LC26
	.word	.LC27
	.word	.LC20
	.word	.LC28
	.word	.LC29
	.word	.LC30
	.word	stdin
	.word	lcdhd
	.word	.LC31
	.word	.LC32
	.word	.LC33
	.word	.LC34
	.word	.LC35
	.word	.LC36
	.size	piMenu, .-piMenu
	.section	.rodata
	.align	2
.LC37:
	.ascii	"Please select from the following. \000"
	.align	2
.LC38:
	.ascii	"1. Binary overview for the Demo \000"
	.align	2
.LC39:
	.ascii	"2. Hex overview for the Demo \000"
	.align	2
.LC40:
	.ascii	"3. Enter own char \000"
	.align	2
.LC41:
	.ascii	"4. Enter own string \000"
	.align	2
.LC42:
	.ascii	"5. Find content by address \000"
	.align	2
.LC43:
	.ascii	"Hex value for 0: \000"
	.align	2
.LC44:
	.ascii	"Hex value for 1: \000"
	.align	2
.LC45:
	.ascii	"Hex value for 255: \000"
	.align	2
.LC46:
	.ascii	"Hex value for 256: \000"
	.align	2
.LC47:
	.ascii	"Biggest value stored in 4 Byte: \000"
	.align	2
.LC48:
	.ascii	"Please enter char \000"
	.align	2
.LC49:
	.ascii	"Char %d in Hex: \012\000"
	.align	2
.LC50:
	.ascii	"Char %d in Binary: \012\000"
	.align	2
.LC51:
	.ascii	"Please enter a string with no more than 7 letters \000"
	.align	2
.LC52:
	.ascii	"%16s\000"
	.align	2
.LC53:
	.ascii	"Address of 1st Variable char: %x\012\000"
	.align	2
.LC54:
	.ascii	"Address of 2nd Variable char: %x\012\000"
	.align	2
.LC55:
	.ascii	"Address of 3rd Variable char: %x\012\000"
	.align	2
.LC56:
	.ascii	"Address of 4th Variable char: %x\012\000"
	.align	2
.LC57:
	.ascii	"Address of 5th Variable char: %x\012\000"
	.align	2
.LC58:
	.ascii	"Address of 6th Variable char: %x\012\000"
	.align	2
.LC59:
	.ascii	"Address of 7th Variable char: %x\012\000"
	.align	2
.LC60:
	.ascii	"Address of 8th Variable char: %x\012\000"
	.align	2
.LC61:
	.ascii	"The data read = %s \012\000"
	.align	2
.LC62:
	.ascii	"Please enter <address> \000"
	.text
	.align	2
	.global	hexMenu
	.syntax unified
	.arm
	.fpu vfp
	.type	hexMenu, %function
hexMenu:
	@ args = 0, pretend = 0, frame = 40
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #40
	mov	r0, #10
	bl	putchar
	ldr	r0, .L49
	bl	puts
	ldr	r0, .L49+4
	bl	puts
	ldr	r0, .L49+8
	bl	puts
	ldr	r0, .L49+12
	bl	puts
	ldr	r0, .L49+16
	bl	puts
	ldr	r0, .L49+20
	bl	puts
	ldr	r0, .L49+24
	bl	puts
	mov	r0, #10
	bl	putchar
	sub	r3, fp, #16
	mov	r1, r3
	ldr	r0, .L49+28
	bl	__isoc99_scanf
	ldr	r3, [fp, #-16]
	cmp	r3, #0
	bne	.L43
	bl	mainMenu
	b	.L44
.L43:
	ldr	r3, [fp, #-16]
	cmp	r3, #1
	bne	.L45
	mov	r3, #0
	strb	r3, [fp, #-5]
	mov	r3, #1
	strb	r3, [fp, #-6]
	mvn	r3, #0
	strb	r3, [fp, #-7]
	ldr	r0, .L49+32
	bl	printf
	ldrb	r3, [fp, #-5]	@ zero_extendqisi2
	mov	r0, r3
	bl	printbits
	mov	r0, #10
	bl	putchar
	ldr	r0, .L49+36
	bl	printf
	ldrb	r3, [fp, #-6]	@ zero_extendqisi2
	mov	r0, r3
	bl	printbits
	mov	r0, #10
	bl	putchar
	ldr	r0, .L49+40
	bl	printf
	ldrb	r3, [fp, #-7]	@ zero_extendqisi2
	mov	r0, r3
	bl	printbits
	mov	r0, #10
	bl	putchar
	bl	hexMenu
	b	.L44
.L45:
	ldr	r3, [fp, #-16]
	cmp	r3, #2
	bne	.L46
	mov	r3, #0
	strb	r3, [fp, #-17]
	mov	r3, #1
	strb	r3, [fp, #-18]
	mvn	r3, #0
	strb	r3, [fp, #-19]
	mov	r3, #256
	str	r3, [fp, #-24]
	mvn	r3, #0
	str	r3, [fp, #-28]
	ldr	r0, .L49+32
	bl	printf
	sub	r3, fp, #17
	mov	r1, #1
	mov	r0, r3
	bl	print_bytes
	mov	r0, #10
	bl	putchar
	ldr	r0, .L49+36
	bl	printf
	sub	r3, fp, #18
	mov	r1, #1
	mov	r0, r3
	bl	print_bytes
	mov	r0, #10
	bl	putchar
	ldr	r0, .L49+40
	bl	printf
	sub	r3, fp, #19
	mov	r1, #1
	mov	r0, r3
	bl	print_bytes
	mov	r0, #10
	bl	putchar
	ldr	r0, .L49+44
	bl	printf
	sub	r3, fp, #24
	mov	r1, #4
	mov	r0, r3
	bl	print_bytes
	mov	r0, #10
	bl	putchar
	ldr	r0, .L49+48
	bl	printf
	sub	r3, fp, #28
	mov	r1, #4
	mov	r0, r3
	bl	print_bytes
	mov	r0, #10
	bl	putchar
	bl	hexMenu
	b	.L44
.L46:
	ldr	r3, [fp, #-16]
	cmp	r3, #3
	bne	.L47
	mov	r0, #10
	bl	putchar
	ldr	r0, .L49+52
	bl	puts
	mov	r0, #10
	bl	putchar
	sub	r3, fp, #29
	mov	r1, r3
	ldr	r0, .L49+28
	bl	__isoc99_scanf
	mov	r0, #10
	bl	putchar
	ldrb	r3, [fp, #-29]	@ zero_extendqisi2
	mov	r1, r3
	ldr	r0, .L49+56
	bl	printf
	sub	r3, fp, #29
	mov	r1, #1
	mov	r0, r3
	bl	print_bytes
	mov	r0, #10
	bl	putchar
	ldrb	r3, [fp, #-29]	@ zero_extendqisi2
	mov	r1, r3
	ldr	r0, .L49+60
	bl	printf
	ldrb	r3, [fp, #-29]	@ zero_extendqisi2
	mov	r0, r3
	bl	printbits
	mov	r0, #10
	bl	putchar
	bl	hexMenu
	b	.L44
.L47:
	ldr	r3, [fp, #-16]
	cmp	r3, #4
	bne	.L48
	mov	r0, #10
	bl	putchar
	ldr	r0, .L49+64
	bl	puts
	mov	r0, #10
	bl	putchar
	sub	r3, fp, #40
	mov	r1, r3
	ldr	r0, .L49+68
	bl	__isoc99_scanf
	mov	r0, #10
	bl	putchar
	sub	r3, fp, #40
	mov	r1, r3
	ldr	r0, .L49+72
	bl	printf
	sub	r3, fp, #40
	add	r3, r3, #1
	mov	r1, r3
	ldr	r0, .L49+76
	bl	printf
	sub	r3, fp, #40
	add	r3, r3, #2
	mov	r1, r3
	ldr	r0, .L49+80
	bl	printf
	sub	r3, fp, #40
	add	r3, r3, #3
	mov	r1, r3
	ldr	r0, .L49+84
	bl	printf
	sub	r3, fp, #40
	add	r3, r3, #4
	mov	r1, r3
	ldr	r0, .L49+88
	bl	printf
	sub	r3, fp, #40
	add	r3, r3, #5
	mov	r1, r3
	ldr	r0, .L49+92
	bl	printf
	sub	r3, fp, #40
	add	r3, r3, #6
	mov	r1, r3
	ldr	r0, .L49+96
	bl	printf
	sub	r3, fp, #40
	add	r3, r3, #7
	mov	r1, r3
	ldr	r0, .L49+100
	bl	printf
	mov	r0, #10
	bl	putchar
	sub	r3, fp, #40
	add	r3, r3, #1
	mov	r1, r3
	ldr	r0, .L49+104
	bl	printf
	bl	hexMenu
	b	.L44
.L48:
	ldr	r3, [fp, #-16]
	cmp	r3, #5
	bne	.L44
	mov	r3, #0
	strb	r3, [fp, #-41]
	ldr	r0, .L49+108
	bl	puts
	ldr	r3, [fp, #-12]
	ldrb	r3, [r3]	@ zero_extendqisi2
	mov	r1, r3
	ldr	r0, .L49+112
	bl	__isoc99_scanf
	ldr	r3, [fp, #-12]
	ldrb	r3, [r3]	@ zero_extendqisi2
	strb	r3, [fp, #-41]
	sub	r3, fp, #41
	mov	r1, r3
	ldr	r0, .L49+104
	bl	printf
	mov	r0, #10
	bl	putchar
	bl	hexMenu
.L44:
	nop
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L50:
	.align	2
.L49:
	.word	.LC37
	.word	.LC38
	.word	.LC39
	.word	.LC40
	.word	.LC41
	.word	.LC42
	.word	.LC27
	.word	.LC20
	.word	.LC43
	.word	.LC44
	.word	.LC45
	.word	.LC46
	.word	.LC47
	.word	.LC48
	.word	.LC49
	.word	.LC50
	.word	.LC51
	.word	.LC52
	.word	.LC53
	.word	.LC54
	.word	.LC55
	.word	.LC56
	.word	.LC57
	.word	.LC58
	.word	.LC59
	.word	.LC60
	.word	.LC61
	.word	.LC62
	.word	.LC31
	.size	hexMenu, .-hexMenu
	.section	.rodata
	.align	2
.LC63:
	.ascii	"Program is starting ...\000"
	.align	2
.LC64:
	.ascii	"No correct I2C address found, \012Please use comman"
	.ascii	"d 'i2cdetect -y 1' to check the I2C address! \012Pr"
	.ascii	"ogram Exit. \000"
	.align	2
.LC65:
	.ascii	"lcdInit failed !\000"
	.text
	.align	2
	.global	main
	.syntax unified
	.arm
	.fpu vfp
	.type	main, %function
main:
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	push	{fp, lr}
	add	fp, sp, #4
	sub	sp, sp, #48
	bl	wiringPiSetup
	ldr	r0, .L59
	bl	puts
	mov	r0, #39
	bl	detectI2C
	mov	r3, r0
	cmp	r3, #0
	beq	.L52
	ldr	r3, .L59+4
	mov	r2, #39
	str	r2, [r3]
	b	.L53
.L52:
	mov	r0, #63
	bl	detectI2C
	mov	r3, r0
	cmp	r3, #0
	beq	.L54
	ldr	r3, .L59+4
	mov	r2, #63
	str	r2, [r3]
	b	.L53
.L54:
	ldr	r0, .L59+8
	bl	puts
	mvn	r3, #0
	b	.L55
.L53:
	ldr	r3, .L59+4
	ldr	r3, [r3]
	mov	r1, r3
	mov	r0, #64
	bl	pcf8574Setup
	mov	r3, #0
	str	r3, [fp, #-8]
	b	.L56
.L57:
	ldr	r3, [fp, #-8]
	add	r3, r3, #64
	mov	r1, #1
	mov	r0, r3
	bl	pinMode
	ldr	r3, [fp, #-8]
	add	r3, r3, #1
	str	r3, [fp, #-8]
.L56:
	ldr	r3, [fp, #-8]
	cmp	r3, #7
	ble	.L57
	mov	r1, #1
	mov	r0, #67
	bl	digitalWrite
	mov	r1, #0
	mov	r0, #65
	bl	digitalWrite
	mov	r3, #0
	str	r3, [sp, #32]
	mov	r3, #0
	str	r3, [sp, #28]
	mov	r3, #0
	str	r3, [sp, #24]
	mov	r3, #0
	str	r3, [sp, #20]
	mov	r3, #71
	str	r3, [sp, #16]
	mov	r3, #70
	str	r3, [sp, #12]
	mov	r3, #69
	str	r3, [sp, #8]
	mov	r3, #68
	str	r3, [sp, #4]
	mov	r3, #66
	str	r3, [sp]
	mov	r3, #64
	mov	r2, #4
	mov	r1, #16
	mov	r0, #2
	bl	lcdInit
	mov	r2, r0
	ldr	r3, .L59+12
	str	r2, [r3]
	ldr	r3, .L59+12
	ldr	r3, [r3]
	cmn	r3, #1
	bne	.L58
	ldr	r0, .L59+16
	bl	printf
	mov	r3, #1
	b	.L55
.L58:
	bl	mainMenu
	mov	r3, #0
.L55:
	mov	r0, r3
	sub	sp, fp, #4
	@ sp needed
	pop	{fp, pc}
.L60:
	.align	2
.L59:
	.word	.LC63
	.word	pcf8574_address
	.word	.LC64
	.word	lcdhd
	.word	.LC65
	.size	main, .-main
	.ident	"GCC: (Raspbian 8.3.0-6+rpi1) 8.3.0"
	.section	.note.GNU-stack,"",%progbits
