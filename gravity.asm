; Name: Carolynn Madriaga
; Assignment: CPSC 240 - 03 Assignment 2

extern	  printf
extern 	  scanf
extern 	  fgets
extern 	  stdin
extern 	  strlen
extern 	  atof
extern 	  floats

global driver_mod:

max_size equ 32

;======= DATA SEGMENT ==========
section .data

align 16

welcomemsg db 'If errors are discovered please report them to Carolynn at cfnmads323@csu.fullerton.edu for a rapid update. At Columbia, Inc, the customer comes first.\n', 10, 0

ask db "Please enter your first and last names: ", 0

name_info db "The number of characters in your name is %2d", 10, 0

endingmsg db "Thank you its nice to meet you, ", 0

prompt db ". We understand that you plan to drop a marble from a high vantage point.", 10, 0

ask2 db "Please enter the height of the marble above the ground surface in meters: ", 0

give db "Here is your number: ", 0

failmessage db `\nAn error was detected the input data. Please make sure that you enter a float number (e.g. 32.32). Thank you.`, 10, 0

give2 db `\nA drop from a height of %lf, will take %lf seconds to drop.`,10 , 0

stringformat db "%s", 0

floatform db "%lf", 0

gravity: dq 0x402399999999999A

align 64

segment .bss

user_name resb max_size
user_float resb max_size
seconds:  resq 1

segment .text

testmodule:

push 	  rbp
mov 	  rbp, rsp
push 	  rbx
push 	  rcx
push 	  rdx
push 	  rdi
push 	  rsi
push 	  r8
push 	  r9
push 	  r10
push 	  r11
push	  r12
push 	  r13
push 	  r14
push 	  r15
pushf

mov qword rax, 0		;no data from SSE will be printed
mov 	  rdi, stringformat     ;"%s"
mov 	  rsi, welcomemsg		;print out the welcome menu
call 	  printf

mov 	  qword rax, 0
mov 	  rdi, stringformat    
mov 	  rsi, ask		;"Please enter your name:"
call 	  printf

mov qword rax, 0
mov 	  rdi, user_name
mov 	  rsi, max_size
mov 	  rdx, [stdin]		;dereference pointer to keyboard
call	  fgets

;compute the length of the string
mov qword rax, 0
mov 	  rdi, user_name
call 	  strlen
sub 	  rax, 1
mov	  r13, rax			;store the length somewhere safe
mov       byte [user_name+r13], 0


;output the users name length
mov qword rax, 0
mov 	  rdi, name_info
mov 	  rsi, r13
call 	  printf

;reply to user
mov       rax, 0
mov	  rdi, stringformat
mov	  rsi, endingmsg
call 	  printf

mov	  rax, 0
mov	  rdi, stringformat
mov	  rsi, user_name
call 	  printf

;prompt the second message to user
mov qword rax, 0
mov 	  rdi, stringformat
mov 	  rsi, prompt
call 	  printf

mov qword rax, 0
mov 	  rdi, stringformat
mov 	  rsi, ask2
call 	  printf

mov qword rax, 0
mov 	  rdi, user_float
mov 	  rsi, max_size
mov 	  rdx, [stdin]
call 	  fgets

mov qword rax, 0
mov       rdi, user_float
call      strlen
sub       rax, 1
;mov    	  r13, rax
mov 	  byte [user_float+rax], 0

mov       rax, 0
mov 	  rdi, stringformat
mov	  rsi, give
call 	  printf


mov       rax, 0
mov	  rdi, stringformat
mov	  rsi, user_float
call 	  printf

mov	  rax, 0
mov	  rdi, user_float
call	  verifyFloat
mov	  r11, rax

cmp 	  r11, 0			
je  	  tryAgain			

mov 	  rax, 1
mov 	  rdi, user_float
call 	  atof
movsd	  xmm15, xmm0
jmp 	  continue			;go to the continue block

tryAgain:

mov	  rax, 0
mov 	  rdi, failmessage
call 	  printf
jmp 	  conclusion


continue:
;t = sqrt(2h/9.8) where 9.8 is our gravity
mov 	  rax, 2
cvtsi2sd  xmm14, rax			;2 into a float and place it into xmm14
movsd	  xmm12, xmm15			;saves height data
mulsd     xmm15, xmm14			;2*height
movsd	  xmm13, [gravity] 		;hex into xmm13
divsd	  xmm15, xmm13
sqrtsd	  xmm15, xmm15			;seconds for free fall

mov 	  rax, 2
movsd	  xmm0, xmm12
movsd     xmm1, xmm15
mov 	  rdi, give2
call	  printf

movsd 	  xmm0, xmm15
mov 	  rax, 0
jmp 	  conclusion

conclusion:

popf
pop 	  r15
pop 	  r14
pop 	  r13
pop 	  r12
pop 	  r11
pop 	  r10
pop 	  r9
pop 	  r8
pop 	  rsi
pop 	  rdi
pop 	  rdx
pop 	  rcx
pop 	  rbx
pop 	  rbp

ret 