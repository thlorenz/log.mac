; vim: ft=nasm

%include "log.mac"

global _start

section .text
  LOGMSG:   db "Logging this Message",0
  LOGLEN    equ $-LOGMSG
  log_data

_start:
  nop

  ; supplying len 
  ; todo: fix strlen
; log_debug LOGMSG
; log_info  LOGMSG
; log_warn  LOGMSG
; log_error LOGMSG

  ; since LOGMSG is 0 terminated we can omit len
  ; (slightly slower though)
  log_debug LOGMSG, LOGLEN
  log_info  LOGMSG, LOGLEN
  log_warn  LOGMSG, LOGLEN
  log_error LOGMSG, LOGLEN

.exit:
  mov eax, 1      ; exit with code zero
  mov ebx, 0
  int 80H
