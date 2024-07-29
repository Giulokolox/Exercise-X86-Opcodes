bits 64

start:
  sub rsp, 8

  sub rsp,32
  mov rcx, 0 ;RCX è il primo indirizzo 
  call MessageBeep
  add rsp,32
  
  sub rsp, 32
  mov rcx, 0 ;NUll
  mov rdx, 0x402000
  mov r8, 0x40200F
  mov r9, 0 ; se vai a vedere nella wiki lo 0 rappresenta l'OK nel messagebox 
  call MessageBox
  add rsp, 32 

  sub rsp,32
  mov rcx, 17
  call ExitProcess
  add rsp, 32

  ret ;opcode che ci fa uscire da una funzione



MessageBeep:
  jmp [0x404064] ;bisogna mettere 400000 perchè nel nostro programma l'entry point inzia a 400000 perciò insieme all'inidirizzo appena impostato li va pure aggiunto questo se lo vogliamo poi nel nostro eseguibile

MessageBox:
  jmp [0x40406C]

ExitProcess:
  jmp[0x40407C]