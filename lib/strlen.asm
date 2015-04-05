; vim: ft=nasm

section .text
; --------------------------------------------------------------
; strlen
;   determines length of given string (not counting the 0 terminator)
;
; ARGS:
;   esi:  address of the string whose length to determine
;         string needs to end with 0 terminator (ala C strings)
; RETURNS:
;   ecx:  the length of the string including the 0 terminator
; --------------------------------------------------------------
  global strlen
strlen:

  push  eax
  push  esi
  mov   ecx, esi                ; save start of string in ecx
.until_null_terminator:
  lodsb                         ; load byte at esi into al (auto increments esi)
  or    al, al                  ; same as 'cmp al, 0'
  jnz   .until_null_terminator
  dec   esi                     ; don't count 0 terminator
  sub   esi, ecx                ; esi = end - start (len)
  pop   ecx                     ; ecx = start
  xchg  esi, ecx                ; esi = start, ecx = len
  pop   eax                     ; restore eax
  ret

;-------+
; TESTS ;
;-------+

%ifenv strlen

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

%endif
