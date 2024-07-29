bits 64

extern MessageBeep
extern MessageBoxA
extern ExitProcess
extern InitWindow
extern BeginDrawing
extern ClearBackground
extern EndDrawing
extern DrawText
extern WindowShouldClose
extern SetTargetFPS

start:
  sub rsp, 8

  sub rsp, 32
  mov rcx, 0
  call [MessageBeep]
  add rsp, 32

  ;sub rsp, 32
  ;mov rcx, 0 ; NULL
  ;mov rdx, boxmessage
  ;mov r8, boxtitle
  ;mov r9, 0 ; OK
  ;call [MessageBoxA]
  ;add rsp, 32

    sub rsp, 32
    mov rcx, 1024
    mov rdx, 768
    mov r8, wintitle
    call [InitWindow]
    add rsp, 32

    sub rsp, 32
    mov rcx, 60
    call [SetTargetFPS]
    add rsp, 32

gameloop:
    sub rsp, 32

    call [WindowShouldClose]
    cmp rax, 0
    jnz end

    call [BeginDrawing]
    
    mov rcx, 0xFF00FFFF
    call [ClearBackground]

    ;DrawText("Congrats! You created your first window!", 190, 200, 20, LIGHTGRAY);

    inc dword [textx]
    inc dword [texty]

    mov rcx, wintitle
    mov rdx, [textx]
    mov r8, [texty]
    mov r9, 20

    sub rsp, 8
    mov rax, 0xFF0000FF
    push rax
    sub rsp, 32
    call [DrawText]
    add rsp, 32
    add rsp, 8
    pop rax

    call [EndDrawing]
    add rsp, 32

    jmp gameloop

end:

  sub rsp, 32
  mov rcx, 100
  call [ExitProcess]
  add rsp, 32

  ret

section .data
boxmessage:
db "Hello World!!!", 0
boxtitle:
db "Title", 0 
wintitle:
db "Game001", 0

textx:
dq 0
texty:
dq 0