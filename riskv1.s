.globl __start
.data
  arr1: .word 4,5,8,9,14,15,16,22,8,1
  arr2: .word 8,10,11,14,10
  sv:   .word 0,0,0,0,0,0,0,0,0,0,0,0,0,0
  msg1: .string " "
  msg2: .string "The result of discrete convolution of arrays { 4 5 8 9 14 15 16 22 8 1 } and { 8 10 11 14 10 } is\n"
  msg3: .string "{ "
  msg4: .string "}"
.text
__start:
main:
 la s9,arr1 #s9=&arr1[0]
 la s10,arr2 #s10=&arr2[0]
 la s11,sv #s11=&sv[0]
 addi s0,x0,0 #sum=0
 addi s1,x0,0 #i=0
 addi s2,x0,0 #j=0
 addi s3,x0,0 #k=0
 addi s4,x0,10 #max i
 addi s5,x0,5 #max j
 addi s6,x0,1 #просто константа, равная 1
 addi s7,x0,0 #длина полученного массива(объявление)
 add s7,s4,s5 #длина полученного массива(больше необходимой на 1)
 sub s7,s7,s6 #длина полученного массива(исправленное значение)
    li a0,4
    la a1, msg2 #печатаем строки
    ecall
    li a0,4
    la a1, msg3
    ecall
    loop:
    slt t2,s3,s7 #k<13?
    beq t2,x0,done #if not, then done
    slli t2,s3,2 #t2=k*4(byte offset)
    add t2,t2,s11 #address of sv[k]
    lw t3, 0(t2) #t1=sv[k]
    slli t3,t3,0 #t1=sv[k]*1
    sw t3,0(t2) #sv[i]=sv[i]*1
    addi s1,x0,0 #j=0
        loop1:
        slt t0,s1,s4 #i<10?
        beq t0,x0,done1 #if not, then done
        slli t0,s1,2 #t0=i*4(byte offset)
        add t0,t0,s9 #address of arr1[i]
        lw t1, 0(t0) #t1=arr1[i]
        slli t1,t1,0 #t1=arr1[i]*1
        sw t1,0(t0) #arr1[i]=arr1[i]*1
        addi s2,x0,0 #j=0
           loop2:
           slt t4,s2,s5 #j<5?
           beq t4,x0,done2 #if not, then done
           slli t4,s2,2 #t4=j*4(byte offset)
           add t4,t4,s10 #address of array[i]
           lw t5, 0(t4) #t5=arr1[i]
           slli t5,t5,0 #t5=arr1[i]*1
           sw t5,0(t4) #arr1[i]=arr1[i]*1
           add t6,s1,s2
              bne t6,s3,L1
              mul s8,t5,t1
      L1:  addi s8,s8,0
           addi s2,s2,1 #i=i+1
           j loop2
           done2:
        add s0,s0,s8 
        sub s8,s8,s8   
        addi s1,s1,1 #j=j+1
        j loop1
      done1: 
      add t3,t3,s0   
      addi s3,s3,1 #k=k+1
      li a0,1
      mv a1,s0
      ecall
      li a0,4
      la a1, msg1
      ecall
      sub s0,s0,s0
     j loop 
     done:
 li a0,4
 la a1, msg4
 ecall  
 li a0,10
 ecall
