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
