; ==============================================================================
; LBM - Nudge Console Prompt Module (Pure x64 ASM)
;
; Purpose: Redraws cmd.exe prompt after CLI output in attached dual-headed app
; Author: Marek Wesolowski - WESMAR, 2026
; ==============================================================================

option casemap:none
include consts.inc

EXTRN GetStdHandle:PROC
EXTRN GetFileType:PROC
EXTRN WriteConsoleInputW:PROC

.code

PUBLIC NudgeConsolePrompt

NudgeConsolePrompt proc frame
    push rdi
    .pushreg rdi
    sub rsp, 64
    .allocstack 64
    .endprolog

    mov ecx, STD_OUTPUT_HANDLE
    sub rsp, 32
    call GetStdHandle
    add rsp, 32
    test rax, rax
    jz ncp_done
    cmp rax, -1
    je ncp_done

    mov rcx, rax
    sub rsp, 32
    call GetFileType
    add rsp, 32
    cmp eax, FILE_TYPE_CHAR
    jne ncp_done

    mov ecx, STD_INPUT_HANDLE
    sub rsp, 32
    call GetStdHandle
    add rsp, 32
    test rax, rax
    jz ncp_done
    cmp rax, -1
    je ncp_done
    mov rdi, rax

    ; INPUT_RECORD structure initialization
    ; EventType = 1 (KEY_EVENT)
    mov word ptr  [rsp+0],  1
    mov word ptr  [rsp+2],  0
    ; bKeyDown = TRUE (1)
    mov dword ptr [rsp+4],  1
    ; wRepeatCount = 1
    mov word ptr  [rsp+8],  1
    ; wVirtualKeyCode = VK_RETURN (0Dh)
    mov word ptr  [rsp+10], 0Dh
    ; wVirtualScanCode = 1Ch
    mov word ptr  [rsp+12], 1Ch
    ; UnicodeChar = 0Dh (\r)
    mov word ptr  [rsp+14], 0Dh
    ; dwControlKeyState = 0
    mov dword ptr [rsp+16], 0

    sub rsp, 32
    lea r9, [rsp+32+24]         ; lpNumberOfEventsWritten
    mov r8d, 1                  ; nLength
    lea rdx, [rsp+32]           ; lpBuffer
    mov rcx, rdi                ; hConsoleInput
    call WriteConsoleInputW
    add rsp, 32

ncp_done:
    add rsp, 64
    pop rdi
    ret
NudgeConsolePrompt endp

end
