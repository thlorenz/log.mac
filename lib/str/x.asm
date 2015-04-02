; vim: ft=nasm
extern strlen

%macro _sys_write 2
  mov eax, 4
  mov ebx, 1
  mov ecx, %1
  mov edx, %2
  int 80H
%endmacro

section .data

SAMPLEMSG:   db "0123456789",0
SAMPLELEN    equ $-SAMPLEMSG
STRLEN       equ SAMPLELEN-1

FAILMSG:  db "FAILED!",10,0
FAILLEN   equ $-FAILMSG
PASSMSG:  db "PASSED!",10,0
PASSLEN   equ $-PASSMSG

section .text

global _start

_start:
  nop

  mov esi, SAMPLEMSG
  call strlen

  cmp ecx, STRLEN

  jz .pass

.fail:
  _sys_write FAILMSG, FAILLEN
  mov ebx, 1
  jmp .exit
.pass:
  _sys_write PASSMSG, PASSLEN
  mov ebx, 0
.exit:
  mov eax, 1
  int 80H
