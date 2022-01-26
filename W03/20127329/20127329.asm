.data 
input1: .asciiz "Enter integer A :"
input2: .asciiz "Enter integer B :"
output_Sum: .asciiz "A + B = "
ouput_Sub: .asciiz "\nA - B = "
output_Muilti: .asciiz "\nA * B = "
ouput_Div:.asciiz "\nA / B = "
output_Mod:.asciiz "\nA % B = "
output_Error:.asciiz "KHONG CHIA DUOC CHO SO 0 "
.text 
#======================================
# ham in chuoi ciiz ra man hinh 
li $v0, 4 # vo=4
la $a0 , input1  
syscall
 #============================
 # ham input1 
li $v0, 5
syscall
move $s0, $v0 #s0=v0 gan so 
#===============================================================
#ham in chuoi ra man hinh 
li $v0, 4 # vo=4
la $a0 , input2 
syscall
#===============================================================
# ham input2 
li $v0,5
syscall
move $s1,$v0
#===============================================================
 #ham xuat chuoi ra man hinh
 li $v0, 4 # vo=4
la $a0 , output_Sum
syscall
#===============================================================
# in tong cua hai so 
add $t3,$s0,$s1
li $v0, 1
move $a0,$t3 
syscall
#=========================
# ham xuat chuoi 
li $v0, 4 # vo=4
la $a0 , ouput_Sub
syscall
#===============================================================
#ham tru hai so 
sub $t4,$s0,$s1
li $v0,1
move $a0,$t4
syscall
#===============================================================
# ham xuat chuoi 
li $v0, 4 # vo=4
la $a0 , output_Muilti
syscall
#===============================================================
# ham nhan 
mul $t5,$s0,$s1
li $v0,1
move $a0,$t5
syscall
#===============================================================
# ham xuat chuoi 
li $v0, 4 # vo=4
la $a0 , ouput_Div
syscall
#===============================================================
beq $s1,0,solve_error
#ham chia 
div $s0,$s1
mflo $t6
li $v0,1
move $a0,$t6
syscall
#==================
li $v0, 4 # vo=4
la $a0 , output_Mod
syscall
#===============================================================
# ham chia lay du 
div $s0,$s1
mfhi $t7
li $v0,1
move $a0,$t7
syscall

li $v0,10
syscall
solve_error:
	li $v0, 4 # vo=4
	la $a0 , output_Error
	syscall
	li $v0, 4 # vo=4
	la $a0 , output_Mod
	syscall
	li $v0, 4 # vo=4
	la $a0 , output_Error
	syscall
