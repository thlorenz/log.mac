; vim: ft=nasm

%include "log.mac"

global _start

section .text
  log_text   ; very important to include this

  debug      : db "logging a debug message",0
    .len     : equ $-debug
  info       : db "logging an info message",0
    .len     : equ $-info
  warn       : db "logging a warn message",0
    .len     : equ $-warn
  error      : db "logging an error message",0
    .len     : equ $-error
  registers  : db "lets debug some register values ..",0
  dec_format : db "decimal format, using eax as example: 'eax:ax:ah:al'",0
  dec_impl   : db "implemented for eax, ebx, ecx, edx, esi, edi", 0

_start:
  nop

  ; supplying length
  log_debug debug, debug.len

  ; as long as  is null terminated we can omit length (slightly slower though)
  log_info  info
  log_warn  warn
  log_error error

  log_info  registers
  xor eax, eax
  mov ah, 10
  mov al, 20

  log_eax
  log_info dec_format
  log_eax_dec

  log_info dec_impl
  mov ebx, 0xbada5501
  log_ebx
  log_ebx_dec
  log_esp
  log_eip   ; yes you can log the instruction pointer too :)

.exit:
  mov eax, 1
  mov ebx, 0
  int 80H
