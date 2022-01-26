.data
   
    input1: .asciiz "Nhap n :"
    error: .asciiz "Nhap so lon hon 0\n"
    str:.asciiz "\nNhap gia tri cua mang tai vi tri  "
    form:.asciiz " : "
    space:.asciiz "\n" 
    output:.asciiz "Danh sach gia tri trong mang\n"
    output_Sum:.asciiz "\nTong cac Gia Tri Le Trong Mang La :"
    arr_form1:.asciiz "arr["
    arr_form2:.asciiz "] = "

.text   

 main: 
      li $v0,4
      la $a0,input1  #Xuat Nhap n :
      syscall
     
      li $v0,5 # nhap so luong mang 
      syscall
     
      addi $s1, $zero, 0 # khoi tao index = 0
      move $s0, $v0 # gán so luong mang cho $s0=n
      mul $s5,$s0,4   # kich co mang 
      sub $sp,$sp,$s5 # khoi tao arr
     
     
      blez $v0,Input_Again # kiem tra lon hon khong (n>0)  
      li $t2,0
      li $t9,0
     
     
      jal Input_Arr
      li $t6,0  # sum=0
    
      li $v0, 4
      la $a0 ,output_Sum # Xuat ra Ket Qua Tinh Tong La : 
      syscall
      
      addi $s1, $zero, 0 # index = 0
      move  $a0, $sp # $a0 = arr (Truyen Tham So )
      move $a1, $s5 # $a1 = n = so phan tu cua mang (Truyen Tham So )
      
      jal Sum  # Goi Ham Sum 
      li $v0,1
      move $a0,$t6   # Xuat Ra Ket Qua Tinh Toan 
      syscall
      
      j exit  # Dung Chuong Trinh (Return 0)
     
     
     
Input_Again:
        li $v0, 4
	la $a0 , error  # Vui Long Nhap So >0
	syscall
	
     	li $v0, 4
	la $a0 , input1  # Cho Input lai
	syscall
	li $v0, 5
	syscall
        mul $s5,$v0,4
        blez $v0,Input_Again  # Kiem tra n>0
       
       jal Input_Arr  
	
       addi $s1, $zero, 0 # index = 0
       move  $a0, $sp # $a0 = arr
       move $a1, $s5 # $a1 = n = so phan tu cua mang
       
     
       jal Sum
       li $v0, 4
       la $a0 ,output_Sum
       syscall
       li $v0,1
       move $a0,$t6
       syscall
       
      j exit  # Thoat Chuong Trinh 
     
 

Input_Arr: 
    beq $s2,$s5,result # nhay toi ham ket qua roi xuat ra man hinh  
    
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
    
    add $s3, $sp, $s2 #$s3 = arr + index * 4
    sw $v0, ($s3) # Luu gia tri nhap vao arr[index]
    
    add $s2,$s2,4   # Cong 4 cho den khi nho hon n*4 thi dung 
    j Input_Arr  
  
result:
	addi $s1, $zero, 0 # index = 0
     	li $v0, 4
	la $a0 , output  
	syscall
	j Output


Output: 
   beq $s1,$s5,exit_InPut   #neu lon hon so luong n nhap vao thi exit
   
   add $s3, $sp, $s1 # arr + index * 4
   
   li $v0, 4
   la $a0 , arr_form1   # Xuat arr[
   syscall
   
   li $v0,1
   move $a0,$t9  # Xuat index
   syscall  
   
   li $v0, 4
   la $a0 , arr_form2  # Xuat ]=
   syscall
   
   li $v0,1
   lw $a0,($s3) #Xuat Gia tri tai index
   syscall
   
   li $v0, 4
   la $a0 , space  #Xuong Dong
   syscall
   
   add $s1, $s1, 4
   add $t9, $t9, 1 #tang index a[j]<-- j la $t9
   j Output
   
exit_InPut:
 jr $ra

Sum:
  
   beq $s1,$a1,exit_InPut   #neu lon hon so luong n nhap vao thi exit
   
   add $s3, $a0, $s1 # arr + index * 4
  
   li $v0,1
   lw $t2,($s3)
   
   li $t9,2
   div $t2,$t9
   mfhi $k0
   beq $k0,$zero,count  # neu la so chan thi nhay toi ham count  va cong index len 
   
   add $t6,$t6,$t2  # sum=sum+arr[index]
   add $s1, $s1, 4
   j Sum

count:
 add $s1, $s1, 4
 j Sum

exit:
  add $sp, $sp, $s5
  li $v0,10
  syscall

 	
