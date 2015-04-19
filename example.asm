; vim: ft=nasm

%include "log.mac"

global _start

section .text
  debug  : db "logging a debug message",0
    .len : equ $-debug
  info   : db "logging an info message",0
    .len : equ $-info
  warn   : db "logging a warn message",0
    .len : equ $-warn
  error  : db "logging an error message",0
    .len : equ $-error
  log_text   ; very important to include this

_start:
  nop

  ; supplying length
  log_debug debug, debug.len

  ; as long as  is null terminated we can omit length (slightly slower though)
  log_info  info
  log_warn  warn
  log_error error

  xor eax, eax
  mov ah, 10
  mov al, 20
  log_reg eax
  log_error error

.exit:
  mov eax, 1
  mov ebx, 0
  int 80H
