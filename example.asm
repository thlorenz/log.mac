; vim: ft=nasm

%include "log.mac"

global _start

section .text
  DEBUGMSG:  db "logging a debug message",0
  DEBUGLEN   equ $-DEBUGMSG
  INFOMSG:   db "logging an info message",0
  INFOLEN    equ $-INFOMSG
  WARNMSG:   db "logging a warn message",0
  WARNLEN    equ $-WARNMSG
  ERRORMSG:  db "logging an error message",0
  ERRORLEN   equ $-ERRORMSG
  log_text   ; very important to include this

_start:
  nop

  ; supplying length
  log_debug DEBUGMSG, DEBUGLEN

  ; as long as msg is null terminated we can omit length (slightly slower though)
  log_info  INFOMSG
  log_warn  WARNMSG
  log_error ERRORMSG

  xor eax, eax
  mov ah, 10
  mov al, 20
  log_reg eax
  log_error ERRORMSG

.exit:
  mov eax, 1
  mov ebx, 0
  int 80H
