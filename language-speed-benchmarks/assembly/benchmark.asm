section .data
    msg db "Benchmark complete. Time taken (ms): ", 0
    msg_len equ $ - msg
    newline db 10

section .bss
    start_time resq 2    ; timespec structure (seconds, nanoseconds)
    end_time resq 2      ; timespec structure (seconds, nanoseconds)
    elapsed_time resq 1
    buffer resb 32       ; Increased buffer size for time string

section .text
global _start

_start:
    ; Get start time
    mov rax, 228         ; syscall for clock_gettime (228 on x86-64)
    xor edi, edi         ; CLOCK_REALTIME (0)
    lea rsi, [start_time]
    syscall

    ; Perform the benchmark - Prime calculation logic
    mov rbx, 2           ; Start from 2
    mov r12, 100000      ; Upper limit

.loop:
    mov rcx, 2           ; Start divisor from 2
.check_prime:
    mov rax, rbx
    xor rdx, rdx
    div rcx
    test rdx, rdx        ; If remainder is 0, not prime
    jz .not_prime
    inc rcx
    mov rax, rcx
    mul rax              ; rcx * rcx
    cmp rax, rbx
    jbe .check_prime     ; Continue if rcx*rcx <= rbx
    ; If we get here, rbx is prime
.not_prime:
    inc rbx
    cmp rbx, r12
    jl .loop

    ; Get end time
    mov rax, 228
    xor edi, edi
    lea rsi, [end_time]
    syscall

    ; Calculate elapsed time in milliseconds
    mov rax, [end_time]
    sub rax, [start_time]        ; Seconds
    imul rax, 1000               ; Convert to milliseconds
    mov rbx, [end_time+8]
    sub rbx, [start_time+8]      ; Nanoseconds
    mov rcx, 1000000
    xor rdx, rdx
    div rcx                      ; Convert nanoseconds to milliseconds
    add rax, [elapsed_time]      ; Add to total milliseconds
    mov [elapsed_time], rax      ; Store the result

    ; Convert elapsed time to string in buffer
    mov rax, [elapsed_time]
    mov rbx, 10                  ; divisor for converting number to string
    lea rdi, [buffer+31]         ; point to end of buffer
    mov byte [rdi], 0            ; null-terminate the string
    mov rcx, 0                   ; character counter

.convert:
    xor rdx, rdx                 ; clear remainder
    div rbx                      ; divide rax by 10, rdx now contains remainder (next digit)
    add dl, '0'                  ; convert to ASCII
    dec rdi                      ; move back one position in buffer
    mov [rdi], dl                ; store digit in buffer
    inc rcx                      ; increase character count
    test rax, rax                ; check if quotient is zero
    jnz .convert                 ; if not zero, continue dividing

    ; Print message
    mov rax, 1                   ; syscall for write
    mov rdi, 1                   ; stdout
    mov rsi, msg                 ; message
    mov rdx, msg_len             ; length of message
    syscall

    ; Print elapsed time from buffer
    mov rax, 1                   ; syscall for write
    mov rdi, 1                   ; stdout
    mov rsi, rdi                 ; rsi should point to the start of the number in buffer
    syscall

    ; Print newline
    mov rax, 1
    mov rdi, 1
    mov rsi, newline
    mov rdx, 1
    syscall

    ; Exit program
    mov rax, 60
    xor rdi, rdi
    syscall