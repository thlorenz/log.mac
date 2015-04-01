; vim: ft=nasm

%macro _push_all 1-*
  %rep %0
    push %1
    %rotate 1
  %endrep
%endmacro

%macro _pop_all 1-*
  %rep %0
    %rotate -1
    pop %1
  %endrep
%endmacro

%macro _sys_write 2 ;(s, len)
  _push_all eax, ebx, ecx, edx
  mov eax, 4
  mov ebx, 1
  mov ecx, %1
  mov edx, %2
  int 80H
  _pop_all eax, ebx, ecx, edx
%endmacro

section .data

section .bss

section .text
  DEBUG:      db 27,"[0;32m"
  DEBUG_LEN   equ $-DEBUG
  INFO:       db 27,"[0;32m"
  INFO_LEN    equ $-INFO
  WARN:       db 27,"[0;32m"
  WARN_LEN    equ $-WARN
  ERROR:      db 27,"[0;32m"
  ERROR_LEN   equ $-ERROR
  CLOSE:      db 27,"[0m"
  CLOSE_LEN   equ $-CLOSE

  FIRSTMSG : db 27,"[0;32mLogging this Message", 27, "[0m",10,0
  FIRSTLEN  equ $-FIRSTMSG
  SECONDMSG: db "Logging this Message"
  SECONDLEN  equ $-SECONDMSG
  THIRDMSG: db "Logging this Message with 0 terminator",0

%macro log_info 2
  _sys_write INFO, INFO_LEN
  _sys_write %1, %2
  _sys_write CLOSE, CLOSE_LEN
%endmacro

global _start

_start:
  nop

  ;log_info SECONDMSG, SECONDLEN
  mov ecx, THIRDMSG
  xor edx, edx
  xor eax, eax

.until_null_terminator:
  mov al, byte [ ecx + edx ]
  inc edx
  cmp al, 0x0
  jnz .until_null_terminator

  log_info ecx, edx



.exit:
  mov eax, 1      ; exit with code zero
  mov ebx, 0
  int 80H
