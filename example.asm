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
  DEBUG:      db 27,"[0;90m"
  DEBUG_LEN   equ $-DEBUG
  INFO:       db 27,"[0;32m"
  INFO_LEN    equ $-INFO
  WARN:       db 27,"[0;91m"
  WARN_LEN    equ $-WARN
  ERROR:      db 27,"[0;31m"
  ERROR_LEN   equ $-ERROR
  CLOSE:      db 27,"[0m"
  CLOSE_LEN   equ $-CLOSE

  LOGMSG: db "Logging this Message",10,0
  LOGLEN  equ $-LOGMSG

%macro log_debug 2
  _sys_write DEBUG, DEBUG_LEN
  _sys_write %1, %2
  _sys_write CLOSE, CLOSE_LEN
%endmacro

%macro log_debug 1
  _push_all eax, ecx, edx
  mov ecx, %1
  call strlen

  log_debug %1, edx

  _pop_all eax, ecx, edx
%endmacro

%macro log_info 2
  _sys_write INFO, INFO_LEN
  _sys_write %1, %2
  _sys_write CLOSE, CLOSE_LEN
%endmacro

%macro log_info 1
  _push_all eax, ecx, edx
  mov ecx, %1
  call strlen

  log_info %1, edx

  _pop_all eax, ecx, edx
%endmacro

%macro log_warn 2
  _sys_write WARN, WARN_LEN
  _sys_write %1, %2
  _sys_write CLOSE, CLOSE_LEN
%endmacro

%macro log_warn 1
  _push_all eax, ecx, edx
  mov ecx, %1
  call strlen

  log_warn %1, edx

  _pop_all eax, ecx, edx
%endmacro

%macro log_error 2
  _sys_write ERROR, ERROR_LEN
  _sys_write %1, %2
  _sys_write CLOSE, CLOSE_LEN
%endmacro

%macro log_error 1
  _push_all eax, ecx, edx
  mov ecx, %1
  call strlen

  log_error %1, edx

  _pop_all eax, ecx, edx
%endmacro

; --------------------------------------------------------------
; strlen
;   determines length of given string
;
; ARGS:
;   ecx:  address of the string whose length to determine
;         string needs to end with 0 terminator (ala C strings)
; RETURNS:
;   edx:  the length of the string including the 0 terminator
; --------------------------------------------------------------
strlen:
  push eax

  xor edx, edx
  xor eax, eax
  .until_null_terminator:
    mov al, byte [ ecx + edx ]
    inc edx
    cmp al, 0x0
    jnz .until_null_terminator

  pop eax
  ret

global _start

_start:
  nop

  ; supplying len
  log_debug LOGMSG
  log_info LOGMSG
  log_warn LOGMSG
  log_error LOGMSG

  ; since LOGMSG is 0 terminated we can omit len
  ; (slightly slower though)
  log_debug LOGMSG, LOGLEN
  log_info LOGMSG, LOGLEN
  log_warn LOGMSG, LOGLEN
  log_error LOGMSG, LOGLEN

.exit:
  mov eax, 1      ; exit with code zero
  mov ebx, 0
  int 80H
