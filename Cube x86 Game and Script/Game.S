bits 64

extern ExitProcess
extern InitWindow
extern BeginDrawing
extern ClearBackground
extern EndDrawing
extern DrawRectangle
extern WindowShouldClose
extern SetTargetFPS
extern IsKeyDown


start:
  sub rsp, 8

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

    mov rcx, 0xFF00FF00
    call [ClearBackground]

    mov rcx, 87
    call[IsKeyDown]
    cmp rax, 0
    jnz up

    mov rcx, 83
    call[IsKeyDown]
    cmp rax, 0
    jnz down

    mov rcx, 65
    call[IsKeyDown]
    cmp rax, 0
    jnz left

    mov rcx, 68
    call[IsKeyDown]
    cmp rax, 0
    jnz right

    jmp draw

draw:
    mov rcx, [cubex]
    mov rdx, [cubey]
    mov r8, 40
    mov r9, 40

    sub rsp, 8
    mov rax, 0xFFF30000
    push rax
    sub rsp, 32
    call [DrawRectangle]
    add rsp, 32
    add rsp, 8
    pop rax

    call [EndDrawing]
    add rsp, 32

    jmp gameloop

up:
    dec dword [cubey]
    jmp draw
down:
    inc dword [cubey]
    jmp draw
left:
    dec dword [cubex]
    jmp draw
right:
    inc dword [cubex]
    jmp draw

end:

  sub rsp, 32
  mov rcx, 100
  call [ExitProcess]
  add rsp, 32

  ret

section .data
boxtitle:
db "Cube", 0 
wintitle:
db "Cube movement", 0

cubex:
dq 0
cubey:
dq 0