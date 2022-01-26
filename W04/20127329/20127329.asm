.data
    arr:.space 10000
    input1: .asciiz "Nhap n :"
    error: .asciiz "Nhap so lon hon 0\n"
    str:.asciiz "\nNhap gia tri cua mang tai vi tri  "
    form:.asciiz " : "
    space:.asciiz "\n" 
    output:.asciiz "Danh sach gia tri trong mang\n"
    arr_form1:.asciiz "arr["
    arr_form2:.asciiz "] = "

.text    
    li $v0,4
    la $a0,input1
    syscall
     li $v0, 5
     syscall
     move $s0, $v0 
     blez $v0,Input_Again
    
  

li $t2,0
mul $s5,$s0,4  # tinh kich co cua mang bang cach nhan cho  4 
Input_Arr: 
    beq $t0,$s5,result # nhay toi ham ket qua roi xuat ra man hinh 
    li $v0, 4 
    la $a0 , str # Nhap gia tri cua mang tai vi tri 
    syscall
    
    li $v0,1
    move $a0,$t2  # index
    syscall
    
    add $t2,$t2,1   # index=index +1 
    li $v0, 4 
    la $a0 , form  # in ra dau :
    syscall
    
    
    li $v0,5   # cho nguoi dung nhap vao so nguyen
    syscall
    
    sw $v0,arr($t0)  # luu vao mang tai vi tri $t0
    add $t0,$t0,4    # tang len 1 don vi cu the tang len khi be hon n la so nguoi dung nhap vao 
    j Input_Arr    
  

Input_Again:
        li $v0, 4
	la $a0 , error
	syscall
     	li $v0, 4
	la $a0 , input1  
	syscall
	li $v0, 5
	syscall
	move $s0, $v0
	blez $v0,Input_Again
	mul $s5,$s0,4
        jal Input_Arr
       	j exit
li $s2,0 # khoi tao bien chay 
li $s3,0  #khoi tao index
result:
     	li $v0, 4
	la $a0 , output  
	syscall
	j Output
exit:
    li $v0,10
    syscall
Output:
   beq $s2,$s5,exit   #neu lon hon so luong n nhap vao thi exit
   li $v0, 4
   la $a0 ,  arr_form1  #xuat "arr["
   syscall
   
   li $v0,1
   move $a0,$s3
   syscall   # xuat index
   add $s3,$s3,1
   li $v0, 4
   la $a0 ,  arr_form2 # xuat "]= " 
   syscall
   li $v0,1
   lw $a0,arr($s2)
   syscall
   
   li $v0, 4
   la $a0 , space   # xuat khoang trang 
   syscall
   
   add $s2,$s2,4
   j Output
   
