; ==============================================================================
; LBM - UAC Self-Elevation Module (Pure x64 ASM)
;
; Purpose: Checks admin privileges and triggers UAC elevation if required
; Author: Marek Wesolowski - WESMAR, 2026
; ==============================================================================

option casemap:none
include consts.inc

EXTRN IsUserAnAdmin:PROC
EXTRN ShellExecuteExW:PROC
EXTRN GetModuleFileNameW:PROC
EXTRN GetCommandLineW:PROC
EXTRN WaitForSingleObject:PROC
EXTRN CloseHandle:PROC
EXTRN ExitProcess:PROC

.const
str_runasVerb dw 'r','u','n','a','s',0

.code

PUBLIC EnsureAdminPrivileges

EnsureAdminPrivileges proc
    push rbx
    push rsi
    push rdi
    sub rsp, 704

    call IsUserAnAdmin
    test eax, eax
    jnz admin_ok

    mov r8d, 260
    lea rdx, [rsp+32]
    xor ecx, ecx
    call GetModuleFileNameW

    call GetCommandLineW
    mov rbx, rax

    ; Skip the executable token while honoring a quoted application path.
    mov rsi, rbx
    cmp word ptr [rsi], '"'
    jne skip_unquoted_arg0
    add rsi, 2
skip_quoted_arg0:
    mov ax, word ptr [rsi]
    test ax, ax
    jz done_arg0
    add rsi, 2
    cmp ax, '"'
    jne skip_quoted_arg0
    jmp skip_spaces

skip_unquoted_arg0:
skip_arg0:
    mov ax, word ptr [rsi]
    test ax, ax
    jz done_arg0
    cmp ax, ' '
    je found_space
    add rsi, 2
    jmp skip_arg0

found_space:
skip_spaces:
    cmp word ptr [rsi], ' '
    jne done_arg0
    add rsi, 2
    jmp skip_spaces

done_arg0:
    lea rdi, [rsp+560]
    mov ecx, 112
    xor eax, eax
    rep stosb

    lea rdi, [rsp+560]
    mov dword ptr [rdi + SHELLEXECUTEINFOW.cbSize], 112
    mov dword ptr [rdi + SHELLEXECUTEINFOW.fMask], SEE_MASK_NOCLOSEPROCESS
    lea rax, str_runasVerb
    mov qword ptr [rdi + SHELLEXECUTEINFOW.lpVerb], rax
    lea rax, [rsp+32]
    mov qword ptr [rdi + SHELLEXECUTEINFOW.lpFile], rax
    mov qword ptr [rdi + SHELLEXECUTEINFOW.lpParameters], rsi
    mov dword ptr [rdi + SHELLEXECUTEINFOW.nShow], 5

    mov rcx, rdi
    call ShellExecuteExW
    test eax, eax
    jz elevate_failed

    mov rcx, qword ptr [rdi + SHELLEXECUTEINFOW.hProcess]
    test rcx, rcx
    jz elevate_exit

    mov edx, -1
    call WaitForSingleObject

    mov rcx, qword ptr [rdi + SHELLEXECUTEINFOW.hProcess]
    call CloseHandle

elevate_exit:
    xor ecx, ecx
    call ExitProcess

elevate_failed:
    xor eax, eax
    jmp admin_exit

admin_ok:
    mov eax, 1

admin_exit:
    add rsp, 704
    pop rdi
    pop rsi
    pop rbx
    ret
EnsureAdminPrivileges endp

end
