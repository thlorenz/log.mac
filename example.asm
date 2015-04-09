; vim: ft=nasm

%include "log.mac"

global _start

section .text
  DEBUGMSG:   db "logging a debug message",0
  DEBUGLEN    equ $-DEBUGMSG
  INFOMSG:   db "logging an info message",0
  INFOLEN    equ $-INFOMSG
  WARNMSG:   db "logging a warn message",0
  WARNLEN    equ $-WARNMSG
  ERRORMSG:   db "logging an error message",0
  ERRORLEN    equ $-ERRORMSG
  log_text

_start:
  nop

  ; supplying len 
  log_debug DEBUGMSG, DEBUGLEN

  ; as long as msg is 0 terminated we can omit len (slightly slower though)
  log_info  INFOMSG
  log_warn  WARNMSG
  log_error ERRORMSG

.exit:
  mov eax, 1      ; exit with code zero
  mov ebx, 0
  int 80H
