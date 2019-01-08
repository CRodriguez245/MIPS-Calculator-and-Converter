.data
	mainMenu: .asciiz "\nMAIN MENU \n---------\n1. Addition\n2. Subtraction\n3. Multiplication\n4. Division\n5. Conversion\n6. Exit\nInput any integer from 1-6 (Don't input any other number):"
	firstInteger: .asciiz "Please input an integer number: "
	secondInteger: .asciiz "Please input another integer number: "
	result: .asciiz "Result: "
	input: .space 4
	otherInput: .space 4
	conversionMenu: .asciiz "\nCONVERSION MENU\n----------------\n1. Decimal to Binary\n2. Decimal to Hexadecimal\n3. Hexadecimal to Binary\n7. To Main Menu\n10. Exit\nInput any integer from 1,2,3,7 or 10 (Don't input any other number):"
	ask_str1:	.asciiz	"Enter a number: "
	result_str:	.asciiz "Result: "
	DecToHexprompt: .asciiz "Enter the decimal number to convert: " 
	DecToHextans: .asciiz "\nHexadecimal equivalent: " 
	DecToHexresult: .space 8 
	promptHexToBinary: .asciiz "  "
	HexToBinaryresultPrompt: .asciiz "Result: "
	inputHexToBinary: .space 16
	print0: .asciiz "0000"
	print1: .asciiz "0001"
	print2: .asciiz "0010"
	print3: .asciiz "0011"
	print4: .asciiz "0100"
	print5: .asciiz "0101"
	print6: .asciiz "0110"
	print7: .asciiz "0111"
	print8: .asciiz "1000"
	print9: .asciiz "1001"
	printA: .asciiz "1010"
	printB: .asciiz "1011"
	printC: .asciiz "1100"
	printD: .asciiz "1101"
	printE: .asciiz "1110"
	printF: .asciiz "1111"


	.align 2
        .ent hextodec

.text


	main:
		li $v0, 4
		la $a0, mainMenu
		syscall 
	
		li $v0, 5
		syscall

		move $t0, $v0
		
		beq $t0, 1, Addition
		beq $t0, 2, Subtraction
		beq $t0, 3, Multiplication
		beq $t0, 4, Division
		beq $t0, 5, ConversionMenu
		j while

	Addition:
		li $v0, 4
		la $a0, firstInteger
		syscall

		#reads and stores first input
		li $v0, 5
		syscall
		move $t0, $v0
		
		#secondInteger prompt
		li $v0, 4
		la $a0, firstInteger
		syscall

		#reads second input
		li $v0, 5
		syscall
		move $t1, $v0

		#add two input
		add $t2, $t1, $t0

		#result prompt
		li $v0, 4
		la $a0, result
		syscall

		#print result
		li $v0, 1		
		move $a0, $t2		
		syscall

		j main	

	Subtraction:
		#firstInteger prompt
		li $v0, 4
		la $a0, firstInteger
		syscall

		#reads and stores first input
		li $v0, 5
		syscall
		move $t0, $v0
		
		#secondInteger prompt
		li $v0, 4
		la $a0, firstInteger
		syscall

		#reads second input
		li $v0, 5
		syscall
		move $t1, $v0

		#sub two input
		sub $t2, $t0, $t1

		#result prompt
		li $v0, 4
		la $a0, result
		syscall

		#print result
		li $v0, 1		
		move $a0, $t2		
		syscall

		j main
	
	Multiplication:
		#firstInteger prompt
		li $v0, 4
		la $a0, firstInteger
		syscall

		#reads and stores first input
		li $v0, 5
		syscall
		move $t0, $v0
		
		#secondInteger prompt
		li $v0, 4
		la $a0, firstInteger
		syscall

		#reads second input
		li $v0, 5
		syscall
		move $t1, $v0

		#multiplication two input
		mult $t0, $t1
		mfhi $t2
		mflo $t3

		#result prompt
		li $v0, 4
		la $a0, result
		syscall

		#print result
		li $v0, 1		
		move $a0, $t2		
		syscall

		li $v0, 1		
		move $a0, $t3		
		syscall

		j main
	
	Division:
		#firstInteger prompt
		li $v0, 4
		la $a0, firstInteger
		syscall

		#reads and stores first input
		li $v0, 5
		syscall
		move $t0, $v0
		
		#secondInteger prompt
		li $v0, 4
		la $a0, firstInteger
		syscall

		#reads second input
		li $v0, 5
		syscall
		move $t1, $v0

		#division two input
		div $t0, $t1
		#mfhi $t2
		mflo $t3

		#result prompt
		li $v0, 4
		la $a0, result
		syscall

		#print result
		#li $v0, 1		
		#move $a0, $t2		
		#syscall
		
		li $v0, 1		
		move $a0, $t3		
		syscall

		j main
	
ConversionMenu:
		#issue when I input 7--RESOLVED
		li $v0, 4
		la $a0, conversionMenu
		syscall

		li $v0, 5
		syscall

		move $t0, $v0
		
		
		beq $t0, 1, DecToBinary
		beq $t0, 2, DecToHex
		beq $t0, 3, HexToBinary
		beq $t0, 7, main
		beq $t0, 10, exit

	DecToBinary:
		# ask and store the first number
		li $v0, 4
		la $a0, ask_str1
		syscall
		li $v0, 5
		syscall
		move $a0, $v0

		jal	print_bin

		# New Line
		li $v0, 11
		li $a0, 10
		syscall

		j __start

		print_bin:

			add $t0, $zero, $a0	# put our input ($a0) into $t0
			add $t1, $zero, $zero	# Zero out $t1
			addi $t3, $zero, 1	# load 1 as a mask
			sll $t3, $t3, 31	# move the mask to appropriate position
			addi $t4, $zero, 32	# loop counter
		loop:

			and $t1, $t0, $t3	# and the input with the mask
			beq $t1, $zero, print	# Branch to print if its 0

			add $t1, $zero, $zero	# Zero out $t1
			addi $t1, $zero, 1	# Put a 1 in $t1
			j print
	

		print:	
			li $v0, 1
			move $a0, $t1
			syscall

		srl $t3, $t3, 1
		addi $t4, $t4, -1
		bne	$t4, $zero, loop

		#jr	$ra


		j ConversionMenu

    
 
	DecToHex:    

   
		la $a0, DecToHexprompt     
		li $v0, 4     
		syscall     

		li $v0, 5     
		syscall
     
		move $t2, $v0     
		la $a0, DecToHextans     
		li $v0, 4     
		syscall 
    
		li $t0, 8               
		la $t3, DecToHexresult      
 
		Loop:     
		beqz $t0, Exit      
		rol $t2, $t2, 4     
		and $t4, $t2, 0xf           
		ble $t4, 9, Sum     
		addi $t4, $t4, 55           
		b End 
    
		Sum:         
		addi $t4, $t4, 48   
 
		End:     
		sb $t4, 0($t3)      
		addi $t3, $t3, 1        
		addi $t0, $t0, -1       
		j Loop
 
		Exit:     
		la $a0, DecToHexresult     
		li $v0, 4     
		syscall 

		j ConversionMenu


	HexToBinary:
		la $t1, inputHexToBinary
		li $s0, '0'
		li $s1, '1'
		li $s2, '2'
		li $s3, '3'
		li $s4, '4'
		li $s5, '5'
		li $s6, '6'
		li $s7, '7'
		li $t0, '8'
		li $t3, '9'
		li $t4, 'a'
		li $t5, 'b'
		li $t6, 'c'
		li $t7, 'd'
		li $t8, 'e'
		li $t9, 'f'
		

		li $v0, 4
		la $a0, promptHexToBinary
		syscall 
	
		li $v0, 8
		la $a0, inputHexToBinary
		syscall

		
		j firstIteration


		
	firstIteration:
		lb $t2, ($t1)
		j loop1
	
	secondIteration:
		addi $t1, $t1, 1
		lb $t2, ($t1)
		j loop2

	thirdIteration:
		addi $t1, $t1, 1
		lb $t2, ($t1)
		j loop3
	fourthIteration:
		addi $t1, $t1, 1
		lb $t2, ($t1)
		j loop4
	Finished:
		j ConversionMenu
		
			

	loop1:	
		check0: 
			bne $s0, $t2, check1
			li $v0, 4		
			la $a0, print0		
			syscall
			j secondIteration
		check1:
			
			bne $s1, $t2, check2
			li $v0, 4		
			la $a0, print1		
			syscall  
		 	j secondIteration
		
		check2:
			bne $s2, $t2, check3
			li $v0, 4		
			la $a0, print2		
			syscall  
			j secondIteration
		check3:
			bne $s3, $t2, check4
			li $v0, 4		
			la $a0, print3		
			syscall
			j secondIteration
		check4:
			bne $s4, $t2, check5
			li $v0, 4		
			la $a0, print4		
			syscall
			j secondIteration
		check5:
			bne $s5, $t2, check6
			li $v0, 4		
			la $a0, print5		
			syscall
			j secondIteration
		check6:
			bne $s6, $t2, check7
			li $v0, 4		
			la $a0, print6		
			syscall
			j secondIteration
		check7:
			bne $s7, $t2, check8
			li $v0, 4		
			la $a0, print7		
			syscall
			j secondIteration
		check8:
			bne $t0, $t2, check9
			li $v0, 4		
			la $a0, print8		
			syscall
			j secondIteration
		check9:
			bne $t3, $t2, checkA
			li $v0, 4		
			la $a0, print9		
			syscall
			j secondIteration
		checkA:
			bne $t4, $t2, checkB
			li $v0, 4		
			la $a0, printA		
			syscall
			j secondIteration
		checkB:
			bne $t5, $t2, checkC
			li $v0, 4		
			la $a0, printB		
			syscall
			j secondIteration
		checkC:
			bne $t6, $t2, checkD
			li $v0, 4		
			la $a0, printC		
			syscall
			j secondIteration
		checkD:
			bne $t7, $t2, checkE
			li $v0, 4		
			la $a0, printD		
			syscall
			j secondIteration
		checkE:
			bne $t8, $t2, checkF
			li $v0, 4		
			la $a0, printE		
			syscall
			j secondIteration
		checkF:
			bne $t9, $t2, Done
			li $v0, 4		
			la $a0, printF		
			syscall
			j secondIteration
		Done:
			j ConversionMenu

	loop2:	
		check0a: 
			bne $0, $t2, check1a
			li $v0, 4		
			la $a0, print0		
			syscall
			j thirdIteration
		check1a:
			
			bne $s1, $t2, check2a
			li $v0, 4		
			la $a0, print1		
			syscall  
		 
			j thirdIteration

		check2a:
			bne $s2, $t2, check3a
			li $v0, 4		
			la $a0, print2		
			syscall  
			j thirdIteration

		check3a:
			bne $s3, $t2, check4a
			li $v0, 4		
			la $a0, print3		
			syscall
			j thirdIteration

		check4a:
			bne $s4, $t2, check5a
			li $v0, 4		
			la $a0, print4		
			syscall
			j thirdIteration

		check5a:
			bne $s5, $t2, check6a
			li $v0, 4		
			la $a0, print5		
			syscall
			j thirdIteration

		check6a:
			bne $s6, $t2, check7a
			li $v0, 4		
			la $a0, print6		
			syscall
			j thirdIteration

		check7a:
			bne $s7, $t2, check8a
			li $v0, 4		
			la $a0, print7		
			syscall
			j thirdIteration

		check8a:
			bne $t0, $t2, check9a
			li $v0, 4		
			la $a0, print8		
			syscall
		check9a:
			bne $t3, $t2, checkAa
			li $v0, 4		
			la $a0, print9		
			syscall
			j thirdIteration

		checkAa:
			bne $t4, $t2, checkBa
			li $v0, 4		
			la $a0, printA		
			syscall
			j thirdIteration

		checkBa:
			bne $t5, $t2, checkCa
			li $v0, 4		
			la $a0, printB		
			syscall
			j thirdIteration

		checkCa:
			bne $t6, $t2, checkDa
			li $v0, 4		
			la $a0, printC		
			syscall
			j thirdIteration

		checkDa:
			bne $t7, $t2, checkEa
			li $v0, 4		
			la $a0, printD		
			syscall
			j thirdIteration

		checkEa:
			bne $t8, $t2, checkFa
			li $v0, 4		
			la $a0, printE		
			syscall
			j thirdIteration

		checkFa:
			bne $t9, $t2, Donea
			li $v0, 4		
			la $a0, printF		
			syscall
			j thirdIteration

		Donea:
			j ConversionMenu

	loop3:	
		check0b: 
			bne $0, $t2, check1b
			li $v0, 4		
			la $a0, print0		
			syscall
			j fourthIteration
		check1b:
			
			bne $s1, $t2, check2b
			li $v0, 4		
			la $a0, print1		
			syscall  
		 
			j fourthIteration
		check2b:
			bne $s2, $t2, check3b
			li $v0, 4		
			la $a0, print2		
			syscall  
			j fourthIteration
		check3b:
			bne $s3, $t2, check4b
			li $v0, 4		
			la $a0, print3		
			syscall
			j fourthIteration
		check4b:
			bne $s4, $t2, check5b
			li $v0, 4		
			la $a0, print4		
			syscall
			j fourthIteration
		check5b:
			bne $s5, $t2, check6b
			li $v0, 4		
			la $a0, print5		
			syscall
			j fourthIteration
		check6b:
			bne $s6, $t2, check7b
			li $v0, 4		
			la $a0, print6		
			syscall
			j fourthIteration
		check7b:
			bne $s7, $t2, check8
			li $v0, 4		
			la $a0, print7		
			syscall
			j fourthIteration
		check8b:
			bne $t0, $t2, check9b
			li $v0, 4		
			la $a0, print8		
			syscall
			j fourthIteration
		check9b:
			bne $t3, $t2, checkA
			li $v0, 4		
			la $a0, print9		
			syscall
			j fourthIteration
		checkAb:
			bne $t4, $t2, checkBb
			li $v0, 4		
			la $a0, printA		
			syscall
			j fourthIteration
		checkBb:
			bne $t5, $t2, checkCb
			li $v0, 4		
			la $a0, printB		
			syscall
			j fourthIteration
		checkCb:
			bne $t6, $t2, checkDb
			li $v0, 4		
			la $a0, printC		
			syscall
			j fourthIteration
		checkDb:
			bne $t7, $t2, checkEb
			li $v0, 4		
			la $a0, printD		
			syscall
			j fourthIteration
		checkEb:
			bne $t8, $t2, checkFb
			li $v0, 4		
			la $a0, printE		
			syscall
			j fourthIteration
		checkFb:
			bne $t9, $t2, Doneb
			li $v0, 4		
			la $a0, printF		
			syscall
			j fourthIteration
		Doneb:
			j ConversionMenu
	loop4:	
		check0c: 
			bne $0, $t2, check1c
			li $v0, 4		
			la $a0, print0		
			syscall
			j Finished
		check1c:
			
			bne $s1, $t2, check2c
			li $v0, 4		
			la $a0, print1		
			syscall  
		 	j Finished
		check2c:
			bne $s2, $t2, check3c
			li $v0, 4		
			la $a0, print2		
			syscall  
			j Finished
		check3c:
			bne $s3, $t2, check4c
			li $v0, 4		
			la $a0, print3		
			syscall
			j Finished
		check4c:
			bne $s4, $t2, check5c
			li $v0, 4		
			la $a0, print4		
			syscall
			j Finished
		check5c:
			bne $s5, $t2, check6c
			li $v0, 4		
			la $a0, print5		
			syscall
			j Finished
		check6c:
			bne $s6, $t2, check7c
			li $v0, 4		
			la $a0, print6		
			syscall
			j Finished
		check7c:
			bne $s7, $t2, check8c
			li $v0, 4		
			la $a0, print7		
			syscall
			j Finished
		check8c:
			bne $t0, $t2, check9c
			li $v0, 4		
			la $a0, print8		
			syscall
			j Finished
		check9c:
			bne $t3, $t2, checkAc
			li $v0, 4		
			la $a0, print9		
			syscall
			j Finished
		checkAc:
			bne $t4, $t2, checkBc
			li $v0, 4		
			la $a0, printA		
			syscall
			j Finished
		checkBc:
			bne $t5, $t2, checkCc
			li $v0, 4		
			la $a0, printB		
			syscall
			j Finished
		checkCc:
			bne $t6, $t2, checkDc
			li $v0, 4		
			la $a0, printC		
			syscall
			j Finished
		checkDc:
			bne $t7, $t2, checkEc
			li $v0, 4		
			la $a0, printD		
			syscall
			j Finished
		checkEc:
			bne $t8, $t2, checkFc
			li $v0, 4		
			la $a0, printE		
			syscall
			j Finished
		checkFc:
			bne $t9, $t2, Done
			li $v0, 4		
			la $a0, printF		
			syscall
			j Finished

		Donec:
			j ConversionMenu		   
 

	
	while:
		beq $v0, 6, exit
		j main

	exit:
		li $v0, 10
		syscall
		
