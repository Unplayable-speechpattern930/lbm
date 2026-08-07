; ==============================================================================
; LBM (Lenovo Battery Manager) - Pure x64 Assembly Edition
; Master Constant definitions & Win32 API Equates
;
; Author: Marek Wesolowski - WESMAR, 2026
; ==============================================================================

; --- Windows Constants ---
STD_INPUT_HANDLE        equ -10
STD_OUTPUT_HANDLE       equ -11
STD_ERROR_HANDLE        equ -12
ATTACH_PARENT_PROCESS   equ -1

FILE_TYPE_CHAR          equ 2
INVALID_HANDLE_VALUE    equ -1

KEY_READ                equ 20019h
KEY_SET_VALUE           equ 00002h
REG_SZ                  equ 1
REG_DWORD               equ 4
ERROR_SUCCESS           equ 0
ERROR_NO_MORE_ITEMS     equ 259

HWND_BROADCAST          equ 0FFFFh
WM_SETTINGCHANGE        equ 001Ah
SMTO_ABORTIFHUNG        equ 00002h

GENERIC_READ            equ 80000000h
GENERIC_WRITE           equ 40000000h
FILE_SHARE_READ         equ 00000001h
FILE_SHARE_WRITE        equ 00000002h
OPEN_EXISTING           equ 3

; --- Lenovo PM driver protocol (\\.\IBMPmDrv) ---
; Payloads encode the primary battery in bits 8..9 and the percentage in
; bits 0..7.  Charge mode 0 is automatic (charge to 100%); 101h selects
; explicit thresholds for battery 1.
IOCTL_LBM_SET_CHARGE_MODE equ 0022261Ch
IOCTL_LBM_SET_START       equ 00222630h
IOCTL_LBM_SET_STOP        equ 00222638h
LBM_PRIMARY_BATTERY       equ 00000100h
LBM_THRESHOLD_MODE        equ 00000101h

; --- DWM, Mica & Rounded Corners Constants ---
DWMWA_USE_IMMERSIVE_DARK_MODE equ 20
DWMWA_WINDOW_CORNER_PREFERENCE equ 33
DWMWA_SYSTEMBACKDROP_TYPE     equ 38

DWMWCP_ROUND                  equ 2
DWMSBT_MAINWINDOW             equ 2

; --- Shell & UAC Constants ---
SEE_MASK_NOCLOSEPROCESS equ 00000040h

; --- GUI Control IDs ---
ID_SLIDER_START         equ 101
ID_SLIDER_STOP          equ 102
ID_BTN_APPLY            equ 103
ID_BTN_DISABLE          equ 104
ID_LBL_START_VAL        equ 105
ID_LBL_STOP_VAL         equ 106
ID_LBL_STATUS           equ 107
ID_CHK_ENABLE           equ 108

TBM_SETRANGE            equ 00401h
TBM_SETPOS              equ 00405h
TBM_GETPOS              equ 00400h

BM_GETCHECK             equ 00F0h
BM_SETCHECK             equ 00F1h
BST_CHECKED             equ 1
BST_UNCHECKED           equ 0

DPI_AWARENESS_CONTEXT_PER_MONITOR_AWARE_V2 equ -4

; --- Structure Definitions ---
LBM_BATTERY_THRESHOLD struct
    startPercentage     dd ?
    stopPercentage      dd ?
    startEnabled        dd ?
    stopEnabled         dd ?
    barcode             dw 64 dup(?)
LBM_BATTERY_THRESHOLD ends
LBM_BATTERY_THRESHOLD_SIZE equ 144

SHELLEXECUTEINFOW struct
    cbSize          dd ?
    fMask           dd ?
    hwnd            dq ?
    lpVerb          dq ?
    lpFile          dq ?
    lpParameters    dq ?
    lpDirectory     dq ?
    nShow           dd ?
    _pad0           dd ?
    hInstApp        dq ?
    lpIDList        dq ?
    lpClass         dq ?
    hkeyClass       dq ?
    dwHotKey        dd ?
    _pad1           dd ?
    hIcon           dq ?
    hProcess        dq ?
SHELLEXECUTEINFOW ends
