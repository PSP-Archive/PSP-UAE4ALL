! --------------------------------------------------
! Fast and Accurate Motorola 68000 Emulation Library
! FAME SH4 version 2.0 (11-01-2006)
! Oscar Orallo Pelaez
! Assembly file generated on Feb 16 2006 01:49:10
! --------------------------------------------------
! Opciones de generacion empleadas:
! - Formato de generacion SH4 (compilador GNU)
! - Bus de direcciones de 24 bits
! - Emulacion de lecturas tontas (OFF)
! - Emulacion de comportamiento no documentado (OFF)
! - Espacio de memoria unico (supervisor)
! - Emulacion de excepciones del grupo 0 (OFF)
! - Prefijo del nombre de las funciones: m68k
! - Realizar calculo preciso de ciclos de reloj (ON)
! - Cachear descriptores de mapas de memoria (ON)
! - Realizar cuenta interna de ciclos de reloj (ON)
! - Emular bit 0 de execinfo (ON)
! - Emular excepcion de traza (ON)
! - Emular accesos en dos regiones de memoria (ON)
! - Contar ciclos de generacion de las IRQs (OFF)
! - Chequear errores de direccion en saltos (ON)
! ---------------------------------------------------
.data
.align 5
.global _m68kcontext
.global _io_cycle_counter
_m68kcontext:
contextbegin:
fetch:     .long 0
readbyte:  .long 0
readword:  .long 0
writebyte: .long 0
writeword: .long 0
s_fetch:     .long 0
s_readbyte:  .long 0
s_readword:  .long 0
s_writebyte: .long 0
s_writeword: .long 0
u_fetch:     .long 0
u_readbyte:  .long 0
u_readword:  .long 0
u_writebyte: .long 0
u_writeword: .long 0
resethandler: .long 0
iackhandler:  .long 0
icusthandler: .long 0
reg:
dreg: .long 0,0,0,0,0,0,0,0
areg: .long 0,0,0,0,0,0,0
a7:   .long 0
asp:  .long 0
pc:   .long 0
cycles_counter: .long 0
interrupts: .byte 0,0,0,0,0,0,0,0
sreg: .word 0
execinfo: .word 0
contextend:
execexit_addr: .long execexit
cycles_needed:    .long 0
_io_cycle_counter: .long -1
io_fetchbase:     .long 0
io_fetchbased_pc: .long 0
fetch_vector:	    .long sfmhtbl, srwmhtbl
fetch_idx:        .long 0
readbyte_idx:     .long 0
readword_idx:     .long 0
writebyte_idx:    .long 0
writeword_idx:    .long 0
decode_extw_addr: .long decode_extw
g0_spec_info: .byte 0
filler:       .byte 0,0,0
rb_addr: .long readmemorybyte
rw_addr: .long readmemoryword
rl_addr: .long readmemorydword
wb_addr: .long writememorybyte
ww_addr: .long writememoryword
wl_addr: .long writememorydword
sfmhtbl:
.rept 4096
 .long 0
 .endr
srbmhtbl:
.rept 4096
 .long 0
 .endr
srwmhtbl:
.rept 4096
 .long 0
 .endr
swbmhtbl:
.rept 4096
 .long 0
 .endr
swwmhtbl:
.rept 4096
 .long 0
 .endr
excep_ptr:  .long 0
inst_reg:   .word 0
filler2:    .word 0
.text
top:
.align 5
.global _m68k_init
_m68k_init:
rts
mov #0,r0
.align 5
.global _m68k_emulate
_m68k_emulate:
mov.l execinfo_addr,r1
mov.w @r1,r0
tst #0x80,r0
bt notstopped
mov.l cycles_counter_addr,r0
mov.l @r0,r1
add r4,r1
mov.l r1,@r0
rts
mov #0,r0
.align 5
notstopped:
mov.l r8,@-r15
mov r4,r7
mov.l r9,@-r15
mov.l r10,@-r15
mov.l r11,@-r15
mov.l r12,@-r15
mov.l fetch_idx_addr,r11
mov.l r13,@-r15
mov.l jmptbl_addr,r12
mov.l r14,@-r15
mov.l reg_addr,r13
sts.l pr,@-r15
mov.l excep_ptr_addr,r2
mov.l r15,@r2
mov.l areg_addr,r14
or #1,r0
mov.w r0,@r1
mov r0,r2
mov.l sreg_addr1,r1
mov.w @r1,r0
mov r0,r10
shlr8 r10
mov #3,r8
and r0,r8
mov r0,r9
shlr2 r9
not r9,r3
shlr r9
mov #1,r0
shlr r9
addc r8,r8
and r0,r9
and r0,r3
mov.l pc_addr,r1
mov.l r4,@(cycles_needed-pc,r1)
mov.l @r1,r6
mov r2,r0
tst #0xA,r0
bf execbase
flush_irqs:
mov.l interrupts_addr,r0
mov #7,r5
mov r5,r1
mov.b @r0,r2
and r10,r1
sub r1,r5
mov #7,r1
shll16 r2
shll8 r2
.loop:
shll r2
bt .int
dt r5
cmp/pl r5
bt/s .loop
dt r1
bra .noint
mov #0,r0
.align 5
.int:
mov.b @r0,r2
mov r1,r5
mov #1,r1
shld r5,r1
xor r1,r2
mov.l r5,@-r15
mov.b r2,@r0
mov.b @(r0,r5),r4
mov #0,r5
mov.l g1_exception_addr,r0
jsr @r0
shll2 r4
mov #0xf8,r0
mov.l @r15+,r5
and r0,r10
mov.l iackhandler_addr,r0
mov.l @r0,r1
or r5,r10
tst r1,r1
bt .intdone
mov.l r3,@-r15
mov.l _io_cycle_counter_addr1,r0
mov.l r7,@r0
mov.l r5,@(io_fetchbase-_io_cycle_counter,r0)
mov.l r6,@(io_fetchbased_pc-_io_cycle_counter,r0)
jsr @r1
nop
mov.l _io_cycle_counter_addr1,r0
mov.l @r0,r7
mov.l @(io_fetchbase-_io_cycle_counter,r0),r5
mov.l @(io_fetchbased_pc-_io_cycle_counter,r0),r6
mov.l @r15+,r3
.intdone:
mov #1,r0
.noint:
tst r0,r0
bf execbase
test_trace:
mov #0x80,r2
tst r2,r10
bt execbase
trace_excep:
mov.l execinfo_addr,r1
mov.w @r1,r0
or #0x8,r0
mov.l cycle_needed_addr,r2
mov.w r0,@r1
mov.l r7,@r2
mov #0,r7
execbase:
bsr basefunction
pref @r13
add r5,r6
execloop:
mov.w @r6+,r0
shll2 r0
mov.l @(r0,r12),r4
jmp @r4
mov #0x1C,r2
.align 5
execexit:
add #-2,r6
mov.l execinfo_addr,r1
mov.w @r1,r0
tst #0x8,r0
bt cont_execexit
mov.l cycle_needed_addr,r4
and #0xF7,r0
mov.l @r4,r7
or #16,r0
mov.w r0,@r1
mov.l g1_exception_addr,r0
jsr @r0
mov #0x24,r4
add #-34,r7
cmp/pl r7
bt execbase
mov #0,r5
cont_execexit:
mov.l pc_addr,r2
sub r5,r6
mov r8,r0
shlr r0
addc r9,r9
tst r3,r3
addc r9,r9
and #3,r0
shll2 r9
or r0,r9
shll8 r10
mov.l sreg_addr1,r0
or r10,r9
mov.w r9,@r0
mov.l r6,@r2
mov.l @(cycles_needed-pc,r2),r4
sub r7,r4
mov.l @(cycles_counter-pc,r2),r6
add r4,r6
mov.l r6,@(cycles_counter-pc,r2)
mov.l execinfo_addr,r1
mov.w @r1,r0
xor #1,r0
mov.w r0,@r1
lds.l	@r15+,pr
mov.l @r15+,r14
mov.l @r15+,r13
mov.l @r15+,r12
mov.l @r15+,r11
mov.l @r15+,r10
mov.l @r15+,r9
rts
mov.l @r15+,r8
.align 2
excep_ptr_addr: .long excep_ptr
interrupts_addr: .long interrupts
pc_addr: .long pc
reg_addr: .long reg
areg_addr: .long areg
fetch_vector_addr: .long fetch_vector
sreg_addr1: .long sreg
jmptbl_addr: .long jmptbl
cycle_needed_addr: .long cycles_needed
cycles_counter_addr: .long cycles_counter
execinfo_addr: .long execinfo
fetch_idx_addr: .long fetch_idx
g1_exception_addr: .long group_1_exception
basefunction_addr: .long basefunction
iackhandler_addr: .long iackhandler
_io_cycle_counter_addr1: .long _io_cycle_counter
.align 5
.global _m68k_reset
_m68k_reset:
mov.l r11,@-r15
mov.l fetchidx_addr,r11
mov #1,r0
mov.l execinfo_addr2,r2
mov.w @r2,r1
tst r1,r0
bf return
mov.l sup_fetch_addr,r0
mov.l @r0,r1
mov #2,r0
tst r1,r1
bt return
mov.l reg_addr2,r0
mov #64,r1
add r1,r0
shlr2 r1
xor r4,r4
gp:
mov.l r4,@-r0
dt r1
bf gp
mov.l asp_addr2,r2
mov.l r4,@r2
mov.l interrupts_addr2,r2
mov.b @r2,r0
and #1,r0
mov.b r0,@r2
mov.l execinfo_addr2,r2
mov.w r4,@r2
mov.l sreg_addr2,r2
mov #0x27,r4
shll8 r4
mov.w r4,@r2
mov.l sfmhtbl_addr2,r0
mov.l fetch_idx_addr2,r1
mov.l r0,@r1
mov.l srbmhtbl_addr2,r0
mov.l r0,@(4,r1)
mov.l srwmhtbl_addr2,r0
mov.l r0,@(8,r1)
mov.l swbmhtbl_addr2,r0
mov.l r0,@(12,r1)
mov.l swwmhtbl_addr2,r0
mov.l r0,@(16,r1)
sts pr,r4
bsr basefunction
xor r6,r6
lds r4,pr
add r5,r6
mov.l @r6+,r0
swap.w r0,r0
mov.l a7_addr2,r2
mov.l r0,@r2
mov.l @r6,r0
swap.w r0,r0
mov.l pc_addr2,r2
mov.l r0,@r2
mov #0,r0
return:
rts
mov.l @r15+,r11
.align 2
reg_addr2: .long reg
execinfo_addr2: .long execinfo
interrupts_addr2: .long interrupts
pc_addr2: .long pc
sreg_addr2: .long sreg
a7_addr2: .long a7
asp_addr2: .long asp
sup_fetch_addr: .long s_fetch
sup_readbyte: .long s_readbyte
sup_readword: .long s_readword
sup_writebyte: .long s_writebyte
sup_writeword: .long s_writeword
act_fetch: .long fetch
act_readbyte: .long readbyte
act_readword: .long readword
act_writebyte: .long writebyte
act_writeword: .long writeword
fetchidx_addr: .long fetch_idx
sfmhtbl_addr2: .long sfmhtbl
srbmhtbl_addr2: .long srbmhtbl
srwmhtbl_addr2: .long srwmhtbl
swbmhtbl_addr2: .long swbmhtbl
swwmhtbl_addr2: .long swwmhtbl
fetch_idx_addr2: .long fetch_idx
.align 5
.global _m68k_raise_irq
_m68k_raise_irq:
mov r4,r0
and #7,r0
tst r0,r0
bt badinput
mov #0xff,r4
extu.b r4,r4
cmp/gt r4,r5
bt badinput
mov #-2,r4
cmp/ge r4,r5
bf badinput
cmp/eq r5,r4
bf notspurious
bra notauto
mov #0x18,r5
notspurious:
mov #-1,r4
cmp/eq r5,r4
bf notauto
mov #0x18,r5
add r0,r5
notauto:
mov #1,r4
shld r0,r4
mov.l interrupts_addr3,r1
mov.b @r1,r6
tst r6,r4
bf failure
or r4,r6
mov.b r5,@(r0,r1)
mov.b r6,@r1
mov #0x80,r1
mov.l execinfo_addr3,r6
extu.b r1,r1
mov.w @r6,r7
tst r1,r7
bt .notstopped
mov.l sreg_addr3,r1
mov.w @r1,r5
shlr8 r5
mov #7,r1
cmp/eq r1,r0
movt r4
and r1,r5
add r4,r0
cmp/hs r0,r5
movt r2
mov #0x7f,r0
shld r1,r2
and r0,r7
or r2,r7
mov.w r7,@r6
.notstopped:
rts
mov #0,r0
failure:
rts
mov #-1,r0
badinput:
rts
mov #-2,r0
.align 2
interrupts_addr3: .long interrupts
execinfo_addr3: .long execinfo
sreg_addr3: .long sreg
.align 5
.global _m68k_lower_irq
_m68k_lower_irq:
mov #6,r1
cmp/gt r1,r4
bt .badlevel
tst r4,r4
bt .badlevel
mov #1,r1
shld r4,r1
mov.l interrupts_addr4,r2
mov.b @r2,r3
tst r3,r1
bt .failstat
not r1,r1
and r1,r3
mov.b r3,@r2
rts
mov #0,r0
.failstat:
rts
mov #-1,r0
.badlevel:
rts
mov #-2,r0
.align 2
interrupts_addr4: .long interrupts
.align 5
.global _m68k_set_irq_type
_m68k_set_irq_type:
mov #1,r0
and r0,r5
tst r4,r4
bt .si_irq
mov #interrupts-contextbegin,r0
mov.b @(r0,r4),r1
shlr r1
shll r1
or r5,r1
mov.b r1,@(r0,r4)
rts
mov #0,r0
.si_irq:
mov.l interrupts_addr5,r1
mov.b @r1,r0
and #0xFE,r0
or r5,r0
mov.b r0,@r1
rts
mov #0,r0
.align 2
interrupts_addr5: .long interrupts
.align 5
.global _m68k_get_irq_vector
_m68k_get_irq_vector:
mov r4,r0
and #7,r0
tst r0,r0
bt badlev
mov #1,r1
shld r0,r1
mov.l interrupts_addr6,r2
mov.b @r2,r3
tst r3,r1
bt notraised
mov.b @(r0,r2),r0
rts
extu.b r0,r0
notraised:
rts
mov #-1,r0
badlev:
rts
mov #-2,r0
.align 2
interrupts_addr6: .long interrupts
.align 5
.global _m68k_change_irq_vector
_m68k_change_irq_vector:
mov r4,r0
and #7,r0
tst r0,r0
bt .badin
mov #1,r1
shld r0,r1
mov.l interrupts_addr7,r7
mov.b @r7,r3
tst r3,r1
bt .nraised
mov #255,r4
extu.b r4,r4
cmp/gt r4,r5
bt .badin
mov #-2,r4
cmp/gt r5,r4
bt .badin
cmp/eq r5,r4
bf .notspurious
bra .notauto
mov #0x18,r5
.notspurious:
dt r4
cmp/eq r5,r4
bf .notauto
mov #0x18,r5
add r0,r5
.notauto:
mov.b r5,@(r0,r7)
rts
mov #0,r0
.nraised:
rts
mov #-1,r0
.badin:
rts
mov #-2,r0
.align 2
interrupts_addr7: .long interrupts
.align 5
.global _m68k_get_context_size
_m68k_get_context_size:
mov.l contextend_addr8,r0
mov.l contextbegin_addr8,r1
rts
sub r1,r0
.align 2
contextbegin_addr8: .long contextbegin
contextend_addr8: .long contextend
.align 5
.global _m68k_get_context
_m68k_get_context:
mov.l contextbegin_addr9,r2
mov.l contextend_addr9,r1
loopgc:
mov.l @r2+,r0
mov.l r0,@r4
add #4,r4
cmp/eq r2,r1
bf loopgc
rts
mov #0,r0
.align 2
contextbegin_addr9: .long contextbegin
contextend_addr9: .long contextend
.align 5
.global _m68k_set_context
_m68k_set_context:
mov.l contxtb,r2
mov.l contxte,r1
lloop:
mov.l @r4+,r0
mov.l r0,@r2
add #4,r2
cmp/eq r2,r1
bf lloop
mov.l idxtbl_size,r1
mov.l sfmhtbl_addr,r2
mov #0,r0
mloop:
mov.l r0,@r2
add #4,r2
dt r1
bf mloop
mov.l sfmhtbl_addr,r4
mov.l s_fetch_addr,r1
mov #-12,r3
mov #4,r6
mov.l @r1,r1
begincmm0:
mov.l @r1,r0
cmp/eq #-1,r0
bt endcmm0
mov.l @r1,r0
mov.l @(4,r1),r2
shld r3,r0
shld r3,r2
sub r0,r2
add #1,r2
shll2 r0
add r4,r0
loop0:
mov.l r1,@r0
add r6,r0
dt r2
bf loop0
bra begincmm0
add #12,r1
endcmm0:
mov.l srbmhtbl_addr,r4
mov.l s_readbyte_addr,r1
mov #-12,r3
mov #4,r6
mov.l @r1,r1
begincmm1:
mov.l @r1,r0
cmp/eq #-1,r0
bt endcmm1
mov.l @r1,r0
mov.l @(4,r1),r2
shld r3,r0
shld r3,r2
sub r0,r2
add #1,r2
shll2 r0
add r4,r0
loop1:
mov.l r1,@r0
add r6,r0
dt r2
bf loop1
bra begincmm1
add #16,r1
endcmm1:
mov.l srwmhtbl_addr,r4
mov.l s_readword_addr,r1
mov #-12,r3
mov #4,r6
mov.l @r1,r1
begincmm2:
mov.l @r1,r0
cmp/eq #-1,r0
bt endcmm2
mov.l @r1,r0
mov.l @(4,r1),r2
shld r3,r0
shld r3,r2
sub r0,r2
add #1,r2
shll2 r0
add r4,r0
loop2:
mov.l r1,@r0
add r6,r0
dt r2
bf loop2
bra begincmm2
add #16,r1
endcmm2:
mov.l swbmhtbl_addr,r4
mov.l s_writebyte_addr,r1
mov #-12,r3
mov #4,r6
mov.l @r1,r1
begincmm3:
mov.l @r1,r0
cmp/eq #-1,r0
bt endcmm3
mov.l @r1,r0
mov.l @(4,r1),r2
shld r3,r0
shld r3,r2
sub r0,r2
add #1,r2
shll2 r0
add r4,r0
loop3:
mov.l r1,@r0
add r6,r0
dt r2
bf loop3
bra begincmm3
add #16,r1
endcmm3:
mov.l swwmhtbl_addr,r4
mov.l s_writeword_addr,r1
mov #-12,r3
mov #4,r6
mov.l @r1,r1
begincmm4:
mov.l @r1,r0
cmp/eq #-1,r0
bt endcmm4
mov.l @r1,r0
mov.l @(4,r1),r2
shld r3,r0
shld r3,r2
sub r0,r2
add #1,r2
shll2 r0
add r4,r0
loop4:
mov.l r1,@r0
add r6,r0
dt r2
bf loop4
bra begincmm4
add #16,r1
endcmm4:
rts
mov #0,r0
.align 2
interrupts_addr10: .long interrupts
idxtbl_size: .long 20480
contxte: .long contextend
contxtb: .long contextbegin
sfmhtbl_addr: .long sfmhtbl
srbmhtbl_addr: .long srbmhtbl
swbmhtbl_addr: .long swbmhtbl
srwmhtbl_addr: .long srwmhtbl
swwmhtbl_addr: .long swwmhtbl
s_fetch_addr: .long s_fetch
s_readbyte_addr: .long s_readbyte
s_writebyte_addr: .long s_writebyte
s_readword_addr: .long s_readword
s_writeword_addr: .long s_writeword
.align 5
.global _m68k_get_register
_m68k_get_register:
mov #17,r0
cmp/gt r0,r4
bt cont_get
mov #16,r0
cmp/gt r0,r4
bf .set_dareg
bra _m68k_get_pc
nop
.set_dareg:
mov.l reg_addr11,r0
shll2 r4
rts
mov.l @(r0,r4),r0
cont_get:
mov #18,r0
cmp/eq r0,r4
bf inv_idx
mov.l sreg_addr11,r0
mov.w @r0,r0
rts
extu.w r0,r0
inv_idx:
rts
mov #-1,r0
.align 2
sreg_addr11: .long sreg
reg_addr11: .long reg
.align 5
.global _m68k_get_pc
_m68k_get_pc:
mov.l execinfo_addr12,r0
mov.w @r0,r0
tst #1,r0
bf running
mov.l pc_addr12,r0
rts
mov.l @r0,r0
running:
mov.l io_fetchbased_pc_addr12,r0
mov.l @r0,r0
mov.l io_fetchbase_addr12,r1
mov.l @r1,r1
rts
sub r1,r0
.align 2
pc_addr12: .long pc
execinfo_addr12: .long execinfo
io_fetchbase_addr12: .long io_fetchbase
io_fetchbased_pc_addr12: .long io_fetchbased_pc
.align 5
.global _m68k_set_register
_m68k_set_register:
mov #17,r0
cmp/gt r0,r4
bt .cont_set
mov #16,r0
cmp/gt r0,r4
bt .set_pc
mov.l reg_addr13,r0
shll2 r4
mov.l r5,@(r0,r4)
rts
mov #0,r0
.set_pc:
shll8 r5
shlr8 r5
mov.l execinfo_addr13,r0
mov #1,r2
mov.b @r0,r1
tst r2,r1
bf .cpulive
mov.l pc_addr13,r0
mov.l r5,@r0
rts
mov #0,r0
.cpulive:
mov.l io_fetchbase_addr13,r0
mov.l @r0,r1
mov.l io_fetchbased_pc_addr13,r2
add r5,r1
mov.l r1,@r2
rts
mov #0,r0
.cont_set:
mov #18,r0
cmp/eq r0,r4
bf .inv_idx
mov.l sreg_addr13,r0
mov.w r5,@r0
rts
mov #0,r0
.inv_idx:
rts
mov #-1,r0
.align 2
sreg_addr13: .long sreg
reg_addr13: .long reg
execinfo_addr13: .long execinfo
pc_addr13: .long pc
io_fetchbase_addr13: .long io_fetchbase
io_fetchbased_pc_addr13: .long io_fetchbased_pc
.align 5
.global _m68k_fetch
_m68k_fetch:
mov #3,r0
and r0,r5
mov r4,r2
mov #-12,r0
shld r0,r4
mov.l fetch_vector_addr14,r0
shll2 r5
mov.l @(r0,r5),r0
shll2 r4
mov.l @(r0,r4),r0
mov r2,r4
tst r0,r0
bt .outofrange
mov #4,r1
tst r1,r5
bt .base_prg
bra .base_dat
nop
.outofrange:
rts
mov #-1,r0
.base_prg:
mov.l @(8,r0),r0
mov.w @(r0,r4),r0
rts
extu.w r0,r0
.base_dat:
mov.l @(8,r0),r1
tst r1,r1
bf .callio
mov.l @(12,r0),r0
mov.w @(r0,r4),r0
rts
extu.w r0,r0
.callio:
sts.l	pr,@-r15
jsr @r1
nop
lds.l	@r15+,pr
rts
extu.w r0,r0
.align 2
fetch_vector_addr14: .long fetch_vector
.align 5
.global _m68k_get_cycles_counter
_m68k_get_cycles_counter:
mov.l cycles_needed_addr15,r2
mov.l @r2,r1
mov.l execinfo_addr15,r0
mov.w @r0,r0
tst #1,r0
bt cpuidle
mov.l _io_cycle_counter_addr15,r0
mov.l @r0,r0
sub r0,r1
cpuidle:
mov.l cycles_counter_addr15,r0
mov.l @r0,r0
rts
add r1,r0
.align 2
execinfo_addr15: .long execinfo
cycles_counter_addr15: .long cycles_counter
cycles_needed_addr15: .long cycles_needed
_io_cycle_counter_addr15: .long _io_cycle_counter
.align 5
.global _m68k_control_cycles_counter
_m68k_control_cycles_counter:
tst r4,r4
bf _m68k_trip_cycles_counter
bra _m68k_get_cycles_counter
nop
rts
nop
.align 5
.global _m68k_trip_cycles_counter
_m68k_trip_cycles_counter:
mov.l cycles_needed_addr16,r4
mov.l @r4,r3
mov.l execinfo_addr16,r5
mov.b @r5,r0
tst #1,r0
bt .cpuidle
mov.l _io_cycle_counter_addr16,r1
mov.l @r1,r7
sub r7,r3
.cpuidle:
mov.l cycles_counter_addr16,r2
mov.l @r2,r6
add r3,r6
mov.l r6,@r2
tst #1,r0
bt .cpuidle2
mov.l @r1,r3
.cpuidle2:
mov.l r3,@r4
mov.l @r2,r0
xor r1,r1
rts
mov.l r1,@r2
.align 2
execinfo_addr16: .long execinfo
cycles_needed_addr16: .long cycles_needed
_io_cycle_counter_addr16: .long _io_cycle_counter
cycles_counter_addr16: .long cycles_counter
.align 5
.global _m68k_release_timeslice
_m68k_release_timeslice:
mov.l execinfo_addr17,r0
mov.w @r0,r0
tst #1,r0
bt cpu_idle
mov.l cycles_needed_addr17,r1
mov.l @r1,r0
mov.l _io_cycle_counter_addr17,r2
mov.l @r2,r3
sub r0,r3
mov.l r3,@r2
cpu_idle:
mov.l cycles_needed_addr17,r1
mov #0,r0
rts
mov.l r0,@r1
.align 2
execinfo_addr17: .long execinfo
cycles_needed_addr17: .long cycles_needed
_io_cycle_counter_addr17: .long _io_cycle_counter
.align 5
.global _m68k_add_cycles
_m68k_add_cycles:
mov.l cycles_counter_addr18,r0
mov.l @r0,r1
add r4,r1
mov.l r1,@r0
rts
mov #0,r0
.align 2
cycles_counter_addr18: .long cycles_counter
.align 5
.global _m68k_release_cycles
_m68k_release_cycles:
mov.l cycles_counter_addr19,r0
mov.l @r0,r1
sub r4,r1
mov.l r1,@r0
rts
mov #0,r0
.align 2
cycles_counter_addr19: .long cycles_counter
.align 5
.global _m68k_get_cpu_state
_m68k_get_cpu_state:
mov.l execinfo_addr20,r0
mov.w @r0,r0
rts
extu.w r0,r0
.align 2
execinfo_addr20: .long execinfo
.align 5
basefunction:
shll8 r6
shlr8 r6
mov r6,r0
mov #-12,r1
shld r1,r0
mov.l @r11,r1
shll2 r0
mov.l @(r0,r1),r0
tst r0,r0
bt outofrange
rts
mov.l @(8,r0),r5
outofrange:
xor r5,r5
mov.l execinfo_addr21,r1
mov.w @r1,r0
or #2,r0
rts
mov.w r0,@r1
.align 2
execinfo_addr21: .long execinfo
.align 5
readmemorybyte:
mov.l r4,@-r15
shll8 r4
shlr8 r4
mov #-12,r1
mov r4,r0
shld r1,r0
mov.l @(readbyte_idx-fetch_idx,r11),r1
shll2 r0
mov.l @(r0,r1),r0
tst r0,r0
bt readb_outofrange
mov.l @(8,r0),r1
tst r1,r1
bf readb_callio
mov.l @(12,r0),r0
add r4,r0
xor #1,r0
mov.b @r0,r3
rts
mov.l @r15+,r4
.align 5
readb_callio:
mov.l r2,@-r15
mov.l _io_cycle_counter_addr22,r0
mov.l r7,@r0
mov.l r5,@(io_fetchbase-_io_cycle_counter,r0)
mov.l r6,@(io_fetchbased_pc-_io_cycle_counter,r0)
sts.l	pr,@-r15
jsr @r1
nop
exts.b r0,r3
lds.l	@r15+,pr
mov.l _io_cycle_counter_addr22,r0
mov.l @r0,r7
mov.l @(io_fetchbase-_io_cycle_counter,r0),r5
mov.l @(io_fetchbased_pc-_io_cycle_counter,r0),r6
mov.l @r15+,r2
rts
mov.l @r15+,r4
readb_outofrange:
bra readw_outofrange
nop
.align 2
_io_cycle_counter_addr22: .long _io_cycle_counter
.align 5
readmemoryword:
mov.l r4,@-r15
shll8 r4
shlr8 r4
mov #-12,r1
mov r4,r0
shld r1,r0
mov.l @(readword_idx-fetch_idx,r11),r1
shll2 r0
mov.l @(r0,r1),r0
tst r0,r0
bt readw_outofrange
mov.l @(8,r0),r1
tst r1,r1
bf readw_callio
mov.l @(12,r0),r0
mov.w @(r0,r4),r3
rts
mov.l @r15+,r4
.align 5
readw_callio:
mov.l r2,@-r15
mov.l _io_cycle_counter_addr24,r0
mov.l r7,@r0
mov.l r5,@(io_fetchbase-_io_cycle_counter,r0)
mov.l r6,@(io_fetchbased_pc-_io_cycle_counter,r0)
sts.l	pr,@-r15
jsr @r1
nop
exts.w r0,r3
lds.l	@r15+,pr
mov.l _io_cycle_counter_addr24,r0
mov.l @r0,r7
mov.l @(io_fetchbase-_io_cycle_counter,r0),r5
mov.l @(io_fetchbased_pc-_io_cycle_counter,r0),r6
mov.l @r15+,r2
rts
mov.l @r15+,r4
readw_outofrange:
mov #-1,r3
rts
mov.l @r15+,r4
.align 2
_io_cycle_counter_addr24: .long _io_cycle_counter
.align 5
readmemorydword:
mov.l r4,@-r15
shll8 r4
shlr8 r4
mov #-12,r1
mov r4,r0
shld r1,r0
mov.l @(readword_idx-fetch_idx,r11),r1
shll2 r0
mov.l @(r0,r1),r0
tst r0,r0
bt readl_outofrange
mov.l @(8,r0),r1
tst r1,r1
bf readl_callio
mov.l @(4,r0),r3
add #-2,r3
cmp/hi r3,r4
bt readl_split
mov.l @(12,r0),r1
add r1,r4
mov.w @r4+,r0
mov.w @r4,r3
shll16 r3
xtrct r0,r3
rts
mov.l @r15+,r4
readl_outofrange:
bra readw_outofrange
nop
.align 5
readl_callio:
mov.l @(4,r0),r3
add #-2,r3
cmp/hi r3,r4
bt readl_iosplit
mov.l r2,@-r15
sts.l	pr,@-r15
mov.l r4,@-r15
mov.l r1,@-r15
mov.l _io_cycle_counter_addr26,r0
mov.l r7,@r0
mov.l r5,@(io_fetchbase-_io_cycle_counter,r0)
mov.l r6,@(io_fetchbased_pc-_io_cycle_counter,r0)
jsr @r1
nop
mov.l @r15+,r1
mov.l @r15+,r4
mov.l r0,@-r15
jsr @r1
add #2,r4
mov.l @r15+,r3
lds.l	@r15+,pr
shll16 r3
extu.w r0,r0
mov.l @r15+,r2
or r0,r3
mov.l _io_cycle_counter_addr26,r0
mov.l @r0,r7
mov.l @(io_fetchbase-_io_cycle_counter,r0),r5
mov.l @(io_fetchbased_pc-_io_cycle_counter,r0),r6
rts
mov.l @r15+,r4
.align 5
readl_split:
mov.l @(12,r0),r0
mov.w @(r0,r4),r3
add #2,r4
mov #-12,r1
mov r4,r0
shld r1,r0
mov.l @(readword_idx-fetch_idx,r11),r1
shll2 r0
mov.l @(r0,r1),r0
tst r0,r0
bt readl_outofrange
mov.l @(8,r0),r1
tst r1,r1
bf readlower_callio
mov.l @(12,r0),r0
readlower_direct:
shll16 r3
mov.w @(r0,r4),r1
extu.w r1,r1
or r1,r3
rts
mov.l @r15+,r4
.align 5
readl_iosplit:
mov.l r2,@-r15
mov.l _io_cycle_counter_addr26,r0
mov.l r7,@r0
mov.l r5,@(io_fetchbase-_io_cycle_counter,r0)
mov.l r6,@(io_fetchbased_pc-_io_cycle_counter,r0)
sts.l	pr,@-r15
jsr @r1
nop
lds.l	@r15+,pr
mov.l _io_cycle_counter_addr26,r0
mov.l r7,@r0
mov.l r5,@(io_fetchbase-_io_cycle_counter,r0)
mov.l r6,@(io_fetchbased_pc-_io_cycle_counter,r0)
mov r0,r3
mov.l @r15+,r2
mov #-12,r1
mov r4,r0
shld r1,r0
mov.l @(readword_idx-fetch_idx,r11),r1
shll2 r0
mov.l @(r0,r1),r0
tst r0,r0
bt readl_outofrange
mov.l @(8,r0),r1
tst r1,r1
bf readlower_callio
bra readlower_direct
mov.l @(12,r0),r0
.align 5
readlower_callio:
mov.l r2,@-r15
mov.l r3,@-r15
mov.l _io_cycle_counter_addr26,r0
mov.l r7,@r0
mov.l r5,@(io_fetchbase-_io_cycle_counter,r0)
mov.l r6,@(io_fetchbased_pc-_io_cycle_counter,r0)
sts.l	pr,@-r15
jsr @r1
nop
lds.l	@r15+,pr
mov.l _io_cycle_counter_addr26,r0
mov.l r7,@r0
mov.l r5,@(io_fetchbase-_io_cycle_counter,r0)
mov.l r6,@(io_fetchbased_pc-_io_cycle_counter,r0)
mov.l @r15+,r2
extu.w r0,r3
mov.l @r15+,r1
shll16 r1
or r1,r3
rts
mov.l @r15+,r4
.align 2
_io_cycle_counter_addr26: .long _io_cycle_counter
.align 5
writememorybyte:
mov.l r4,@-r15
shll8 r4
shlr8 r4
mov #-12,r1
mov r4,r0
shld r1,r0
mov.l @(writebyte_idx-fetch_idx,r11),r1
shll2 r0
mov.l @(r0,r1),r0
tst r0,r0
bt writeb_outofrange
mov.l @(8,r0),r1
tst r1,r1
bf writeb_callio
mov.l @(12,r0),r0
add r4,r0
xor #1,r0
mov.b r3,@r0
rts
mov.l @r15+,r4
writeb_outofrange:
bra writew_outofrange
nop
.align 5
writeb_callio:
mov.l r2,@-r15
mov.l r3,@-r15
mov.l _io_cycle_counter_addr30,r0
mov.l r7,@r0
mov.l r5,@(io_fetchbase-_io_cycle_counter,r0)
mov.l r6,@(io_fetchbased_pc-_io_cycle_counter,r0)
sts.l	pr,@-r15
jsr @r1
extu.b r3,r5
lds.l	@r15+,pr
mov.l _io_cycle_counter_addr30,r0
mov.l @r0,r7
mov.l @(io_fetchbase-_io_cycle_counter,r0),r5
mov.l @(io_fetchbased_pc-_io_cycle_counter,r0),r6
mov.l @r15+,r3
mov.l @r15+,r2
rts
mov.l @r15+,r4
.align 2
_io_cycle_counter_addr30: .long _io_cycle_counter
.align 5
writememoryword:
mov.l r4,@-r15
shll8 r4
shlr8 r4
mov #-12,r1
mov r4,r0
shld r1,r0
mov.l @(writeword_idx-fetch_idx,r11),r1
shll2 r0
mov.l @(r0,r1),r0
tst r0,r0
bt writew_outofrange
mov.l @(8,r0),r1
tst r1,r1
bf writew_callio
mov.l @(12,r0),r0
mov.w r3,@(r0,r4)
rts
mov.l @r15+,r4
writew_outofrange:
rts
mov.l @r15+,r4
.align 5
writew_callio:
mov.l r2,@-r15
mov.l r3,@-r15
mov.l _io_cycle_counter_addr32,r0
mov.l r7,@r0
mov.l r5,@(io_fetchbase-_io_cycle_counter,r0)
mov.l r6,@(io_fetchbased_pc-_io_cycle_counter,r0)
sts.l	pr,@-r15
jsr @r1
extu.w r3,r5
lds.l	@r15+,pr
mov.l _io_cycle_counter_addr32,r0
mov.l @r0,r7
mov.l @(io_fetchbase-_io_cycle_counter,r0),r5
mov.l @(io_fetchbased_pc-_io_cycle_counter,r0),r6
mov.l @r15+,r3
mov.l @r15+,r2
rts
mov.l @r15+,r4
.align 2
_io_cycle_counter_addr32: .long _io_cycle_counter
.align 5
writememorydword:
mov.l r4,@-r15
shll8 r4
shlr8 r4
mov #-12,r1
mov r4,r0
shld r1,r0
mov.l @(writeword_idx-fetch_idx,r11),r1
shll2 r0
mov.l @(r0,r1),r0
tst r0,r0
bt writel_outofrange
mov.l @(8,r0),r1
tst r1,r1
bf writel_callio
mov.l @(4,r0),r1
add #-2,r1
cmp/hi r1,r4
bt writel_split
mov.l @(12,r0),r0
mov r3,r1
shlr16 r1
mov.w r1,@(r0,r4)
add #2,r4
mov.w r3,@(r0,r4)
rts
mov.l @r15+,r4
writel_outofrange:
bra readw_outofrange
nop
.align 5
writel_callio:
mov.l @(4,r0),r1
add #-2,r1
cmp/hi r1,r4
bt writel_iosplit
mov.l @(8,r0),r1
mov.l _io_cycle_counter_addr34,r0
mov.l r7,@r0
mov.l r5,@(io_fetchbase-_io_cycle_counter,r0)
mov.l r6,@(io_fetchbased_pc-_io_cycle_counter,r0)
mov.l r2,@-r15
mov.l r3,@-r15
sts.l	pr,@-r15
mov.l r4,@-r15
mov.l r1,@-r15
mov r3,r5
jsr @r1
shlr16 r5
mov.l @r15+,r1
mov.l @r15+,r4
mov.l @(4,r15),r5
add #2,r4
jsr @r1
extu.w r5,r5
lds.l	@r15+,pr
mov.l @r15+,r3
mov.l @r15+,r2
mov.l _io_cycle_counter_addr34,r0
mov.l @r0,r7
mov.l @(io_fetchbase-_io_cycle_counter,r0),r5
mov.l @(io_fetchbased_pc-_io_cycle_counter,r0),r6
rts
mov.l @r15+,r4
.align 5
writel_split:
mov.l @(12,r0),r0
mov r3,r1
shlr16 r1
mov.w r1,@(r0,r4)
add #2,r4
mov #-12,r1
mov r4,r0
shld r1,r0
mov.l @(writeword_idx-fetch_idx,r11),r1
shll2 r0
mov.l @(r0,r1),r0
tst r0,r0
bt writel_outofrange
mov.l @(8,r0),r1
tst r1,r1
bf writelower_callio
mov.l @(12,r0),r0
writelower_direct:
mov.w r3,@(r0,r4)
rts
mov.l @r15+,r4
.align 5
writel_iosplit:
mov.l @(8,r0),r1
mov.l _io_cycle_counter_addr34,r0
mov.l r7,@r0
mov.l r5,@(io_fetchbase-_io_cycle_counter,r0)
mov.l r6,@(io_fetchbased_pc-_io_cycle_counter,r0)
mov.l @r15,r5
mov.l r2,@-r15
mov.l r3,@-r15
mov.l r4,@-r15
sts.l	pr,@-r15
mov r3,r5
jsr @r1
shlr16 r5
lds.l	@r15+,pr
mov.l @r15+,r4
mov.l @r15+,r3
add #2,r4
mov.l @r15+,r2
mov.l _io_cycle_counter_addr34,r0
mov.l @r0,r7
mov.l @(io_fetchbase-_io_cycle_counter,r0),r5
mov.l @(io_fetchbased_pc-_io_cycle_counter,r0),r6
mov #-12,r1
mov r4,r0
shld r1,r0
mov.l @(writeword_idx-fetch_idx,r11),r1
shll2 r0
mov.l @(r0,r1),r0
tst r0,r0
bt writel_outofrange
mov.l @(8,r0),r1
tst r1,r1
bf writelower_callio
bra writelower_direct
mov.l @(12,r0),r0
.align 5
writelower_callio:
mov.l _io_cycle_counter_addr34,r0
mov.l r7,@r0
mov.l r5,@(io_fetchbase-_io_cycle_counter,r0)
mov.l r6,@(io_fetchbased_pc-_io_cycle_counter,r0)
mov.l r2,@-r15
mov.l r3,@-r15
sts.l	pr,@-r15
jsr @r1
extu.w r3,r5
lds.l	@r15+,pr
mov.l @r15+,r3
mov.l @r15+,r2
mov.l _io_cycle_counter_addr34,r0
mov.l @r0,r7
mov.l @(io_fetchbase-_io_cycle_counter,r0),r5
mov.l @(io_fetchbased_pc-_io_cycle_counter,r0),r6
rts
mov.l @r15+,r4
.align 2
_io_cycle_counter_addr34: .long _io_cycle_counter
.align 5
decode_extw:
mov.w @r6+,r0
exts.b r0,r4
shlr8 r0
shlr2 r0
tst #0x02,r0
and #0x3c,r0
bf/s longwd
mov.l @(r0,r13),r0
exts.w r0,r0
longwd:
rts
add r0,r4
.align 5
group_0_exception:
mov.l execinfo_addr38,r2
mov.w @r2,r0
tst #2,r0
bt/s .excflow
add #-50,r7
mov.l @(execexit_addr-areg,r14),r1
or #4,r0
mov.w r0,@r2
jmp @r1
add #2,r6
.align 5
.excflow:
or #2,r0
and #0x7F,r0
mov.w r0,@r2
mov.l r3,@-r15
mov.l readmemorydword_addr38,r1
jsr @r1
nop
mov r3,r2
mov.l @r15+,r3
mov.l r3,@-r15
mov.l r2,@-r15
mov r8,r0
mov r9,r1
shlr r0
addc r1,r1
tst r3,r3
addc r1,r1
and #3,r0
mov r1,r3
shll2 r3
or r0,r3
mov r10,r0
shll8 r0
or r0,r3
mov.l r3,@-r15
mov #0x20,r0
tst r0,r10
bf ln39
or r0,r10
mov.l @(32,r14),r0
mov.l @(60,r13),r1
mov.l r0,@(60,r13)
mov.l r1,@(32,r14)
ln39:
mov #0x27,r0
mov.l execinfo_addr38,r1
and r0,r10
mov.w @r1,r0
tst #0x20,r0
bt .bus_error
mov r6,r3
sub r5,r3
.bus_error:
mov.l @(60,r13),r4
mov.l writememorydword_addr38,r0
jsr @r0
add #-4,r4
mov.l @r15+,r3
mov.l writememoryword_addr38,r0
jsr @r0
add #-2,r4
mov.l inst_reg_addr38,r0
mov.w @r0,r3
mov.l writememoryword_addr38,r0
jsr @r0
add #-2,r4
mov r6,r3
mov.l writememorydword_addr38,r0
jsr @r0
add #-4,r4
mov.l g0_spec_info_addr38,r0
mov.b @r0,r3
mov.l writememoryword_addr38,r0
jsr @r0
add #-2,r4
mov.l r4,@(60,r13)
mov.l @r15+,r6
mov.l @r15+,r3
mov.l basefunction_addr38,r0
jsr @r0
nop
add r5,r6
mov.w @r6+,r0
shll2 r0
cmp/pl r7
bt/s fdl40
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl40:
jmp @r4
mov #0x1C,r2
.align 2
execinfo_addr38: .long execinfo
readmemoryword_addr38: .long readmemoryword
readmemorydword_addr38: .long readmemorydword
writememoryword_addr38: .long writememoryword
writememorydword_addr38: .long writememorydword
io_fetchbase_addr38: .long io_fetchbase
io_fetchbased_pc_addr38: .long io_fetchbased_pc
inst_reg_addr38: .long inst_reg
g0_spec_info_addr38: .long g0_spec_info
basefunction_addr38: .long basefunction
.align 5
group_1_exception:
group_2_exception:
mov.l execinfo_addr41,r1
mov.w @r1,r0
and #0x7F,r0
mov.w r0,@r1
mov.l icusthandler_addr41,r0
mov.l @r0,r0
tst r0,r0
bt .vect_except
mov r4,r1
shll2 r1
mov.l @(r0,r1),r1
tst r1,r1
bt .vect_except
mov.l r3,@-r15
mov r8,r0
shlr r0
addc r9,r9
tst r3,r3
addc r9,r9
and #3,r0
shll2 r9
or r0,r9
shll8 r10
mov.l sreg_addr41,r0
or r10,r9
mov.w r9,@r0
mov.l _io_cycle_counter_addr41,r0
mov.l r7,@r0
mov.l r5,@(io_fetchbase-_io_cycle_counter,r0)
mov.l r6,@(io_fetchbased_pc-_io_cycle_counter,r0)
sts.l	pr,@-r15
jsr @r1
nop
lds.l	@r15+,pr
mov.l _io_cycle_counter_addr41,r0
mov.l @r0,r7
mov.l @(io_fetchbase-_io_cycle_counter,r0),r5
mov.l @(io_fetchbased_pc-_io_cycle_counter,r0),r6
mov.l @r15+,r3
mov.l sreg_addr41,r1
mov.w @r1,r0
mov r0,r10
shlr8 r10
mov #3,r8
and r0,r8
mov r0,r9
shlr2 r9
not r9,r3
shlr r9
mov #1,r0
shlr r9
addc r8,r8
and r0,r9
and r0,r3
rts
sub r5,r6
.align 5
.vect_except:
sts.l	pr,@-r15
mov.l r3,@-r15
mov.l readmemorydword_addr41,r0
jsr @r0
sub r5,r6
mov r3,r2
mov.l @r15,r3
mov r8,r0
mov r9,r1
shlr r0
addc r1,r1
tst r3,r3
addc r1,r1
and #3,r0
mov r1,r3
shll2 r3
or r0,r3
mov r10,r0
shll8 r0
or r0,r3
mov r3,r5
mov #0x20,r0
tst r0,r10
bf ln42
or r0,r10
mov.l @(32,r14),r0
mov.l @(60,r13),r1
mov.l r0,@(60,r13)
mov.l r1,@(32,r14)
ln42:
mov #0x27,r0
mov r6,r3
and r0,r10
mov.l @(60,r13),r4
mov.l writememorydword_addr41,r0
jsr @r0
add #-4,r4
mov r5,r3
mov.l writememoryword_addr41,r0
jsr @r0
add #-2,r4
mov.l @r15+,r3
mov.l r4,@(60,r13)
lds.l	@r15+,pr
rts
mov r2,r6
.align 2
readmemoryword_addr41: .long readmemoryword
readmemorydword_addr41: .long readmemorydword
writememoryword_addr41: .long writememoryword
writememorydword_addr41: .long writememorydword
icusthandler_addr41: .long icusthandler
_io_cycle_counter_addr41: .long _io_cycle_counter
execinfo_addr41: .long execinfo
sreg_addr41: .long sreg
.align 5
privilege_violation:
add #-2,r6
bsr group_1_exception
mov #0x20,r4
mov.l bf_addr43,r0
jsr @r0
nop
add r5,r6
mov.w @r6+,r0
add #-34,r7
shll2 r0
cmp/pl r7
bt/s fdl44
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl44:
jmp @r4
mov #0x1C,r2
.align 2
bf_addr43: .long basefunction
! Opcodes 0000 - 0007
K000:
and r0,r2
mov.w @r6+,r1
exts.b r1,r1
add r13,r2
mov.b @r2,r3
or r1,r3
mov.b r3,@r2
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl45
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl45:
jmp @r4
mov #0x1C,r2
! Opcodes 0010 - 0017
K010:
and r0,r2
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl46
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl46:
jmp @r4
mov #0x1C,r2
! Opcodes 0018 - 001F
K018:
and r0,r2
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl47
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl47:
jmp @r4
mov #0x1C,r2
! Opcodes 0020 - 0027
K020:
and r0,r2
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl48
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl48:
jmp @r4
mov #0x1C,r2
! Opcodes 0028 - 002F
K028:
and r0,r2
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl49
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl49:
jmp @r4
mov #0x1C,r2
! Opcodes 0030 - 0037
K030:
and r0,r2
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl50
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl50:
jmp @r4
mov #0x1C,r2
! Opcode 0038
K038:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl51
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl51:
jmp @r4
mov #0x1C,r2
! Opcode 0039
K039:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl52
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl52:
jmp @r4
mov #0x1C,r2
! Opcode 003C
K03C:
mov.w @r6+,r2
mov r8,r0
mov r9,r1
shlr r0
addc r1,r1
tst r3,r3
addc r1,r1
and #3,r0
mov r1,r3
shll2 r3
or r0,r3
or r2,r3
mov #3,r8
and r3,r8
mov r3,r9
shlr2 r9
not r9,r3
shlr r9
mov #1,r0
shlr r9
addc r8,r8
and r0,r9
and r0,r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl53
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl53:
jmp @r4
mov #0x1C,r2
! Opcodes 0040 - 0047
K040:
and r0,r2
mov.w @r6+,r1
add r13,r2
mov.w @r2,r3
or r1,r3
mov.w r3,@r2
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl54
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl54:
jmp @r4
mov #0x1C,r2
! Opcodes 0050 - 0057
K050:
and r0,r2
mov.w @r6+,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
or r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl55
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl55:
jmp @r4
mov #0x1C,r2
! Opcodes 0058 - 005F
K058:
and r0,r2
mov.w @r6+,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
or r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl56
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl56:
jmp @r4
mov #0x1C,r2
! Opcodes 0060 - 0067
K060:
and r0,r2
mov.w @r6+,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
or r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl57
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl57:
jmp @r4
mov #0x1C,r2
! Opcodes 0068 - 006F
K068:
and r0,r2
mov.w @r6+,r1
mov r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
or r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl58
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl58:
jmp @r4
mov #0x1C,r2
! Opcodes 0070 - 0077
K070:
and r0,r2
mov.w @r6+,r1
mov r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
or r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl59
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl59:
jmp @r4
mov #0x1C,r2
! Opcode 0078
K078:
mov.w @r6+,r1
mov r1,r8
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
or r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl60
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl60:
jmp @r4
mov #0x1C,r2
! Opcode 0079
K079:
mov.w @r6+,r1
mov r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
or r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl61
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl61:
jmp @r4
mov #0x1C,r2
! Opcode 007C
K07C:
mov r10,r0
tst #0x20,r0
bf pcheck_ok62
mov.l priviolation_addr62,r0
jmp @r0
nop
.align 2
priviolation_addr62: .long privilege_violation
pcheck_ok62:
mov.w @r6+,r2
mov r8,r0
mov r9,r1
shlr r0
addc r1,r1
tst r3,r3
addc r1,r1
and #3,r0
mov r1,r3
shll2 r3
or r0,r3
mov r10,r0
shll8 r0
or r0,r3
or r2,r3
mov r3,r0
shlr8 r0
xor r10,r0
tst #0x20,r0
bt ln63
mov.l @(32,r14),r0
mov.l @(60,r13),r1
mov.l r0,@(60,r13)
mov.l r1,@(32,r14)
ln63:
mov r3,r0
shlr8 r0
and #0xA7,r0
mov r0,r10
mov #3,r8
and r3,r8
mov r3,r9
shlr2 r9
not r9,r3
shlr r9
mov #1,r0
shlr r9
addc r8,r8
and r0,r9
and r0,r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s continue65
mov.l @(r0,r12),r4
bra fdl65
mov.l @(execexit_addr-areg,r14),r4
continue65:
lds r0,MACL
mov r10,r0
tst #0x80,r0
bt fde65
mov.l execinfo_ptr65,r1
mov.w @r1,r0
mov.l trace_excep_ptr65,r2
sub r5,r6
jmp @r2
add #-2,r6
fde65:
sts MACL,r0
fdl65:
jmp @r4
mov #0x1C,r2
.align 2
execinfo_ptr65: .long execinfo
trace_excep_ptr65: .long trace_excep
! Opcodes 0080 - 0087
K080:
and r0,r2
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
add r13,r2
mov.l @r2,r3
or r1,r3
mov.l r3,@r2
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl66
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl66:
jmp @r4
mov #0x1C,r2
! Opcodes 0090 - 0097
K090:
and r0,r2
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
or r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl67
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl67:
jmp @r4
mov #0x1C,r2
! Opcodes 0098 - 009F
K098:
and r0,r2
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
or r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl68
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl68:
jmp @r4
mov #0x1C,r2
! Opcodes 00A0 - 00A7
K0A0:
and r0,r2
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
or r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl69
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl69:
jmp @r4
mov #0x1C,r2
! Opcodes 00A8 - 00AF
K0A8:
and r0,r2
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
or r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-32,r7
shll2 r0
cmp/pl r7
bt/s fdl70
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl70:
jmp @r4
mov #0x1C,r2
! Opcodes 00B0 - 00B7
K0B0:
and r0,r2
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
or r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-34,r7
shll2 r0
cmp/pl r7
bt/s fdl71
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl71:
jmp @r4
mov #0x1C,r2
! Opcode 00B8
K0B8:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
or r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-32,r7
shll2 r0
cmp/pl r7
bt/s fdl72
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl72:
jmp @r4
mov #0x1C,r2
! Opcode 00B9
K0B9:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
or r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-36,r7
shll2 r0
cmp/pl r7
bt/s fdl73
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl73:
jmp @r4
mov #0x1C,r2
! Opcodes 0100 - 0107
K100:
and r0,r2
mov.b @r13,r0
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
mov.w @r6+,r0
add #-6,r7
shll2 r0
cmp/pl r7
bt/s fdl74
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl74:
jmp @r4
mov #0x1C,r2
! Opcodes 0108 - 010F
K108:
mov.l r3,@-r15
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add r1,r4
mov r3,r2
extu.b r2,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
mov.w r2,@r13
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl75
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl75:
jmp @r4
mov #0x1C,r2
! Opcodes 0110 - 0117
K110:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl76
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl76:
jmp @r4
mov #0x1C,r2
! Opcodes 0118 - 011F
K118:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl77
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl77:
jmp @r4
mov #0x1C,r2
! Opcodes 0120 - 0127
K120:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-10,r7
shll2 r0
cmp/pl r7
bt/s fdl78
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl78:
jmp @r4
mov #0x1C,r2
! Opcodes 0128 - 012F
K128:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl79
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl79:
jmp @r4
mov #0x1C,r2
! Opcodes 0130 - 0137
K130:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl80
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl80:
jmp @r4
mov #0x1C,r2
! Opcode 0138
K138:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl81
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl81:
jmp @r4
mov #0x1C,r2
! Opcode 0139
K139:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl82
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl82:
jmp @r4
mov #0x1C,r2
! Opcode 013A
K13A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl83
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl83:
jmp @r4
mov #0x1C,r2
! Opcode 013B
K13B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl84
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl84:
jmp @r4
mov #0x1C,r2
! Opcode 013C
K13C:
mov.b @r6,r3
add #2,r6
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl85
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl85:
jmp @r4
mov #0x1C,r2
! Opcodes 0140 - 0147
K140:
and r0,r2
mov.b @r13,r0
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
xor r4,r1
mov.l r1,@r2
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl86
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl86:
jmp @r4
mov #0x1C,r2
! Opcodes 0148 - 014F
K148:
mov.l r3,@-r15
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add r1,r4
mov r3,r2
extu.b r2,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
shll8 r2
extu.b r3,r3
or r3,r2
mov.l r2,@r13
mov.l @r15+,r3
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl87
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl87:
jmp @r4
mov #0x1C,r2
! Opcodes 0150 - 0157
K150:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl88
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl88:
jmp @r4
mov #0x1C,r2
! Opcodes 0158 - 015F
K158:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl89
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl89:
jmp @r4
mov #0x1C,r2
! Opcodes 0160 - 0167
K160:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl90
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl90:
jmp @r4
mov #0x1C,r2
! Opcodes 0168 - 016F
K168:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl91
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl91:
jmp @r4
mov #0x1C,r2
! Opcodes 0170 - 0177
K170:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl92
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl92:
jmp @r4
mov #0x1C,r2
! Opcode 0178
K178:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl93
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl93:
jmp @r4
mov #0x1C,r2
! Opcode 0179
K179:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl94
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl94:
jmp @r4
mov #0x1C,r2
! Opcodes 0180 - 0187
K180:
and r0,r2
mov.b @r13,r0
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
not r4,r4
and r4,r1
mov.l r1,@r2
mov.w @r6+,r0
add #-10,r7
shll2 r0
cmp/pl r7
bt/s fdl95
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl95:
jmp @r4
mov #0x1C,r2
! Opcodes 0188 - 018F
K188:
mov.l r3,@-r15
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @r13,r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl96
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl96:
jmp @r4
mov #0x1C,r2
! Opcodes 0190 - 0197
K190:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl97
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl97:
jmp @r4
mov #0x1C,r2
! Opcodes 0198 - 019F
K198:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl98
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl98:
jmp @r4
mov #0x1C,r2
! Opcodes 01A0 - 01A7
K1A0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl99
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl99:
jmp @r4
mov #0x1C,r2
! Opcodes 01A8 - 01AF
K1A8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl100
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl100:
jmp @r4
mov #0x1C,r2
! Opcodes 01B0 - 01B7
K1B0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl101
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl101:
jmp @r4
mov #0x1C,r2
! Opcode 01B8
K1B8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl102
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl102:
jmp @r4
mov #0x1C,r2
! Opcode 01B9
K1B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl103
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl103:
jmp @r4
mov #0x1C,r2
! Opcodes 01C0 - 01C7
K1C0:
and r0,r2
mov.b @r13,r0
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
or r4,r1
mov.l r1,@r2
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl104
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl104:
jmp @r4
mov #0x1C,r2
! Opcodes 01C8 - 01CF
K1C8:
mov.l r3,@-r15
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @r13,r2
swap.w r2,r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
add #2,r4
swap.w r2,r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
mov.l @r15+,r3
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl105
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl105:
jmp @r4
mov #0x1C,r2
! Opcodes 01D0 - 01D7
K1D0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl106
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl106:
jmp @r4
mov #0x1C,r2
! Opcodes 01D8 - 01DF
K1D8:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl107
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl107:
jmp @r4
mov #0x1C,r2
! Opcodes 01E0 - 01E7
K1E0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl108
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl108:
jmp @r4
mov #0x1C,r2
! Opcodes 01E8 - 01EF
K1E8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl109
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl109:
jmp @r4
mov #0x1C,r2
! Opcodes 01F0 - 01F7
K1F0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl110
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl110:
jmp @r4
mov #0x1C,r2
! Opcode 01F8
K1F8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl111
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl111:
jmp @r4
mov #0x1C,r2
! Opcode 01F9
K1F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b @r13,r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl112
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl112:
jmp @r4
mov #0x1C,r2
! Opcodes 0200 - 0207
K200:
and r0,r2
mov.w @r6+,r1
exts.b r1,r1
add r13,r2
mov.b @r2,r3
and r1,r3
mov.b r3,@r2
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl113
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl113:
jmp @r4
mov #0x1C,r2
! Opcodes 0210 - 0217
K210:
and r0,r2
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl114
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl114:
jmp @r4
mov #0x1C,r2
! Opcodes 0218 - 021F
K218:
and r0,r2
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl115
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl115:
jmp @r4
mov #0x1C,r2
! Opcodes 0220 - 0227
K220:
and r0,r2
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl116
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl116:
jmp @r4
mov #0x1C,r2
! Opcodes 0228 - 022F
K228:
and r0,r2
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl117
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl117:
jmp @r4
mov #0x1C,r2
! Opcodes 0230 - 0237
K230:
and r0,r2
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl118
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl118:
jmp @r4
mov #0x1C,r2
! Opcode 0238
K238:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl119
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl119:
jmp @r4
mov #0x1C,r2
! Opcode 0239
K239:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl120
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl120:
jmp @r4
mov #0x1C,r2
! Opcode 023C
K23C:
mov.w @r6+,r2
mov r8,r0
mov r9,r1
shlr r0
addc r1,r1
tst r3,r3
addc r1,r1
and #3,r0
mov r1,r3
shll2 r3
or r0,r3
and r2,r3
mov #3,r8
and r3,r8
mov r3,r9
shlr2 r9
not r9,r3
shlr r9
mov #1,r0
shlr r9
addc r8,r8
and r0,r9
and r0,r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl121
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl121:
jmp @r4
mov #0x1C,r2
! Opcodes 0240 - 0247
K240:
and r0,r2
mov.w @r6+,r1
add r13,r2
mov.w @r2,r3
and r1,r3
mov.w r3,@r2
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl122
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl122:
jmp @r4
mov #0x1C,r2
! Opcodes 0250 - 0257
K250:
and r0,r2
mov.w @r6+,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
and r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl123
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl123:
jmp @r4
mov #0x1C,r2
! Opcodes 0258 - 025F
K258:
and r0,r2
mov.w @r6+,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
and r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl124
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl124:
jmp @r4
mov #0x1C,r2
! Opcodes 0260 - 0267
K260:
and r0,r2
mov.w @r6+,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
and r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl125
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl125:
jmp @r4
mov #0x1C,r2
! Opcodes 0268 - 026F
K268:
and r0,r2
mov.w @r6+,r1
mov r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
and r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl126
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl126:
jmp @r4
mov #0x1C,r2
! Opcodes 0270 - 0277
K270:
and r0,r2
mov.w @r6+,r1
mov r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
and r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl127
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl127:
jmp @r4
mov #0x1C,r2
! Opcode 0278
K278:
mov.w @r6+,r1
mov r1,r8
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
and r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl128
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl128:
jmp @r4
mov #0x1C,r2
! Opcode 0279
K279:
mov.w @r6+,r1
mov r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
and r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl129
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl129:
jmp @r4
mov #0x1C,r2
! Opcode 027C
K27C:
mov r10,r0
tst #0x20,r0
bf pcheck_ok130
mov.l priviolation_addr130,r0
jmp @r0
nop
.align 2
priviolation_addr130: .long privilege_violation
pcheck_ok130:
mov.w @r6+,r2
mov r8,r0
mov r9,r1
shlr r0
addc r1,r1
tst r3,r3
addc r1,r1
and #3,r0
mov r1,r3
shll2 r3
or r0,r3
mov r10,r0
shll8 r0
or r0,r3
and r2,r3
mov r3,r0
shlr8 r0
xor r10,r0
tst #0x20,r0
bt ln131
mov.l @(32,r14),r0
mov.l @(60,r13),r1
mov.l r0,@(60,r13)
mov.l r1,@(32,r14)
ln131:
mov r3,r0
shlr8 r0
and #0xA7,r0
mov r0,r10
mov #3,r8
and r3,r8
mov r3,r9
shlr2 r9
not r9,r3
shlr r9
mov #1,r0
shlr r9
addc r8,r8
and r0,r9
and r0,r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s continue133
mov.l @(r0,r12),r4
bra fdl133
mov.l @(execexit_addr-areg,r14),r4
continue133:
lds r0,MACL
mov r10,r0
tst #0x80,r0
bt fde133
mov.l execinfo_ptr133,r1
mov.w @r1,r0
mov.l trace_excep_ptr133,r2
sub r5,r6
jmp @r2
add #-2,r6
fde133:
sts MACL,r0
fdl133:
jmp @r4
mov #0x1C,r2
.align 2
execinfo_ptr133: .long execinfo
trace_excep_ptr133: .long trace_excep
! Opcodes 0280 - 0287
K280:
and r0,r2
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
add r13,r2
mov.l @r2,r3
and r1,r3
mov.l r3,@r2
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl134
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl134:
jmp @r4
mov #0x1C,r2
! Opcodes 0290 - 0297
K290:
and r0,r2
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
and r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl135
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl135:
jmp @r4
mov #0x1C,r2
! Opcodes 0298 - 029F
K298:
and r0,r2
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
and r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl136
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl136:
jmp @r4
mov #0x1C,r2
! Opcodes 02A0 - 02A7
K2A0:
and r0,r2
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
and r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl137
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl137:
jmp @r4
mov #0x1C,r2
! Opcodes 02A8 - 02AF
K2A8:
and r0,r2
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
and r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-32,r7
shll2 r0
cmp/pl r7
bt/s fdl138
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl138:
jmp @r4
mov #0x1C,r2
! Opcodes 02B0 - 02B7
K2B0:
and r0,r2
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
and r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-34,r7
shll2 r0
cmp/pl r7
bt/s fdl139
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl139:
jmp @r4
mov #0x1C,r2
! Opcode 02B8
K2B8:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
and r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-32,r7
shll2 r0
cmp/pl r7
bt/s fdl140
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl140:
jmp @r4
mov #0x1C,r2
! Opcode 02B9
K2B9:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
and r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-36,r7
shll2 r0
cmp/pl r7
bt/s fdl141
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl141:
jmp @r4
mov #0x1C,r2
! Opcodes 0300 - 0307
K300:
and r0,r2
mov #4,r0
mov.b @(r0,r13),r0
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
mov.w @r6+,r0
add #-6,r7
shll2 r0
cmp/pl r7
bt/s fdl142
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl142:
jmp @r4
mov #0x1C,r2
! Opcodes 0308 - 030F
K308:
mov.l r3,@-r15
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add r1,r4
mov r3,r2
extu.b r2,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
mov #4,r0
mov.w r2,@(r0,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl143
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl143:
jmp @r4
mov #0x1C,r2
! Opcodes 0310 - 0317
K310:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl144
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl144:
jmp @r4
mov #0x1C,r2
! Opcodes 0318 - 031F
K318:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #4,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl145
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl145:
jmp @r4
mov #0x1C,r2
! Opcodes 0320 - 0327
K320:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #4,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-10,r7
shll2 r0
cmp/pl r7
bt/s fdl146
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl146:
jmp @r4
mov #0x1C,r2
! Opcodes 0328 - 032F
K328:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl147
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl147:
jmp @r4
mov #0x1C,r2
! Opcodes 0330 - 0337
K330:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl148
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl148:
jmp @r4
mov #0x1C,r2
! Opcode 0338
K338:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl149
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl149:
jmp @r4
mov #0x1C,r2
! Opcode 0339
K339:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl150
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl150:
jmp @r4
mov #0x1C,r2
! Opcode 033A
K33A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl151
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl151:
jmp @r4
mov #0x1C,r2
! Opcode 033B
K33B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl152
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl152:
jmp @r4
mov #0x1C,r2
! Opcode 033C
K33C:
mov.b @r6,r3
add #2,r6
mov #4,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl153
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl153:
jmp @r4
mov #0x1C,r2
! Opcodes 0340 - 0347
K340:
and r0,r2
mov #4,r0
mov.b @(r0,r13),r0
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
xor r4,r1
mov.l r1,@r2
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl154
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl154:
jmp @r4
mov #0x1C,r2
! Opcodes 0348 - 034F
K348:
mov.l r3,@-r15
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add r1,r4
mov r3,r2
extu.b r2,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
shll8 r2
extu.b r3,r3
or r3,r2
mov.l r2,@(4,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl155
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl155:
jmp @r4
mov #0x1C,r2
! Opcodes 0350 - 0357
K350:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl156
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl156:
jmp @r4
mov #0x1C,r2
! Opcodes 0358 - 035F
K358:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl157
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl157:
jmp @r4
mov #0x1C,r2
! Opcodes 0360 - 0367
K360:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl158
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl158:
jmp @r4
mov #0x1C,r2
! Opcodes 0368 - 036F
K368:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl159
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl159:
jmp @r4
mov #0x1C,r2
! Opcodes 0370 - 0377
K370:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl160
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl160:
jmp @r4
mov #0x1C,r2
! Opcode 0378
K378:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl161
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl161:
jmp @r4
mov #0x1C,r2
! Opcode 0379
K379:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl162
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl162:
jmp @r4
mov #0x1C,r2
! Opcodes 0380 - 0387
K380:
and r0,r2
mov #4,r0
mov.b @(r0,r13),r0
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
not r4,r4
and r4,r1
mov.l r1,@r2
mov.w @r6+,r0
add #-10,r7
shll2 r0
cmp/pl r7
bt/s fdl163
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl163:
jmp @r4
mov #0x1C,r2
! Opcodes 0388 - 038F
K388:
mov.l r3,@-r15
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(4,r13),r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl164
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl164:
jmp @r4
mov #0x1C,r2
! Opcodes 0390 - 0397
K390:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl165
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl165:
jmp @r4
mov #0x1C,r2
! Opcodes 0398 - 039F
K398:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl166
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl166:
jmp @r4
mov #0x1C,r2
! Opcodes 03A0 - 03A7
K3A0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl167
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl167:
jmp @r4
mov #0x1C,r2
! Opcodes 03A8 - 03AF
K3A8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl168
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl168:
jmp @r4
mov #0x1C,r2
! Opcodes 03B0 - 03B7
K3B0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl169
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl169:
jmp @r4
mov #0x1C,r2
! Opcode 03B8
K3B8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl170
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl170:
jmp @r4
mov #0x1C,r2
! Opcode 03B9
K3B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl171
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl171:
jmp @r4
mov #0x1C,r2
! Opcodes 03C0 - 03C7
K3C0:
and r0,r2
mov #4,r0
mov.b @(r0,r13),r0
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
or r4,r1
mov.l r1,@r2
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl172
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl172:
jmp @r4
mov #0x1C,r2
! Opcodes 03C8 - 03CF
K3C8:
mov.l r3,@-r15
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(4,r13),r2
swap.w r2,r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
add #2,r4
swap.w r2,r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
mov.l @r15+,r3
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl173
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl173:
jmp @r4
mov #0x1C,r2
! Opcodes 03D0 - 03D7
K3D0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl174
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl174:
jmp @r4
mov #0x1C,r2
! Opcodes 03D8 - 03DF
K3D8:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl175
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl175:
jmp @r4
mov #0x1C,r2
! Opcodes 03E0 - 03E7
K3E0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl176
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl176:
jmp @r4
mov #0x1C,r2
! Opcodes 03E8 - 03EF
K3E8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl177
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl177:
jmp @r4
mov #0x1C,r2
! Opcodes 03F0 - 03F7
K3F0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl178
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl178:
jmp @r4
mov #0x1C,r2
! Opcode 03F8
K3F8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl179
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl179:
jmp @r4
mov #0x1C,r2
! Opcode 03F9
K3F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl180
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl180:
jmp @r4
mov #0x1C,r2
! Opcodes 0400 - 0407
K400:
and r0,r2
mov.w @r6+,r1
exts.b r1,r1
add r13,r2
mov.b @r2,r3
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.b r3,@r2
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl181
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl181:
jmp @r4
mov #0x1C,r2
! Opcodes 0410 - 0417
K410:
and r0,r2
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl182
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl182:
jmp @r4
mov #0x1C,r2
! Opcodes 0418 - 041F
K418:
and r0,r2
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl183
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl183:
jmp @r4
mov #0x1C,r2
! Opcodes 0420 - 0427
K420:
and r0,r2
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl184
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl184:
jmp @r4
mov #0x1C,r2
! Opcodes 0428 - 042F
K428:
and r0,r2
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl185
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl185:
jmp @r4
mov #0x1C,r2
! Opcodes 0430 - 0437
K430:
and r0,r2
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl186
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl186:
jmp @r4
mov #0x1C,r2
! Opcode 0438
K438:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl187
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl187:
jmp @r4
mov #0x1C,r2
! Opcode 0439
K439:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl188
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl188:
jmp @r4
mov #0x1C,r2
! Opcodes 0440 - 0447
K440:
and r0,r2
mov.w @r6+,r1
add r13,r2
mov.w @r2,r3
shll16 r1
shll16 r3
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.w r3,@r2
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl189
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl189:
jmp @r4
mov #0x1C,r2
! Opcodes 0450 - 0457
K450:
and r0,r2
mov.w @r6+,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl190
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl190:
jmp @r4
mov #0x1C,r2
! Opcodes 0458 - 045F
K458:
and r0,r2
mov.w @r6+,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl191
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl191:
jmp @r4
mov #0x1C,r2
! Opcodes 0460 - 0467
K460:
and r0,r2
mov.w @r6+,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl192
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl192:
jmp @r4
mov #0x1C,r2
! Opcodes 0468 - 046F
K468:
and r0,r2
mov.w @r6+,r1
mov r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl193
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl193:
jmp @r4
mov #0x1C,r2
! Opcodes 0470 - 0477
K470:
and r0,r2
mov.w @r6+,r1
mov r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl194
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl194:
jmp @r4
mov #0x1C,r2
! Opcode 0478
K478:
mov.w @r6+,r1
mov r1,r8
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl195
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl195:
jmp @r4
mov #0x1C,r2
! Opcode 0479
K479:
mov.w @r6+,r1
mov r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl196
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl196:
jmp @r4
mov #0x1C,r2
! Opcodes 0480 - 0487
K480:
and r0,r2
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
add r13,r2
mov.l @r2,r3
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
movt r9
addc r8,r8
mov.l r3,@r2
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl197
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl197:
jmp @r4
mov #0x1C,r2
! Opcodes 0490 - 0497
K490:
and r0,r2
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl198
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl198:
jmp @r4
mov #0x1C,r2
! Opcodes 0498 - 049F
K498:
and r0,r2
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl199
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl199:
jmp @r4
mov #0x1C,r2
! Opcodes 04A0 - 04A7
K4A0:
and r0,r2
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl200
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl200:
jmp @r4
mov #0x1C,r2
! Opcodes 04A8 - 04AF
K4A8:
and r0,r2
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-32,r7
shll2 r0
cmp/pl r7
bt/s fdl201
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl201:
jmp @r4
mov #0x1C,r2
! Opcodes 04B0 - 04B7
K4B0:
and r0,r2
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-34,r7
shll2 r0
cmp/pl r7
bt/s fdl202
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl202:
jmp @r4
mov #0x1C,r2
! Opcode 04B8
K4B8:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-32,r7
shll2 r0
cmp/pl r7
bt/s fdl203
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl203:
jmp @r4
mov #0x1C,r2
! Opcode 04B9
K4B9:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-36,r7
shll2 r0
cmp/pl r7
bt/s fdl204
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl204:
jmp @r4
mov #0x1C,r2
! Opcodes 0500 - 0507
K500:
and r0,r2
mov #8,r0
mov.b @(r0,r13),r0
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
mov.w @r6+,r0
add #-6,r7
shll2 r0
cmp/pl r7
bt/s fdl205
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl205:
jmp @r4
mov #0x1C,r2
! Opcodes 0508 - 050F
K508:
mov.l r3,@-r15
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add r1,r4
mov r3,r2
extu.b r2,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
mov #8,r0
mov.w r2,@(r0,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl206
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl206:
jmp @r4
mov #0x1C,r2
! Opcodes 0510 - 0517
K510:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl207
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl207:
jmp @r4
mov #0x1C,r2
! Opcodes 0518 - 051F
K518:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #8,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl208
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl208:
jmp @r4
mov #0x1C,r2
! Opcodes 0520 - 0527
K520:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #8,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-10,r7
shll2 r0
cmp/pl r7
bt/s fdl209
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl209:
jmp @r4
mov #0x1C,r2
! Opcodes 0528 - 052F
K528:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl210
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl210:
jmp @r4
mov #0x1C,r2
! Opcodes 0530 - 0537
K530:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl211
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl211:
jmp @r4
mov #0x1C,r2
! Opcode 0538
K538:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl212
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl212:
jmp @r4
mov #0x1C,r2
! Opcode 0539
K539:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl213
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl213:
jmp @r4
mov #0x1C,r2
! Opcode 053A
K53A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl214
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl214:
jmp @r4
mov #0x1C,r2
! Opcode 053B
K53B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl215
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl215:
jmp @r4
mov #0x1C,r2
! Opcode 053C
K53C:
mov.b @r6,r3
add #2,r6
mov #8,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl216
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl216:
jmp @r4
mov #0x1C,r2
! Opcodes 0540 - 0547
K540:
and r0,r2
mov #8,r0
mov.b @(r0,r13),r0
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
xor r4,r1
mov.l r1,@r2
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl217
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl217:
jmp @r4
mov #0x1C,r2
! Opcodes 0548 - 054F
K548:
mov.l r3,@-r15
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add r1,r4
mov r3,r2
extu.b r2,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
shll8 r2
extu.b r3,r3
or r3,r2
mov.l r2,@(8,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl218
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl218:
jmp @r4
mov #0x1C,r2
! Opcodes 0550 - 0557
K550:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl219
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl219:
jmp @r4
mov #0x1C,r2
! Opcodes 0558 - 055F
K558:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl220
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl220:
jmp @r4
mov #0x1C,r2
! Opcodes 0560 - 0567
K560:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl221
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl221:
jmp @r4
mov #0x1C,r2
! Opcodes 0568 - 056F
K568:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl222
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl222:
jmp @r4
mov #0x1C,r2
! Opcodes 0570 - 0577
K570:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl223
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl223:
jmp @r4
mov #0x1C,r2
! Opcode 0578
K578:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl224
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl224:
jmp @r4
mov #0x1C,r2
! Opcode 0579
K579:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl225
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl225:
jmp @r4
mov #0x1C,r2
! Opcodes 0580 - 0587
K580:
and r0,r2
mov #8,r0
mov.b @(r0,r13),r0
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
not r4,r4
and r4,r1
mov.l r1,@r2
mov.w @r6+,r0
add #-10,r7
shll2 r0
cmp/pl r7
bt/s fdl226
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl226:
jmp @r4
mov #0x1C,r2
! Opcodes 0588 - 058F
K588:
mov.l r3,@-r15
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(8,r13),r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl227
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl227:
jmp @r4
mov #0x1C,r2
! Opcodes 0590 - 0597
K590:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl228
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl228:
jmp @r4
mov #0x1C,r2
! Opcodes 0598 - 059F
K598:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl229
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl229:
jmp @r4
mov #0x1C,r2
! Opcodes 05A0 - 05A7
K5A0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl230
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl230:
jmp @r4
mov #0x1C,r2
! Opcodes 05A8 - 05AF
K5A8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl231
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl231:
jmp @r4
mov #0x1C,r2
! Opcodes 05B0 - 05B7
K5B0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl232
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl232:
jmp @r4
mov #0x1C,r2
! Opcode 05B8
K5B8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl233
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl233:
jmp @r4
mov #0x1C,r2
! Opcode 05B9
K5B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl234
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl234:
jmp @r4
mov #0x1C,r2
! Opcodes 05C0 - 05C7
K5C0:
and r0,r2
mov #8,r0
mov.b @(r0,r13),r0
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
or r4,r1
mov.l r1,@r2
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl235
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl235:
jmp @r4
mov #0x1C,r2
! Opcodes 05C8 - 05CF
K5C8:
mov.l r3,@-r15
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(8,r13),r2
swap.w r2,r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
add #2,r4
swap.w r2,r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
mov.l @r15+,r3
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl236
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl236:
jmp @r4
mov #0x1C,r2
! Opcodes 05D0 - 05D7
K5D0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl237
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl237:
jmp @r4
mov #0x1C,r2
! Opcodes 05D8 - 05DF
K5D8:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl238
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl238:
jmp @r4
mov #0x1C,r2
! Opcodes 05E0 - 05E7
K5E0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl239
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl239:
jmp @r4
mov #0x1C,r2
! Opcodes 05E8 - 05EF
K5E8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl240
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl240:
jmp @r4
mov #0x1C,r2
! Opcodes 05F0 - 05F7
K5F0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl241
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl241:
jmp @r4
mov #0x1C,r2
! Opcode 05F8
K5F8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl242
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl242:
jmp @r4
mov #0x1C,r2
! Opcode 05F9
K5F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl243
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl243:
jmp @r4
mov #0x1C,r2
! Opcodes 0600 - 0607
K600:
and r0,r2
mov.w @r6+,r1
exts.b r1,r1
add r13,r2
mov.b @r2,r3
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r0
movt r8
clrt
addc r1,r3
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.b r3,@r2
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl244
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl244:
jmp @r4
mov #0x1C,r2
! Opcodes 0610 - 0617
K610:
and r0,r2
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r0
movt r8
clrt
addc r1,r3
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl245
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl245:
jmp @r4
mov #0x1C,r2
! Opcodes 0618 - 061F
K618:
and r0,r2
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r0
movt r8
clrt
addc r1,r3
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl246
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl246:
jmp @r4
mov #0x1C,r2
! Opcodes 0620 - 0627
K620:
and r0,r2
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r0
movt r8
clrt
addc r1,r3
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl247
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl247:
jmp @r4
mov #0x1C,r2
! Opcodes 0628 - 062F
K628:
and r0,r2
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r0
movt r8
clrt
addc r1,r3
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl248
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl248:
jmp @r4
mov #0x1C,r2
! Opcodes 0630 - 0637
K630:
and r0,r2
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r0
movt r8
clrt
addc r1,r3
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl249
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl249:
jmp @r4
mov #0x1C,r2
! Opcode 0638
K638:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r0
movt r8
clrt
addc r1,r3
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl250
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl250:
jmp @r4
mov #0x1C,r2
! Opcode 0639
K639:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
addv r1,r0
movt r8
clrt
addc r1,r3
movt r9
addc r8,r8
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl251
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl251:
jmp @r4
mov #0x1C,r2
! Opcodes 0640 - 0647
K640:
and r0,r2
mov.w @r6+,r1
add r13,r2
mov.w @r2,r3
shll16 r1
shll16 r3
mov r3,r0
addv r1,r0
movt r8
clrt
addc r1,r3
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.w r3,@r2
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl252
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl252:
jmp @r4
mov #0x1C,r2
! Opcodes 0650 - 0657
K650:
and r0,r2
mov.w @r6+,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r0
movt r8
clrt
addc r1,r3
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl253
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl253:
jmp @r4
mov #0x1C,r2
! Opcodes 0658 - 065F
K658:
and r0,r2
mov.w @r6+,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r0
movt r8
clrt
addc r1,r3
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl254
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl254:
jmp @r4
mov #0x1C,r2
! Opcodes 0660 - 0667
K660:
and r0,r2
mov.w @r6+,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r0
movt r8
clrt
addc r1,r3
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl255
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl255:
jmp @r4
mov #0x1C,r2
! Opcodes 0668 - 066F
K668:
and r0,r2
mov.w @r6+,r1
mov r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r0
movt r8
clrt
addc r1,r3
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl256
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl256:
jmp @r4
mov #0x1C,r2
! Opcodes 0670 - 0677
K670:
and r0,r2
mov.w @r6+,r1
mov r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r0
movt r8
clrt
addc r1,r3
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl257
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl257:
jmp @r4
mov #0x1C,r2
! Opcode 0678
K678:
mov.w @r6+,r1
mov r1,r8
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r0
movt r8
clrt
addc r1,r3
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl258
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl258:
jmp @r4
mov #0x1C,r2
! Opcode 0679
K679:
mov.w @r6+,r1
mov r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
shll16 r1
shll16 r3
mov r3,r0
addv r1,r0
movt r8
clrt
addc r1,r3
movt r9
addc r8,r8
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl259
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl259:
jmp @r4
mov #0x1C,r2
! Opcodes 0680 - 0687
K680:
and r0,r2
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
add r13,r2
mov.l @r2,r3
mov r3,r0
addv r1,r0
movt r8
clrt
addc r1,r3
movt r9
addc r8,r8
mov.l r3,@r2
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl260
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl260:
jmp @r4
mov #0x1C,r2
! Opcodes 0690 - 0697
K690:
and r0,r2
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov r3,r0
addv r1,r0
movt r8
clrt
addc r1,r3
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl261
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl261:
jmp @r4
mov #0x1C,r2
! Opcodes 0698 - 069F
K698:
and r0,r2
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov r3,r0
addv r1,r0
movt r8
clrt
addc r1,r3
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl262
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl262:
jmp @r4
mov #0x1C,r2
! Opcodes 06A0 - 06A7
K6A0:
and r0,r2
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov r3,r0
addv r1,r0
movt r8
clrt
addc r1,r3
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl263
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl263:
jmp @r4
mov #0x1C,r2
! Opcodes 06A8 - 06AF
K6A8:
and r0,r2
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov r3,r0
addv r1,r0
movt r8
clrt
addc r1,r3
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-32,r7
shll2 r0
cmp/pl r7
bt/s fdl264
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl264:
jmp @r4
mov #0x1C,r2
! Opcodes 06B0 - 06B7
K6B0:
and r0,r2
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov r3,r0
addv r1,r0
movt r8
clrt
addc r1,r3
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-34,r7
shll2 r0
cmp/pl r7
bt/s fdl265
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl265:
jmp @r4
mov #0x1C,r2
! Opcode 06B8
K6B8:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov r3,r0
addv r1,r0
movt r8
clrt
addc r1,r3
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-32,r7
shll2 r0
cmp/pl r7
bt/s fdl266
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl266:
jmp @r4
mov #0x1C,r2
! Opcode 06B9
K6B9:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov r3,r0
addv r1,r0
movt r8
clrt
addc r1,r3
movt r9
addc r8,r8
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-36,r7
shll2 r0
cmp/pl r7
bt/s fdl267
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl267:
jmp @r4
mov #0x1C,r2
! Opcodes 0700 - 0707
K700:
and r0,r2
mov #12,r0
mov.b @(r0,r13),r0
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
mov.w @r6+,r0
add #-6,r7
shll2 r0
cmp/pl r7
bt/s fdl268
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl268:
jmp @r4
mov #0x1C,r2
! Opcodes 0708 - 070F
K708:
mov.l r3,@-r15
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add r1,r4
mov r3,r2
extu.b r2,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
mov #12,r0
mov.w r2,@(r0,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl269
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl269:
jmp @r4
mov #0x1C,r2
! Opcodes 0710 - 0717
K710:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl270
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl270:
jmp @r4
mov #0x1C,r2
! Opcodes 0718 - 071F
K718:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #12,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl271
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl271:
jmp @r4
mov #0x1C,r2
! Opcodes 0720 - 0727
K720:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #12,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-10,r7
shll2 r0
cmp/pl r7
bt/s fdl272
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl272:
jmp @r4
mov #0x1C,r2
! Opcodes 0728 - 072F
K728:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl273
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl273:
jmp @r4
mov #0x1C,r2
! Opcodes 0730 - 0737
K730:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl274
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl274:
jmp @r4
mov #0x1C,r2
! Opcode 0738
K738:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl275
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl275:
jmp @r4
mov #0x1C,r2
! Opcode 0739
K739:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl276
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl276:
jmp @r4
mov #0x1C,r2
! Opcode 073A
K73A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl277
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl277:
jmp @r4
mov #0x1C,r2
! Opcode 073B
K73B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl278
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl278:
jmp @r4
mov #0x1C,r2
! Opcode 073C
K73C:
mov.b @r6,r3
add #2,r6
mov #12,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl279
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl279:
jmp @r4
mov #0x1C,r2
! Opcodes 0740 - 0747
K740:
and r0,r2
mov #12,r0
mov.b @(r0,r13),r0
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
xor r4,r1
mov.l r1,@r2
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl280
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl280:
jmp @r4
mov #0x1C,r2
! Opcodes 0748 - 074F
K748:
mov.l r3,@-r15
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add r1,r4
mov r3,r2
extu.b r2,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
shll8 r2
extu.b r3,r3
or r3,r2
mov.l r2,@(12,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl281
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl281:
jmp @r4
mov #0x1C,r2
! Opcodes 0750 - 0757
K750:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl282
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl282:
jmp @r4
mov #0x1C,r2
! Opcodes 0758 - 075F
K758:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl283
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl283:
jmp @r4
mov #0x1C,r2
! Opcodes 0760 - 0767
K760:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl284
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl284:
jmp @r4
mov #0x1C,r2
! Opcodes 0768 - 076F
K768:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl285
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl285:
jmp @r4
mov #0x1C,r2
! Opcodes 0770 - 0777
K770:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl286
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl286:
jmp @r4
mov #0x1C,r2
! Opcode 0778
K778:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl287
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl287:
jmp @r4
mov #0x1C,r2
! Opcode 0779
K779:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl288
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl288:
jmp @r4
mov #0x1C,r2
! Opcodes 0780 - 0787
K780:
and r0,r2
mov #12,r0
mov.b @(r0,r13),r0
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
not r4,r4
and r4,r1
mov.l r1,@r2
mov.w @r6+,r0
add #-10,r7
shll2 r0
cmp/pl r7
bt/s fdl289
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl289:
jmp @r4
mov #0x1C,r2
! Opcodes 0788 - 078F
K788:
mov.l r3,@-r15
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(12,r13),r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl290
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl290:
jmp @r4
mov #0x1C,r2
! Opcodes 0790 - 0797
K790:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl291
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl291:
jmp @r4
mov #0x1C,r2
! Opcodes 0798 - 079F
K798:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl292
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl292:
jmp @r4
mov #0x1C,r2
! Opcodes 07A0 - 07A7
K7A0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl293
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl293:
jmp @r4
mov #0x1C,r2
! Opcodes 07A8 - 07AF
K7A8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl294
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl294:
jmp @r4
mov #0x1C,r2
! Opcodes 07B0 - 07B7
K7B0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl295
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl295:
jmp @r4
mov #0x1C,r2
! Opcode 07B8
K7B8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl296
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl296:
jmp @r4
mov #0x1C,r2
! Opcode 07B9
K7B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl297
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl297:
jmp @r4
mov #0x1C,r2
! Opcodes 07C0 - 07C7
K7C0:
and r0,r2
mov #12,r0
mov.b @(r0,r13),r0
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
or r4,r1
mov.l r1,@r2
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl298
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl298:
jmp @r4
mov #0x1C,r2
! Opcodes 07C8 - 07CF
K7C8:
mov.l r3,@-r15
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(12,r13),r2
swap.w r2,r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
add #2,r4
swap.w r2,r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
mov.l @r15+,r3
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl299
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl299:
jmp @r4
mov #0x1C,r2
! Opcodes 07D0 - 07D7
K7D0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl300
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl300:
jmp @r4
mov #0x1C,r2
! Opcodes 07D8 - 07DF
K7D8:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl301
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl301:
jmp @r4
mov #0x1C,r2
! Opcodes 07E0 - 07E7
K7E0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl302
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl302:
jmp @r4
mov #0x1C,r2
! Opcodes 07E8 - 07EF
K7E8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl303
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl303:
jmp @r4
mov #0x1C,r2
! Opcodes 07F0 - 07F7
K7F0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl304
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl304:
jmp @r4
mov #0x1C,r2
! Opcode 07F8
K7F8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl305
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl305:
jmp @r4
mov #0x1C,r2
! Opcode 07F9
K7F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl306
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl306:
jmp @r4
mov #0x1C,r2
! Opcodes 0800 - 0807
K800:
and r0,r2
mov.w @r6+,r0
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
mov.w @r6+,r0
add #-10,r7
shll2 r0
cmp/pl r7
bt/s fdl307
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl307:
jmp @r4
mov #0x1C,r2
! Opcodes 0810 - 0817
K810:
and r0,r2
mov.w @r6+,r0
and #7,r0
mov.l r0,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl308
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl308:
jmp @r4
mov #0x1C,r2
! Opcodes 0818 - 081F
K818:
and r0,r2
mov.w @r6+,r0
and #7,r0
mov.l r0,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl309
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl309:
jmp @r4
mov #0x1C,r2
! Opcodes 0820 - 0827
K820:
and r0,r2
mov.w @r6+,r0
and #7,r0
mov.l r0,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl310
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl310:
jmp @r4
mov #0x1C,r2
! Opcodes 0828 - 082F
K828:
and r0,r2
mov.w @r6+,r0
and #7,r0
mov.l r0,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl311
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl311:
jmp @r4
mov #0x1C,r2
! Opcodes 0830 - 0837
K830:
and r0,r2
mov.w @r6+,r0
and #7,r0
mov.l r0,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl312
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl312:
jmp @r4
mov #0x1C,r2
! Opcode 0838
K838:
mov.w @r6+,r0
and #7,r0
mov.l r0,@-r15
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl313
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl313:
jmp @r4
mov #0x1C,r2
! Opcode 0839
K839:
mov.w @r6+,r0
and #7,r0
mov.l r0,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl314
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl314:
jmp @r4
mov #0x1C,r2
! Opcode 083A
K83A:
mov.w @r6+,r0
and #7,r0
mov.l r0,@-r15
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl315
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl315:
jmp @r4
mov #0x1C,r2
! Opcode 083B
K83B:
mov.w @r6+,r0
and #7,r0
mov.l r0,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl316
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl316:
jmp @r4
mov #0x1C,r2
! Opcode 083C
K83C:
mov.w @r6+,r0
and #7,r0
mov.l r0,@-r15
mov.b @r6,r3
add #2,r6
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl317
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl317:
jmp @r4
mov #0x1C,r2
! Opcodes 0840 - 0847
K840:
and r0,r2
mov.w @r6+,r0
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
xor r4,r1
mov.l r1,@r2
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl318
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl318:
jmp @r4
mov #0x1C,r2
! Opcodes 0850 - 0857
K850:
and r0,r2
mov.w @r6+,r0
and #7,r0
mov.l r0,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl319
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl319:
jmp @r4
mov #0x1C,r2
! Opcodes 0858 - 085F
K858:
and r0,r2
mov.w @r6+,r0
and #7,r0
mov.l r0,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl320
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl320:
jmp @r4
mov #0x1C,r2
! Opcodes 0860 - 0867
K860:
and r0,r2
mov.w @r6+,r0
and #7,r0
mov.l r0,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl321
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl321:
jmp @r4
mov #0x1C,r2
! Opcodes 0868 - 086F
K868:
and r0,r2
mov.w @r6+,r0
and #7,r0
mov.l r0,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl322
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl322:
jmp @r4
mov #0x1C,r2
! Opcodes 0870 - 0877
K870:
and r0,r2
mov.w @r6+,r0
and #7,r0
mov.l r0,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl323
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl323:
jmp @r4
mov #0x1C,r2
! Opcode 0878
K878:
mov.w @r6+,r0
and #7,r0
mov.l r0,@-r15
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl324
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl324:
jmp @r4
mov #0x1C,r2
! Opcode 0879
K879:
mov.w @r6+,r0
and #7,r0
mov.l r0,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl325
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl325:
jmp @r4
mov #0x1C,r2
! Opcodes 0880 - 0887
K880:
and r0,r2
mov.w @r6+,r0
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
not r4,r4
and r4,r1
mov.l r1,@r2
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl326
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl326:
jmp @r4
mov #0x1C,r2
! Opcodes 0890 - 0897
K890:
and r0,r2
mov.w @r6+,r0
and #7,r0
mov.l r0,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl327
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl327:
jmp @r4
mov #0x1C,r2
! Opcodes 0898 - 089F
K898:
and r0,r2
mov.w @r6+,r0
and #7,r0
mov.l r0,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl328
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl328:
jmp @r4
mov #0x1C,r2
! Opcodes 08A0 - 08A7
K8A0:
and r0,r2
mov.w @r6+,r0
and #7,r0
mov.l r0,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl329
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl329:
jmp @r4
mov #0x1C,r2
! Opcodes 08A8 - 08AF
K8A8:
and r0,r2
mov.w @r6+,r0
and #7,r0
mov.l r0,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl330
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl330:
jmp @r4
mov #0x1C,r2
! Opcodes 08B0 - 08B7
K8B0:
and r0,r2
mov.w @r6+,r0
and #7,r0
mov.l r0,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl331
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl331:
jmp @r4
mov #0x1C,r2
! Opcode 08B8
K8B8:
mov.w @r6+,r0
and #7,r0
mov.l r0,@-r15
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl332
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl332:
jmp @r4
mov #0x1C,r2
! Opcode 08B9
K8B9:
mov.w @r6+,r0
and #7,r0
mov.l r0,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl333
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl333:
jmp @r4
mov #0x1C,r2
! Opcodes 08C0 - 08C7
K8C0:
and r0,r2
mov.w @r6+,r0
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
or r4,r1
mov.l r1,@r2
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl334
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl334:
jmp @r4
mov #0x1C,r2
! Opcodes 08D0 - 08D7
K8D0:
and r0,r2
mov.w @r6+,r0
and #7,r0
mov.l r0,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl335
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl335:
jmp @r4
mov #0x1C,r2
! Opcodes 08D8 - 08DF
K8D8:
and r0,r2
mov.w @r6+,r0
and #7,r0
mov.l r0,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl336
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl336:
jmp @r4
mov #0x1C,r2
! Opcodes 08E0 - 08E7
K8E0:
and r0,r2
mov.w @r6+,r0
and #7,r0
mov.l r0,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl337
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl337:
jmp @r4
mov #0x1C,r2
! Opcodes 08E8 - 08EF
K8E8:
and r0,r2
mov.w @r6+,r0
and #7,r0
mov.l r0,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl338
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl338:
jmp @r4
mov #0x1C,r2
! Opcodes 08F0 - 08F7
K8F0:
and r0,r2
mov.w @r6+,r0
and #7,r0
mov.l r0,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl339
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl339:
jmp @r4
mov #0x1C,r2
! Opcode 08F8
K8F8:
mov.w @r6+,r0
and #7,r0
mov.l r0,@-r15
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl340
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl340:
jmp @r4
mov #0x1C,r2
! Opcode 08F9
K8F9:
mov.w @r6+,r0
and #7,r0
mov.l r0,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r0
mov #1,r1
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl341
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl341:
jmp @r4
mov #0x1C,r2
! Opcodes 0900 - 0907
K900:
and r0,r2
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
mov.w @r6+,r0
add #-6,r7
shll2 r0
cmp/pl r7
bt/s fdl342
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl342:
jmp @r4
mov #0x1C,r2
! Opcodes 0908 - 090F
K908:
mov.l r3,@-r15
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add r1,r4
mov r3,r2
extu.b r2,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
mov #16,r0
mov.w r2,@(r0,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl343
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl343:
jmp @r4
mov #0x1C,r2
! Opcodes 0910 - 0917
K910:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl344
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl344:
jmp @r4
mov #0x1C,r2
! Opcodes 0918 - 091F
K918:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl345
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl345:
jmp @r4
mov #0x1C,r2
! Opcodes 0920 - 0927
K920:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-10,r7
shll2 r0
cmp/pl r7
bt/s fdl346
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl346:
jmp @r4
mov #0x1C,r2
! Opcodes 0928 - 092F
K928:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl347
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl347:
jmp @r4
mov #0x1C,r2
! Opcodes 0930 - 0937
K930:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl348
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl348:
jmp @r4
mov #0x1C,r2
! Opcode 0938
K938:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl349
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl349:
jmp @r4
mov #0x1C,r2
! Opcode 0939
K939:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl350
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl350:
jmp @r4
mov #0x1C,r2
! Opcode 093A
K93A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl351
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl351:
jmp @r4
mov #0x1C,r2
! Opcode 093B
K93B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl352
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl352:
jmp @r4
mov #0x1C,r2
! Opcode 093C
K93C:
mov.b @r6,r3
add #2,r6
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl353
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl353:
jmp @r4
mov #0x1C,r2
! Opcodes 0940 - 0947
K940:
and r0,r2
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
xor r4,r1
mov.l r1,@r2
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl354
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl354:
jmp @r4
mov #0x1C,r2
! Opcodes 0948 - 094F
K948:
mov.l r3,@-r15
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add r1,r4
mov r3,r2
extu.b r2,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
shll8 r2
extu.b r3,r3
or r3,r2
mov.l r2,@(16,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl355
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl355:
jmp @r4
mov #0x1C,r2
! Opcodes 0950 - 0957
K950:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl356
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl356:
jmp @r4
mov #0x1C,r2
! Opcodes 0958 - 095F
K958:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl357
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl357:
jmp @r4
mov #0x1C,r2
! Opcodes 0960 - 0967
K960:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl358
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl358:
jmp @r4
mov #0x1C,r2
! Opcodes 0968 - 096F
K968:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl359
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl359:
jmp @r4
mov #0x1C,r2
! Opcodes 0970 - 0977
K970:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl360
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl360:
jmp @r4
mov #0x1C,r2
! Opcode 0978
K978:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl361
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl361:
jmp @r4
mov #0x1C,r2
! Opcode 0979
K979:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl362
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl362:
jmp @r4
mov #0x1C,r2
! Opcodes 0980 - 0987
K980:
and r0,r2
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
not r4,r4
and r4,r1
mov.l r1,@r2
mov.w @r6+,r0
add #-10,r7
shll2 r0
cmp/pl r7
bt/s fdl363
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl363:
jmp @r4
mov #0x1C,r2
! Opcodes 0988 - 098F
K988:
mov.l r3,@-r15
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(16,r13),r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl364
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl364:
jmp @r4
mov #0x1C,r2
! Opcodes 0990 - 0997
K990:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl365
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl365:
jmp @r4
mov #0x1C,r2
! Opcodes 0998 - 099F
K998:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl366
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl366:
jmp @r4
mov #0x1C,r2
! Opcodes 09A0 - 09A7
K9A0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl367
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl367:
jmp @r4
mov #0x1C,r2
! Opcodes 09A8 - 09AF
K9A8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl368
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl368:
jmp @r4
mov #0x1C,r2
! Opcodes 09B0 - 09B7
K9B0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl369
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl369:
jmp @r4
mov #0x1C,r2
! Opcode 09B8
K9B8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl370
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl370:
jmp @r4
mov #0x1C,r2
! Opcode 09B9
K9B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl371
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl371:
jmp @r4
mov #0x1C,r2
! Opcodes 09C0 - 09C7
K9C0:
and r0,r2
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
or r4,r1
mov.l r1,@r2
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl372
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl372:
jmp @r4
mov #0x1C,r2
! Opcodes 09C8 - 09CF
K9C8:
mov.l r3,@-r15
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(16,r13),r2
swap.w r2,r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
add #2,r4
swap.w r2,r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
mov.l @r15+,r3
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl373
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl373:
jmp @r4
mov #0x1C,r2
! Opcodes 09D0 - 09D7
K9D0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl374
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl374:
jmp @r4
mov #0x1C,r2
! Opcodes 09D8 - 09DF
K9D8:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl375
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl375:
jmp @r4
mov #0x1C,r2
! Opcodes 09E0 - 09E7
K9E0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl376
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl376:
jmp @r4
mov #0x1C,r2
! Opcodes 09E8 - 09EF
K9E8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl377
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl377:
jmp @r4
mov #0x1C,r2
! Opcodes 09F0 - 09F7
K9F0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl378
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl378:
jmp @r4
mov #0x1C,r2
! Opcode 09F8
K9F8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl379
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl379:
jmp @r4
mov #0x1C,r2
! Opcode 09F9
K9F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl380
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl380:
jmp @r4
mov #0x1C,r2
! Opcodes 0A00 - 0A07
KA00:
and r0,r2
mov.w @r6+,r1
exts.b r1,r1
add r13,r2
mov.b @r2,r3
xor r1,r3
mov.b r3,@r2
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl381
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl381:
jmp @r4
mov #0x1C,r2
! Opcodes 0A10 - 0A17
KA10:
and r0,r2
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl382
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl382:
jmp @r4
mov #0x1C,r2
! Opcodes 0A18 - 0A1F
KA18:
and r0,r2
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl383
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl383:
jmp @r4
mov #0x1C,r2
! Opcodes 0A20 - 0A27
KA20:
and r0,r2
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl384
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl384:
jmp @r4
mov #0x1C,r2
! Opcodes 0A28 - 0A2F
KA28:
and r0,r2
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl385
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl385:
jmp @r4
mov #0x1C,r2
! Opcodes 0A30 - 0A37
KA30:
and r0,r2
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl386
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl386:
jmp @r4
mov #0x1C,r2
! Opcode 0A38
KA38:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl387
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl387:
jmp @r4
mov #0x1C,r2
! Opcode 0A39
KA39:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl388
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl388:
jmp @r4
mov #0x1C,r2
! Opcode 0A3C
KA3C:
mov.w @r6+,r2
mov r8,r0
mov r9,r1
shlr r0
addc r1,r1
tst r3,r3
addc r1,r1
and #3,r0
mov r1,r3
shll2 r3
or r0,r3
xor r2,r3
mov #3,r8
and r3,r8
mov r3,r9
shlr2 r9
not r9,r3
shlr r9
mov #1,r0
shlr r9
addc r8,r8
and r0,r9
and r0,r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl389
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl389:
jmp @r4
mov #0x1C,r2
! Opcodes 0A40 - 0A47
KA40:
and r0,r2
mov.w @r6+,r1
add r13,r2
mov.w @r2,r3
xor r1,r3
mov.w r3,@r2
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl390
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl390:
jmp @r4
mov #0x1C,r2
! Opcodes 0A50 - 0A57
KA50:
and r0,r2
mov.w @r6+,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
xor r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl391
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl391:
jmp @r4
mov #0x1C,r2
! Opcodes 0A58 - 0A5F
KA58:
and r0,r2
mov.w @r6+,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
xor r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl392
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl392:
jmp @r4
mov #0x1C,r2
! Opcodes 0A60 - 0A67
KA60:
and r0,r2
mov.w @r6+,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
xor r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl393
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl393:
jmp @r4
mov #0x1C,r2
! Opcodes 0A68 - 0A6F
KA68:
and r0,r2
mov.w @r6+,r1
mov r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
xor r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl394
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl394:
jmp @r4
mov #0x1C,r2
! Opcodes 0A70 - 0A77
KA70:
and r0,r2
mov.w @r6+,r1
mov r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
xor r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl395
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl395:
jmp @r4
mov #0x1C,r2
! Opcode 0A78
KA78:
mov.w @r6+,r1
mov r1,r8
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
xor r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl396
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl396:
jmp @r4
mov #0x1C,r2
! Opcode 0A79
KA79:
mov.w @r6+,r1
mov r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
xor r1,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl397
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl397:
jmp @r4
mov #0x1C,r2
! Opcode 0A7C
KA7C:
mov r10,r0
tst #0x20,r0
bf pcheck_ok398
mov.l priviolation_addr398,r0
jmp @r0
nop
.align 2
priviolation_addr398: .long privilege_violation
pcheck_ok398:
mov.w @r6+,r2
mov r8,r0
mov r9,r1
shlr r0
addc r1,r1
tst r3,r3
addc r1,r1
and #3,r0
mov r1,r3
shll2 r3
or r0,r3
mov r10,r0
shll8 r0
or r0,r3
xor r2,r3
mov r3,r0
shlr8 r0
xor r10,r0
tst #0x20,r0
bt ln399
mov.l @(32,r14),r0
mov.l @(60,r13),r1
mov.l r0,@(60,r13)
mov.l r1,@(32,r14)
ln399:
mov r3,r0
shlr8 r0
and #0xA7,r0
mov r0,r10
mov #3,r8
and r3,r8
mov r3,r9
shlr2 r9
not r9,r3
shlr r9
mov #1,r0
shlr r9
addc r8,r8
and r0,r9
and r0,r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s continue401
mov.l @(r0,r12),r4
bra fdl401
mov.l @(execexit_addr-areg,r14),r4
continue401:
lds r0,MACL
mov r10,r0
tst #0x80,r0
bt fde401
mov.l execinfo_ptr401,r1
mov.w @r1,r0
mov.l trace_excep_ptr401,r2
sub r5,r6
jmp @r2
add #-2,r6
fde401:
sts MACL,r0
fdl401:
jmp @r4
mov #0x1C,r2
.align 2
execinfo_ptr401: .long execinfo
trace_excep_ptr401: .long trace_excep
! Opcodes 0A80 - 0A87
KA80:
and r0,r2
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
add r13,r2
mov.l @r2,r3
xor r1,r3
mov.l r3,@r2
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl402
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl402:
jmp @r4
mov #0x1C,r2
! Opcodes 0A90 - 0A97
KA90:
and r0,r2
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
xor r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl403
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl403:
jmp @r4
mov #0x1C,r2
! Opcodes 0A98 - 0A9F
KA98:
and r0,r2
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
xor r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl404
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl404:
jmp @r4
mov #0x1C,r2
! Opcodes 0AA0 - 0AA7
KAA0:
and r0,r2
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
xor r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl405
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl405:
jmp @r4
mov #0x1C,r2
! Opcodes 0AA8 - 0AAF
KAA8:
and r0,r2
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
xor r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-32,r7
shll2 r0
cmp/pl r7
bt/s fdl406
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl406:
jmp @r4
mov #0x1C,r2
! Opcodes 0AB0 - 0AB7
KAB0:
and r0,r2
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
xor r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-34,r7
shll2 r0
cmp/pl r7
bt/s fdl407
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl407:
jmp @r4
mov #0x1C,r2
! Opcode 0AB8
KAB8:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
xor r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-32,r7
shll2 r0
cmp/pl r7
bt/s fdl408
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl408:
jmp @r4
mov #0x1C,r2
! Opcode 0AB9
KAB9:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
xor r1,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-36,r7
shll2 r0
cmp/pl r7
bt/s fdl409
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl409:
jmp @r4
mov #0x1C,r2
! Opcodes 0B00 - 0B07
KB00:
and r0,r2
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
mov.w @r6+,r0
add #-6,r7
shll2 r0
cmp/pl r7
bt/s fdl410
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl410:
jmp @r4
mov #0x1C,r2
! Opcodes 0B08 - 0B0F
KB08:
mov.l r3,@-r15
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add r1,r4
mov r3,r2
extu.b r2,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
mov #20,r0
mov.w r2,@(r0,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl411
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl411:
jmp @r4
mov #0x1C,r2
! Opcodes 0B10 - 0B17
KB10:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl412
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl412:
jmp @r4
mov #0x1C,r2
! Opcodes 0B18 - 0B1F
KB18:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl413
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl413:
jmp @r4
mov #0x1C,r2
! Opcodes 0B20 - 0B27
KB20:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-10,r7
shll2 r0
cmp/pl r7
bt/s fdl414
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl414:
jmp @r4
mov #0x1C,r2
! Opcodes 0B28 - 0B2F
KB28:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl415
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl415:
jmp @r4
mov #0x1C,r2
! Opcodes 0B30 - 0B37
KB30:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl416
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl416:
jmp @r4
mov #0x1C,r2
! Opcode 0B38
KB38:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl417
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl417:
jmp @r4
mov #0x1C,r2
! Opcode 0B39
KB39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl418
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl418:
jmp @r4
mov #0x1C,r2
! Opcode 0B3A
KB3A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl419
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl419:
jmp @r4
mov #0x1C,r2
! Opcode 0B3B
KB3B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl420
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl420:
jmp @r4
mov #0x1C,r2
! Opcode 0B3C
KB3C:
mov.b @r6,r3
add #2,r6
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl421
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl421:
jmp @r4
mov #0x1C,r2
! Opcodes 0B40 - 0B47
KB40:
and r0,r2
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
xor r4,r1
mov.l r1,@r2
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl422
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl422:
jmp @r4
mov #0x1C,r2
! Opcodes 0B48 - 0B4F
KB48:
mov.l r3,@-r15
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add r1,r4
mov r3,r2
extu.b r2,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
shll8 r2
extu.b r3,r3
or r3,r2
mov.l r2,@(20,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl423
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl423:
jmp @r4
mov #0x1C,r2
! Opcodes 0B50 - 0B57
KB50:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl424
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl424:
jmp @r4
mov #0x1C,r2
! Opcodes 0B58 - 0B5F
KB58:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl425
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl425:
jmp @r4
mov #0x1C,r2
! Opcodes 0B60 - 0B67
KB60:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl426
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl426:
jmp @r4
mov #0x1C,r2
! Opcodes 0B68 - 0B6F
KB68:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl427
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl427:
jmp @r4
mov #0x1C,r2
! Opcodes 0B70 - 0B77
KB70:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl428
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl428:
jmp @r4
mov #0x1C,r2
! Opcode 0B78
KB78:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl429
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl429:
jmp @r4
mov #0x1C,r2
! Opcode 0B79
KB79:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl430
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl430:
jmp @r4
mov #0x1C,r2
! Opcodes 0B80 - 0B87
KB80:
and r0,r2
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
not r4,r4
and r4,r1
mov.l r1,@r2
mov.w @r6+,r0
add #-10,r7
shll2 r0
cmp/pl r7
bt/s fdl431
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl431:
jmp @r4
mov #0x1C,r2
! Opcodes 0B88 - 0B8F
KB88:
mov.l r3,@-r15
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(20,r13),r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl432
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl432:
jmp @r4
mov #0x1C,r2
! Opcodes 0B90 - 0B97
KB90:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl433
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl433:
jmp @r4
mov #0x1C,r2
! Opcodes 0B98 - 0B9F
KB98:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl434
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl434:
jmp @r4
mov #0x1C,r2
! Opcodes 0BA0 - 0BA7
KBA0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl435
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl435:
jmp @r4
mov #0x1C,r2
! Opcodes 0BA8 - 0BAF
KBA8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl436
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl436:
jmp @r4
mov #0x1C,r2
! Opcodes 0BB0 - 0BB7
KBB0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl437
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl437:
jmp @r4
mov #0x1C,r2
! Opcode 0BB8
KBB8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl438
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl438:
jmp @r4
mov #0x1C,r2
! Opcode 0BB9
KBB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl439
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl439:
jmp @r4
mov #0x1C,r2
! Opcodes 0BC0 - 0BC7
KBC0:
and r0,r2
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
or r4,r1
mov.l r1,@r2
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl440
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl440:
jmp @r4
mov #0x1C,r2
! Opcodes 0BC8 - 0BCF
KBC8:
mov.l r3,@-r15
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(20,r13),r2
swap.w r2,r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
add #2,r4
swap.w r2,r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
mov.l @r15+,r3
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl441
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl441:
jmp @r4
mov #0x1C,r2
! Opcodes 0BD0 - 0BD7
KBD0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl442
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl442:
jmp @r4
mov #0x1C,r2
! Opcodes 0BD8 - 0BDF
KBD8:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl443
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl443:
jmp @r4
mov #0x1C,r2
! Opcodes 0BE0 - 0BE7
KBE0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl444
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl444:
jmp @r4
mov #0x1C,r2
! Opcodes 0BE8 - 0BEF
KBE8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl445
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl445:
jmp @r4
mov #0x1C,r2
! Opcodes 0BF0 - 0BF7
KBF0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl446
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl446:
jmp @r4
mov #0x1C,r2
! Opcode 0BF8
KBF8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl447
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl447:
jmp @r4
mov #0x1C,r2
! Opcode 0BF9
KBF9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl448
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl448:
jmp @r4
mov #0x1C,r2
! Opcodes 0C00 - 0C07
KC00:
and r0,r2
mov.w @r6+,r1
exts.b r1,r1
add r13,r2
mov.b @r2,r3
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
addc r8,r8
mov #-24,r0
shad r0,r3
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl449
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl449:
jmp @r4
mov #0x1C,r2
! Opcodes 0C10 - 0C17
KC10:
and r0,r2
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
addc r8,r8
mov #-24,r0
shad r0,r3
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl450
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl450:
jmp @r4
mov #0x1C,r2
! Opcodes 0C18 - 0C1F
KC18:
and r0,r2
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov r8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
addc r8,r8
mov #-24,r0
shad r0,r3
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl451
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl451:
jmp @r4
mov #0x1C,r2
! Opcodes 0C20 - 0C27
KC20:
and r0,r2
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov r8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
addc r8,r8
mov #-24,r0
shad r0,r3
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl452
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl452:
jmp @r4
mov #0x1C,r2
! Opcodes 0C28 - 0C2F
KC28:
and r0,r2
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
addc r8,r8
mov #-24,r0
shad r0,r3
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl453
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl453:
jmp @r4
mov #0x1C,r2
! Opcodes 0C30 - 0C37
KC30:
and r0,r2
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
addc r8,r8
mov #-24,r0
shad r0,r3
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl454
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl454:
jmp @r4
mov #0x1C,r2
! Opcode 0C38
KC38:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
addc r8,r8
mov #-24,r0
shad r0,r3
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl455
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl455:
jmp @r4
mov #0x1C,r2
! Opcode 0C39
KC39:
mov.w @r6+,r1
exts.b r1,r1
mov r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov #24,r0
shld r0,r1
shld r0,r3
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
addc r8,r8
mov #-24,r0
shad r0,r3
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl456
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl456:
jmp @r4
mov #0x1C,r2
! Opcodes 0C40 - 0C47
KC40:
and r0,r2
mov.w @r6+,r1
add r13,r2
mov.w @r2,r3
shll16 r1
shll16 r3
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
addc r8,r8
mov #-16,r0
shad r0,r3
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl457
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl457:
jmp @r4
mov #0x1C,r2
! Opcodes 0C50 - 0C57
KC50:
and r0,r2
mov.w @r6+,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
addc r8,r8
mov #-16,r0
shad r0,r3
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl458
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl458:
jmp @r4
mov #0x1C,r2
! Opcodes 0C58 - 0C5F
KC58:
and r0,r2
mov.w @r6+,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov r8,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
addc r8,r8
mov #-16,r0
shad r0,r3
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl459
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl459:
jmp @r4
mov #0x1C,r2
! Opcodes 0C60 - 0C67
KC60:
and r0,r2
mov.w @r6+,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov r8,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
addc r8,r8
mov #-16,r0
shad r0,r3
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl460
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl460:
jmp @r4
mov #0x1C,r2
! Opcodes 0C68 - 0C6F
KC68:
and r0,r2
mov.w @r6+,r1
mov r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
addc r8,r8
mov #-16,r0
shad r0,r3
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl461
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl461:
jmp @r4
mov #0x1C,r2
! Opcodes 0C70 - 0C77
KC70:
and r0,r2
mov.w @r6+,r1
mov r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
addc r8,r8
mov #-16,r0
shad r0,r3
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl462
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl462:
jmp @r4
mov #0x1C,r2
! Opcode 0C78
KC78:
mov.w @r6+,r1
mov r1,r8
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
addc r8,r8
mov #-16,r0
shad r0,r3
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl463
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl463:
jmp @r4
mov #0x1C,r2
! Opcode 0C79
KC79:
mov.w @r6+,r1
mov r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
shll16 r1
shll16 r3
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
addc r8,r8
mov #-16,r0
shad r0,r3
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl464
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl464:
jmp @r4
mov #0x1C,r2
! Opcodes 0C80 - 0C87
KC80:
and r0,r2
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
add r13,r2
mov.l @r2,r3
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
addc r8,r8
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl465
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl465:
jmp @r4
mov #0x1C,r2
! Opcodes 0C90 - 0C97
KC90:
and r0,r2
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
addc r8,r8
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl466
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl466:
jmp @r4
mov #0x1C,r2
! Opcodes 0C98 - 0C9F
KC98:
and r0,r2
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov r8,r1
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
addc r8,r8
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl467
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl467:
jmp @r4
mov #0x1C,r2
! Opcodes 0CA0 - 0CA7
KCA0:
and r0,r2
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov r8,r1
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
addc r8,r8
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl468
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl468:
jmp @r4
mov #0x1C,r2
! Opcodes 0CA8 - 0CAF
KCA8:
and r0,r2
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
addc r8,r8
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl469
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl469:
jmp @r4
mov #0x1C,r2
! Opcodes 0CB0 - 0CB7
KCB0:
and r0,r2
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
addc r8,r8
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl470
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl470:
jmp @r4
mov #0x1C,r2
! Opcode 0CB8
KCB8:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
addc r8,r8
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl471
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl471:
jmp @r4
mov #0x1C,r2
! Opcode 0CB9
KCB9:
mov.w @r6+,r0
mov.w @r6+,r1
shll16 r1
xtrct r0,r1
mov r1,r8
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r8,r1
mov r3,r0
subv r1,r0
movt r8
clrt
subc r1,r3
addc r8,r8
rotl r3
addc r8,r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl472
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl472:
jmp @r4
mov #0x1C,r2
! Opcodes 0D00 - 0D07
KD00:
and r0,r2
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
mov.w @r6+,r0
add #-6,r7
shll2 r0
cmp/pl r7
bt/s fdl473
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl473:
jmp @r4
mov #0x1C,r2
! Opcodes 0D08 - 0D0F
KD08:
mov.l r3,@-r15
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add r1,r4
mov r3,r2
extu.b r2,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
mov #24,r0
mov.w r2,@(r0,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl474
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl474:
jmp @r4
mov #0x1C,r2
! Opcodes 0D10 - 0D17
KD10:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl475
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl475:
jmp @r4
mov #0x1C,r2
! Opcodes 0D18 - 0D1F
KD18:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl476
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl476:
jmp @r4
mov #0x1C,r2
! Opcodes 0D20 - 0D27
KD20:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-10,r7
shll2 r0
cmp/pl r7
bt/s fdl477
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl477:
jmp @r4
mov #0x1C,r2
! Opcodes 0D28 - 0D2F
KD28:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl478
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl478:
jmp @r4
mov #0x1C,r2
! Opcodes 0D30 - 0D37
KD30:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl479
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl479:
jmp @r4
mov #0x1C,r2
! Opcode 0D38
KD38:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl480
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl480:
jmp @r4
mov #0x1C,r2
! Opcode 0D39
KD39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl481
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl481:
jmp @r4
mov #0x1C,r2
! Opcode 0D3A
KD3A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl482
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl482:
jmp @r4
mov #0x1C,r2
! Opcode 0D3B
KD3B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl483
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl483:
jmp @r4
mov #0x1C,r2
! Opcode 0D3C
KD3C:
mov.b @r6,r3
add #2,r6
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl484
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl484:
jmp @r4
mov #0x1C,r2
! Opcodes 0D40 - 0D47
KD40:
and r0,r2
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
xor r4,r1
mov.l r1,@r2
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl485
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl485:
jmp @r4
mov #0x1C,r2
! Opcodes 0D48 - 0D4F
KD48:
mov.l r3,@-r15
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add r1,r4
mov r3,r2
extu.b r2,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
shll8 r2
extu.b r3,r3
or r3,r2
mov.l r2,@(24,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl486
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl486:
jmp @r4
mov #0x1C,r2
! Opcodes 0D50 - 0D57
KD50:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl487
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl487:
jmp @r4
mov #0x1C,r2
! Opcodes 0D58 - 0D5F
KD58:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl488
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl488:
jmp @r4
mov #0x1C,r2
! Opcodes 0D60 - 0D67
KD60:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl489
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl489:
jmp @r4
mov #0x1C,r2
! Opcodes 0D68 - 0D6F
KD68:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl490
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl490:
jmp @r4
mov #0x1C,r2
! Opcodes 0D70 - 0D77
KD70:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl491
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl491:
jmp @r4
mov #0x1C,r2
! Opcode 0D78
KD78:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl492
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl492:
jmp @r4
mov #0x1C,r2
! Opcode 0D79
KD79:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl493
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl493:
jmp @r4
mov #0x1C,r2
! Opcodes 0D80 - 0D87
KD80:
and r0,r2
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
not r4,r4
and r4,r1
mov.l r1,@r2
mov.w @r6+,r0
add #-10,r7
shll2 r0
cmp/pl r7
bt/s fdl494
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl494:
jmp @r4
mov #0x1C,r2
! Opcodes 0D88 - 0D8F
KD88:
mov.l r3,@-r15
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(24,r13),r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl495
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl495:
jmp @r4
mov #0x1C,r2
! Opcodes 0D90 - 0D97
KD90:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl496
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl496:
jmp @r4
mov #0x1C,r2
! Opcodes 0D98 - 0D9F
KD98:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl497
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl497:
jmp @r4
mov #0x1C,r2
! Opcodes 0DA0 - 0DA7
KDA0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl498
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl498:
jmp @r4
mov #0x1C,r2
! Opcodes 0DA8 - 0DAF
KDA8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl499
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl499:
jmp @r4
mov #0x1C,r2
! Opcodes 0DB0 - 0DB7
KDB0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl500
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl500:
jmp @r4
mov #0x1C,r2
! Opcode 0DB8
KDB8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl501
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl501:
jmp @r4
mov #0x1C,r2
! Opcode 0DB9
KDB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl502
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl502:
jmp @r4
mov #0x1C,r2
! Opcodes 0DC0 - 0DC7
KDC0:
and r0,r2
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
or r4,r1
mov.l r1,@r2
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl503
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl503:
jmp @r4
mov #0x1C,r2
! Opcodes 0DC8 - 0DCF
KDC8:
mov.l r3,@-r15
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(24,r13),r2
swap.w r2,r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
add #2,r4
swap.w r2,r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
mov.l @r15+,r3
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl504
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl504:
jmp @r4
mov #0x1C,r2
! Opcodes 0DD0 - 0DD7
KDD0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl505
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl505:
jmp @r4
mov #0x1C,r2
! Opcodes 0DD8 - 0DDF
KDD8:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl506
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl506:
jmp @r4
mov #0x1C,r2
! Opcodes 0DE0 - 0DE7
KDE0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl507
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl507:
jmp @r4
mov #0x1C,r2
! Opcodes 0DE8 - 0DEF
KDE8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl508
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl508:
jmp @r4
mov #0x1C,r2
! Opcodes 0DF0 - 0DF7
KDF0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl509
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl509:
jmp @r4
mov #0x1C,r2
! Opcode 0DF8
KDF8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl510
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl510:
jmp @r4
mov #0x1C,r2
! Opcode 0DF9
KDF9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl511
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl511:
jmp @r4
mov #0x1C,r2
! Opcodes 0F00 - 0F07
KF00:
and r0,r2
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
mov.w @r6+,r0
add #-6,r7
shll2 r0
cmp/pl r7
bt/s fdl512
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl512:
jmp @r4
mov #0x1C,r2
! Opcodes 0F08 - 0F0F
KF08:
mov.l r3,@-r15
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add r1,r4
mov r3,r2
extu.b r2,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
mov #28,r0
mov.w r2,@(r0,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl513
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl513:
jmp @r4
mov #0x1C,r2
! Opcodes 0F10 - 0F17
KF10:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl514
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl514:
jmp @r4
mov #0x1C,r2
! Opcodes 0F18 - 0F1F
KF18:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl515
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl515:
jmp @r4
mov #0x1C,r2
! Opcodes 0F20 - 0F27
KF20:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-10,r7
shll2 r0
cmp/pl r7
bt/s fdl516
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl516:
jmp @r4
mov #0x1C,r2
! Opcodes 0F28 - 0F2F
KF28:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl517
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl517:
jmp @r4
mov #0x1C,r2
! Opcodes 0F30 - 0F37
KF30:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl518
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl518:
jmp @r4
mov #0x1C,r2
! Opcode 0F38
KF38:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl519
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl519:
jmp @r4
mov #0x1C,r2
! Opcode 0F39
KF39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl520
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl520:
jmp @r4
mov #0x1C,r2
! Opcode 0F3A
KF3A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl521
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl521:
jmp @r4
mov #0x1C,r2
! Opcode 0F3B
KF3B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl522
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl522:
jmp @r4
mov #0x1C,r2
! Opcode 0F3C
KF3C:
mov.b @r6,r3
add #2,r6
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl523
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl523:
jmp @r4
mov #0x1C,r2
! Opcodes 0F40 - 0F47
KF40:
and r0,r2
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
xor r4,r1
mov.l r1,@r2
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl524
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl524:
jmp @r4
mov #0x1C,r2
! Opcodes 0F48 - 0F4F
KF48:
mov.l r3,@-r15
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add r1,r4
mov r3,r2
extu.b r2,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
shll8 r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
extu.b r3,r3
or r3,r2
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
add #2,r4
shll8 r2
extu.b r3,r3
or r3,r2
mov.l r2,@(28,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl525
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl525:
jmp @r4
mov #0x1C,r2
! Opcodes 0F50 - 0F57
KF50:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl526
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl526:
jmp @r4
mov #0x1C,r2
! Opcodes 0F58 - 0F5F
KF58:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl527
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl527:
jmp @r4
mov #0x1C,r2
! Opcodes 0F60 - 0F67
KF60:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl528
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl528:
jmp @r4
mov #0x1C,r2
! Opcodes 0F68 - 0F6F
KF68:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl529
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl529:
jmp @r4
mov #0x1C,r2
! Opcodes 0F70 - 0F77
KF70:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl530
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl530:
jmp @r4
mov #0x1C,r2
! Opcode 0F78
KF78:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl531
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl531:
jmp @r4
mov #0x1C,r2
! Opcode 0F79
KF79:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
xor r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl532
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl532:
jmp @r4
mov #0x1C,r2
! Opcodes 0F80 - 0F87
KF80:
and r0,r2
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
not r4,r4
and r4,r1
mov.l r1,@r2
mov.w @r6+,r0
add #-10,r7
shll2 r0
cmp/pl r7
bt/s fdl533
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl533:
jmp @r4
mov #0x1C,r2
! Opcodes 0F88 - 0F8F
KF88:
mov.l r3,@-r15
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(28,r13),r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl534
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl534:
jmp @r4
mov #0x1C,r2
! Opcodes 0F90 - 0F97
KF90:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl535
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl535:
jmp @r4
mov #0x1C,r2
! Opcodes 0F98 - 0F9F
KF98:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl536
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl536:
jmp @r4
mov #0x1C,r2
! Opcodes 0FA0 - 0FA7
KFA0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl537
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl537:
jmp @r4
mov #0x1C,r2
! Opcodes 0FA8 - 0FAF
KFA8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl538
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl538:
jmp @r4
mov #0x1C,r2
! Opcodes 0FB0 - 0FB7
KFB0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl539
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl539:
jmp @r4
mov #0x1C,r2
! Opcode 0FB8
KFB8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl540
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl540:
jmp @r4
mov #0x1C,r2
! Opcode 0FB9
KFB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
not r1,r1
and r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl541
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl541:
jmp @r4
mov #0x1C,r2
! Opcodes 0FC0 - 0FC7
KFC0:
and r0,r2
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r4
and #31,r0
add r13,r2
mov.l @r2,r1
shld r0,r4
tst r4,r1
movt r3
dt r3
or r4,r1
mov.l r1,@r2
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl542
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl542:
jmp @r4
mov #0x1C,r2
! Opcodes 0FC8 - 0FCF
KFC8:
mov.l r3,@-r15
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(28,r13),r2
swap.w r2,r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
add #2,r4
swap.w r2,r2
mov r2,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
shlr8 r3
add #2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
mov r2,r3
mov.l @r15+,r3
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl543
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl543:
jmp @r4
mov #0x1C,r2
! Opcodes 0FD0 - 0FD7
KFD0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl544
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl544:
jmp @r4
mov #0x1C,r2
! Opcodes 0FD8 - 0FDF
KFD8:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl545
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl545:
jmp @r4
mov #0x1C,r2
! Opcodes 0FE0 - 0FE7
KFE0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl546
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl546:
jmp @r4
mov #0x1C,r2
! Opcodes 0FE8 - 0FEF
KFE8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl547
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl547:
jmp @r4
mov #0x1C,r2
! Opcodes 0FF0 - 0FF7
KFF0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl548
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl548:
jmp @r4
mov #0x1C,r2
! Opcode 0FF8
KFF8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl549
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl549:
jmp @r4
mov #0x1C,r2
! Opcode 0FF9
KFF9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b @(r0,r13),r0
mov #1,r1
and #7,r0
shld r0,r1
tst r1,r3
rotcl r8
or r1,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
shlr r8
movt r3
dt r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl550
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl550:
jmp @r4
mov #0x1C,r2
! Opcodes 1000 - 1007
L000:
and r0,r2
add r13,r2
mov.b @r2,r3
mov.b r3,@r13
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl551
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl551:
jmp @r4
mov #0x1C,r2
! Opcodes 1008 - 100F
L008:
and r0,r2
add r14,r2
mov.b @r2,r3
mov.b r3,@r13
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl552
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl552:
jmp @r4
mov #0x1C,r2
! Opcodes 1010 - 1017
L010:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b r3,@r13
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl553
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl553:
jmp @r4
mov #0x1C,r2
! Opcodes 1018 - 101F
L018:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.b r3,@r13
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl554
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl554:
jmp @r4
mov #0x1C,r2
! Opcodes 1020 - 1027
L020:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.b r3,@r13
rotl r3
movt r8
mov.w @r6+,r0
add #-10,r7
shll2 r0
cmp/pl r7
bt/s fdl555
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl555:
jmp @r4
mov #0x1C,r2
! Opcodes 1028 - 102F
L028:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b r3,@r13
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl556
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl556:
jmp @r4
mov #0x1C,r2
! Opcodes 1030 - 1037
L030:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b r3,@r13
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl557
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl557:
jmp @r4
mov #0x1C,r2
! Opcode 1038
L038:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b r3,@r13
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl558
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl558:
jmp @r4
mov #0x1C,r2
! Opcode 1039
L039:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b r3,@r13
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl559
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl559:
jmp @r4
mov #0x1C,r2
! Opcode 103A
L03A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b r3,@r13
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl560
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl560:
jmp @r4
mov #0x1C,r2
! Opcode 103B
L03B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.b r3,@r13
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl561
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl561:
jmp @r4
mov #0x1C,r2
! Opcode 103C
L03C:
mov.b @r6,r3
add #2,r6
mov.b r3,@r13
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl562
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl562:
jmp @r4
mov #0x1C,r2
! Opcodes 1080 - 1087
L080:
and r0,r2
add r13,r2
mov.b @r2,r3
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl563
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl563:
jmp @r4
mov #0x1C,r2
! Opcodes 1088 - 108F
L088:
and r0,r2
add r14,r2
mov.b @r2,r3
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl564
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl564:
jmp @r4
mov #0x1C,r2
! Opcodes 1090 - 1097
L090:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl565
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl565:
jmp @r4
mov #0x1C,r2
! Opcodes 1098 - 109F
L098:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl566
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl566:
jmp @r4
mov #0x1C,r2
! Opcodes 10A0 - 10A7
L0A0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl567
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl567:
jmp @r4
mov #0x1C,r2
! Opcodes 10A8 - 10AF
L0A8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl568
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl568:
jmp @r4
mov #0x1C,r2
! Opcodes 10B0 - 10B7
L0B0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl569
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl569:
jmp @r4
mov #0x1C,r2
! Opcode 10B8
L0B8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl570
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl570:
jmp @r4
mov #0x1C,r2
! Opcode 10B9
L0B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl571
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl571:
jmp @r4
mov #0x1C,r2
! Opcode 10BA
L0BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl572
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl572:
jmp @r4
mov #0x1C,r2
! Opcode 10BB
L0BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl573
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl573:
jmp @r4
mov #0x1C,r2
! Opcode 10BC
L0BC:
mov.b @r6,r3
add #2,r6
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl574
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl574:
jmp @r4
mov #0x1C,r2
! Opcodes 10C0 - 10C7
L0C0:
and r0,r2
add r13,r2
mov.b @r2,r3
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl575
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl575:
jmp @r4
mov #0x1C,r2
! Opcodes 10C8 - 10CF
L0C8:
and r0,r2
add r14,r2
mov.b @r2,r3
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl576
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl576:
jmp @r4
mov #0x1C,r2
! Opcodes 10D0 - 10D7
L0D0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl577
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl577:
jmp @r4
mov #0x1C,r2
! Opcodes 10D8 - 10DF
L0D8:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl578
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl578:
jmp @r4
mov #0x1C,r2
! Opcodes 10E0 - 10E7
L0E0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl579
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl579:
jmp @r4
mov #0x1C,r2
! Opcodes 10E8 - 10EF
L0E8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl580
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl580:
jmp @r4
mov #0x1C,r2
! Opcodes 10F0 - 10F7
L0F0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl581
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl581:
jmp @r4
mov #0x1C,r2
! Opcode 10F8
L0F8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl582
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl582:
jmp @r4
mov #0x1C,r2
! Opcode 10F9
L0F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl583
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl583:
jmp @r4
mov #0x1C,r2
! Opcode 10FA
L0FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl584
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl584:
jmp @r4
mov #0x1C,r2
! Opcode 10FB
L0FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl585
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl585:
jmp @r4
mov #0x1C,r2
! Opcode 10FC
L0FC:
mov.b @r6,r3
add #2,r6
mov.l @(32,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl586
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl586:
jmp @r4
mov #0x1C,r2
! Opcodes 1100 - 1107
L100:
and r0,r2
add r13,r2
mov.b @r2,r3
mov.l @(32,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl587
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl587:
jmp @r4
mov #0x1C,r2
! Opcodes 1108 - 110F
L108:
and r0,r2
add r14,r2
mov.b @r2,r3
mov.l @(32,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl588
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl588:
jmp @r4
mov #0x1C,r2
! Opcodes 1110 - 1117
L110:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl589
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl589:
jmp @r4
mov #0x1C,r2
! Opcodes 1118 - 111F
L118:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(32,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl590
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl590:
jmp @r4
mov #0x1C,r2
! Opcodes 1120 - 1127
L120:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(32,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl591
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl591:
jmp @r4
mov #0x1C,r2
! Opcodes 1128 - 112F
L128:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl592
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl592:
jmp @r4
mov #0x1C,r2
! Opcodes 1130 - 1137
L130:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl593
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl593:
jmp @r4
mov #0x1C,r2
! Opcode 1138
L138:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl594
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl594:
jmp @r4
mov #0x1C,r2
! Opcode 1139
L139:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl595
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl595:
jmp @r4
mov #0x1C,r2
! Opcode 113A
L13A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl596
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl596:
jmp @r4
mov #0x1C,r2
! Opcode 113B
L13B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl597
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl597:
jmp @r4
mov #0x1C,r2
! Opcode 113C
L13C:
mov.b @r6,r3
add #2,r6
mov.l @(32,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl598
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl598:
jmp @r4
mov #0x1C,r2
! Opcodes 1140 - 1147
L140:
and r0,r2
add r13,r2
mov.b @r2,r3
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl599
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl599:
jmp @r4
mov #0x1C,r2
! Opcodes 1148 - 114F
L148:
and r0,r2
add r14,r2
mov.b @r2,r3
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl600
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl600:
jmp @r4
mov #0x1C,r2
! Opcodes 1150 - 1157
L150:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl601
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl601:
jmp @r4
mov #0x1C,r2
! Opcodes 1158 - 115F
L158:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl602
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl602:
jmp @r4
mov #0x1C,r2
! Opcodes 1160 - 1167
L160:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl603
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl603:
jmp @r4
mov #0x1C,r2
! Opcodes 1168 - 116F
L168:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl604
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl604:
jmp @r4
mov #0x1C,r2
! Opcodes 1170 - 1177
L170:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl605
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl605:
jmp @r4
mov #0x1C,r2
! Opcode 1178
L178:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl606
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl606:
jmp @r4
mov #0x1C,r2
! Opcode 1179
L179:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl607
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl607:
jmp @r4
mov #0x1C,r2
! Opcode 117A
L17A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl608
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl608:
jmp @r4
mov #0x1C,r2
! Opcode 117B
L17B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl609
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl609:
jmp @r4
mov #0x1C,r2
! Opcode 117C
L17C:
mov.b @r6,r3
add #2,r6
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl610
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl610:
jmp @r4
mov #0x1C,r2
! Opcodes 1180 - 1187
L180:
and r0,r2
add r13,r2
mov.b @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl611
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl611:
jmp @r4
mov #0x1C,r2
! Opcodes 1188 - 118F
L188:
and r0,r2
add r14,r2
mov.b @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl612
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl612:
jmp @r4
mov #0x1C,r2
! Opcodes 1190 - 1197
L190:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl613
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl613:
jmp @r4
mov #0x1C,r2
! Opcodes 1198 - 119F
L198:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl614
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl614:
jmp @r4
mov #0x1C,r2
! Opcodes 11A0 - 11A7
L1A0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl615
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl615:
jmp @r4
mov #0x1C,r2
! Opcodes 11A8 - 11AF
L1A8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl616
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl616:
jmp @r4
mov #0x1C,r2
! Opcodes 11B0 - 11B7
L1B0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl617
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl617:
jmp @r4
mov #0x1C,r2
! Opcode 11B8
L1B8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl618
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl618:
jmp @r4
mov #0x1C,r2
! Opcode 11B9
L1B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl619
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl619:
jmp @r4
mov #0x1C,r2
! Opcode 11BA
L1BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl620
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl620:
jmp @r4
mov #0x1C,r2
! Opcode 11BB
L1BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl621
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl621:
jmp @r4
mov #0x1C,r2
! Opcode 11BC
L1BC:
mov.b @r6,r3
add #2,r6
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl622
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl622:
jmp @r4
mov #0x1C,r2
! Opcodes 11C0 - 11C7
L1C0:
and r0,r2
add r13,r2
mov.b @r2,r3
mov.w @r6+,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl623
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl623:
jmp @r4
mov #0x1C,r2
! Opcodes 11C8 - 11CF
L1C8:
and r0,r2
add r14,r2
mov.b @r2,r3
mov.w @r6+,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl624
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl624:
jmp @r4
mov #0x1C,r2
! Opcodes 11D0 - 11D7
L1D0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl625
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl625:
jmp @r4
mov #0x1C,r2
! Opcodes 11D8 - 11DF
L1D8:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl626
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl626:
jmp @r4
mov #0x1C,r2
! Opcodes 11E0 - 11E7
L1E0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl627
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl627:
jmp @r4
mov #0x1C,r2
! Opcodes 11E8 - 11EF
L1E8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl628
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl628:
jmp @r4
mov #0x1C,r2
! Opcodes 11F0 - 11F7
L1F0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl629
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl629:
jmp @r4
mov #0x1C,r2
! Opcode 11F8
L1F8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl630
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl630:
jmp @r4
mov #0x1C,r2
! Opcode 11F9
L1F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl631
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl631:
jmp @r4
mov #0x1C,r2
! Opcode 11FA
L1FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl632
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl632:
jmp @r4
mov #0x1C,r2
! Opcode 11FB
L1FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl633
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl633:
jmp @r4
mov #0x1C,r2
! Opcode 11FC
L1FC:
mov.b @r6,r3
add #2,r6
mov.w @r6+,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl634
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl634:
jmp @r4
mov #0x1C,r2
! Opcodes 1200 - 1207
L200:
and r0,r2
add r13,r2
mov.b @r2,r3
mov #4,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl635
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl635:
jmp @r4
mov #0x1C,r2
! Opcodes 1208 - 120F
L208:
and r0,r2
add r14,r2
mov.b @r2,r3
mov #4,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl636
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl636:
jmp @r4
mov #0x1C,r2
! Opcodes 1210 - 1217
L210:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl637
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl637:
jmp @r4
mov #0x1C,r2
! Opcodes 1218 - 121F
L218:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #4,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl638
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl638:
jmp @r4
mov #0x1C,r2
! Opcodes 1220 - 1227
L220:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #4,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-10,r7
shll2 r0
cmp/pl r7
bt/s fdl639
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl639:
jmp @r4
mov #0x1C,r2
! Opcodes 1228 - 122F
L228:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl640
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl640:
jmp @r4
mov #0x1C,r2
! Opcodes 1230 - 1237
L230:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl641
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl641:
jmp @r4
mov #0x1C,r2
! Opcode 1238
L238:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl642
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl642:
jmp @r4
mov #0x1C,r2
! Opcode 1239
L239:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl643
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl643:
jmp @r4
mov #0x1C,r2
! Opcode 123A
L23A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl644
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl644:
jmp @r4
mov #0x1C,r2
! Opcode 123B
L23B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl645
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl645:
jmp @r4
mov #0x1C,r2
! Opcode 123C
L23C:
mov.b @r6,r3
add #2,r6
mov #4,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl646
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl646:
jmp @r4
mov #0x1C,r2
! Opcodes 1280 - 1287
L280:
and r0,r2
add r13,r2
mov.b @r2,r3
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl647
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl647:
jmp @r4
mov #0x1C,r2
! Opcodes 1288 - 128F
L288:
and r0,r2
add r14,r2
mov.b @r2,r3
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl648
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl648:
jmp @r4
mov #0x1C,r2
! Opcodes 1290 - 1297
L290:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl649
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl649:
jmp @r4
mov #0x1C,r2
! Opcodes 1298 - 129F
L298:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl650
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl650:
jmp @r4
mov #0x1C,r2
! Opcodes 12A0 - 12A7
L2A0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl651
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl651:
jmp @r4
mov #0x1C,r2
! Opcodes 12A8 - 12AF
L2A8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl652
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl652:
jmp @r4
mov #0x1C,r2
! Opcodes 12B0 - 12B7
L2B0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl653
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl653:
jmp @r4
mov #0x1C,r2
! Opcode 12B8
L2B8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl654
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl654:
jmp @r4
mov #0x1C,r2
! Opcode 12B9
L2B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl655
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl655:
jmp @r4
mov #0x1C,r2
! Opcode 12BA
L2BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl656
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl656:
jmp @r4
mov #0x1C,r2
! Opcode 12BB
L2BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl657
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl657:
jmp @r4
mov #0x1C,r2
! Opcode 12BC
L2BC:
mov.b @r6,r3
add #2,r6
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl658
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl658:
jmp @r4
mov #0x1C,r2
! Opcodes 12C0 - 12C7
L2C0:
and r0,r2
add r13,r2
mov.b @r2,r3
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl659
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl659:
jmp @r4
mov #0x1C,r2
! Opcodes 12C8 - 12CF
L2C8:
and r0,r2
add r14,r2
mov.b @r2,r3
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl660
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl660:
jmp @r4
mov #0x1C,r2
! Opcodes 12D0 - 12D7
L2D0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl661
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl661:
jmp @r4
mov #0x1C,r2
! Opcodes 12D8 - 12DF
L2D8:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl662
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl662:
jmp @r4
mov #0x1C,r2
! Opcodes 12E0 - 12E7
L2E0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl663
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl663:
jmp @r4
mov #0x1C,r2
! Opcodes 12E8 - 12EF
L2E8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl664
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl664:
jmp @r4
mov #0x1C,r2
! Opcodes 12F0 - 12F7
L2F0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl665
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl665:
jmp @r4
mov #0x1C,r2
! Opcode 12F8
L2F8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl666
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl666:
jmp @r4
mov #0x1C,r2
! Opcode 12F9
L2F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl667
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl667:
jmp @r4
mov #0x1C,r2
! Opcode 12FA
L2FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl668
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl668:
jmp @r4
mov #0x1C,r2
! Opcode 12FB
L2FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl669
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl669:
jmp @r4
mov #0x1C,r2
! Opcode 12FC
L2FC:
mov.b @r6,r3
add #2,r6
mov.l @(36,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl670
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl670:
jmp @r4
mov #0x1C,r2
! Opcodes 1300 - 1307
L300:
and r0,r2
add r13,r2
mov.b @r2,r3
mov.l @(36,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl671
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl671:
jmp @r4
mov #0x1C,r2
! Opcodes 1308 - 130F
L308:
and r0,r2
add r14,r2
mov.b @r2,r3
mov.l @(36,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl672
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl672:
jmp @r4
mov #0x1C,r2
! Opcodes 1310 - 1317
L310:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl673
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl673:
jmp @r4
mov #0x1C,r2
! Opcodes 1318 - 131F
L318:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(36,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl674
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl674:
jmp @r4
mov #0x1C,r2
! Opcodes 1320 - 1327
L320:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(36,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl675
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl675:
jmp @r4
mov #0x1C,r2
! Opcodes 1328 - 132F
L328:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl676
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl676:
jmp @r4
mov #0x1C,r2
! Opcodes 1330 - 1337
L330:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl677
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl677:
jmp @r4
mov #0x1C,r2
! Opcode 1338
L338:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl678
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl678:
jmp @r4
mov #0x1C,r2
! Opcode 1339
L339:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl679
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl679:
jmp @r4
mov #0x1C,r2
! Opcode 133A
L33A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl680
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl680:
jmp @r4
mov #0x1C,r2
! Opcode 133B
L33B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl681
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl681:
jmp @r4
mov #0x1C,r2
! Opcode 133C
L33C:
mov.b @r6,r3
add #2,r6
mov.l @(36,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl682
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl682:
jmp @r4
mov #0x1C,r2
! Opcodes 1340 - 1347
L340:
and r0,r2
add r13,r2
mov.b @r2,r3
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl683
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl683:
jmp @r4
mov #0x1C,r2
! Opcodes 1348 - 134F
L348:
and r0,r2
add r14,r2
mov.b @r2,r3
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl684
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl684:
jmp @r4
mov #0x1C,r2
! Opcodes 1350 - 1357
L350:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl685
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl685:
jmp @r4
mov #0x1C,r2
! Opcodes 1358 - 135F
L358:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl686
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl686:
jmp @r4
mov #0x1C,r2
! Opcodes 1360 - 1367
L360:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl687
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl687:
jmp @r4
mov #0x1C,r2
! Opcodes 1368 - 136F
L368:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl688
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl688:
jmp @r4
mov #0x1C,r2
! Opcodes 1370 - 1377
L370:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl689
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl689:
jmp @r4
mov #0x1C,r2
! Opcode 1378
L378:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl690
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl690:
jmp @r4
mov #0x1C,r2
! Opcode 1379
L379:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl691
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl691:
jmp @r4
mov #0x1C,r2
! Opcode 137A
L37A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl692
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl692:
jmp @r4
mov #0x1C,r2
! Opcode 137B
L37B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl693
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl693:
jmp @r4
mov #0x1C,r2
! Opcode 137C
L37C:
mov.b @r6,r3
add #2,r6
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl694
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl694:
jmp @r4
mov #0x1C,r2
! Opcodes 1380 - 1387
L380:
and r0,r2
add r13,r2
mov.b @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl695
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl695:
jmp @r4
mov #0x1C,r2
! Opcodes 1388 - 138F
L388:
and r0,r2
add r14,r2
mov.b @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl696
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl696:
jmp @r4
mov #0x1C,r2
! Opcodes 1390 - 1397
L390:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl697
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl697:
jmp @r4
mov #0x1C,r2
! Opcodes 1398 - 139F
L398:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl698
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl698:
jmp @r4
mov #0x1C,r2
! Opcodes 13A0 - 13A7
L3A0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl699
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl699:
jmp @r4
mov #0x1C,r2
! Opcodes 13A8 - 13AF
L3A8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl700
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl700:
jmp @r4
mov #0x1C,r2
! Opcodes 13B0 - 13B7
L3B0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl701
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl701:
jmp @r4
mov #0x1C,r2
! Opcode 13B8
L3B8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl702
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl702:
jmp @r4
mov #0x1C,r2
! Opcode 13B9
L3B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl703
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl703:
jmp @r4
mov #0x1C,r2
! Opcode 13BA
L3BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl704
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl704:
jmp @r4
mov #0x1C,r2
! Opcode 13BB
L3BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl705
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl705:
jmp @r4
mov #0x1C,r2
! Opcode 13BC
L3BC:
mov.b @r6,r3
add #2,r6
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl706
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl706:
jmp @r4
mov #0x1C,r2
! Opcodes 13C0 - 13C7
L3C0:
and r0,r2
add r13,r2
mov.b @r2,r3
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl707
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl707:
jmp @r4
mov #0x1C,r2
! Opcodes 13C8 - 13CF
L3C8:
and r0,r2
add r14,r2
mov.b @r2,r3
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl708
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl708:
jmp @r4
mov #0x1C,r2
! Opcodes 13D0 - 13D7
L3D0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl709
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl709:
jmp @r4
mov #0x1C,r2
! Opcodes 13D8 - 13DF
L3D8:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl710
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl710:
jmp @r4
mov #0x1C,r2
! Opcodes 13E0 - 13E7
L3E0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl711
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl711:
jmp @r4
mov #0x1C,r2
! Opcodes 13E8 - 13EF
L3E8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl712
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl712:
jmp @r4
mov #0x1C,r2
! Opcodes 13F0 - 13F7
L3F0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl713
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl713:
jmp @r4
mov #0x1C,r2
! Opcode 13F8
L3F8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl714
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl714:
jmp @r4
mov #0x1C,r2
! Opcode 13F9
L3F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl715
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl715:
jmp @r4
mov #0x1C,r2
! Opcode 13FA
L3FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl716
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl716:
jmp @r4
mov #0x1C,r2
! Opcode 13FB
L3FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl717
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl717:
jmp @r4
mov #0x1C,r2
! Opcode 13FC
L3FC:
mov.b @r6,r3
add #2,r6
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl718
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl718:
jmp @r4
mov #0x1C,r2
! Opcodes 1400 - 1407
L400:
and r0,r2
add r13,r2
mov.b @r2,r3
mov #8,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl719
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl719:
jmp @r4
mov #0x1C,r2
! Opcodes 1408 - 140F
L408:
and r0,r2
add r14,r2
mov.b @r2,r3
mov #8,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl720
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl720:
jmp @r4
mov #0x1C,r2
! Opcodes 1410 - 1417
L410:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl721
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl721:
jmp @r4
mov #0x1C,r2
! Opcodes 1418 - 141F
L418:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #8,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl722
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl722:
jmp @r4
mov #0x1C,r2
! Opcodes 1420 - 1427
L420:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #8,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-10,r7
shll2 r0
cmp/pl r7
bt/s fdl723
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl723:
jmp @r4
mov #0x1C,r2
! Opcodes 1428 - 142F
L428:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl724
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl724:
jmp @r4
mov #0x1C,r2
! Opcodes 1430 - 1437
L430:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl725
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl725:
jmp @r4
mov #0x1C,r2
! Opcode 1438
L438:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl726
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl726:
jmp @r4
mov #0x1C,r2
! Opcode 1439
L439:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl727
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl727:
jmp @r4
mov #0x1C,r2
! Opcode 143A
L43A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl728
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl728:
jmp @r4
mov #0x1C,r2
! Opcode 143B
L43B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl729
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl729:
jmp @r4
mov #0x1C,r2
! Opcode 143C
L43C:
mov.b @r6,r3
add #2,r6
mov #8,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl730
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl730:
jmp @r4
mov #0x1C,r2
! Opcodes 1480 - 1487
L480:
and r0,r2
add r13,r2
mov.b @r2,r3
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl731
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl731:
jmp @r4
mov #0x1C,r2
! Opcodes 1488 - 148F
L488:
and r0,r2
add r14,r2
mov.b @r2,r3
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl732
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl732:
jmp @r4
mov #0x1C,r2
! Opcodes 1490 - 1497
L490:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl733
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl733:
jmp @r4
mov #0x1C,r2
! Opcodes 1498 - 149F
L498:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl734
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl734:
jmp @r4
mov #0x1C,r2
! Opcodes 14A0 - 14A7
L4A0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl735
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl735:
jmp @r4
mov #0x1C,r2
! Opcodes 14A8 - 14AF
L4A8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl736
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl736:
jmp @r4
mov #0x1C,r2
! Opcodes 14B0 - 14B7
L4B0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl737
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl737:
jmp @r4
mov #0x1C,r2
! Opcode 14B8
L4B8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl738
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl738:
jmp @r4
mov #0x1C,r2
! Opcode 14B9
L4B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl739
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl739:
jmp @r4
mov #0x1C,r2
! Opcode 14BA
L4BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl740
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl740:
jmp @r4
mov #0x1C,r2
! Opcode 14BB
L4BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl741
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl741:
jmp @r4
mov #0x1C,r2
! Opcode 14BC
L4BC:
mov.b @r6,r3
add #2,r6
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl742
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl742:
jmp @r4
mov #0x1C,r2
! Opcodes 14C0 - 14C7
L4C0:
and r0,r2
add r13,r2
mov.b @r2,r3
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl743
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl743:
jmp @r4
mov #0x1C,r2
! Opcodes 14C8 - 14CF
L4C8:
and r0,r2
add r14,r2
mov.b @r2,r3
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl744
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl744:
jmp @r4
mov #0x1C,r2
! Opcodes 14D0 - 14D7
L4D0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl745
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl745:
jmp @r4
mov #0x1C,r2
! Opcodes 14D8 - 14DF
L4D8:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl746
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl746:
jmp @r4
mov #0x1C,r2
! Opcodes 14E0 - 14E7
L4E0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl747
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl747:
jmp @r4
mov #0x1C,r2
! Opcodes 14E8 - 14EF
L4E8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl748
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl748:
jmp @r4
mov #0x1C,r2
! Opcodes 14F0 - 14F7
L4F0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl749
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl749:
jmp @r4
mov #0x1C,r2
! Opcode 14F8
L4F8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl750
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl750:
jmp @r4
mov #0x1C,r2
! Opcode 14F9
L4F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl751
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl751:
jmp @r4
mov #0x1C,r2
! Opcode 14FA
L4FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl752
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl752:
jmp @r4
mov #0x1C,r2
! Opcode 14FB
L4FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl753
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl753:
jmp @r4
mov #0x1C,r2
! Opcode 14FC
L4FC:
mov.b @r6,r3
add #2,r6
mov.l @(40,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl754
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl754:
jmp @r4
mov #0x1C,r2
! Opcodes 1500 - 1507
L500:
and r0,r2
add r13,r2
mov.b @r2,r3
mov.l @(40,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl755
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl755:
jmp @r4
mov #0x1C,r2
! Opcodes 1508 - 150F
L508:
and r0,r2
add r14,r2
mov.b @r2,r3
mov.l @(40,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl756
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl756:
jmp @r4
mov #0x1C,r2
! Opcodes 1510 - 1517
L510:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl757
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl757:
jmp @r4
mov #0x1C,r2
! Opcodes 1518 - 151F
L518:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(40,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl758
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl758:
jmp @r4
mov #0x1C,r2
! Opcodes 1520 - 1527
L520:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(40,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl759
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl759:
jmp @r4
mov #0x1C,r2
! Opcodes 1528 - 152F
L528:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl760
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl760:
jmp @r4
mov #0x1C,r2
! Opcodes 1530 - 1537
L530:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl761
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl761:
jmp @r4
mov #0x1C,r2
! Opcode 1538
L538:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl762
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl762:
jmp @r4
mov #0x1C,r2
! Opcode 1539
L539:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl763
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl763:
jmp @r4
mov #0x1C,r2
! Opcode 153A
L53A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl764
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl764:
jmp @r4
mov #0x1C,r2
! Opcode 153B
L53B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl765
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl765:
jmp @r4
mov #0x1C,r2
! Opcode 153C
L53C:
mov.b @r6,r3
add #2,r6
mov.l @(40,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl766
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl766:
jmp @r4
mov #0x1C,r2
! Opcodes 1540 - 1547
L540:
and r0,r2
add r13,r2
mov.b @r2,r3
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl767
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl767:
jmp @r4
mov #0x1C,r2
! Opcodes 1548 - 154F
L548:
and r0,r2
add r14,r2
mov.b @r2,r3
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl768
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl768:
jmp @r4
mov #0x1C,r2
! Opcodes 1550 - 1557
L550:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl769
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl769:
jmp @r4
mov #0x1C,r2
! Opcodes 1558 - 155F
L558:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl770
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl770:
jmp @r4
mov #0x1C,r2
! Opcodes 1560 - 1567
L560:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl771
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl771:
jmp @r4
mov #0x1C,r2
! Opcodes 1568 - 156F
L568:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl772
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl772:
jmp @r4
mov #0x1C,r2
! Opcodes 1570 - 1577
L570:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl773
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl773:
jmp @r4
mov #0x1C,r2
! Opcode 1578
L578:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl774
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl774:
jmp @r4
mov #0x1C,r2
! Opcode 1579
L579:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl775
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl775:
jmp @r4
mov #0x1C,r2
! Opcode 157A
L57A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl776
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl776:
jmp @r4
mov #0x1C,r2
! Opcode 157B
L57B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl777
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl777:
jmp @r4
mov #0x1C,r2
! Opcode 157C
L57C:
mov.b @r6,r3
add #2,r6
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl778
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl778:
jmp @r4
mov #0x1C,r2
! Opcodes 1580 - 1587
L580:
and r0,r2
add r13,r2
mov.b @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl779
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl779:
jmp @r4
mov #0x1C,r2
! Opcodes 1588 - 158F
L588:
and r0,r2
add r14,r2
mov.b @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl780
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl780:
jmp @r4
mov #0x1C,r2
! Opcodes 1590 - 1597
L590:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl781
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl781:
jmp @r4
mov #0x1C,r2
! Opcodes 1598 - 159F
L598:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl782
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl782:
jmp @r4
mov #0x1C,r2
! Opcodes 15A0 - 15A7
L5A0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl783
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl783:
jmp @r4
mov #0x1C,r2
! Opcodes 15A8 - 15AF
L5A8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl784
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl784:
jmp @r4
mov #0x1C,r2
! Opcodes 15B0 - 15B7
L5B0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl785
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl785:
jmp @r4
mov #0x1C,r2
! Opcode 15B8
L5B8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl786
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl786:
jmp @r4
mov #0x1C,r2
! Opcode 15B9
L5B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl787
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl787:
jmp @r4
mov #0x1C,r2
! Opcode 15BA
L5BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl788
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl788:
jmp @r4
mov #0x1C,r2
! Opcode 15BB
L5BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl789
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl789:
jmp @r4
mov #0x1C,r2
! Opcode 15BC
L5BC:
mov.b @r6,r3
add #2,r6
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl790
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl790:
jmp @r4
mov #0x1C,r2
! Opcodes 1600 - 1607
L600:
and r0,r2
add r13,r2
mov.b @r2,r3
mov #12,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl791
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl791:
jmp @r4
mov #0x1C,r2
! Opcodes 1608 - 160F
L608:
and r0,r2
add r14,r2
mov.b @r2,r3
mov #12,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl792
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl792:
jmp @r4
mov #0x1C,r2
! Opcodes 1610 - 1617
L610:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl793
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl793:
jmp @r4
mov #0x1C,r2
! Opcodes 1618 - 161F
L618:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #12,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl794
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl794:
jmp @r4
mov #0x1C,r2
! Opcodes 1620 - 1627
L620:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #12,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-10,r7
shll2 r0
cmp/pl r7
bt/s fdl795
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl795:
jmp @r4
mov #0x1C,r2
! Opcodes 1628 - 162F
L628:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl796
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl796:
jmp @r4
mov #0x1C,r2
! Opcodes 1630 - 1637
L630:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl797
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl797:
jmp @r4
mov #0x1C,r2
! Opcode 1638
L638:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl798
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl798:
jmp @r4
mov #0x1C,r2
! Opcode 1639
L639:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl799
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl799:
jmp @r4
mov #0x1C,r2
! Opcode 163A
L63A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl800
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl800:
jmp @r4
mov #0x1C,r2
! Opcode 163B
L63B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl801
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl801:
jmp @r4
mov #0x1C,r2
! Opcode 163C
L63C:
mov.b @r6,r3
add #2,r6
mov #12,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl802
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl802:
jmp @r4
mov #0x1C,r2
! Opcodes 1680 - 1687
L680:
and r0,r2
add r13,r2
mov.b @r2,r3
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl803
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl803:
jmp @r4
mov #0x1C,r2
! Opcodes 1688 - 168F
L688:
and r0,r2
add r14,r2
mov.b @r2,r3
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl804
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl804:
jmp @r4
mov #0x1C,r2
! Opcodes 1690 - 1697
L690:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl805
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl805:
jmp @r4
mov #0x1C,r2
! Opcodes 1698 - 169F
L698:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl806
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl806:
jmp @r4
mov #0x1C,r2
! Opcodes 16A0 - 16A7
L6A0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl807
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl807:
jmp @r4
mov #0x1C,r2
! Opcodes 16A8 - 16AF
L6A8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl808
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl808:
jmp @r4
mov #0x1C,r2
! Opcodes 16B0 - 16B7
L6B0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl809
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl809:
jmp @r4
mov #0x1C,r2
! Opcode 16B8
L6B8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl810
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl810:
jmp @r4
mov #0x1C,r2
! Opcode 16B9
L6B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl811
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl811:
jmp @r4
mov #0x1C,r2
! Opcode 16BA
L6BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl812
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl812:
jmp @r4
mov #0x1C,r2
! Opcode 16BB
L6BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl813
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl813:
jmp @r4
mov #0x1C,r2
! Opcode 16BC
L6BC:
mov.b @r6,r3
add #2,r6
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl814
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl814:
jmp @r4
mov #0x1C,r2
! Opcodes 16C0 - 16C7
L6C0:
and r0,r2
add r13,r2
mov.b @r2,r3
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl815
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl815:
jmp @r4
mov #0x1C,r2
! Opcodes 16C8 - 16CF
L6C8:
and r0,r2
add r14,r2
mov.b @r2,r3
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl816
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl816:
jmp @r4
mov #0x1C,r2
! Opcodes 16D0 - 16D7
L6D0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl817
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl817:
jmp @r4
mov #0x1C,r2
! Opcodes 16D8 - 16DF
L6D8:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl818
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl818:
jmp @r4
mov #0x1C,r2
! Opcodes 16E0 - 16E7
L6E0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl819
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl819:
jmp @r4
mov #0x1C,r2
! Opcodes 16E8 - 16EF
L6E8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl820
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl820:
jmp @r4
mov #0x1C,r2
! Opcodes 16F0 - 16F7
L6F0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl821
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl821:
jmp @r4
mov #0x1C,r2
! Opcode 16F8
L6F8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl822
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl822:
jmp @r4
mov #0x1C,r2
! Opcode 16F9
L6F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl823
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl823:
jmp @r4
mov #0x1C,r2
! Opcode 16FA
L6FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl824
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl824:
jmp @r4
mov #0x1C,r2
! Opcode 16FB
L6FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl825
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl825:
jmp @r4
mov #0x1C,r2
! Opcode 16FC
L6FC:
mov.b @r6,r3
add #2,r6
mov.l @(44,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl826
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl826:
jmp @r4
mov #0x1C,r2
! Opcodes 1700 - 1707
L700:
and r0,r2
add r13,r2
mov.b @r2,r3
mov.l @(44,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl827
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl827:
jmp @r4
mov #0x1C,r2
! Opcodes 1708 - 170F
L708:
and r0,r2
add r14,r2
mov.b @r2,r3
mov.l @(44,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl828
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl828:
jmp @r4
mov #0x1C,r2
! Opcodes 1710 - 1717
L710:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl829
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl829:
jmp @r4
mov #0x1C,r2
! Opcodes 1718 - 171F
L718:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(44,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl830
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl830:
jmp @r4
mov #0x1C,r2
! Opcodes 1720 - 1727
L720:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(44,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl831
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl831:
jmp @r4
mov #0x1C,r2
! Opcodes 1728 - 172F
L728:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl832
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl832:
jmp @r4
mov #0x1C,r2
! Opcodes 1730 - 1737
L730:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl833
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl833:
jmp @r4
mov #0x1C,r2
! Opcode 1738
L738:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl834
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl834:
jmp @r4
mov #0x1C,r2
! Opcode 1739
L739:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl835
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl835:
jmp @r4
mov #0x1C,r2
! Opcode 173A
L73A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl836
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl836:
jmp @r4
mov #0x1C,r2
! Opcode 173B
L73B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl837
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl837:
jmp @r4
mov #0x1C,r2
! Opcode 173C
L73C:
mov.b @r6,r3
add #2,r6
mov.l @(44,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl838
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl838:
jmp @r4
mov #0x1C,r2
! Opcodes 1740 - 1747
L740:
and r0,r2
add r13,r2
mov.b @r2,r3
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl839
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl839:
jmp @r4
mov #0x1C,r2
! Opcodes 1748 - 174F
L748:
and r0,r2
add r14,r2
mov.b @r2,r3
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl840
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl840:
jmp @r4
mov #0x1C,r2
! Opcodes 1750 - 1757
L750:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl841
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl841:
jmp @r4
mov #0x1C,r2
! Opcodes 1758 - 175F
L758:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl842
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl842:
jmp @r4
mov #0x1C,r2
! Opcodes 1760 - 1767
L760:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl843
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl843:
jmp @r4
mov #0x1C,r2
! Opcodes 1768 - 176F
L768:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl844
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl844:
jmp @r4
mov #0x1C,r2
! Opcodes 1770 - 1777
L770:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl845
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl845:
jmp @r4
mov #0x1C,r2
! Opcode 1778
L778:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl846
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl846:
jmp @r4
mov #0x1C,r2
! Opcode 1779
L779:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl847
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl847:
jmp @r4
mov #0x1C,r2
! Opcode 177A
L77A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl848
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl848:
jmp @r4
mov #0x1C,r2
! Opcode 177B
L77B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl849
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl849:
jmp @r4
mov #0x1C,r2
! Opcode 177C
L77C:
mov.b @r6,r3
add #2,r6
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl850
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl850:
jmp @r4
mov #0x1C,r2
! Opcodes 1780 - 1787
L780:
and r0,r2
add r13,r2
mov.b @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl851
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl851:
jmp @r4
mov #0x1C,r2
! Opcodes 1788 - 178F
L788:
and r0,r2
add r14,r2
mov.b @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl852
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl852:
jmp @r4
mov #0x1C,r2
! Opcodes 1790 - 1797
L790:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl853
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl853:
jmp @r4
mov #0x1C,r2
! Opcodes 1798 - 179F
L798:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl854
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl854:
jmp @r4
mov #0x1C,r2
! Opcodes 17A0 - 17A7
L7A0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl855
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl855:
jmp @r4
mov #0x1C,r2
! Opcodes 17A8 - 17AF
L7A8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl856
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl856:
jmp @r4
mov #0x1C,r2
! Opcodes 17B0 - 17B7
L7B0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl857
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl857:
jmp @r4
mov #0x1C,r2
! Opcode 17B8
L7B8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl858
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl858:
jmp @r4
mov #0x1C,r2
! Opcode 17B9
L7B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl859
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl859:
jmp @r4
mov #0x1C,r2
! Opcode 17BA
L7BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl860
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl860:
jmp @r4
mov #0x1C,r2
! Opcode 17BB
L7BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl861
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl861:
jmp @r4
mov #0x1C,r2
! Opcode 17BC
L7BC:
mov.b @r6,r3
add #2,r6
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl862
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl862:
jmp @r4
mov #0x1C,r2
! Opcodes 1800 - 1807
L800:
and r0,r2
add r13,r2
mov.b @r2,r3
mov #16,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl863
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl863:
jmp @r4
mov #0x1C,r2
! Opcodes 1808 - 180F
L808:
and r0,r2
add r14,r2
mov.b @r2,r3
mov #16,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl864
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl864:
jmp @r4
mov #0x1C,r2
! Opcodes 1810 - 1817
L810:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl865
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl865:
jmp @r4
mov #0x1C,r2
! Opcodes 1818 - 181F
L818:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #16,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl866
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl866:
jmp @r4
mov #0x1C,r2
! Opcodes 1820 - 1827
L820:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #16,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-10,r7
shll2 r0
cmp/pl r7
bt/s fdl867
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl867:
jmp @r4
mov #0x1C,r2
! Opcodes 1828 - 182F
L828:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl868
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl868:
jmp @r4
mov #0x1C,r2
! Opcodes 1830 - 1837
L830:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl869
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl869:
jmp @r4
mov #0x1C,r2
! Opcode 1838
L838:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl870
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl870:
jmp @r4
mov #0x1C,r2
! Opcode 1839
L839:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl871
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl871:
jmp @r4
mov #0x1C,r2
! Opcode 183A
L83A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl872
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl872:
jmp @r4
mov #0x1C,r2
! Opcode 183B
L83B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl873
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl873:
jmp @r4
mov #0x1C,r2
! Opcode 183C
L83C:
mov.b @r6,r3
add #2,r6
mov #16,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl874
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl874:
jmp @r4
mov #0x1C,r2
! Opcodes 1880 - 1887
L880:
and r0,r2
add r13,r2
mov.b @r2,r3
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl875
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl875:
jmp @r4
mov #0x1C,r2
! Opcodes 1888 - 188F
L888:
and r0,r2
add r14,r2
mov.b @r2,r3
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl876
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl876:
jmp @r4
mov #0x1C,r2
! Opcodes 1890 - 1897
L890:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl877
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl877:
jmp @r4
mov #0x1C,r2
! Opcodes 1898 - 189F
L898:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl878
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl878:
jmp @r4
mov #0x1C,r2
! Opcodes 18A0 - 18A7
L8A0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl879
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl879:
jmp @r4
mov #0x1C,r2
! Opcodes 18A8 - 18AF
L8A8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl880
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl880:
jmp @r4
mov #0x1C,r2
! Opcodes 18B0 - 18B7
L8B0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl881
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl881:
jmp @r4
mov #0x1C,r2
! Opcode 18B8
L8B8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl882
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl882:
jmp @r4
mov #0x1C,r2
! Opcode 18B9
L8B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl883
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl883:
jmp @r4
mov #0x1C,r2
! Opcode 18BA
L8BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl884
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl884:
jmp @r4
mov #0x1C,r2
! Opcode 18BB
L8BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl885
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl885:
jmp @r4
mov #0x1C,r2
! Opcode 18BC
L8BC:
mov.b @r6,r3
add #2,r6
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl886
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl886:
jmp @r4
mov #0x1C,r2
! Opcodes 18C0 - 18C7
L8C0:
and r0,r2
add r13,r2
mov.b @r2,r3
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl887
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl887:
jmp @r4
mov #0x1C,r2
! Opcodes 18C8 - 18CF
L8C8:
and r0,r2
add r14,r2
mov.b @r2,r3
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl888
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl888:
jmp @r4
mov #0x1C,r2
! Opcodes 18D0 - 18D7
L8D0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl889
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl889:
jmp @r4
mov #0x1C,r2
! Opcodes 18D8 - 18DF
L8D8:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl890
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl890:
jmp @r4
mov #0x1C,r2
! Opcodes 18E0 - 18E7
L8E0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl891
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl891:
jmp @r4
mov #0x1C,r2
! Opcodes 18E8 - 18EF
L8E8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl892
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl892:
jmp @r4
mov #0x1C,r2
! Opcodes 18F0 - 18F7
L8F0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl893
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl893:
jmp @r4
mov #0x1C,r2
! Opcode 18F8
L8F8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl894
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl894:
jmp @r4
mov #0x1C,r2
! Opcode 18F9
L8F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl895
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl895:
jmp @r4
mov #0x1C,r2
! Opcode 18FA
L8FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl896
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl896:
jmp @r4
mov #0x1C,r2
! Opcode 18FB
L8FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl897
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl897:
jmp @r4
mov #0x1C,r2
! Opcode 18FC
L8FC:
mov.b @r6,r3
add #2,r6
mov.l @(48,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl898
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl898:
jmp @r4
mov #0x1C,r2
! Opcodes 1900 - 1907
L900:
and r0,r2
add r13,r2
mov.b @r2,r3
mov.l @(48,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl899
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl899:
jmp @r4
mov #0x1C,r2
! Opcodes 1908 - 190F
L908:
and r0,r2
add r14,r2
mov.b @r2,r3
mov.l @(48,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl900
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl900:
jmp @r4
mov #0x1C,r2
! Opcodes 1910 - 1917
L910:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl901
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl901:
jmp @r4
mov #0x1C,r2
! Opcodes 1918 - 191F
L918:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(48,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl902
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl902:
jmp @r4
mov #0x1C,r2
! Opcodes 1920 - 1927
L920:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(48,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl903
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl903:
jmp @r4
mov #0x1C,r2
! Opcodes 1928 - 192F
L928:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl904
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl904:
jmp @r4
mov #0x1C,r2
! Opcodes 1930 - 1937
L930:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl905
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl905:
jmp @r4
mov #0x1C,r2
! Opcode 1938
L938:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl906
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl906:
jmp @r4
mov #0x1C,r2
! Opcode 1939
L939:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl907
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl907:
jmp @r4
mov #0x1C,r2
! Opcode 193A
L93A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl908
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl908:
jmp @r4
mov #0x1C,r2
! Opcode 193B
L93B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl909
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl909:
jmp @r4
mov #0x1C,r2
! Opcode 193C
L93C:
mov.b @r6,r3
add #2,r6
mov.l @(48,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl910
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl910:
jmp @r4
mov #0x1C,r2
! Opcodes 1940 - 1947
L940:
and r0,r2
add r13,r2
mov.b @r2,r3
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl911
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl911:
jmp @r4
mov #0x1C,r2
! Opcodes 1948 - 194F
L948:
and r0,r2
add r14,r2
mov.b @r2,r3
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl912
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl912:
jmp @r4
mov #0x1C,r2
! Opcodes 1950 - 1957
L950:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl913
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl913:
jmp @r4
mov #0x1C,r2
! Opcodes 1958 - 195F
L958:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl914
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl914:
jmp @r4
mov #0x1C,r2
! Opcodes 1960 - 1967
L960:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl915
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl915:
jmp @r4
mov #0x1C,r2
! Opcodes 1968 - 196F
L968:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl916
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl916:
jmp @r4
mov #0x1C,r2
! Opcodes 1970 - 1977
L970:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl917
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl917:
jmp @r4
mov #0x1C,r2
! Opcode 1978
L978:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl918
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl918:
jmp @r4
mov #0x1C,r2
! Opcode 1979
L979:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl919
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl919:
jmp @r4
mov #0x1C,r2
! Opcode 197A
L97A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl920
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl920:
jmp @r4
mov #0x1C,r2
! Opcode 197B
L97B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl921
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl921:
jmp @r4
mov #0x1C,r2
! Opcode 197C
L97C:
mov.b @r6,r3
add #2,r6
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl922
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl922:
jmp @r4
mov #0x1C,r2
! Opcodes 1980 - 1987
L980:
and r0,r2
add r13,r2
mov.b @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl923
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl923:
jmp @r4
mov #0x1C,r2
! Opcodes 1988 - 198F
L988:
and r0,r2
add r14,r2
mov.b @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl924
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl924:
jmp @r4
mov #0x1C,r2
! Opcodes 1990 - 1997
L990:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl925
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl925:
jmp @r4
mov #0x1C,r2
! Opcodes 1998 - 199F
L998:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl926
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl926:
jmp @r4
mov #0x1C,r2
! Opcodes 19A0 - 19A7
L9A0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl927
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl927:
jmp @r4
mov #0x1C,r2
! Opcodes 19A8 - 19AF
L9A8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl928
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl928:
jmp @r4
mov #0x1C,r2
! Opcodes 19B0 - 19B7
L9B0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl929
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl929:
jmp @r4
mov #0x1C,r2
! Opcode 19B8
L9B8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl930
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl930:
jmp @r4
mov #0x1C,r2
! Opcode 19B9
L9B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl931
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl931:
jmp @r4
mov #0x1C,r2
! Opcode 19BA
L9BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl932
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl932:
jmp @r4
mov #0x1C,r2
! Opcode 19BB
L9BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl933
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl933:
jmp @r4
mov #0x1C,r2
! Opcode 19BC
L9BC:
mov.b @r6,r3
add #2,r6
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl934
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl934:
jmp @r4
mov #0x1C,r2
! Opcodes 1A00 - 1A07
LA00:
and r0,r2
add r13,r2
mov.b @r2,r3
mov #20,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl935
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl935:
jmp @r4
mov #0x1C,r2
! Opcodes 1A08 - 1A0F
LA08:
and r0,r2
add r14,r2
mov.b @r2,r3
mov #20,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl936
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl936:
jmp @r4
mov #0x1C,r2
! Opcodes 1A10 - 1A17
LA10:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl937
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl937:
jmp @r4
mov #0x1C,r2
! Opcodes 1A18 - 1A1F
LA18:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #20,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl938
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl938:
jmp @r4
mov #0x1C,r2
! Opcodes 1A20 - 1A27
LA20:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #20,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-10,r7
shll2 r0
cmp/pl r7
bt/s fdl939
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl939:
jmp @r4
mov #0x1C,r2
! Opcodes 1A28 - 1A2F
LA28:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl940
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl940:
jmp @r4
mov #0x1C,r2
! Opcodes 1A30 - 1A37
LA30:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl941
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl941:
jmp @r4
mov #0x1C,r2
! Opcode 1A38
LA38:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl942
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl942:
jmp @r4
mov #0x1C,r2
! Opcode 1A39
LA39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl943
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl943:
jmp @r4
mov #0x1C,r2
! Opcode 1A3A
LA3A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl944
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl944:
jmp @r4
mov #0x1C,r2
! Opcode 1A3B
LA3B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl945
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl945:
jmp @r4
mov #0x1C,r2
! Opcode 1A3C
LA3C:
mov.b @r6,r3
add #2,r6
mov #20,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl946
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl946:
jmp @r4
mov #0x1C,r2
! Opcodes 1A80 - 1A87
LA80:
and r0,r2
add r13,r2
mov.b @r2,r3
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl947
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl947:
jmp @r4
mov #0x1C,r2
! Opcodes 1A88 - 1A8F
LA88:
and r0,r2
add r14,r2
mov.b @r2,r3
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl948
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl948:
jmp @r4
mov #0x1C,r2
! Opcodes 1A90 - 1A97
LA90:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl949
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl949:
jmp @r4
mov #0x1C,r2
! Opcodes 1A98 - 1A9F
LA98:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl950
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl950:
jmp @r4
mov #0x1C,r2
! Opcodes 1AA0 - 1AA7
LAA0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl951
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl951:
jmp @r4
mov #0x1C,r2
! Opcodes 1AA8 - 1AAF
LAA8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl952
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl952:
jmp @r4
mov #0x1C,r2
! Opcodes 1AB0 - 1AB7
LAB0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl953
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl953:
jmp @r4
mov #0x1C,r2
! Opcode 1AB8
LAB8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl954
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl954:
jmp @r4
mov #0x1C,r2
! Opcode 1AB9
LAB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl955
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl955:
jmp @r4
mov #0x1C,r2
! Opcode 1ABA
LABA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl956
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl956:
jmp @r4
mov #0x1C,r2
! Opcode 1ABB
LABB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl957
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl957:
jmp @r4
mov #0x1C,r2
! Opcode 1ABC
LABC:
mov.b @r6,r3
add #2,r6
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl958
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl958:
jmp @r4
mov #0x1C,r2
! Opcodes 1AC0 - 1AC7
LAC0:
and r0,r2
add r13,r2
mov.b @r2,r3
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl959
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl959:
jmp @r4
mov #0x1C,r2
! Opcodes 1AC8 - 1ACF
LAC8:
and r0,r2
add r14,r2
mov.b @r2,r3
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl960
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl960:
jmp @r4
mov #0x1C,r2
! Opcodes 1AD0 - 1AD7
LAD0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl961
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl961:
jmp @r4
mov #0x1C,r2
! Opcodes 1AD8 - 1ADF
LAD8:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl962
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl962:
jmp @r4
mov #0x1C,r2
! Opcodes 1AE0 - 1AE7
LAE0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl963
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl963:
jmp @r4
mov #0x1C,r2
! Opcodes 1AE8 - 1AEF
LAE8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl964
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl964:
jmp @r4
mov #0x1C,r2
! Opcodes 1AF0 - 1AF7
LAF0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl965
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl965:
jmp @r4
mov #0x1C,r2
! Opcode 1AF8
LAF8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl966
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl966:
jmp @r4
mov #0x1C,r2
! Opcode 1AF9
LAF9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl967
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl967:
jmp @r4
mov #0x1C,r2
! Opcode 1AFA
LAFA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl968
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl968:
jmp @r4
mov #0x1C,r2
! Opcode 1AFB
LAFB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl969
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl969:
jmp @r4
mov #0x1C,r2
! Opcode 1AFC
LAFC:
mov.b @r6,r3
add #2,r6
mov.l @(52,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl970
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl970:
jmp @r4
mov #0x1C,r2
! Opcodes 1B00 - 1B07
LB00:
and r0,r2
add r13,r2
mov.b @r2,r3
mov.l @(52,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl971
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl971:
jmp @r4
mov #0x1C,r2
! Opcodes 1B08 - 1B0F
LB08:
and r0,r2
add r14,r2
mov.b @r2,r3
mov.l @(52,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl972
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl972:
jmp @r4
mov #0x1C,r2
! Opcodes 1B10 - 1B17
LB10:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl973
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl973:
jmp @r4
mov #0x1C,r2
! Opcodes 1B18 - 1B1F
LB18:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(52,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl974
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl974:
jmp @r4
mov #0x1C,r2
! Opcodes 1B20 - 1B27
LB20:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(52,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl975
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl975:
jmp @r4
mov #0x1C,r2
! Opcodes 1B28 - 1B2F
LB28:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl976
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl976:
jmp @r4
mov #0x1C,r2
! Opcodes 1B30 - 1B37
LB30:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl977
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl977:
jmp @r4
mov #0x1C,r2
! Opcode 1B38
LB38:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl978
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl978:
jmp @r4
mov #0x1C,r2
! Opcode 1B39
LB39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl979
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl979:
jmp @r4
mov #0x1C,r2
! Opcode 1B3A
LB3A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl980
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl980:
jmp @r4
mov #0x1C,r2
! Opcode 1B3B
LB3B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl981
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl981:
jmp @r4
mov #0x1C,r2
! Opcode 1B3C
LB3C:
mov.b @r6,r3
add #2,r6
mov.l @(52,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl982
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl982:
jmp @r4
mov #0x1C,r2
! Opcodes 1B40 - 1B47
LB40:
and r0,r2
add r13,r2
mov.b @r2,r3
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl983
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl983:
jmp @r4
mov #0x1C,r2
! Opcodes 1B48 - 1B4F
LB48:
and r0,r2
add r14,r2
mov.b @r2,r3
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl984
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl984:
jmp @r4
mov #0x1C,r2
! Opcodes 1B50 - 1B57
LB50:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl985
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl985:
jmp @r4
mov #0x1C,r2
! Opcodes 1B58 - 1B5F
LB58:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl986
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl986:
jmp @r4
mov #0x1C,r2
! Opcodes 1B60 - 1B67
LB60:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl987
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl987:
jmp @r4
mov #0x1C,r2
! Opcodes 1B68 - 1B6F
LB68:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl988
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl988:
jmp @r4
mov #0x1C,r2
! Opcodes 1B70 - 1B77
LB70:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl989
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl989:
jmp @r4
mov #0x1C,r2
! Opcode 1B78
LB78:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl990
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl990:
jmp @r4
mov #0x1C,r2
! Opcode 1B79
LB79:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl991
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl991:
jmp @r4
mov #0x1C,r2
! Opcode 1B7A
LB7A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl992
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl992:
jmp @r4
mov #0x1C,r2
! Opcode 1B7B
LB7B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl993
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl993:
jmp @r4
mov #0x1C,r2
! Opcode 1B7C
LB7C:
mov.b @r6,r3
add #2,r6
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl994
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl994:
jmp @r4
mov #0x1C,r2
! Opcodes 1B80 - 1B87
LB80:
and r0,r2
add r13,r2
mov.b @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl995
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl995:
jmp @r4
mov #0x1C,r2
! Opcodes 1B88 - 1B8F
LB88:
and r0,r2
add r14,r2
mov.b @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl996
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl996:
jmp @r4
mov #0x1C,r2
! Opcodes 1B90 - 1B97
LB90:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl997
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl997:
jmp @r4
mov #0x1C,r2
! Opcodes 1B98 - 1B9F
LB98:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl998
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl998:
jmp @r4
mov #0x1C,r2
! Opcodes 1BA0 - 1BA7
LBA0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl999
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl999:
jmp @r4
mov #0x1C,r2
! Opcodes 1BA8 - 1BAF
LBA8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1000
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1000:
jmp @r4
mov #0x1C,r2
! Opcodes 1BB0 - 1BB7
LBB0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1001
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1001:
jmp @r4
mov #0x1C,r2
! Opcode 1BB8
LBB8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1002
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1002:
jmp @r4
mov #0x1C,r2
! Opcode 1BB9
LBB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1003
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1003:
jmp @r4
mov #0x1C,r2
! Opcode 1BBA
LBBA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1004
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1004:
jmp @r4
mov #0x1C,r2
! Opcode 1BBB
LBBB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1005
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1005:
jmp @r4
mov #0x1C,r2
! Opcode 1BBC
LBBC:
mov.b @r6,r3
add #2,r6
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1006
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1006:
jmp @r4
mov #0x1C,r2
! Opcodes 1C00 - 1C07
LC00:
and r0,r2
add r13,r2
mov.b @r2,r3
mov #24,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1007
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1007:
jmp @r4
mov #0x1C,r2
! Opcodes 1C08 - 1C0F
LC08:
and r0,r2
add r14,r2
mov.b @r2,r3
mov #24,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1008
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1008:
jmp @r4
mov #0x1C,r2
! Opcodes 1C10 - 1C17
LC10:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl1009
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1009:
jmp @r4
mov #0x1C,r2
! Opcodes 1C18 - 1C1F
LC18:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #24,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl1010
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1010:
jmp @r4
mov #0x1C,r2
! Opcodes 1C20 - 1C27
LC20:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #24,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-10,r7
shll2 r0
cmp/pl r7
bt/s fdl1011
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1011:
jmp @r4
mov #0x1C,r2
! Opcodes 1C28 - 1C2F
LC28:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1012
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1012:
jmp @r4
mov #0x1C,r2
! Opcodes 1C30 - 1C37
LC30:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1013
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1013:
jmp @r4
mov #0x1C,r2
! Opcode 1C38
LC38:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1014
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1014:
jmp @r4
mov #0x1C,r2
! Opcode 1C39
LC39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1015
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1015:
jmp @r4
mov #0x1C,r2
! Opcode 1C3A
LC3A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1016
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1016:
jmp @r4
mov #0x1C,r2
! Opcode 1C3B
LC3B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1017
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1017:
jmp @r4
mov #0x1C,r2
! Opcode 1C3C
LC3C:
mov.b @r6,r3
add #2,r6
mov #24,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl1018
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1018:
jmp @r4
mov #0x1C,r2
! Opcodes 1C80 - 1C87
LC80:
and r0,r2
add r13,r2
mov.b @r2,r3
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl1019
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1019:
jmp @r4
mov #0x1C,r2
! Opcodes 1C88 - 1C8F
LC88:
and r0,r2
add r14,r2
mov.b @r2,r3
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl1020
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1020:
jmp @r4
mov #0x1C,r2
! Opcodes 1C90 - 1C97
LC90:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1021
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1021:
jmp @r4
mov #0x1C,r2
! Opcodes 1C98 - 1C9F
LC98:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1022
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1022:
jmp @r4
mov #0x1C,r2
! Opcodes 1CA0 - 1CA7
LCA0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1023
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1023:
jmp @r4
mov #0x1C,r2
! Opcodes 1CA8 - 1CAF
LCA8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1024
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1024:
jmp @r4
mov #0x1C,r2
! Opcodes 1CB0 - 1CB7
LCB0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1025
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1025:
jmp @r4
mov #0x1C,r2
! Opcode 1CB8
LCB8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1026
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1026:
jmp @r4
mov #0x1C,r2
! Opcode 1CB9
LCB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1027
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1027:
jmp @r4
mov #0x1C,r2
! Opcode 1CBA
LCBA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1028
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1028:
jmp @r4
mov #0x1C,r2
! Opcode 1CBB
LCBB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1029
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1029:
jmp @r4
mov #0x1C,r2
! Opcode 1CBC
LCBC:
mov.b @r6,r3
add #2,r6
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1030
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1030:
jmp @r4
mov #0x1C,r2
! Opcodes 1CC0 - 1CC7
LCC0:
and r0,r2
add r13,r2
mov.b @r2,r3
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl1031
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1031:
jmp @r4
mov #0x1C,r2
! Opcodes 1CC8 - 1CCF
LCC8:
and r0,r2
add r14,r2
mov.b @r2,r3
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl1032
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1032:
jmp @r4
mov #0x1C,r2
! Opcodes 1CD0 - 1CD7
LCD0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1033
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1033:
jmp @r4
mov #0x1C,r2
! Opcodes 1CD8 - 1CDF
LCD8:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1034
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1034:
jmp @r4
mov #0x1C,r2
! Opcodes 1CE0 - 1CE7
LCE0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1035
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1035:
jmp @r4
mov #0x1C,r2
! Opcodes 1CE8 - 1CEF
LCE8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1036
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1036:
jmp @r4
mov #0x1C,r2
! Opcodes 1CF0 - 1CF7
LCF0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1037
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1037:
jmp @r4
mov #0x1C,r2
! Opcode 1CF8
LCF8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1038
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1038:
jmp @r4
mov #0x1C,r2
! Opcode 1CF9
LCF9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1039
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1039:
jmp @r4
mov #0x1C,r2
! Opcode 1CFA
LCFA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1040
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1040:
jmp @r4
mov #0x1C,r2
! Opcode 1CFB
LCFB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1041
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1041:
jmp @r4
mov #0x1C,r2
! Opcode 1CFC
LCFC:
mov.b @r6,r3
add #2,r6
mov.l @(56,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #1,r4
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1042
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1042:
jmp @r4
mov #0x1C,r2
! Opcodes 1D00 - 1D07
LD00:
and r0,r2
add r13,r2
mov.b @r2,r3
mov.l @(56,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl1043
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1043:
jmp @r4
mov #0x1C,r2
! Opcodes 1D08 - 1D0F
LD08:
and r0,r2
add r14,r2
mov.b @r2,r3
mov.l @(56,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl1044
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1044:
jmp @r4
mov #0x1C,r2
! Opcodes 1D10 - 1D17
LD10:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1045
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1045:
jmp @r4
mov #0x1C,r2
! Opcodes 1D18 - 1D1F
LD18:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(56,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1046
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1046:
jmp @r4
mov #0x1C,r2
! Opcodes 1D20 - 1D27
LD20:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(56,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1047
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1047:
jmp @r4
mov #0x1C,r2
! Opcodes 1D28 - 1D2F
LD28:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1048
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1048:
jmp @r4
mov #0x1C,r2
! Opcodes 1D30 - 1D37
LD30:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1049
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1049:
jmp @r4
mov #0x1C,r2
! Opcode 1D38
LD38:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1050
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1050:
jmp @r4
mov #0x1C,r2
! Opcode 1D39
LD39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1051
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1051:
jmp @r4
mov #0x1C,r2
! Opcode 1D3A
LD3A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1052
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1052:
jmp @r4
mov #0x1C,r2
! Opcode 1D3B
LD3B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1053
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1053:
jmp @r4
mov #0x1C,r2
! Opcode 1D3C
LD3C:
mov.b @r6,r3
add #2,r6
mov.l @(56,r13),r4
dt r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1054
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1054:
jmp @r4
mov #0x1C,r2
! Opcodes 1D40 - 1D47
LD40:
and r0,r2
add r13,r2
mov.b @r2,r3
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1055
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1055:
jmp @r4
mov #0x1C,r2
! Opcodes 1D48 - 1D4F
LD48:
and r0,r2
add r14,r2
mov.b @r2,r3
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1056
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1056:
jmp @r4
mov #0x1C,r2
! Opcodes 1D50 - 1D57
LD50:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1057
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1057:
jmp @r4
mov #0x1C,r2
! Opcodes 1D58 - 1D5F
LD58:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1058
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1058:
jmp @r4
mov #0x1C,r2
! Opcodes 1D60 - 1D67
LD60:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1059
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1059:
jmp @r4
mov #0x1C,r2
! Opcodes 1D68 - 1D6F
LD68:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1060
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1060:
jmp @r4
mov #0x1C,r2
! Opcodes 1D70 - 1D77
LD70:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1061
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1061:
jmp @r4
mov #0x1C,r2
! Opcode 1D78
LD78:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1062
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1062:
jmp @r4
mov #0x1C,r2
! Opcode 1D79
LD79:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1063
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1063:
jmp @r4
mov #0x1C,r2
! Opcode 1D7A
LD7A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1064
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1064:
jmp @r4
mov #0x1C,r2
! Opcode 1D7B
LD7B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1065
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1065:
jmp @r4
mov #0x1C,r2
! Opcode 1D7C
LD7C:
mov.b @r6,r3
add #2,r6
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1066
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1066:
jmp @r4
mov #0x1C,r2
! Opcodes 1D80 - 1D87
LD80:
and r0,r2
add r13,r2
mov.b @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1067
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1067:
jmp @r4
mov #0x1C,r2
! Opcodes 1D88 - 1D8F
LD88:
and r0,r2
add r14,r2
mov.b @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1068
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1068:
jmp @r4
mov #0x1C,r2
! Opcodes 1D90 - 1D97
LD90:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1069
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1069:
jmp @r4
mov #0x1C,r2
! Opcodes 1D98 - 1D9F
LD98:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1070
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1070:
jmp @r4
mov #0x1C,r2
! Opcodes 1DA0 - 1DA7
LDA0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1071
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1071:
jmp @r4
mov #0x1C,r2
! Opcodes 1DA8 - 1DAF
LDA8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1072
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1072:
jmp @r4
mov #0x1C,r2
! Opcodes 1DB0 - 1DB7
LDB0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1073
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1073:
jmp @r4
mov #0x1C,r2
! Opcode 1DB8
LDB8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1074
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1074:
jmp @r4
mov #0x1C,r2
! Opcode 1DB9
LDB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1075
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1075:
jmp @r4
mov #0x1C,r2
! Opcode 1DBA
LDBA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1076
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1076:
jmp @r4
mov #0x1C,r2
! Opcode 1DBB
LDBB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1077
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1077:
jmp @r4
mov #0x1C,r2
! Opcode 1DBC
LDBC:
mov.b @r6,r3
add #2,r6
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1078
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1078:
jmp @r4
mov #0x1C,r2
! Opcodes 1E00 - 1E07
LE00:
and r0,r2
add r13,r2
mov.b @r2,r3
mov #28,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1079
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1079:
jmp @r4
mov #0x1C,r2
! Opcodes 1E08 - 1E0F
LE08:
and r0,r2
add r14,r2
mov.b @r2,r3
mov #28,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1080
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1080:
jmp @r4
mov #0x1C,r2
! Opcodes 1E10 - 1E17
LE10:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl1081
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1081:
jmp @r4
mov #0x1C,r2
! Opcodes 1E18 - 1E1F
LE18:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #28,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl1082
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1082:
jmp @r4
mov #0x1C,r2
! Opcodes 1E20 - 1E27
LE20:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #28,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-10,r7
shll2 r0
cmp/pl r7
bt/s fdl1083
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1083:
jmp @r4
mov #0x1C,r2
! Opcodes 1E28 - 1E2F
LE28:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1084
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1084:
jmp @r4
mov #0x1C,r2
! Opcodes 1E30 - 1E37
LE30:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1085
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1085:
jmp @r4
mov #0x1C,r2
! Opcode 1E38
LE38:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1086
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1086:
jmp @r4
mov #0x1C,r2
! Opcode 1E39
LE39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1087
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1087:
jmp @r4
mov #0x1C,r2
! Opcode 1E3A
LE3A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1088
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1088:
jmp @r4
mov #0x1C,r2
! Opcode 1E3B
LE3B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1089
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1089:
jmp @r4
mov #0x1C,r2
! Opcode 1E3C
LE3C:
mov.b @r6,r3
add #2,r6
mov #28,r0
mov.b r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl1090
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1090:
jmp @r4
mov #0x1C,r2
! Opcodes 1E80 - 1E87
LE80:
and r0,r2
add r13,r2
mov.b @r2,r3
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl1091
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1091:
jmp @r4
mov #0x1C,r2
! Opcodes 1E88 - 1E8F
LE88:
and r0,r2
add r14,r2
mov.b @r2,r3
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl1092
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1092:
jmp @r4
mov #0x1C,r2
! Opcodes 1E90 - 1E97
LE90:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1093
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1093:
jmp @r4
mov #0x1C,r2
! Opcodes 1E98 - 1E9F
LE98:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1094
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1094:
jmp @r4
mov #0x1C,r2
! Opcodes 1EA0 - 1EA7
LEA0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1095
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1095:
jmp @r4
mov #0x1C,r2
! Opcodes 1EA8 - 1EAF
LEA8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1096
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1096:
jmp @r4
mov #0x1C,r2
! Opcodes 1EB0 - 1EB7
LEB0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1097
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1097:
jmp @r4
mov #0x1C,r2
! Opcode 1EB8
LEB8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1098
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1098:
jmp @r4
mov #0x1C,r2
! Opcode 1EB9
LEB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1099
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1099:
jmp @r4
mov #0x1C,r2
! Opcode 1EBA
LEBA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1100
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1100:
jmp @r4
mov #0x1C,r2
! Opcode 1EBB
LEBB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1101
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1101:
jmp @r4
mov #0x1C,r2
! Opcode 1EBC
LEBC:
mov.b @r6,r3
add #2,r6
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1102
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1102:
jmp @r4
mov #0x1C,r2
! Opcodes 1EC0 - 1EC7
LEC0:
and r0,r2
add r13,r2
mov.b @r2,r3
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl1103
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1103:
jmp @r4
mov #0x1C,r2
! Opcodes 1EC8 - 1ECF
LEC8:
and r0,r2
add r14,r2
mov.b @r2,r3
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl1104
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1104:
jmp @r4
mov #0x1C,r2
! Opcodes 1ED0 - 1ED7
LED0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1105
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1105:
jmp @r4
mov #0x1C,r2
! Opcodes 1ED8 - 1EDF
LED8:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1106
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1106:
jmp @r4
mov #0x1C,r2
! Opcodes 1EE0 - 1EE7
LEE0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1107
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1107:
jmp @r4
mov #0x1C,r2
! Opcodes 1EE8 - 1EEF
LEE8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1108
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1108:
jmp @r4
mov #0x1C,r2
! Opcodes 1EF0 - 1EF7
LEF0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1109
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1109:
jmp @r4
mov #0x1C,r2
! Opcode 1EF8
LEF8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1110
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1110:
jmp @r4
mov #0x1C,r2
! Opcode 1EF9
LEF9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1111
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1111:
jmp @r4
mov #0x1C,r2
! Opcode 1EFA
LEFA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1112
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1112:
jmp @r4
mov #0x1C,r2
! Opcode 1EFB
LEFB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1113
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1113:
jmp @r4
mov #0x1C,r2
! Opcode 1EFC
LEFC:
mov.b @r6,r3
add #2,r6
mov.l @(60,r13),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1114
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1114:
jmp @r4
mov #0x1C,r2
! Opcodes 1F00 - 1F07
LF00:
and r0,r2
add r13,r2
mov.b @r2,r3
mov.l @(60,r13),r4
add #-2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl1115
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1115:
jmp @r4
mov #0x1C,r2
! Opcodes 1F08 - 1F0F
LF08:
and r0,r2
add r14,r2
mov.b @r2,r3
mov.l @(60,r13),r4
add #-2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl1116
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1116:
jmp @r4
mov #0x1C,r2
! Opcodes 1F10 - 1F17
LF10:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
add #-2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1117
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1117:
jmp @r4
mov #0x1C,r2
! Opcodes 1F18 - 1F1F
LF18:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(60,r13),r4
add #-2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1118
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1118:
jmp @r4
mov #0x1C,r2
! Opcodes 1F20 - 1F27
LF20:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(60,r13),r4
add #-2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1119
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1119:
jmp @r4
mov #0x1C,r2
! Opcodes 1F28 - 1F2F
LF28:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
add #-2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1120
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1120:
jmp @r4
mov #0x1C,r2
! Opcodes 1F30 - 1F37
LF30:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
add #-2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1121
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1121:
jmp @r4
mov #0x1C,r2
! Opcode 1F38
LF38:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
add #-2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1122
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1122:
jmp @r4
mov #0x1C,r2
! Opcode 1F39
LF39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
add #-2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1123
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1123:
jmp @r4
mov #0x1C,r2
! Opcode 1F3A
LF3A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
add #-2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1124
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1124:
jmp @r4
mov #0x1C,r2
! Opcode 1F3B
LF3B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
add #-2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1125
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1125:
jmp @r4
mov #0x1C,r2
! Opcode 1F3C
LF3C:
mov.b @r6,r3
add #2,r6
mov.l @(60,r13),r4
add #-2,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1126
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1126:
jmp @r4
mov #0x1C,r2
! Opcodes 1F40 - 1F47
LF40:
and r0,r2
add r13,r2
mov.b @r2,r3
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1127
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1127:
jmp @r4
mov #0x1C,r2
! Opcodes 1F48 - 1F4F
LF48:
and r0,r2
add r14,r2
mov.b @r2,r3
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1128
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1128:
jmp @r4
mov #0x1C,r2
! Opcodes 1F50 - 1F57
LF50:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1129
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1129:
jmp @r4
mov #0x1C,r2
! Opcodes 1F58 - 1F5F
LF58:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1130
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1130:
jmp @r4
mov #0x1C,r2
! Opcodes 1F60 - 1F67
LF60:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1131
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1131:
jmp @r4
mov #0x1C,r2
! Opcodes 1F68 - 1F6F
LF68:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1132
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1132:
jmp @r4
mov #0x1C,r2
! Opcodes 1F70 - 1F77
LF70:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1133
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1133:
jmp @r4
mov #0x1C,r2
! Opcode 1F78
LF78:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1134
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1134:
jmp @r4
mov #0x1C,r2
! Opcode 1F79
LF79:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1135
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1135:
jmp @r4
mov #0x1C,r2
! Opcode 1F7A
LF7A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1136
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1136:
jmp @r4
mov #0x1C,r2
! Opcode 1F7B
LF7B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1137
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1137:
jmp @r4
mov #0x1C,r2
! Opcode 1F7C
LF7C:
mov.b @r6,r3
add #2,r6
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1138
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1138:
jmp @r4
mov #0x1C,r2
! Opcodes 1F80 - 1F87
LF80:
and r0,r2
add r13,r2
mov.b @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1139
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1139:
jmp @r4
mov #0x1C,r2
! Opcodes 1F88 - 1F8F
LF88:
and r0,r2
add r14,r2
mov.b @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1140
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1140:
jmp @r4
mov #0x1C,r2
! Opcodes 1F90 - 1F97
LF90:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1141
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1141:
jmp @r4
mov #0x1C,r2
! Opcodes 1F98 - 1F9F
LF98:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1142
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1142:
jmp @r4
mov #0x1C,r2
! Opcodes 1FA0 - 1FA7
LFA0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1143
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1143:
jmp @r4
mov #0x1C,r2
! Opcodes 1FA8 - 1FAF
LFA8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1144
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1144:
jmp @r4
mov #0x1C,r2
! Opcodes 1FB0 - 1FB7
LFB0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1145
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1145:
jmp @r4
mov #0x1C,r2
! Opcode 1FB8
LFB8:
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1146
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1146:
jmp @r4
mov #0x1C,r2
! Opcode 1FB9
LFB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1147
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1147:
jmp @r4
mov #0x1C,r2
! Opcode 1FBA
LFBA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1148
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1148:
jmp @r4
mov #0x1C,r2
! Opcode 1FBB
LFBB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1149
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1149:
jmp @r4
mov #0x1C,r2
! Opcode 1FBC
LFBC:
mov.b @r6,r3
add #2,r6
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1150
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1150:
jmp @r4
mov #0x1C,r2
! Opcodes 2000 - 2007
M000:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.l r3,@r13
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1151
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1151:
jmp @r4
mov #0x1C,r2
! Opcodes 2008 - 200F
M008:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.l r3,@r13
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1152
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1152:
jmp @r4
mov #0x1C,r2
! Opcodes 2010 - 2017
M010:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@r13
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1153
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1153:
jmp @r4
mov #0x1C,r2
! Opcodes 2018 - 201F
M018:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@r13
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1154
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1154:
jmp @r4
mov #0x1C,r2
! Opcodes 2020 - 2027
M020:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@r13
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1155
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1155:
jmp @r4
mov #0x1C,r2
! Opcodes 2028 - 202F
M028:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@r13
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1156
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1156:
jmp @r4
mov #0x1C,r2
! Opcodes 2030 - 2037
M030:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@r13
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1157
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1157:
jmp @r4
mov #0x1C,r2
! Opcode 2038
M038:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@r13
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1158
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1158:
jmp @r4
mov #0x1C,r2
! Opcode 2039
M039:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@r13
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1159
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1159:
jmp @r4
mov #0x1C,r2
! Opcode 203A
M03A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@r13
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1160
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1160:
jmp @r4
mov #0x1C,r2
! Opcode 203B
M03B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@r13
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1161
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1161:
jmp @r4
mov #0x1C,r2
! Opcode 203C
M03C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l r3,@r13
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1162
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1162:
jmp @r4
mov #0x1C,r2
! Opcodes 2040 - 2047
M040:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r13),r3
mov.l r3,@(32,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1163
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1163:
jmp @r4
mov #0x1C,r2
! Opcodes 2048 - 204F
M048:
and r0,r2
mov.l r3,@-r15
add r14,r2
mov.l @r2,r3
mov.l r3,@(32,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1164
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1164:
jmp @r4
mov #0x1C,r2
! Opcodes 2050 - 2057
M050:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(32,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1165
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1165:
jmp @r4
mov #0x1C,r2
! Opcodes 2058 - 205F
M058:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(32,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1166
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1166:
jmp @r4
mov #0x1C,r2
! Opcodes 2060 - 2067
M060:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(32,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1167
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1167:
jmp @r4
mov #0x1C,r2
! Opcodes 2068 - 206F
M068:
and r0,r2
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(32,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1168
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1168:
jmp @r4
mov #0x1C,r2
! Opcodes 2070 - 2077
M070:
and r0,r2
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(32,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1169
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1169:
jmp @r4
mov #0x1C,r2
! Opcode 2078
M078:
mov.l r3,@-r15
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(32,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1170
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1170:
jmp @r4
mov #0x1C,r2
! Opcode 2079
M079:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(32,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1171
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1171:
jmp @r4
mov #0x1C,r2
! Opcode 207A
M07A:
mov.l r3,@-r15
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(32,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1172
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1172:
jmp @r4
mov #0x1C,r2
! Opcode 207B
M07B:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(32,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1173
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1173:
jmp @r4
mov #0x1C,r2
! Opcode 207C
M07C:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l r3,@(32,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1174
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1174:
jmp @r4
mov #0x1C,r2
! Opcodes 2080 - 2087
M080:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1175
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1175:
jmp @r4
mov #0x1C,r2
! Opcodes 2088 - 208F
M088:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1176
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1176:
jmp @r4
mov #0x1C,r2
! Opcodes 2090 - 2097
M090:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1177
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1177:
jmp @r4
mov #0x1C,r2
! Opcodes 2098 - 209F
M098:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1178
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1178:
jmp @r4
mov #0x1C,r2
! Opcodes 20A0 - 20A7
M0A0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1179
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1179:
jmp @r4
mov #0x1C,r2
! Opcodes 20A8 - 20AF
M0A8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1180
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1180:
jmp @r4
mov #0x1C,r2
! Opcodes 20B0 - 20B7
M0B0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1181
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1181:
jmp @r4
mov #0x1C,r2
! Opcode 20B8
M0B8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1182
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1182:
jmp @r4
mov #0x1C,r2
! Opcode 20B9
M0B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1183
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1183:
jmp @r4
mov #0x1C,r2
! Opcode 20BA
M0BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1184
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1184:
jmp @r4
mov #0x1C,r2
! Opcode 20BB
M0BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1185
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1185:
jmp @r4
mov #0x1C,r2
! Opcode 20BC
M0BC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1186
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1186:
jmp @r4
mov #0x1C,r2
! Opcodes 20C0 - 20C7
M0C0:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1187
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1187:
jmp @r4
mov #0x1C,r2
! Opcodes 20C8 - 20CF
M0C8:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1188
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1188:
jmp @r4
mov #0x1C,r2
! Opcodes 20D0 - 20D7
M0D0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1189
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1189:
jmp @r4
mov #0x1C,r2
! Opcodes 20D8 - 20DF
M0D8:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1190
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1190:
jmp @r4
mov #0x1C,r2
! Opcodes 20E0 - 20E7
M0E0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1191
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1191:
jmp @r4
mov #0x1C,r2
! Opcodes 20E8 - 20EF
M0E8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1192
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1192:
jmp @r4
mov #0x1C,r2
! Opcodes 20F0 - 20F7
M0F0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1193
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1193:
jmp @r4
mov #0x1C,r2
! Opcode 20F8
M0F8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1194
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1194:
jmp @r4
mov #0x1C,r2
! Opcode 20F9
M0F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1195
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1195:
jmp @r4
mov #0x1C,r2
! Opcode 20FA
M0FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1196
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1196:
jmp @r4
mov #0x1C,r2
! Opcode 20FB
M0FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1197
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1197:
jmp @r4
mov #0x1C,r2
! Opcode 20FC
M0FC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(32,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1198
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1198:
jmp @r4
mov #0x1C,r2
! Opcodes 2100 - 2107
M100:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.l @(32,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1199
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1199:
jmp @r4
mov #0x1C,r2
! Opcodes 2108 - 210F
M108:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.l @(32,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1200
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1200:
jmp @r4
mov #0x1C,r2
! Opcodes 2110 - 2117
M110:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1201
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1201:
jmp @r4
mov #0x1C,r2
! Opcodes 2118 - 211F
M118:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(32,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1202
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1202:
jmp @r4
mov #0x1C,r2
! Opcodes 2120 - 2127
M120:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(32,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1203
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1203:
jmp @r4
mov #0x1C,r2
! Opcodes 2128 - 212F
M128:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1204
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1204:
jmp @r4
mov #0x1C,r2
! Opcodes 2130 - 2137
M130:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1205
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1205:
jmp @r4
mov #0x1C,r2
! Opcode 2138
M138:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1206
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1206:
jmp @r4
mov #0x1C,r2
! Opcode 2139
M139:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1207
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1207:
jmp @r4
mov #0x1C,r2
! Opcode 213A
M13A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1208
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1208:
jmp @r4
mov #0x1C,r2
! Opcode 213B
M13B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1209
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1209:
jmp @r4
mov #0x1C,r2
! Opcode 213C
M13C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(32,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1210
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1210:
jmp @r4
mov #0x1C,r2
! Opcodes 2140 - 2147
M140:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1211
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1211:
jmp @r4
mov #0x1C,r2
! Opcodes 2148 - 214F
M148:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1212
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1212:
jmp @r4
mov #0x1C,r2
! Opcodes 2150 - 2157
M150:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1213
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1213:
jmp @r4
mov #0x1C,r2
! Opcodes 2158 - 215F
M158:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1214
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1214:
jmp @r4
mov #0x1C,r2
! Opcodes 2160 - 2167
M160:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1215
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1215:
jmp @r4
mov #0x1C,r2
! Opcodes 2168 - 216F
M168:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1216
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1216:
jmp @r4
mov #0x1C,r2
! Opcodes 2170 - 2177
M170:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl1217
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1217:
jmp @r4
mov #0x1C,r2
! Opcode 2178
M178:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1218
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1218:
jmp @r4
mov #0x1C,r2
! Opcode 2179
M179:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-32,r7
shll2 r0
cmp/pl r7
bt/s fdl1219
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1219:
jmp @r4
mov #0x1C,r2
! Opcode 217A
M17A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1220
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1220:
jmp @r4
mov #0x1C,r2
! Opcode 217B
M17B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl1221
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1221:
jmp @r4
mov #0x1C,r2
! Opcode 217C
M17C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1222
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1222:
jmp @r4
mov #0x1C,r2
! Opcodes 2180 - 2187
M180:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1223
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1223:
jmp @r4
mov #0x1C,r2
! Opcodes 2188 - 218F
M188:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1224
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1224:
jmp @r4
mov #0x1C,r2
! Opcodes 2190 - 2197
M190:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1225
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1225:
jmp @r4
mov #0x1C,r2
! Opcodes 2198 - 219F
M198:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1226
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1226:
jmp @r4
mov #0x1C,r2
! Opcodes 21A0 - 21A7
M1A0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1227
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1227:
jmp @r4
mov #0x1C,r2
! Opcodes 21A8 - 21AF
M1A8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl1228
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1228:
jmp @r4
mov #0x1C,r2
! Opcodes 21B0 - 21B7
M1B0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-32,r7
shll2 r0
cmp/pl r7
bt/s fdl1229
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1229:
jmp @r4
mov #0x1C,r2
! Opcode 21B8
M1B8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl1230
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1230:
jmp @r4
mov #0x1C,r2
! Opcode 21B9
M1B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-34,r7
shll2 r0
cmp/pl r7
bt/s fdl1231
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1231:
jmp @r4
mov #0x1C,r2
! Opcode 21BA
M1BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl1232
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1232:
jmp @r4
mov #0x1C,r2
! Opcode 21BB
M1BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-32,r7
shll2 r0
cmp/pl r7
bt/s fdl1233
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1233:
jmp @r4
mov #0x1C,r2
! Opcode 21BC
M1BC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1234
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1234:
jmp @r4
mov #0x1C,r2
! Opcodes 21C0 - 21C7
M1C0:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.w @r6+,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1235
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1235:
jmp @r4
mov #0x1C,r2
! Opcodes 21C8 - 21CF
M1C8:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.w @r6+,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1236
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1236:
jmp @r4
mov #0x1C,r2
! Opcodes 21D0 - 21D7
M1D0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1237
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1237:
jmp @r4
mov #0x1C,r2
! Opcodes 21D8 - 21DF
M1D8:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1238
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1238:
jmp @r4
mov #0x1C,r2
! Opcodes 21E0 - 21E7
M1E0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1239
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1239:
jmp @r4
mov #0x1C,r2
! Opcodes 21E8 - 21EF
M1E8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1240
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1240:
jmp @r4
mov #0x1C,r2
! Opcodes 21F0 - 21F7
M1F0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl1241
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1241:
jmp @r4
mov #0x1C,r2
! Opcode 21F8
M1F8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1242
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1242:
jmp @r4
mov #0x1C,r2
! Opcode 21F9
M1F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-32,r7
shll2 r0
cmp/pl r7
bt/s fdl1243
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1243:
jmp @r4
mov #0x1C,r2
! Opcode 21FA
M1FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1244
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1244:
jmp @r4
mov #0x1C,r2
! Opcode 21FB
M1FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl1245
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1245:
jmp @r4
mov #0x1C,r2
! Opcode 21FC
M1FC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.w @r6+,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1246
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1246:
jmp @r4
mov #0x1C,r2
! Opcodes 2200 - 2207
M200:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.l r3,@(4,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1247
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1247:
jmp @r4
mov #0x1C,r2
! Opcodes 2208 - 220F
M208:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.l r3,@(4,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1248
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1248:
jmp @r4
mov #0x1C,r2
! Opcodes 2210 - 2217
M210:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(4,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1249
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1249:
jmp @r4
mov #0x1C,r2
! Opcodes 2218 - 221F
M218:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(4,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1250
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1250:
jmp @r4
mov #0x1C,r2
! Opcodes 2220 - 2227
M220:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(4,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1251
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1251:
jmp @r4
mov #0x1C,r2
! Opcodes 2228 - 222F
M228:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(4,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1252
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1252:
jmp @r4
mov #0x1C,r2
! Opcodes 2230 - 2237
M230:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(4,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1253
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1253:
jmp @r4
mov #0x1C,r2
! Opcode 2238
M238:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(4,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1254
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1254:
jmp @r4
mov #0x1C,r2
! Opcode 2239
M239:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(4,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1255
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1255:
jmp @r4
mov #0x1C,r2
! Opcode 223A
M23A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(4,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1256
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1256:
jmp @r4
mov #0x1C,r2
! Opcode 223B
M23B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(4,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1257
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1257:
jmp @r4
mov #0x1C,r2
! Opcode 223C
M23C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l r3,@(4,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1258
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1258:
jmp @r4
mov #0x1C,r2
! Opcodes 2240 - 2247
M240:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r13),r3
mov.l r3,@(36,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1259
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1259:
jmp @r4
mov #0x1C,r2
! Opcodes 2248 - 224F
M248:
and r0,r2
mov.l r3,@-r15
add r14,r2
mov.l @r2,r3
mov.l r3,@(36,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1260
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1260:
jmp @r4
mov #0x1C,r2
! Opcodes 2250 - 2257
M250:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(36,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1261
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1261:
jmp @r4
mov #0x1C,r2
! Opcodes 2258 - 225F
M258:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(36,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1262
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1262:
jmp @r4
mov #0x1C,r2
! Opcodes 2260 - 2267
M260:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(36,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1263
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1263:
jmp @r4
mov #0x1C,r2
! Opcodes 2268 - 226F
M268:
and r0,r2
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(36,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1264
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1264:
jmp @r4
mov #0x1C,r2
! Opcodes 2270 - 2277
M270:
and r0,r2
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(36,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1265
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1265:
jmp @r4
mov #0x1C,r2
! Opcode 2278
M278:
mov.l r3,@-r15
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(36,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1266
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1266:
jmp @r4
mov #0x1C,r2
! Opcode 2279
M279:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(36,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1267
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1267:
jmp @r4
mov #0x1C,r2
! Opcode 227A
M27A:
mov.l r3,@-r15
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(36,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1268
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1268:
jmp @r4
mov #0x1C,r2
! Opcode 227B
M27B:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(36,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1269
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1269:
jmp @r4
mov #0x1C,r2
! Opcode 227C
M27C:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l r3,@(36,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1270
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1270:
jmp @r4
mov #0x1C,r2
! Opcodes 2280 - 2287
M280:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1271
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1271:
jmp @r4
mov #0x1C,r2
! Opcodes 2288 - 228F
M288:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1272
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1272:
jmp @r4
mov #0x1C,r2
! Opcodes 2290 - 2297
M290:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1273
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1273:
jmp @r4
mov #0x1C,r2
! Opcodes 2298 - 229F
M298:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1274
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1274:
jmp @r4
mov #0x1C,r2
! Opcodes 22A0 - 22A7
M2A0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1275
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1275:
jmp @r4
mov #0x1C,r2
! Opcodes 22A8 - 22AF
M2A8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1276
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1276:
jmp @r4
mov #0x1C,r2
! Opcodes 22B0 - 22B7
M2B0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1277
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1277:
jmp @r4
mov #0x1C,r2
! Opcode 22B8
M2B8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1278
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1278:
jmp @r4
mov #0x1C,r2
! Opcode 22B9
M2B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1279
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1279:
jmp @r4
mov #0x1C,r2
! Opcode 22BA
M2BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1280
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1280:
jmp @r4
mov #0x1C,r2
! Opcode 22BB
M2BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1281
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1281:
jmp @r4
mov #0x1C,r2
! Opcode 22BC
M2BC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1282
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1282:
jmp @r4
mov #0x1C,r2
! Opcodes 22C0 - 22C7
M2C0:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1283
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1283:
jmp @r4
mov #0x1C,r2
! Opcodes 22C8 - 22CF
M2C8:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1284
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1284:
jmp @r4
mov #0x1C,r2
! Opcodes 22D0 - 22D7
M2D0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1285
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1285:
jmp @r4
mov #0x1C,r2
! Opcodes 22D8 - 22DF
M2D8:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1286
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1286:
jmp @r4
mov #0x1C,r2
! Opcodes 22E0 - 22E7
M2E0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1287
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1287:
jmp @r4
mov #0x1C,r2
! Opcodes 22E8 - 22EF
M2E8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1288
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1288:
jmp @r4
mov #0x1C,r2
! Opcodes 22F0 - 22F7
M2F0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1289
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1289:
jmp @r4
mov #0x1C,r2
! Opcode 22F8
M2F8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1290
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1290:
jmp @r4
mov #0x1C,r2
! Opcode 22F9
M2F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1291
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1291:
jmp @r4
mov #0x1C,r2
! Opcode 22FA
M2FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1292
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1292:
jmp @r4
mov #0x1C,r2
! Opcode 22FB
M2FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1293
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1293:
jmp @r4
mov #0x1C,r2
! Opcode 22FC
M2FC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(36,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1294
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1294:
jmp @r4
mov #0x1C,r2
! Opcodes 2300 - 2307
M300:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.l @(36,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1295
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1295:
jmp @r4
mov #0x1C,r2
! Opcodes 2308 - 230F
M308:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.l @(36,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1296
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1296:
jmp @r4
mov #0x1C,r2
! Opcodes 2310 - 2317
M310:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1297
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1297:
jmp @r4
mov #0x1C,r2
! Opcodes 2318 - 231F
M318:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(36,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1298
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1298:
jmp @r4
mov #0x1C,r2
! Opcodes 2320 - 2327
M320:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(36,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1299
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1299:
jmp @r4
mov #0x1C,r2
! Opcodes 2328 - 232F
M328:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1300
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1300:
jmp @r4
mov #0x1C,r2
! Opcodes 2330 - 2337
M330:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1301
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1301:
jmp @r4
mov #0x1C,r2
! Opcode 2338
M338:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1302
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1302:
jmp @r4
mov #0x1C,r2
! Opcode 2339
M339:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1303
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1303:
jmp @r4
mov #0x1C,r2
! Opcode 233A
M33A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1304
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1304:
jmp @r4
mov #0x1C,r2
! Opcode 233B
M33B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1305
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1305:
jmp @r4
mov #0x1C,r2
! Opcode 233C
M33C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(36,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1306
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1306:
jmp @r4
mov #0x1C,r2
! Opcodes 2340 - 2347
M340:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1307
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1307:
jmp @r4
mov #0x1C,r2
! Opcodes 2348 - 234F
M348:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1308
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1308:
jmp @r4
mov #0x1C,r2
! Opcodes 2350 - 2357
M350:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1309
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1309:
jmp @r4
mov #0x1C,r2
! Opcodes 2358 - 235F
M358:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1310
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1310:
jmp @r4
mov #0x1C,r2
! Opcodes 2360 - 2367
M360:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1311
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1311:
jmp @r4
mov #0x1C,r2
! Opcodes 2368 - 236F
M368:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1312
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1312:
jmp @r4
mov #0x1C,r2
! Opcodes 2370 - 2377
M370:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl1313
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1313:
jmp @r4
mov #0x1C,r2
! Opcode 2378
M378:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1314
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1314:
jmp @r4
mov #0x1C,r2
! Opcode 2379
M379:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-32,r7
shll2 r0
cmp/pl r7
bt/s fdl1315
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1315:
jmp @r4
mov #0x1C,r2
! Opcode 237A
M37A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1316
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1316:
jmp @r4
mov #0x1C,r2
! Opcode 237B
M37B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl1317
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1317:
jmp @r4
mov #0x1C,r2
! Opcode 237C
M37C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1318
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1318:
jmp @r4
mov #0x1C,r2
! Opcodes 2380 - 2387
M380:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1319
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1319:
jmp @r4
mov #0x1C,r2
! Opcodes 2388 - 238F
M388:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1320
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1320:
jmp @r4
mov #0x1C,r2
! Opcodes 2390 - 2397
M390:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1321
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1321:
jmp @r4
mov #0x1C,r2
! Opcodes 2398 - 239F
M398:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1322
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1322:
jmp @r4
mov #0x1C,r2
! Opcodes 23A0 - 23A7
M3A0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1323
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1323:
jmp @r4
mov #0x1C,r2
! Opcodes 23A8 - 23AF
M3A8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl1324
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1324:
jmp @r4
mov #0x1C,r2
! Opcodes 23B0 - 23B7
M3B0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-32,r7
shll2 r0
cmp/pl r7
bt/s fdl1325
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1325:
jmp @r4
mov #0x1C,r2
! Opcode 23B8
M3B8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl1326
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1326:
jmp @r4
mov #0x1C,r2
! Opcode 23B9
M3B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-34,r7
shll2 r0
cmp/pl r7
bt/s fdl1327
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1327:
jmp @r4
mov #0x1C,r2
! Opcode 23BA
M3BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl1328
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1328:
jmp @r4
mov #0x1C,r2
! Opcode 23BB
M3BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-32,r7
shll2 r0
cmp/pl r7
bt/s fdl1329
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1329:
jmp @r4
mov #0x1C,r2
! Opcode 23BC
M3BC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1330
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1330:
jmp @r4
mov #0x1C,r2
! Opcodes 23C0 - 23C7
M3C0:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1331
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1331:
jmp @r4
mov #0x1C,r2
! Opcodes 23C8 - 23CF
M3C8:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1332
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1332:
jmp @r4
mov #0x1C,r2
! Opcodes 23D0 - 23D7
M3D0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1333
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1333:
jmp @r4
mov #0x1C,r2
! Opcodes 23D8 - 23DF
M3D8:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1334
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1334:
jmp @r4
mov #0x1C,r2
! Opcodes 23E0 - 23E7
M3E0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl1335
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1335:
jmp @r4
mov #0x1C,r2
! Opcodes 23E8 - 23EF
M3E8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-32,r7
shll2 r0
cmp/pl r7
bt/s fdl1336
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1336:
jmp @r4
mov #0x1C,r2
! Opcodes 23F0 - 23F7
M3F0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-34,r7
shll2 r0
cmp/pl r7
bt/s fdl1337
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1337:
jmp @r4
mov #0x1C,r2
! Opcode 23F8
M3F8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-32,r7
shll2 r0
cmp/pl r7
bt/s fdl1338
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1338:
jmp @r4
mov #0x1C,r2
! Opcode 23F9
M3F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-36,r7
shll2 r0
cmp/pl r7
bt/s fdl1339
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1339:
jmp @r4
mov #0x1C,r2
! Opcode 23FA
M3FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-32,r7
shll2 r0
cmp/pl r7
bt/s fdl1340
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1340:
jmp @r4
mov #0x1C,r2
! Opcode 23FB
M3FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-34,r7
shll2 r0
cmp/pl r7
bt/s fdl1341
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1341:
jmp @r4
mov #0x1C,r2
! Opcode 23FC
M3FC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1342
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1342:
jmp @r4
mov #0x1C,r2
! Opcodes 2400 - 2407
M400:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.l r3,@(8,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1343
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1343:
jmp @r4
mov #0x1C,r2
! Opcodes 2408 - 240F
M408:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.l r3,@(8,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1344
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1344:
jmp @r4
mov #0x1C,r2
! Opcodes 2410 - 2417
M410:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(8,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1345
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1345:
jmp @r4
mov #0x1C,r2
! Opcodes 2418 - 241F
M418:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(8,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1346
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1346:
jmp @r4
mov #0x1C,r2
! Opcodes 2420 - 2427
M420:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(8,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1347
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1347:
jmp @r4
mov #0x1C,r2
! Opcodes 2428 - 242F
M428:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(8,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1348
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1348:
jmp @r4
mov #0x1C,r2
! Opcodes 2430 - 2437
M430:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(8,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1349
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1349:
jmp @r4
mov #0x1C,r2
! Opcode 2438
M438:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(8,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1350
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1350:
jmp @r4
mov #0x1C,r2
! Opcode 2439
M439:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(8,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1351
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1351:
jmp @r4
mov #0x1C,r2
! Opcode 243A
M43A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(8,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1352
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1352:
jmp @r4
mov #0x1C,r2
! Opcode 243B
M43B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(8,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1353
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1353:
jmp @r4
mov #0x1C,r2
! Opcode 243C
M43C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l r3,@(8,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1354
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1354:
jmp @r4
mov #0x1C,r2
! Opcodes 2440 - 2447
M440:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r13),r3
mov.l r3,@(40,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1355
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1355:
jmp @r4
mov #0x1C,r2
! Opcodes 2448 - 244F
M448:
and r0,r2
mov.l r3,@-r15
add r14,r2
mov.l @r2,r3
mov.l r3,@(40,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1356
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1356:
jmp @r4
mov #0x1C,r2
! Opcodes 2450 - 2457
M450:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(40,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1357
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1357:
jmp @r4
mov #0x1C,r2
! Opcodes 2458 - 245F
M458:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(40,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1358
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1358:
jmp @r4
mov #0x1C,r2
! Opcodes 2460 - 2467
M460:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(40,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1359
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1359:
jmp @r4
mov #0x1C,r2
! Opcodes 2468 - 246F
M468:
and r0,r2
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(40,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1360
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1360:
jmp @r4
mov #0x1C,r2
! Opcodes 2470 - 2477
M470:
and r0,r2
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(40,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1361
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1361:
jmp @r4
mov #0x1C,r2
! Opcode 2478
M478:
mov.l r3,@-r15
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(40,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1362
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1362:
jmp @r4
mov #0x1C,r2
! Opcode 2479
M479:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(40,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1363
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1363:
jmp @r4
mov #0x1C,r2
! Opcode 247A
M47A:
mov.l r3,@-r15
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(40,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1364
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1364:
jmp @r4
mov #0x1C,r2
! Opcode 247B
M47B:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(40,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1365
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1365:
jmp @r4
mov #0x1C,r2
! Opcode 247C
M47C:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l r3,@(40,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1366
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1366:
jmp @r4
mov #0x1C,r2
! Opcodes 2480 - 2487
M480:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1367
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1367:
jmp @r4
mov #0x1C,r2
! Opcodes 2488 - 248F
M488:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1368
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1368:
jmp @r4
mov #0x1C,r2
! Opcodes 2490 - 2497
M490:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1369
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1369:
jmp @r4
mov #0x1C,r2
! Opcodes 2498 - 249F
M498:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1370
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1370:
jmp @r4
mov #0x1C,r2
! Opcodes 24A0 - 24A7
M4A0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1371
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1371:
jmp @r4
mov #0x1C,r2
! Opcodes 24A8 - 24AF
M4A8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1372
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1372:
jmp @r4
mov #0x1C,r2
! Opcodes 24B0 - 24B7
M4B0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1373
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1373:
jmp @r4
mov #0x1C,r2
! Opcode 24B8
M4B8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1374
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1374:
jmp @r4
mov #0x1C,r2
! Opcode 24B9
M4B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1375
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1375:
jmp @r4
mov #0x1C,r2
! Opcode 24BA
M4BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1376
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1376:
jmp @r4
mov #0x1C,r2
! Opcode 24BB
M4BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1377
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1377:
jmp @r4
mov #0x1C,r2
! Opcode 24BC
M4BC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1378
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1378:
jmp @r4
mov #0x1C,r2
! Opcodes 24C0 - 24C7
M4C0:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1379
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1379:
jmp @r4
mov #0x1C,r2
! Opcodes 24C8 - 24CF
M4C8:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1380
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1380:
jmp @r4
mov #0x1C,r2
! Opcodes 24D0 - 24D7
M4D0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1381
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1381:
jmp @r4
mov #0x1C,r2
! Opcodes 24D8 - 24DF
M4D8:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1382
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1382:
jmp @r4
mov #0x1C,r2
! Opcodes 24E0 - 24E7
M4E0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1383
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1383:
jmp @r4
mov #0x1C,r2
! Opcodes 24E8 - 24EF
M4E8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1384
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1384:
jmp @r4
mov #0x1C,r2
! Opcodes 24F0 - 24F7
M4F0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1385
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1385:
jmp @r4
mov #0x1C,r2
! Opcode 24F8
M4F8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1386
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1386:
jmp @r4
mov #0x1C,r2
! Opcode 24F9
M4F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1387
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1387:
jmp @r4
mov #0x1C,r2
! Opcode 24FA
M4FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1388
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1388:
jmp @r4
mov #0x1C,r2
! Opcode 24FB
M4FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1389
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1389:
jmp @r4
mov #0x1C,r2
! Opcode 24FC
M4FC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(40,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1390
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1390:
jmp @r4
mov #0x1C,r2
! Opcodes 2500 - 2507
M500:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.l @(40,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1391
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1391:
jmp @r4
mov #0x1C,r2
! Opcodes 2508 - 250F
M508:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.l @(40,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1392
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1392:
jmp @r4
mov #0x1C,r2
! Opcodes 2510 - 2517
M510:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1393
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1393:
jmp @r4
mov #0x1C,r2
! Opcodes 2518 - 251F
M518:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(40,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1394
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1394:
jmp @r4
mov #0x1C,r2
! Opcodes 2520 - 2527
M520:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(40,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1395
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1395:
jmp @r4
mov #0x1C,r2
! Opcodes 2528 - 252F
M528:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1396
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1396:
jmp @r4
mov #0x1C,r2
! Opcodes 2530 - 2537
M530:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1397
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1397:
jmp @r4
mov #0x1C,r2
! Opcode 2538
M538:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1398
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1398:
jmp @r4
mov #0x1C,r2
! Opcode 2539
M539:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1399
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1399:
jmp @r4
mov #0x1C,r2
! Opcode 253A
M53A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1400
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1400:
jmp @r4
mov #0x1C,r2
! Opcode 253B
M53B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1401
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1401:
jmp @r4
mov #0x1C,r2
! Opcode 253C
M53C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(40,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1402
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1402:
jmp @r4
mov #0x1C,r2
! Opcodes 2540 - 2547
M540:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1403
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1403:
jmp @r4
mov #0x1C,r2
! Opcodes 2548 - 254F
M548:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1404
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1404:
jmp @r4
mov #0x1C,r2
! Opcodes 2550 - 2557
M550:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1405
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1405:
jmp @r4
mov #0x1C,r2
! Opcodes 2558 - 255F
M558:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1406
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1406:
jmp @r4
mov #0x1C,r2
! Opcodes 2560 - 2567
M560:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1407
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1407:
jmp @r4
mov #0x1C,r2
! Opcodes 2568 - 256F
M568:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1408
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1408:
jmp @r4
mov #0x1C,r2
! Opcodes 2570 - 2577
M570:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl1409
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1409:
jmp @r4
mov #0x1C,r2
! Opcode 2578
M578:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1410
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1410:
jmp @r4
mov #0x1C,r2
! Opcode 2579
M579:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-32,r7
shll2 r0
cmp/pl r7
bt/s fdl1411
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1411:
jmp @r4
mov #0x1C,r2
! Opcode 257A
M57A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1412
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1412:
jmp @r4
mov #0x1C,r2
! Opcode 257B
M57B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl1413
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1413:
jmp @r4
mov #0x1C,r2
! Opcode 257C
M57C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1414
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1414:
jmp @r4
mov #0x1C,r2
! Opcodes 2580 - 2587
M580:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1415
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1415:
jmp @r4
mov #0x1C,r2
! Opcodes 2588 - 258F
M588:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1416
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1416:
jmp @r4
mov #0x1C,r2
! Opcodes 2590 - 2597
M590:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1417
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1417:
jmp @r4
mov #0x1C,r2
! Opcodes 2598 - 259F
M598:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1418
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1418:
jmp @r4
mov #0x1C,r2
! Opcodes 25A0 - 25A7
M5A0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1419
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1419:
jmp @r4
mov #0x1C,r2
! Opcodes 25A8 - 25AF
M5A8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl1420
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1420:
jmp @r4
mov #0x1C,r2
! Opcodes 25B0 - 25B7
M5B0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-32,r7
shll2 r0
cmp/pl r7
bt/s fdl1421
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1421:
jmp @r4
mov #0x1C,r2
! Opcode 25B8
M5B8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl1422
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1422:
jmp @r4
mov #0x1C,r2
! Opcode 25B9
M5B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-34,r7
shll2 r0
cmp/pl r7
bt/s fdl1423
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1423:
jmp @r4
mov #0x1C,r2
! Opcode 25BA
M5BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl1424
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1424:
jmp @r4
mov #0x1C,r2
! Opcode 25BB
M5BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-32,r7
shll2 r0
cmp/pl r7
bt/s fdl1425
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1425:
jmp @r4
mov #0x1C,r2
! Opcode 25BC
M5BC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1426
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1426:
jmp @r4
mov #0x1C,r2
! Opcodes 2600 - 2607
M600:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.l r3,@(12,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1427
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1427:
jmp @r4
mov #0x1C,r2
! Opcodes 2608 - 260F
M608:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.l r3,@(12,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1428
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1428:
jmp @r4
mov #0x1C,r2
! Opcodes 2610 - 2617
M610:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(12,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1429
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1429:
jmp @r4
mov #0x1C,r2
! Opcodes 2618 - 261F
M618:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(12,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1430
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1430:
jmp @r4
mov #0x1C,r2
! Opcodes 2620 - 2627
M620:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(12,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1431
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1431:
jmp @r4
mov #0x1C,r2
! Opcodes 2628 - 262F
M628:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(12,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1432
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1432:
jmp @r4
mov #0x1C,r2
! Opcodes 2630 - 2637
M630:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(12,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1433
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1433:
jmp @r4
mov #0x1C,r2
! Opcode 2638
M638:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(12,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1434
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1434:
jmp @r4
mov #0x1C,r2
! Opcode 2639
M639:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(12,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1435
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1435:
jmp @r4
mov #0x1C,r2
! Opcode 263A
M63A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(12,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1436
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1436:
jmp @r4
mov #0x1C,r2
! Opcode 263B
M63B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(12,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1437
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1437:
jmp @r4
mov #0x1C,r2
! Opcode 263C
M63C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l r3,@(12,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1438
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1438:
jmp @r4
mov #0x1C,r2
! Opcodes 2640 - 2647
M640:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r13),r3
mov.l r3,@(44,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1439
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1439:
jmp @r4
mov #0x1C,r2
! Opcodes 2648 - 264F
M648:
and r0,r2
mov.l r3,@-r15
add r14,r2
mov.l @r2,r3
mov.l r3,@(44,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1440
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1440:
jmp @r4
mov #0x1C,r2
! Opcodes 2650 - 2657
M650:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(44,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1441
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1441:
jmp @r4
mov #0x1C,r2
! Opcodes 2658 - 265F
M658:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(44,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1442
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1442:
jmp @r4
mov #0x1C,r2
! Opcodes 2660 - 2667
M660:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(44,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1443
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1443:
jmp @r4
mov #0x1C,r2
! Opcodes 2668 - 266F
M668:
and r0,r2
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(44,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1444
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1444:
jmp @r4
mov #0x1C,r2
! Opcodes 2670 - 2677
M670:
and r0,r2
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(44,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1445
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1445:
jmp @r4
mov #0x1C,r2
! Opcode 2678
M678:
mov.l r3,@-r15
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(44,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1446
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1446:
jmp @r4
mov #0x1C,r2
! Opcode 2679
M679:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(44,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1447
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1447:
jmp @r4
mov #0x1C,r2
! Opcode 267A
M67A:
mov.l r3,@-r15
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(44,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1448
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1448:
jmp @r4
mov #0x1C,r2
! Opcode 267B
M67B:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(44,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1449
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1449:
jmp @r4
mov #0x1C,r2
! Opcode 267C
M67C:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l r3,@(44,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1450
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1450:
jmp @r4
mov #0x1C,r2
! Opcodes 2680 - 2687
M680:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1451
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1451:
jmp @r4
mov #0x1C,r2
! Opcodes 2688 - 268F
M688:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1452
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1452:
jmp @r4
mov #0x1C,r2
! Opcodes 2690 - 2697
M690:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1453
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1453:
jmp @r4
mov #0x1C,r2
! Opcodes 2698 - 269F
M698:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1454
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1454:
jmp @r4
mov #0x1C,r2
! Opcodes 26A0 - 26A7
M6A0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1455
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1455:
jmp @r4
mov #0x1C,r2
! Opcodes 26A8 - 26AF
M6A8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1456
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1456:
jmp @r4
mov #0x1C,r2
! Opcodes 26B0 - 26B7
M6B0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1457
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1457:
jmp @r4
mov #0x1C,r2
! Opcode 26B8
M6B8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1458
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1458:
jmp @r4
mov #0x1C,r2
! Opcode 26B9
M6B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1459
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1459:
jmp @r4
mov #0x1C,r2
! Opcode 26BA
M6BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1460
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1460:
jmp @r4
mov #0x1C,r2
! Opcode 26BB
M6BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1461
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1461:
jmp @r4
mov #0x1C,r2
! Opcode 26BC
M6BC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1462
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1462:
jmp @r4
mov #0x1C,r2
! Opcodes 26C0 - 26C7
M6C0:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1463
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1463:
jmp @r4
mov #0x1C,r2
! Opcodes 26C8 - 26CF
M6C8:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1464
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1464:
jmp @r4
mov #0x1C,r2
! Opcodes 26D0 - 26D7
M6D0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1465
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1465:
jmp @r4
mov #0x1C,r2
! Opcodes 26D8 - 26DF
M6D8:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1466
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1466:
jmp @r4
mov #0x1C,r2
! Opcodes 26E0 - 26E7
M6E0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1467
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1467:
jmp @r4
mov #0x1C,r2
! Opcodes 26E8 - 26EF
M6E8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1468
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1468:
jmp @r4
mov #0x1C,r2
! Opcodes 26F0 - 26F7
M6F0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1469
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1469:
jmp @r4
mov #0x1C,r2
! Opcode 26F8
M6F8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1470
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1470:
jmp @r4
mov #0x1C,r2
! Opcode 26F9
M6F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1471
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1471:
jmp @r4
mov #0x1C,r2
! Opcode 26FA
M6FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1472
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1472:
jmp @r4
mov #0x1C,r2
! Opcode 26FB
M6FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1473
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1473:
jmp @r4
mov #0x1C,r2
! Opcode 26FC
M6FC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(44,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1474
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1474:
jmp @r4
mov #0x1C,r2
! Opcodes 2700 - 2707
M700:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.l @(44,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1475
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1475:
jmp @r4
mov #0x1C,r2
! Opcodes 2708 - 270F
M708:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.l @(44,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1476
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1476:
jmp @r4
mov #0x1C,r2
! Opcodes 2710 - 2717
M710:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1477
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1477:
jmp @r4
mov #0x1C,r2
! Opcodes 2718 - 271F
M718:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(44,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1478
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1478:
jmp @r4
mov #0x1C,r2
! Opcodes 2720 - 2727
M720:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(44,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1479
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1479:
jmp @r4
mov #0x1C,r2
! Opcodes 2728 - 272F
M728:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1480
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1480:
jmp @r4
mov #0x1C,r2
! Opcodes 2730 - 2737
M730:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1481
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1481:
jmp @r4
mov #0x1C,r2
! Opcode 2738
M738:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1482
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1482:
jmp @r4
mov #0x1C,r2
! Opcode 2739
M739:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1483
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1483:
jmp @r4
mov #0x1C,r2
! Opcode 273A
M73A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1484
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1484:
jmp @r4
mov #0x1C,r2
! Opcode 273B
M73B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1485
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1485:
jmp @r4
mov #0x1C,r2
! Opcode 273C
M73C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(44,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1486
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1486:
jmp @r4
mov #0x1C,r2
! Opcodes 2740 - 2747
M740:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1487
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1487:
jmp @r4
mov #0x1C,r2
! Opcodes 2748 - 274F
M748:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1488
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1488:
jmp @r4
mov #0x1C,r2
! Opcodes 2750 - 2757
M750:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1489
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1489:
jmp @r4
mov #0x1C,r2
! Opcodes 2758 - 275F
M758:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1490
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1490:
jmp @r4
mov #0x1C,r2
! Opcodes 2760 - 2767
M760:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1491
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1491:
jmp @r4
mov #0x1C,r2
! Opcodes 2768 - 276F
M768:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1492
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1492:
jmp @r4
mov #0x1C,r2
! Opcodes 2770 - 2777
M770:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl1493
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1493:
jmp @r4
mov #0x1C,r2
! Opcode 2778
M778:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1494
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1494:
jmp @r4
mov #0x1C,r2
! Opcode 2779
M779:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-32,r7
shll2 r0
cmp/pl r7
bt/s fdl1495
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1495:
jmp @r4
mov #0x1C,r2
! Opcode 277A
M77A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1496
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1496:
jmp @r4
mov #0x1C,r2
! Opcode 277B
M77B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl1497
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1497:
jmp @r4
mov #0x1C,r2
! Opcode 277C
M77C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1498
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1498:
jmp @r4
mov #0x1C,r2
! Opcodes 2780 - 2787
M780:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1499
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1499:
jmp @r4
mov #0x1C,r2
! Opcodes 2788 - 278F
M788:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1500
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1500:
jmp @r4
mov #0x1C,r2
! Opcodes 2790 - 2797
M790:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1501
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1501:
jmp @r4
mov #0x1C,r2
! Opcodes 2798 - 279F
M798:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1502
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1502:
jmp @r4
mov #0x1C,r2
! Opcodes 27A0 - 27A7
M7A0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1503
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1503:
jmp @r4
mov #0x1C,r2
! Opcodes 27A8 - 27AF
M7A8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl1504
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1504:
jmp @r4
mov #0x1C,r2
! Opcodes 27B0 - 27B7
M7B0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-32,r7
shll2 r0
cmp/pl r7
bt/s fdl1505
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1505:
jmp @r4
mov #0x1C,r2
! Opcode 27B8
M7B8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl1506
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1506:
jmp @r4
mov #0x1C,r2
! Opcode 27B9
M7B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-34,r7
shll2 r0
cmp/pl r7
bt/s fdl1507
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1507:
jmp @r4
mov #0x1C,r2
! Opcode 27BA
M7BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl1508
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1508:
jmp @r4
mov #0x1C,r2
! Opcode 27BB
M7BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-32,r7
shll2 r0
cmp/pl r7
bt/s fdl1509
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1509:
jmp @r4
mov #0x1C,r2
! Opcode 27BC
M7BC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1510
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1510:
jmp @r4
mov #0x1C,r2
! Opcodes 2800 - 2807
M800:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.l r3,@(16,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1511
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1511:
jmp @r4
mov #0x1C,r2
! Opcodes 2808 - 280F
M808:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.l r3,@(16,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1512
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1512:
jmp @r4
mov #0x1C,r2
! Opcodes 2810 - 2817
M810:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(16,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1513
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1513:
jmp @r4
mov #0x1C,r2
! Opcodes 2818 - 281F
M818:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(16,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1514
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1514:
jmp @r4
mov #0x1C,r2
! Opcodes 2820 - 2827
M820:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(16,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1515
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1515:
jmp @r4
mov #0x1C,r2
! Opcodes 2828 - 282F
M828:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(16,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1516
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1516:
jmp @r4
mov #0x1C,r2
! Opcodes 2830 - 2837
M830:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(16,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1517
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1517:
jmp @r4
mov #0x1C,r2
! Opcode 2838
M838:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(16,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1518
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1518:
jmp @r4
mov #0x1C,r2
! Opcode 2839
M839:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(16,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1519
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1519:
jmp @r4
mov #0x1C,r2
! Opcode 283A
M83A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(16,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1520
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1520:
jmp @r4
mov #0x1C,r2
! Opcode 283B
M83B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(16,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1521
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1521:
jmp @r4
mov #0x1C,r2
! Opcode 283C
M83C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l r3,@(16,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1522
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1522:
jmp @r4
mov #0x1C,r2
! Opcodes 2840 - 2847
M840:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r13),r3
mov.l r3,@(48,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1523
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1523:
jmp @r4
mov #0x1C,r2
! Opcodes 2848 - 284F
M848:
and r0,r2
mov.l r3,@-r15
add r14,r2
mov.l @r2,r3
mov.l r3,@(48,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1524
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1524:
jmp @r4
mov #0x1C,r2
! Opcodes 2850 - 2857
M850:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(48,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1525
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1525:
jmp @r4
mov #0x1C,r2
! Opcodes 2858 - 285F
M858:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(48,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1526
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1526:
jmp @r4
mov #0x1C,r2
! Opcodes 2860 - 2867
M860:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(48,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1527
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1527:
jmp @r4
mov #0x1C,r2
! Opcodes 2868 - 286F
M868:
and r0,r2
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(48,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1528
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1528:
jmp @r4
mov #0x1C,r2
! Opcodes 2870 - 2877
M870:
and r0,r2
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(48,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1529
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1529:
jmp @r4
mov #0x1C,r2
! Opcode 2878
M878:
mov.l r3,@-r15
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(48,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1530
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1530:
jmp @r4
mov #0x1C,r2
! Opcode 2879
M879:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(48,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1531
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1531:
jmp @r4
mov #0x1C,r2
! Opcode 287A
M87A:
mov.l r3,@-r15
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(48,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1532
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1532:
jmp @r4
mov #0x1C,r2
! Opcode 287B
M87B:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(48,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1533
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1533:
jmp @r4
mov #0x1C,r2
! Opcode 287C
M87C:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l r3,@(48,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1534
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1534:
jmp @r4
mov #0x1C,r2
! Opcodes 2880 - 2887
M880:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1535
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1535:
jmp @r4
mov #0x1C,r2
! Opcodes 2888 - 288F
M888:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1536
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1536:
jmp @r4
mov #0x1C,r2
! Opcodes 2890 - 2897
M890:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1537
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1537:
jmp @r4
mov #0x1C,r2
! Opcodes 2898 - 289F
M898:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1538
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1538:
jmp @r4
mov #0x1C,r2
! Opcodes 28A0 - 28A7
M8A0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1539
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1539:
jmp @r4
mov #0x1C,r2
! Opcodes 28A8 - 28AF
M8A8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1540
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1540:
jmp @r4
mov #0x1C,r2
! Opcodes 28B0 - 28B7
M8B0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1541
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1541:
jmp @r4
mov #0x1C,r2
! Opcode 28B8
M8B8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1542
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1542:
jmp @r4
mov #0x1C,r2
! Opcode 28B9
M8B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1543
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1543:
jmp @r4
mov #0x1C,r2
! Opcode 28BA
M8BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1544
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1544:
jmp @r4
mov #0x1C,r2
! Opcode 28BB
M8BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1545
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1545:
jmp @r4
mov #0x1C,r2
! Opcode 28BC
M8BC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1546
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1546:
jmp @r4
mov #0x1C,r2
! Opcodes 28C0 - 28C7
M8C0:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1547
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1547:
jmp @r4
mov #0x1C,r2
! Opcodes 28C8 - 28CF
M8C8:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1548
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1548:
jmp @r4
mov #0x1C,r2
! Opcodes 28D0 - 28D7
M8D0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1549
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1549:
jmp @r4
mov #0x1C,r2
! Opcodes 28D8 - 28DF
M8D8:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1550
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1550:
jmp @r4
mov #0x1C,r2
! Opcodes 28E0 - 28E7
M8E0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1551
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1551:
jmp @r4
mov #0x1C,r2
! Opcodes 28E8 - 28EF
M8E8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1552
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1552:
jmp @r4
mov #0x1C,r2
! Opcodes 28F0 - 28F7
M8F0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1553
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1553:
jmp @r4
mov #0x1C,r2
! Opcode 28F8
M8F8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1554
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1554:
jmp @r4
mov #0x1C,r2
! Opcode 28F9
M8F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1555
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1555:
jmp @r4
mov #0x1C,r2
! Opcode 28FA
M8FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1556
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1556:
jmp @r4
mov #0x1C,r2
! Opcode 28FB
M8FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1557
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1557:
jmp @r4
mov #0x1C,r2
! Opcode 28FC
M8FC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(48,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1558
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1558:
jmp @r4
mov #0x1C,r2
! Opcodes 2900 - 2907
M900:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.l @(48,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1559
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1559:
jmp @r4
mov #0x1C,r2
! Opcodes 2908 - 290F
M908:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.l @(48,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1560
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1560:
jmp @r4
mov #0x1C,r2
! Opcodes 2910 - 2917
M910:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1561
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1561:
jmp @r4
mov #0x1C,r2
! Opcodes 2918 - 291F
M918:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(48,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1562
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1562:
jmp @r4
mov #0x1C,r2
! Opcodes 2920 - 2927
M920:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(48,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1563
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1563:
jmp @r4
mov #0x1C,r2
! Opcodes 2928 - 292F
M928:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1564
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1564:
jmp @r4
mov #0x1C,r2
! Opcodes 2930 - 2937
M930:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1565
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1565:
jmp @r4
mov #0x1C,r2
! Opcode 2938
M938:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1566
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1566:
jmp @r4
mov #0x1C,r2
! Opcode 2939
M939:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1567
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1567:
jmp @r4
mov #0x1C,r2
! Opcode 293A
M93A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1568
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1568:
jmp @r4
mov #0x1C,r2
! Opcode 293B
M93B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1569
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1569:
jmp @r4
mov #0x1C,r2
! Opcode 293C
M93C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(48,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1570
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1570:
jmp @r4
mov #0x1C,r2
! Opcodes 2940 - 2947
M940:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1571
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1571:
jmp @r4
mov #0x1C,r2
! Opcodes 2948 - 294F
M948:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1572
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1572:
jmp @r4
mov #0x1C,r2
! Opcodes 2950 - 2957
M950:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1573
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1573:
jmp @r4
mov #0x1C,r2
! Opcodes 2958 - 295F
M958:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1574
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1574:
jmp @r4
mov #0x1C,r2
! Opcodes 2960 - 2967
M960:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1575
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1575:
jmp @r4
mov #0x1C,r2
! Opcodes 2968 - 296F
M968:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1576
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1576:
jmp @r4
mov #0x1C,r2
! Opcodes 2970 - 2977
M970:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl1577
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1577:
jmp @r4
mov #0x1C,r2
! Opcode 2978
M978:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1578
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1578:
jmp @r4
mov #0x1C,r2
! Opcode 2979
M979:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-32,r7
shll2 r0
cmp/pl r7
bt/s fdl1579
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1579:
jmp @r4
mov #0x1C,r2
! Opcode 297A
M97A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1580
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1580:
jmp @r4
mov #0x1C,r2
! Opcode 297B
M97B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl1581
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1581:
jmp @r4
mov #0x1C,r2
! Opcode 297C
M97C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1582
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1582:
jmp @r4
mov #0x1C,r2
! Opcodes 2980 - 2987
M980:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1583
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1583:
jmp @r4
mov #0x1C,r2
! Opcodes 2988 - 298F
M988:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1584
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1584:
jmp @r4
mov #0x1C,r2
! Opcodes 2990 - 2997
M990:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1585
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1585:
jmp @r4
mov #0x1C,r2
! Opcodes 2998 - 299F
M998:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1586
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1586:
jmp @r4
mov #0x1C,r2
! Opcodes 29A0 - 29A7
M9A0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1587
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1587:
jmp @r4
mov #0x1C,r2
! Opcodes 29A8 - 29AF
M9A8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl1588
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1588:
jmp @r4
mov #0x1C,r2
! Opcodes 29B0 - 29B7
M9B0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-32,r7
shll2 r0
cmp/pl r7
bt/s fdl1589
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1589:
jmp @r4
mov #0x1C,r2
! Opcode 29B8
M9B8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl1590
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1590:
jmp @r4
mov #0x1C,r2
! Opcode 29B9
M9B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-34,r7
shll2 r0
cmp/pl r7
bt/s fdl1591
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1591:
jmp @r4
mov #0x1C,r2
! Opcode 29BA
M9BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl1592
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1592:
jmp @r4
mov #0x1C,r2
! Opcode 29BB
M9BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-32,r7
shll2 r0
cmp/pl r7
bt/s fdl1593
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1593:
jmp @r4
mov #0x1C,r2
! Opcode 29BC
M9BC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1594
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1594:
jmp @r4
mov #0x1C,r2
! Opcodes 2A00 - 2A07
MA00:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.l r3,@(20,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1595
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1595:
jmp @r4
mov #0x1C,r2
! Opcodes 2A08 - 2A0F
MA08:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.l r3,@(20,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1596
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1596:
jmp @r4
mov #0x1C,r2
! Opcodes 2A10 - 2A17
MA10:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(20,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1597
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1597:
jmp @r4
mov #0x1C,r2
! Opcodes 2A18 - 2A1F
MA18:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(20,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1598
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1598:
jmp @r4
mov #0x1C,r2
! Opcodes 2A20 - 2A27
MA20:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(20,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1599
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1599:
jmp @r4
mov #0x1C,r2
! Opcodes 2A28 - 2A2F
MA28:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(20,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1600
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1600:
jmp @r4
mov #0x1C,r2
! Opcodes 2A30 - 2A37
MA30:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(20,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1601
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1601:
jmp @r4
mov #0x1C,r2
! Opcode 2A38
MA38:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(20,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1602
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1602:
jmp @r4
mov #0x1C,r2
! Opcode 2A39
MA39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(20,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1603
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1603:
jmp @r4
mov #0x1C,r2
! Opcode 2A3A
MA3A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(20,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1604
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1604:
jmp @r4
mov #0x1C,r2
! Opcode 2A3B
MA3B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(20,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1605
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1605:
jmp @r4
mov #0x1C,r2
! Opcode 2A3C
MA3C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l r3,@(20,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1606
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1606:
jmp @r4
mov #0x1C,r2
! Opcodes 2A40 - 2A47
MA40:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r13),r3
mov.l r3,@(52,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1607
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1607:
jmp @r4
mov #0x1C,r2
! Opcodes 2A48 - 2A4F
MA48:
and r0,r2
mov.l r3,@-r15
add r14,r2
mov.l @r2,r3
mov.l r3,@(52,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1608
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1608:
jmp @r4
mov #0x1C,r2
! Opcodes 2A50 - 2A57
MA50:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(52,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1609
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1609:
jmp @r4
mov #0x1C,r2
! Opcodes 2A58 - 2A5F
MA58:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(52,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1610
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1610:
jmp @r4
mov #0x1C,r2
! Opcodes 2A60 - 2A67
MA60:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(52,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1611
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1611:
jmp @r4
mov #0x1C,r2
! Opcodes 2A68 - 2A6F
MA68:
and r0,r2
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(52,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1612
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1612:
jmp @r4
mov #0x1C,r2
! Opcodes 2A70 - 2A77
MA70:
and r0,r2
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(52,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1613
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1613:
jmp @r4
mov #0x1C,r2
! Opcode 2A78
MA78:
mov.l r3,@-r15
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(52,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1614
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1614:
jmp @r4
mov #0x1C,r2
! Opcode 2A79
MA79:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(52,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1615
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1615:
jmp @r4
mov #0x1C,r2
! Opcode 2A7A
MA7A:
mov.l r3,@-r15
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(52,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1616
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1616:
jmp @r4
mov #0x1C,r2
! Opcode 2A7B
MA7B:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(52,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1617
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1617:
jmp @r4
mov #0x1C,r2
! Opcode 2A7C
MA7C:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l r3,@(52,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1618
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1618:
jmp @r4
mov #0x1C,r2
! Opcodes 2A80 - 2A87
MA80:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1619
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1619:
jmp @r4
mov #0x1C,r2
! Opcodes 2A88 - 2A8F
MA88:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1620
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1620:
jmp @r4
mov #0x1C,r2
! Opcodes 2A90 - 2A97
MA90:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1621
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1621:
jmp @r4
mov #0x1C,r2
! Opcodes 2A98 - 2A9F
MA98:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1622
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1622:
jmp @r4
mov #0x1C,r2
! Opcodes 2AA0 - 2AA7
MAA0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1623
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1623:
jmp @r4
mov #0x1C,r2
! Opcodes 2AA8 - 2AAF
MAA8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1624
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1624:
jmp @r4
mov #0x1C,r2
! Opcodes 2AB0 - 2AB7
MAB0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1625
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1625:
jmp @r4
mov #0x1C,r2
! Opcode 2AB8
MAB8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1626
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1626:
jmp @r4
mov #0x1C,r2
! Opcode 2AB9
MAB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1627
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1627:
jmp @r4
mov #0x1C,r2
! Opcode 2ABA
MABA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1628
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1628:
jmp @r4
mov #0x1C,r2
! Opcode 2ABB
MABB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1629
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1629:
jmp @r4
mov #0x1C,r2
! Opcode 2ABC
MABC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1630
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1630:
jmp @r4
mov #0x1C,r2
! Opcodes 2AC0 - 2AC7
MAC0:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1631
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1631:
jmp @r4
mov #0x1C,r2
! Opcodes 2AC8 - 2ACF
MAC8:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1632
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1632:
jmp @r4
mov #0x1C,r2
! Opcodes 2AD0 - 2AD7
MAD0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1633
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1633:
jmp @r4
mov #0x1C,r2
! Opcodes 2AD8 - 2ADF
MAD8:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1634
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1634:
jmp @r4
mov #0x1C,r2
! Opcodes 2AE0 - 2AE7
MAE0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1635
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1635:
jmp @r4
mov #0x1C,r2
! Opcodes 2AE8 - 2AEF
MAE8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1636
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1636:
jmp @r4
mov #0x1C,r2
! Opcodes 2AF0 - 2AF7
MAF0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1637
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1637:
jmp @r4
mov #0x1C,r2
! Opcode 2AF8
MAF8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1638
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1638:
jmp @r4
mov #0x1C,r2
! Opcode 2AF9
MAF9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1639
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1639:
jmp @r4
mov #0x1C,r2
! Opcode 2AFA
MAFA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1640
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1640:
jmp @r4
mov #0x1C,r2
! Opcode 2AFB
MAFB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1641
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1641:
jmp @r4
mov #0x1C,r2
! Opcode 2AFC
MAFC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(52,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1642
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1642:
jmp @r4
mov #0x1C,r2
! Opcodes 2B00 - 2B07
MB00:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.l @(52,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1643
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1643:
jmp @r4
mov #0x1C,r2
! Opcodes 2B08 - 2B0F
MB08:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.l @(52,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1644
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1644:
jmp @r4
mov #0x1C,r2
! Opcodes 2B10 - 2B17
MB10:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1645
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1645:
jmp @r4
mov #0x1C,r2
! Opcodes 2B18 - 2B1F
MB18:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(52,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1646
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1646:
jmp @r4
mov #0x1C,r2
! Opcodes 2B20 - 2B27
MB20:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(52,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1647
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1647:
jmp @r4
mov #0x1C,r2
! Opcodes 2B28 - 2B2F
MB28:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1648
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1648:
jmp @r4
mov #0x1C,r2
! Opcodes 2B30 - 2B37
MB30:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1649
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1649:
jmp @r4
mov #0x1C,r2
! Opcode 2B38
MB38:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1650
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1650:
jmp @r4
mov #0x1C,r2
! Opcode 2B39
MB39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1651
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1651:
jmp @r4
mov #0x1C,r2
! Opcode 2B3A
MB3A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1652
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1652:
jmp @r4
mov #0x1C,r2
! Opcode 2B3B
MB3B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1653
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1653:
jmp @r4
mov #0x1C,r2
! Opcode 2B3C
MB3C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(52,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1654
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1654:
jmp @r4
mov #0x1C,r2
! Opcodes 2B40 - 2B47
MB40:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1655
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1655:
jmp @r4
mov #0x1C,r2
! Opcodes 2B48 - 2B4F
MB48:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1656
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1656:
jmp @r4
mov #0x1C,r2
! Opcodes 2B50 - 2B57
MB50:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1657
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1657:
jmp @r4
mov #0x1C,r2
! Opcodes 2B58 - 2B5F
MB58:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1658
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1658:
jmp @r4
mov #0x1C,r2
! Opcodes 2B60 - 2B67
MB60:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1659
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1659:
jmp @r4
mov #0x1C,r2
! Opcodes 2B68 - 2B6F
MB68:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1660
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1660:
jmp @r4
mov #0x1C,r2
! Opcodes 2B70 - 2B77
MB70:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl1661
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1661:
jmp @r4
mov #0x1C,r2
! Opcode 2B78
MB78:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1662
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1662:
jmp @r4
mov #0x1C,r2
! Opcode 2B79
MB79:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-32,r7
shll2 r0
cmp/pl r7
bt/s fdl1663
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1663:
jmp @r4
mov #0x1C,r2
! Opcode 2B7A
MB7A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1664
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1664:
jmp @r4
mov #0x1C,r2
! Opcode 2B7B
MB7B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl1665
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1665:
jmp @r4
mov #0x1C,r2
! Opcode 2B7C
MB7C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1666
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1666:
jmp @r4
mov #0x1C,r2
! Opcodes 2B80 - 2B87
MB80:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1667
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1667:
jmp @r4
mov #0x1C,r2
! Opcodes 2B88 - 2B8F
MB88:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1668
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1668:
jmp @r4
mov #0x1C,r2
! Opcodes 2B90 - 2B97
MB90:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1669
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1669:
jmp @r4
mov #0x1C,r2
! Opcodes 2B98 - 2B9F
MB98:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1670
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1670:
jmp @r4
mov #0x1C,r2
! Opcodes 2BA0 - 2BA7
MBA0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1671
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1671:
jmp @r4
mov #0x1C,r2
! Opcodes 2BA8 - 2BAF
MBA8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl1672
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1672:
jmp @r4
mov #0x1C,r2
! Opcodes 2BB0 - 2BB7
MBB0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-32,r7
shll2 r0
cmp/pl r7
bt/s fdl1673
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1673:
jmp @r4
mov #0x1C,r2
! Opcode 2BB8
MBB8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl1674
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1674:
jmp @r4
mov #0x1C,r2
! Opcode 2BB9
MBB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-34,r7
shll2 r0
cmp/pl r7
bt/s fdl1675
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1675:
jmp @r4
mov #0x1C,r2
! Opcode 2BBA
MBBA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl1676
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1676:
jmp @r4
mov #0x1C,r2
! Opcode 2BBB
MBBB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-32,r7
shll2 r0
cmp/pl r7
bt/s fdl1677
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1677:
jmp @r4
mov #0x1C,r2
! Opcode 2BBC
MBBC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1678
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1678:
jmp @r4
mov #0x1C,r2
! Opcodes 2C00 - 2C07
MC00:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.l r3,@(24,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1679
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1679:
jmp @r4
mov #0x1C,r2
! Opcodes 2C08 - 2C0F
MC08:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.l r3,@(24,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1680
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1680:
jmp @r4
mov #0x1C,r2
! Opcodes 2C10 - 2C17
MC10:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(24,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1681
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1681:
jmp @r4
mov #0x1C,r2
! Opcodes 2C18 - 2C1F
MC18:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(24,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1682
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1682:
jmp @r4
mov #0x1C,r2
! Opcodes 2C20 - 2C27
MC20:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(24,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1683
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1683:
jmp @r4
mov #0x1C,r2
! Opcodes 2C28 - 2C2F
MC28:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(24,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1684
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1684:
jmp @r4
mov #0x1C,r2
! Opcodes 2C30 - 2C37
MC30:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(24,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1685
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1685:
jmp @r4
mov #0x1C,r2
! Opcode 2C38
MC38:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(24,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1686
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1686:
jmp @r4
mov #0x1C,r2
! Opcode 2C39
MC39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(24,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1687
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1687:
jmp @r4
mov #0x1C,r2
! Opcode 2C3A
MC3A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(24,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1688
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1688:
jmp @r4
mov #0x1C,r2
! Opcode 2C3B
MC3B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(24,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1689
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1689:
jmp @r4
mov #0x1C,r2
! Opcode 2C3C
MC3C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l r3,@(24,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1690
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1690:
jmp @r4
mov #0x1C,r2
! Opcodes 2C40 - 2C47
MC40:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r13),r3
mov.l r3,@(56,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1691
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1691:
jmp @r4
mov #0x1C,r2
! Opcodes 2C48 - 2C4F
MC48:
and r0,r2
mov.l r3,@-r15
add r14,r2
mov.l @r2,r3
mov.l r3,@(56,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1692
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1692:
jmp @r4
mov #0x1C,r2
! Opcodes 2C50 - 2C57
MC50:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(56,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1693
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1693:
jmp @r4
mov #0x1C,r2
! Opcodes 2C58 - 2C5F
MC58:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(56,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1694
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1694:
jmp @r4
mov #0x1C,r2
! Opcodes 2C60 - 2C67
MC60:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(56,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1695
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1695:
jmp @r4
mov #0x1C,r2
! Opcodes 2C68 - 2C6F
MC68:
and r0,r2
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(56,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1696
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1696:
jmp @r4
mov #0x1C,r2
! Opcodes 2C70 - 2C77
MC70:
and r0,r2
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(56,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1697
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1697:
jmp @r4
mov #0x1C,r2
! Opcode 2C78
MC78:
mov.l r3,@-r15
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(56,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1698
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1698:
jmp @r4
mov #0x1C,r2
! Opcode 2C79
MC79:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(56,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1699
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1699:
jmp @r4
mov #0x1C,r2
! Opcode 2C7A
MC7A:
mov.l r3,@-r15
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(56,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1700
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1700:
jmp @r4
mov #0x1C,r2
! Opcode 2C7B
MC7B:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(56,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1701
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1701:
jmp @r4
mov #0x1C,r2
! Opcode 2C7C
MC7C:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l r3,@(56,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1702
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1702:
jmp @r4
mov #0x1C,r2
! Opcodes 2C80 - 2C87
MC80:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1703
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1703:
jmp @r4
mov #0x1C,r2
! Opcodes 2C88 - 2C8F
MC88:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1704
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1704:
jmp @r4
mov #0x1C,r2
! Opcodes 2C90 - 2C97
MC90:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1705
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1705:
jmp @r4
mov #0x1C,r2
! Opcodes 2C98 - 2C9F
MC98:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1706
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1706:
jmp @r4
mov #0x1C,r2
! Opcodes 2CA0 - 2CA7
MCA0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1707
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1707:
jmp @r4
mov #0x1C,r2
! Opcodes 2CA8 - 2CAF
MCA8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1708
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1708:
jmp @r4
mov #0x1C,r2
! Opcodes 2CB0 - 2CB7
MCB0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1709
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1709:
jmp @r4
mov #0x1C,r2
! Opcode 2CB8
MCB8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1710
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1710:
jmp @r4
mov #0x1C,r2
! Opcode 2CB9
MCB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1711
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1711:
jmp @r4
mov #0x1C,r2
! Opcode 2CBA
MCBA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1712
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1712:
jmp @r4
mov #0x1C,r2
! Opcode 2CBB
MCBB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1713
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1713:
jmp @r4
mov #0x1C,r2
! Opcode 2CBC
MCBC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1714
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1714:
jmp @r4
mov #0x1C,r2
! Opcodes 2CC0 - 2CC7
MCC0:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1715
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1715:
jmp @r4
mov #0x1C,r2
! Opcodes 2CC8 - 2CCF
MCC8:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1716
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1716:
jmp @r4
mov #0x1C,r2
! Opcodes 2CD0 - 2CD7
MCD0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1717
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1717:
jmp @r4
mov #0x1C,r2
! Opcodes 2CD8 - 2CDF
MCD8:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1718
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1718:
jmp @r4
mov #0x1C,r2
! Opcodes 2CE0 - 2CE7
MCE0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1719
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1719:
jmp @r4
mov #0x1C,r2
! Opcodes 2CE8 - 2CEF
MCE8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1720
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1720:
jmp @r4
mov #0x1C,r2
! Opcodes 2CF0 - 2CF7
MCF0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1721
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1721:
jmp @r4
mov #0x1C,r2
! Opcode 2CF8
MCF8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1722
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1722:
jmp @r4
mov #0x1C,r2
! Opcode 2CF9
MCF9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1723
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1723:
jmp @r4
mov #0x1C,r2
! Opcode 2CFA
MCFA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1724
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1724:
jmp @r4
mov #0x1C,r2
! Opcode 2CFB
MCFB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1725
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1725:
jmp @r4
mov #0x1C,r2
! Opcode 2CFC
MCFC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(56,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1726
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1726:
jmp @r4
mov #0x1C,r2
! Opcodes 2D00 - 2D07
MD00:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.l @(56,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1727
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1727:
jmp @r4
mov #0x1C,r2
! Opcodes 2D08 - 2D0F
MD08:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.l @(56,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1728
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1728:
jmp @r4
mov #0x1C,r2
! Opcodes 2D10 - 2D17
MD10:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1729
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1729:
jmp @r4
mov #0x1C,r2
! Opcodes 2D18 - 2D1F
MD18:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(56,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1730
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1730:
jmp @r4
mov #0x1C,r2
! Opcodes 2D20 - 2D27
MD20:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(56,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1731
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1731:
jmp @r4
mov #0x1C,r2
! Opcodes 2D28 - 2D2F
MD28:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1732
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1732:
jmp @r4
mov #0x1C,r2
! Opcodes 2D30 - 2D37
MD30:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1733
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1733:
jmp @r4
mov #0x1C,r2
! Opcode 2D38
MD38:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1734
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1734:
jmp @r4
mov #0x1C,r2
! Opcode 2D39
MD39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1735
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1735:
jmp @r4
mov #0x1C,r2
! Opcode 2D3A
MD3A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1736
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1736:
jmp @r4
mov #0x1C,r2
! Opcode 2D3B
MD3B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1737
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1737:
jmp @r4
mov #0x1C,r2
! Opcode 2D3C
MD3C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(56,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1738
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1738:
jmp @r4
mov #0x1C,r2
! Opcodes 2D40 - 2D47
MD40:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1739
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1739:
jmp @r4
mov #0x1C,r2
! Opcodes 2D48 - 2D4F
MD48:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1740
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1740:
jmp @r4
mov #0x1C,r2
! Opcodes 2D50 - 2D57
MD50:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1741
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1741:
jmp @r4
mov #0x1C,r2
! Opcodes 2D58 - 2D5F
MD58:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1742
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1742:
jmp @r4
mov #0x1C,r2
! Opcodes 2D60 - 2D67
MD60:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1743
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1743:
jmp @r4
mov #0x1C,r2
! Opcodes 2D68 - 2D6F
MD68:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1744
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1744:
jmp @r4
mov #0x1C,r2
! Opcodes 2D70 - 2D77
MD70:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl1745
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1745:
jmp @r4
mov #0x1C,r2
! Opcode 2D78
MD78:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1746
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1746:
jmp @r4
mov #0x1C,r2
! Opcode 2D79
MD79:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-32,r7
shll2 r0
cmp/pl r7
bt/s fdl1747
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1747:
jmp @r4
mov #0x1C,r2
! Opcode 2D7A
MD7A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1748
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1748:
jmp @r4
mov #0x1C,r2
! Opcode 2D7B
MD7B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl1749
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1749:
jmp @r4
mov #0x1C,r2
! Opcode 2D7C
MD7C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1750
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1750:
jmp @r4
mov #0x1C,r2
! Opcodes 2D80 - 2D87
MD80:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1751
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1751:
jmp @r4
mov #0x1C,r2
! Opcodes 2D88 - 2D8F
MD88:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1752
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1752:
jmp @r4
mov #0x1C,r2
! Opcodes 2D90 - 2D97
MD90:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1753
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1753:
jmp @r4
mov #0x1C,r2
! Opcodes 2D98 - 2D9F
MD98:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1754
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1754:
jmp @r4
mov #0x1C,r2
! Opcodes 2DA0 - 2DA7
MDA0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1755
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1755:
jmp @r4
mov #0x1C,r2
! Opcodes 2DA8 - 2DAF
MDA8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl1756
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1756:
jmp @r4
mov #0x1C,r2
! Opcodes 2DB0 - 2DB7
MDB0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-32,r7
shll2 r0
cmp/pl r7
bt/s fdl1757
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1757:
jmp @r4
mov #0x1C,r2
! Opcode 2DB8
MDB8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl1758
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1758:
jmp @r4
mov #0x1C,r2
! Opcode 2DB9
MDB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-34,r7
shll2 r0
cmp/pl r7
bt/s fdl1759
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1759:
jmp @r4
mov #0x1C,r2
! Opcode 2DBA
MDBA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl1760
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1760:
jmp @r4
mov #0x1C,r2
! Opcode 2DBB
MDBB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-32,r7
shll2 r0
cmp/pl r7
bt/s fdl1761
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1761:
jmp @r4
mov #0x1C,r2
! Opcode 2DBC
MDBC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1762
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1762:
jmp @r4
mov #0x1C,r2
! Opcodes 2E00 - 2E07
ME00:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.l r3,@(28,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1763
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1763:
jmp @r4
mov #0x1C,r2
! Opcodes 2E08 - 2E0F
ME08:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.l r3,@(28,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1764
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1764:
jmp @r4
mov #0x1C,r2
! Opcodes 2E10 - 2E17
ME10:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(28,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1765
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1765:
jmp @r4
mov #0x1C,r2
! Opcodes 2E18 - 2E1F
ME18:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(28,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1766
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1766:
jmp @r4
mov #0x1C,r2
! Opcodes 2E20 - 2E27
ME20:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(28,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1767
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1767:
jmp @r4
mov #0x1C,r2
! Opcodes 2E28 - 2E2F
ME28:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(28,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1768
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1768:
jmp @r4
mov #0x1C,r2
! Opcodes 2E30 - 2E37
ME30:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(28,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1769
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1769:
jmp @r4
mov #0x1C,r2
! Opcode 2E38
ME38:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(28,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1770
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1770:
jmp @r4
mov #0x1C,r2
! Opcode 2E39
ME39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(28,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1771
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1771:
jmp @r4
mov #0x1C,r2
! Opcode 2E3A
ME3A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(28,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1772
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1772:
jmp @r4
mov #0x1C,r2
! Opcode 2E3B
ME3B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(28,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1773
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1773:
jmp @r4
mov #0x1C,r2
! Opcode 2E3C
ME3C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l r3,@(28,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1774
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1774:
jmp @r4
mov #0x1C,r2
! Opcodes 2E40 - 2E47
ME40:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r13),r3
mov.l r3,@(60,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1775
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1775:
jmp @r4
mov #0x1C,r2
! Opcodes 2E48 - 2E4F
ME48:
and r0,r2
mov.l r3,@-r15
add r14,r2
mov.l @r2,r3
mov.l r3,@(60,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1776
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1776:
jmp @r4
mov #0x1C,r2
! Opcodes 2E50 - 2E57
ME50:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(60,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1777
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1777:
jmp @r4
mov #0x1C,r2
! Opcodes 2E58 - 2E5F
ME58:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(60,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1778
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1778:
jmp @r4
mov #0x1C,r2
! Opcodes 2E60 - 2E67
ME60:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(60,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1779
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1779:
jmp @r4
mov #0x1C,r2
! Opcodes 2E68 - 2E6F
ME68:
and r0,r2
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(60,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1780
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1780:
jmp @r4
mov #0x1C,r2
! Opcodes 2E70 - 2E77
ME70:
and r0,r2
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(60,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1781
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1781:
jmp @r4
mov #0x1C,r2
! Opcode 2E78
ME78:
mov.l r3,@-r15
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(60,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1782
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1782:
jmp @r4
mov #0x1C,r2
! Opcode 2E79
ME79:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(60,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1783
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1783:
jmp @r4
mov #0x1C,r2
! Opcode 2E7A
ME7A:
mov.l r3,@-r15
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(60,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1784
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1784:
jmp @r4
mov #0x1C,r2
! Opcode 2E7B
ME7B:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(60,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1785
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1785:
jmp @r4
mov #0x1C,r2
! Opcode 2E7C
ME7C:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l r3,@(60,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1786
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1786:
jmp @r4
mov #0x1C,r2
! Opcodes 2E80 - 2E87
ME80:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1787
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1787:
jmp @r4
mov #0x1C,r2
! Opcodes 2E88 - 2E8F
ME88:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1788
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1788:
jmp @r4
mov #0x1C,r2
! Opcodes 2E90 - 2E97
ME90:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1789
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1789:
jmp @r4
mov #0x1C,r2
! Opcodes 2E98 - 2E9F
ME98:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1790
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1790:
jmp @r4
mov #0x1C,r2
! Opcodes 2EA0 - 2EA7
MEA0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1791
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1791:
jmp @r4
mov #0x1C,r2
! Opcodes 2EA8 - 2EAF
MEA8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1792
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1792:
jmp @r4
mov #0x1C,r2
! Opcodes 2EB0 - 2EB7
MEB0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1793
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1793:
jmp @r4
mov #0x1C,r2
! Opcode 2EB8
MEB8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1794
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1794:
jmp @r4
mov #0x1C,r2
! Opcode 2EB9
MEB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1795
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1795:
jmp @r4
mov #0x1C,r2
! Opcode 2EBA
MEBA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1796
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1796:
jmp @r4
mov #0x1C,r2
! Opcode 2EBB
MEBB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1797
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1797:
jmp @r4
mov #0x1C,r2
! Opcode 2EBC
MEBC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1798
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1798:
jmp @r4
mov #0x1C,r2
! Opcodes 2EC0 - 2EC7
MEC0:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1799
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1799:
jmp @r4
mov #0x1C,r2
! Opcodes 2EC8 - 2ECF
MEC8:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1800
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1800:
jmp @r4
mov #0x1C,r2
! Opcodes 2ED0 - 2ED7
MED0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1801
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1801:
jmp @r4
mov #0x1C,r2
! Opcodes 2ED8 - 2EDF
MED8:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1802
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1802:
jmp @r4
mov #0x1C,r2
! Opcodes 2EE0 - 2EE7
MEE0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1803
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1803:
jmp @r4
mov #0x1C,r2
! Opcodes 2EE8 - 2EEF
MEE8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1804
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1804:
jmp @r4
mov #0x1C,r2
! Opcodes 2EF0 - 2EF7
MEF0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1805
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1805:
jmp @r4
mov #0x1C,r2
! Opcode 2EF8
MEF8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1806
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1806:
jmp @r4
mov #0x1C,r2
! Opcode 2EF9
MEF9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1807
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1807:
jmp @r4
mov #0x1C,r2
! Opcode 2EFA
MEFA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1808
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1808:
jmp @r4
mov #0x1C,r2
! Opcode 2EFB
MEFB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1809
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1809:
jmp @r4
mov #0x1C,r2
! Opcode 2EFC
MEFC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(60,r13),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1810
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1810:
jmp @r4
mov #0x1C,r2
! Opcodes 2F00 - 2F07
MF00:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.l @(60,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1811
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1811:
jmp @r4
mov #0x1C,r2
! Opcodes 2F08 - 2F0F
MF08:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.l @(60,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1812
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1812:
jmp @r4
mov #0x1C,r2
! Opcodes 2F10 - 2F17
MF10:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1813
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1813:
jmp @r4
mov #0x1C,r2
! Opcodes 2F18 - 2F1F
MF18:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(60,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1814
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1814:
jmp @r4
mov #0x1C,r2
! Opcodes 2F20 - 2F27
MF20:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(60,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1815
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1815:
jmp @r4
mov #0x1C,r2
! Opcodes 2F28 - 2F2F
MF28:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1816
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1816:
jmp @r4
mov #0x1C,r2
! Opcodes 2F30 - 2F37
MF30:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1817
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1817:
jmp @r4
mov #0x1C,r2
! Opcode 2F38
MF38:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1818
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1818:
jmp @r4
mov #0x1C,r2
! Opcode 2F39
MF39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1819
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1819:
jmp @r4
mov #0x1C,r2
! Opcode 2F3A
MF3A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1820
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1820:
jmp @r4
mov #0x1C,r2
! Opcode 2F3B
MF3B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1821
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1821:
jmp @r4
mov #0x1C,r2
! Opcode 2F3C
MF3C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(60,r13),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1822
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1822:
jmp @r4
mov #0x1C,r2
! Opcodes 2F40 - 2F47
MF40:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1823
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1823:
jmp @r4
mov #0x1C,r2
! Opcodes 2F48 - 2F4F
MF48:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1824
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1824:
jmp @r4
mov #0x1C,r2
! Opcodes 2F50 - 2F57
MF50:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1825
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1825:
jmp @r4
mov #0x1C,r2
! Opcodes 2F58 - 2F5F
MF58:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1826
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1826:
jmp @r4
mov #0x1C,r2
! Opcodes 2F60 - 2F67
MF60:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1827
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1827:
jmp @r4
mov #0x1C,r2
! Opcodes 2F68 - 2F6F
MF68:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1828
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1828:
jmp @r4
mov #0x1C,r2
! Opcodes 2F70 - 2F77
MF70:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl1829
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1829:
jmp @r4
mov #0x1C,r2
! Opcode 2F78
MF78:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1830
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1830:
jmp @r4
mov #0x1C,r2
! Opcode 2F79
MF79:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-32,r7
shll2 r0
cmp/pl r7
bt/s fdl1831
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1831:
jmp @r4
mov #0x1C,r2
! Opcode 2F7A
MF7A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1832
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1832:
jmp @r4
mov #0x1C,r2
! Opcode 2F7B
MF7B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl1833
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1833:
jmp @r4
mov #0x1C,r2
! Opcode 2F7C
MF7C:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1834
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1834:
jmp @r4
mov #0x1C,r2
! Opcodes 2F80 - 2F87
MF80:
and r0,r2
add r13,r2
mov.l @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1835
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1835:
jmp @r4
mov #0x1C,r2
! Opcodes 2F88 - 2F8F
MF88:
and r0,r2
add r14,r2
mov.l @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1836
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1836:
jmp @r4
mov #0x1C,r2
! Opcodes 2F90 - 2F97
MF90:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1837
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1837:
jmp @r4
mov #0x1C,r2
! Opcodes 2F98 - 2F9F
MF98:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1838
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1838:
jmp @r4
mov #0x1C,r2
! Opcodes 2FA0 - 2FA7
MFA0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl1839
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1839:
jmp @r4
mov #0x1C,r2
! Opcodes 2FA8 - 2FAF
MFA8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl1840
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1840:
jmp @r4
mov #0x1C,r2
! Opcodes 2FB0 - 2FB7
MFB0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-32,r7
shll2 r0
cmp/pl r7
bt/s fdl1841
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1841:
jmp @r4
mov #0x1C,r2
! Opcode 2FB8
MFB8:
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl1842
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1842:
jmp @r4
mov #0x1C,r2
! Opcode 2FB9
MFB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-34,r7
shll2 r0
cmp/pl r7
bt/s fdl1843
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1843:
jmp @r4
mov #0x1C,r2
! Opcode 2FBA
MFBA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-30,r7
shll2 r0
cmp/pl r7
bt/s fdl1844
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1844:
jmp @r4
mov #0x1C,r2
! Opcode 2FBB
MFBB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-32,r7
shll2 r0
cmp/pl r7
bt/s fdl1845
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1845:
jmp @r4
mov #0x1C,r2
! Opcode 2FBC
MFBC:
mov.w @r6+,r0
mov.w @r6+,r3
shll16 r3
xtrct r0,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1846
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1846:
jmp @r4
mov #0x1C,r2
! Opcodes 3000 - 3007
N000:
and r0,r2
add r13,r2
mov.w @r2,r3
mov.w r3,@r13
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1847
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1847:
jmp @r4
mov #0x1C,r2
! Opcodes 3008 - 300F
N008:
and r0,r2
add r14,r2
mov.w @r2,r3
mov.w r3,@r13
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1848
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1848:
jmp @r4
mov #0x1C,r2
! Opcodes 3010 - 3017
N010:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w r3,@r13
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl1849
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1849:
jmp @r4
mov #0x1C,r2
! Opcodes 3018 - 301F
N018:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w r3,@r13
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl1850
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1850:
jmp @r4
mov #0x1C,r2
! Opcodes 3020 - 3027
N020:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w r3,@r13
rotl r3
movt r8
mov.w @r6+,r0
add #-10,r7
shll2 r0
cmp/pl r7
bt/s fdl1851
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1851:
jmp @r4
mov #0x1C,r2
! Opcodes 3028 - 302F
N028:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w r3,@r13
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1852
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1852:
jmp @r4
mov #0x1C,r2
! Opcodes 3030 - 3037
N030:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w r3,@r13
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1853
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1853:
jmp @r4
mov #0x1C,r2
! Opcode 3038
N038:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w r3,@r13
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1854
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1854:
jmp @r4
mov #0x1C,r2
! Opcode 3039
N039:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w r3,@r13
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1855
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1855:
jmp @r4
mov #0x1C,r2
! Opcode 303A
N03A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w r3,@r13
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1856
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1856:
jmp @r4
mov #0x1C,r2
! Opcode 303B
N03B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w r3,@r13
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1857
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1857:
jmp @r4
mov #0x1C,r2
! Opcode 303C
N03C:
mov.w @r6+,r3
mov.w r3,@r13
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl1858
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1858:
jmp @r4
mov #0x1C,r2
! Opcodes 3040 - 3047
N040:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.w @(r0,r13),r3
mov.l r3,@(32,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1859
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1859:
jmp @r4
mov #0x1C,r2
! Opcodes 3048 - 304F
N048:
and r0,r2
mov.l r3,@-r15
add r14,r2
mov.w @r2,r3
mov.l r3,@(32,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1860
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1860:
jmp @r4
mov #0x1C,r2
! Opcodes 3050 - 3057
N050:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(32,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl1861
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1861:
jmp @r4
mov #0x1C,r2
! Opcodes 3058 - 305F
N058:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(32,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl1862
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1862:
jmp @r4
mov #0x1C,r2
! Opcodes 3060 - 3067
N060:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(32,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-10,r7
shll2 r0
cmp/pl r7
bt/s fdl1863
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1863:
jmp @r4
mov #0x1C,r2
! Opcodes 3068 - 306F
N068:
and r0,r2
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(32,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1864
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1864:
jmp @r4
mov #0x1C,r2
! Opcodes 3070 - 3077
N070:
and r0,r2
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(32,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1865
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1865:
jmp @r4
mov #0x1C,r2
! Opcode 3078
N078:
mov.l r3,@-r15
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(32,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1866
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1866:
jmp @r4
mov #0x1C,r2
! Opcode 3079
N079:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(32,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1867
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1867:
jmp @r4
mov #0x1C,r2
! Opcode 307A
N07A:
mov.l r3,@-r15
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(32,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1868
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1868:
jmp @r4
mov #0x1C,r2
! Opcode 307B
N07B:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(32,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1869
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1869:
jmp @r4
mov #0x1C,r2
! Opcode 307C
N07C:
mov.l r3,@-r15
mov.w @r6+,r3
mov.l r3,@(32,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl1870
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1870:
jmp @r4
mov #0x1C,r2
! Opcodes 3080 - 3087
N080:
and r0,r2
add r13,r2
mov.w @r2,r3
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl1871
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1871:
jmp @r4
mov #0x1C,r2
! Opcodes 3088 - 308F
N088:
and r0,r2
add r14,r2
mov.w @r2,r3
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl1872
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1872:
jmp @r4
mov #0x1C,r2
! Opcodes 3090 - 3097
N090:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1873
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1873:
jmp @r4
mov #0x1C,r2
! Opcodes 3098 - 309F
N098:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1874
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1874:
jmp @r4
mov #0x1C,r2
! Opcodes 30A0 - 30A7
N0A0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1875
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1875:
jmp @r4
mov #0x1C,r2
! Opcodes 30A8 - 30AF
N0A8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1876
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1876:
jmp @r4
mov #0x1C,r2
! Opcodes 30B0 - 30B7
N0B0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1877
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1877:
jmp @r4
mov #0x1C,r2
! Opcode 30B8
N0B8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1878
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1878:
jmp @r4
mov #0x1C,r2
! Opcode 30B9
N0B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1879
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1879:
jmp @r4
mov #0x1C,r2
! Opcode 30BA
N0BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1880
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1880:
jmp @r4
mov #0x1C,r2
! Opcode 30BB
N0BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1881
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1881:
jmp @r4
mov #0x1C,r2
! Opcode 30BC
N0BC:
mov.w @r6+,r3
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1882
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1882:
jmp @r4
mov #0x1C,r2
! Opcodes 30C0 - 30C7
N0C0:
and r0,r2
add r13,r2
mov.w @r2,r3
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl1883
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1883:
jmp @r4
mov #0x1C,r2
! Opcodes 30C8 - 30CF
N0C8:
and r0,r2
add r14,r2
mov.w @r2,r3
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl1884
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1884:
jmp @r4
mov #0x1C,r2
! Opcodes 30D0 - 30D7
N0D0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1885
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1885:
jmp @r4
mov #0x1C,r2
! Opcodes 30D8 - 30DF
N0D8:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1886
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1886:
jmp @r4
mov #0x1C,r2
! Opcodes 30E0 - 30E7
N0E0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1887
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1887:
jmp @r4
mov #0x1C,r2
! Opcodes 30E8 - 30EF
N0E8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1888
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1888:
jmp @r4
mov #0x1C,r2
! Opcodes 30F0 - 30F7
N0F0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1889
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1889:
jmp @r4
mov #0x1C,r2
! Opcode 30F8
N0F8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1890
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1890:
jmp @r4
mov #0x1C,r2
! Opcode 30F9
N0F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1891
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1891:
jmp @r4
mov #0x1C,r2
! Opcode 30FA
N0FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1892
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1892:
jmp @r4
mov #0x1C,r2
! Opcode 30FB
N0FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1893
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1893:
jmp @r4
mov #0x1C,r2
! Opcode 30FC
N0FC:
mov.w @r6+,r3
mov.l @(32,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1894
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1894:
jmp @r4
mov #0x1C,r2
! Opcodes 3100 - 3107
N100:
and r0,r2
add r13,r2
mov.w @r2,r3
mov.l @(32,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl1895
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1895:
jmp @r4
mov #0x1C,r2
! Opcodes 3108 - 310F
N108:
and r0,r2
add r14,r2
mov.w @r2,r3
mov.l @(32,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl1896
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1896:
jmp @r4
mov #0x1C,r2
! Opcodes 3110 - 3117
N110:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1897
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1897:
jmp @r4
mov #0x1C,r2
! Opcodes 3118 - 311F
N118:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(32,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1898
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1898:
jmp @r4
mov #0x1C,r2
! Opcodes 3120 - 3127
N120:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(32,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1899
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1899:
jmp @r4
mov #0x1C,r2
! Opcodes 3128 - 312F
N128:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1900
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1900:
jmp @r4
mov #0x1C,r2
! Opcodes 3130 - 3137
N130:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1901
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1901:
jmp @r4
mov #0x1C,r2
! Opcode 3138
N138:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1902
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1902:
jmp @r4
mov #0x1C,r2
! Opcode 3139
N139:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1903
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1903:
jmp @r4
mov #0x1C,r2
! Opcode 313A
N13A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1904
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1904:
jmp @r4
mov #0x1C,r2
! Opcode 313B
N13B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(32,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1905
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1905:
jmp @r4
mov #0x1C,r2
! Opcode 313C
N13C:
mov.w @r6+,r3
mov.l @(32,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(32,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1906
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1906:
jmp @r4
mov #0x1C,r2
! Opcodes 3140 - 3147
N140:
and r0,r2
add r13,r2
mov.w @r2,r3
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1907
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1907:
jmp @r4
mov #0x1C,r2
! Opcodes 3148 - 314F
N148:
and r0,r2
add r14,r2
mov.w @r2,r3
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1908
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1908:
jmp @r4
mov #0x1C,r2
! Opcodes 3150 - 3157
N150:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1909
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1909:
jmp @r4
mov #0x1C,r2
! Opcodes 3158 - 315F
N158:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1910
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1910:
jmp @r4
mov #0x1C,r2
! Opcodes 3160 - 3167
N160:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1911
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1911:
jmp @r4
mov #0x1C,r2
! Opcodes 3168 - 316F
N168:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1912
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1912:
jmp @r4
mov #0x1C,r2
! Opcodes 3170 - 3177
N170:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1913
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1913:
jmp @r4
mov #0x1C,r2
! Opcode 3178
N178:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1914
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1914:
jmp @r4
mov #0x1C,r2
! Opcode 3179
N179:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1915
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1915:
jmp @r4
mov #0x1C,r2
! Opcode 317A
N17A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1916
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1916:
jmp @r4
mov #0x1C,r2
! Opcode 317B
N17B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1917
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1917:
jmp @r4
mov #0x1C,r2
! Opcode 317C
N17C:
mov.w @r6+,r3
mov.w @r6+,r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1918
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1918:
jmp @r4
mov #0x1C,r2
! Opcodes 3180 - 3187
N180:
and r0,r2
add r13,r2
mov.w @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1919
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1919:
jmp @r4
mov #0x1C,r2
! Opcodes 3188 - 318F
N188:
and r0,r2
add r14,r2
mov.w @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1920
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1920:
jmp @r4
mov #0x1C,r2
! Opcodes 3190 - 3197
N190:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1921
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1921:
jmp @r4
mov #0x1C,r2
! Opcodes 3198 - 319F
N198:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1922
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1922:
jmp @r4
mov #0x1C,r2
! Opcodes 31A0 - 31A7
N1A0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1923
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1923:
jmp @r4
mov #0x1C,r2
! Opcodes 31A8 - 31AF
N1A8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1924
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1924:
jmp @r4
mov #0x1C,r2
! Opcodes 31B0 - 31B7
N1B0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1925
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1925:
jmp @r4
mov #0x1C,r2
! Opcode 31B8
N1B8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1926
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1926:
jmp @r4
mov #0x1C,r2
! Opcode 31B9
N1B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl1927
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1927:
jmp @r4
mov #0x1C,r2
! Opcode 31BA
N1BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1928
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1928:
jmp @r4
mov #0x1C,r2
! Opcode 31BB
N1BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1929
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1929:
jmp @r4
mov #0x1C,r2
! Opcode 31BC
N1BC:
mov.w @r6+,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(32,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1930
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1930:
jmp @r4
mov #0x1C,r2
! Opcodes 31C0 - 31C7
N1C0:
and r0,r2
add r13,r2
mov.w @r2,r3
mov.w @r6+,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1931
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1931:
jmp @r4
mov #0x1C,r2
! Opcodes 31C8 - 31CF
N1C8:
and r0,r2
add r14,r2
mov.w @r2,r3
mov.w @r6+,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1932
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1932:
jmp @r4
mov #0x1C,r2
! Opcodes 31D0 - 31D7
N1D0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1933
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1933:
jmp @r4
mov #0x1C,r2
! Opcodes 31D8 - 31DF
N1D8:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1934
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1934:
jmp @r4
mov #0x1C,r2
! Opcodes 31E0 - 31E7
N1E0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1935
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1935:
jmp @r4
mov #0x1C,r2
! Opcodes 31E8 - 31EF
N1E8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1936
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1936:
jmp @r4
mov #0x1C,r2
! Opcodes 31F0 - 31F7
N1F0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1937
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1937:
jmp @r4
mov #0x1C,r2
! Opcode 31F8
N1F8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1938
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1938:
jmp @r4
mov #0x1C,r2
! Opcode 31F9
N1F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl1939
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1939:
jmp @r4
mov #0x1C,r2
! Opcode 31FA
N1FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1940
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1940:
jmp @r4
mov #0x1C,r2
! Opcode 31FB
N1FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl1941
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1941:
jmp @r4
mov #0x1C,r2
! Opcode 31FC
N1FC:
mov.w @r6+,r3
mov.w @r6+,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1942
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1942:
jmp @r4
mov #0x1C,r2
! Opcodes 3200 - 3207
N200:
and r0,r2
add r13,r2
mov.w @r2,r3
mov #4,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1943
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1943:
jmp @r4
mov #0x1C,r2
! Opcodes 3208 - 320F
N208:
and r0,r2
add r14,r2
mov.w @r2,r3
mov #4,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1944
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1944:
jmp @r4
mov #0x1C,r2
! Opcodes 3210 - 3217
N210:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl1945
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1945:
jmp @r4
mov #0x1C,r2
! Opcodes 3218 - 321F
N218:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #4,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl1946
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1946:
jmp @r4
mov #0x1C,r2
! Opcodes 3220 - 3227
N220:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #4,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-10,r7
shll2 r0
cmp/pl r7
bt/s fdl1947
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1947:
jmp @r4
mov #0x1C,r2
! Opcodes 3228 - 322F
N228:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1948
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1948:
jmp @r4
mov #0x1C,r2
! Opcodes 3230 - 3237
N230:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1949
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1949:
jmp @r4
mov #0x1C,r2
! Opcode 3238
N238:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1950
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1950:
jmp @r4
mov #0x1C,r2
! Opcode 3239
N239:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1951
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1951:
jmp @r4
mov #0x1C,r2
! Opcode 323A
N23A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1952
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1952:
jmp @r4
mov #0x1C,r2
! Opcode 323B
N23B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1953
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1953:
jmp @r4
mov #0x1C,r2
! Opcode 323C
N23C:
mov.w @r6+,r3
mov #4,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl1954
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1954:
jmp @r4
mov #0x1C,r2
! Opcodes 3240 - 3247
N240:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.w @(r0,r13),r3
mov.l r3,@(36,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1955
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1955:
jmp @r4
mov #0x1C,r2
! Opcodes 3248 - 324F
N248:
and r0,r2
mov.l r3,@-r15
add r14,r2
mov.w @r2,r3
mov.l r3,@(36,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl1956
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1956:
jmp @r4
mov #0x1C,r2
! Opcodes 3250 - 3257
N250:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(36,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl1957
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1957:
jmp @r4
mov #0x1C,r2
! Opcodes 3258 - 325F
N258:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(36,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl1958
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1958:
jmp @r4
mov #0x1C,r2
! Opcodes 3260 - 3267
N260:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(36,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-10,r7
shll2 r0
cmp/pl r7
bt/s fdl1959
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1959:
jmp @r4
mov #0x1C,r2
! Opcodes 3268 - 326F
N268:
and r0,r2
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(36,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1960
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1960:
jmp @r4
mov #0x1C,r2
! Opcodes 3270 - 3277
N270:
and r0,r2
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(36,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1961
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1961:
jmp @r4
mov #0x1C,r2
! Opcode 3278
N278:
mov.l r3,@-r15
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(36,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1962
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1962:
jmp @r4
mov #0x1C,r2
! Opcode 3279
N279:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(36,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1963
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1963:
jmp @r4
mov #0x1C,r2
! Opcode 327A
N27A:
mov.l r3,@-r15
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(36,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1964
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1964:
jmp @r4
mov #0x1C,r2
! Opcode 327B
N27B:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(36,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1965
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1965:
jmp @r4
mov #0x1C,r2
! Opcode 327C
N27C:
mov.l r3,@-r15
mov.w @r6+,r3
mov.l r3,@(36,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl1966
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1966:
jmp @r4
mov #0x1C,r2
! Opcodes 3280 - 3287
N280:
and r0,r2
add r13,r2
mov.w @r2,r3
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl1967
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1967:
jmp @r4
mov #0x1C,r2
! Opcodes 3288 - 328F
N288:
and r0,r2
add r14,r2
mov.w @r2,r3
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl1968
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1968:
jmp @r4
mov #0x1C,r2
! Opcodes 3290 - 3297
N290:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1969
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1969:
jmp @r4
mov #0x1C,r2
! Opcodes 3298 - 329F
N298:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1970
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1970:
jmp @r4
mov #0x1C,r2
! Opcodes 32A0 - 32A7
N2A0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1971
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1971:
jmp @r4
mov #0x1C,r2
! Opcodes 32A8 - 32AF
N2A8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1972
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1972:
jmp @r4
mov #0x1C,r2
! Opcodes 32B0 - 32B7
N2B0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1973
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1973:
jmp @r4
mov #0x1C,r2
! Opcode 32B8
N2B8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1974
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1974:
jmp @r4
mov #0x1C,r2
! Opcode 32B9
N2B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1975
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1975:
jmp @r4
mov #0x1C,r2
! Opcode 32BA
N2BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1976
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1976:
jmp @r4
mov #0x1C,r2
! Opcode 32BB
N2BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1977
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1977:
jmp @r4
mov #0x1C,r2
! Opcode 32BC
N2BC:
mov.w @r6+,r3
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1978
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1978:
jmp @r4
mov #0x1C,r2
! Opcodes 32C0 - 32C7
N2C0:
and r0,r2
add r13,r2
mov.w @r2,r3
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl1979
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1979:
jmp @r4
mov #0x1C,r2
! Opcodes 32C8 - 32CF
N2C8:
and r0,r2
add r14,r2
mov.w @r2,r3
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl1980
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1980:
jmp @r4
mov #0x1C,r2
! Opcodes 32D0 - 32D7
N2D0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1981
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1981:
jmp @r4
mov #0x1C,r2
! Opcodes 32D8 - 32DF
N2D8:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1982
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1982:
jmp @r4
mov #0x1C,r2
! Opcodes 32E0 - 32E7
N2E0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1983
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1983:
jmp @r4
mov #0x1C,r2
! Opcodes 32E8 - 32EF
N2E8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1984
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1984:
jmp @r4
mov #0x1C,r2
! Opcodes 32F0 - 32F7
N2F0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1985
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1985:
jmp @r4
mov #0x1C,r2
! Opcode 32F8
N2F8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1986
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1986:
jmp @r4
mov #0x1C,r2
! Opcode 32F9
N2F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1987
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1987:
jmp @r4
mov #0x1C,r2
! Opcode 32FA
N2FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1988
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1988:
jmp @r4
mov #0x1C,r2
! Opcode 32FB
N2FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1989
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1989:
jmp @r4
mov #0x1C,r2
! Opcode 32FC
N2FC:
mov.w @r6+,r3
mov.l @(36,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1990
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1990:
jmp @r4
mov #0x1C,r2
! Opcodes 3300 - 3307
N300:
and r0,r2
add r13,r2
mov.w @r2,r3
mov.l @(36,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl1991
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1991:
jmp @r4
mov #0x1C,r2
! Opcodes 3308 - 330F
N308:
and r0,r2
add r14,r2
mov.w @r2,r3
mov.l @(36,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl1992
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1992:
jmp @r4
mov #0x1C,r2
! Opcodes 3310 - 3317
N310:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1993
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1993:
jmp @r4
mov #0x1C,r2
! Opcodes 3318 - 331F
N318:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(36,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl1994
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1994:
jmp @r4
mov #0x1C,r2
! Opcodes 3320 - 3327
N320:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(36,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl1995
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1995:
jmp @r4
mov #0x1C,r2
! Opcodes 3328 - 332F
N328:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1996
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1996:
jmp @r4
mov #0x1C,r2
! Opcodes 3330 - 3337
N330:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl1997
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1997:
jmp @r4
mov #0x1C,r2
! Opcode 3338
N338:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl1998
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1998:
jmp @r4
mov #0x1C,r2
! Opcode 3339
N339:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl1999
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl1999:
jmp @r4
mov #0x1C,r2
! Opcode 333A
N33A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2000
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2000:
jmp @r4
mov #0x1C,r2
! Opcode 333B
N33B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(36,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2001
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2001:
jmp @r4
mov #0x1C,r2
! Opcode 333C
N33C:
mov.w @r6+,r3
mov.l @(36,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(36,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2002
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2002:
jmp @r4
mov #0x1C,r2
! Opcodes 3340 - 3347
N340:
and r0,r2
add r13,r2
mov.w @r2,r3
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2003
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2003:
jmp @r4
mov #0x1C,r2
! Opcodes 3348 - 334F
N348:
and r0,r2
add r14,r2
mov.w @r2,r3
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2004
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2004:
jmp @r4
mov #0x1C,r2
! Opcodes 3350 - 3357
N350:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2005
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2005:
jmp @r4
mov #0x1C,r2
! Opcodes 3358 - 335F
N358:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2006
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2006:
jmp @r4
mov #0x1C,r2
! Opcodes 3360 - 3367
N360:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2007
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2007:
jmp @r4
mov #0x1C,r2
! Opcodes 3368 - 336F
N368:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2008
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2008:
jmp @r4
mov #0x1C,r2
! Opcodes 3370 - 3377
N370:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl2009
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2009:
jmp @r4
mov #0x1C,r2
! Opcode 3378
N378:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2010
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2010:
jmp @r4
mov #0x1C,r2
! Opcode 3379
N379:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl2011
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2011:
jmp @r4
mov #0x1C,r2
! Opcode 337A
N37A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2012
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2012:
jmp @r4
mov #0x1C,r2
! Opcode 337B
N37B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl2013
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2013:
jmp @r4
mov #0x1C,r2
! Opcode 337C
N37C:
mov.w @r6+,r3
mov.w @r6+,r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2014
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2014:
jmp @r4
mov #0x1C,r2
! Opcodes 3380 - 3387
N380:
and r0,r2
add r13,r2
mov.w @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2015
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2015:
jmp @r4
mov #0x1C,r2
! Opcodes 3388 - 338F
N388:
and r0,r2
add r14,r2
mov.w @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2016
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2016:
jmp @r4
mov #0x1C,r2
! Opcodes 3390 - 3397
N390:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2017
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2017:
jmp @r4
mov #0x1C,r2
! Opcodes 3398 - 339F
N398:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2018
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2018:
jmp @r4
mov #0x1C,r2
! Opcodes 33A0 - 33A7
N3A0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2019
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2019:
jmp @r4
mov #0x1C,r2
! Opcodes 33A8 - 33AF
N3A8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl2020
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2020:
jmp @r4
mov #0x1C,r2
! Opcodes 33B0 - 33B7
N3B0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl2021
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2021:
jmp @r4
mov #0x1C,r2
! Opcode 33B8
N3B8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl2022
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2022:
jmp @r4
mov #0x1C,r2
! Opcode 33B9
N3B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl2023
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2023:
jmp @r4
mov #0x1C,r2
! Opcode 33BA
N3BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl2024
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2024:
jmp @r4
mov #0x1C,r2
! Opcode 33BB
N3BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl2025
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2025:
jmp @r4
mov #0x1C,r2
! Opcode 33BC
N3BC:
mov.w @r6+,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(36,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2026
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2026:
jmp @r4
mov #0x1C,r2
! Opcodes 33C0 - 33C7
N3C0:
and r0,r2
add r13,r2
mov.w @r2,r3
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2027
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2027:
jmp @r4
mov #0x1C,r2
! Opcodes 33C8 - 33CF
N3C8:
and r0,r2
add r14,r2
mov.w @r2,r3
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2028
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2028:
jmp @r4
mov #0x1C,r2
! Opcodes 33D0 - 33D7
N3D0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2029
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2029:
jmp @r4
mov #0x1C,r2
! Opcodes 33D8 - 33DF
N3D8:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2030
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2030:
jmp @r4
mov #0x1C,r2
! Opcodes 33E0 - 33E7
N3E0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl2031
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2031:
jmp @r4
mov #0x1C,r2
! Opcodes 33E8 - 33EF
N3E8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl2032
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2032:
jmp @r4
mov #0x1C,r2
! Opcodes 33F0 - 33F7
N3F0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl2033
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2033:
jmp @r4
mov #0x1C,r2
! Opcode 33F8
N3F8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl2034
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2034:
jmp @r4
mov #0x1C,r2
! Opcode 33F9
N3F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl2035
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2035:
jmp @r4
mov #0x1C,r2
! Opcode 33FA
N3FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl2036
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2036:
jmp @r4
mov #0x1C,r2
! Opcode 33FB
N3FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl2037
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2037:
jmp @r4
mov #0x1C,r2
! Opcode 33FC
N3FC:
mov.w @r6+,r3
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2038
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2038:
jmp @r4
mov #0x1C,r2
! Opcodes 3400 - 3407
N400:
and r0,r2
add r13,r2
mov.w @r2,r3
mov #8,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl2039
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2039:
jmp @r4
mov #0x1C,r2
! Opcodes 3408 - 340F
N408:
and r0,r2
add r14,r2
mov.w @r2,r3
mov #8,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl2040
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2040:
jmp @r4
mov #0x1C,r2
! Opcodes 3410 - 3417
N410:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2041
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2041:
jmp @r4
mov #0x1C,r2
! Opcodes 3418 - 341F
N418:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #8,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2042
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2042:
jmp @r4
mov #0x1C,r2
! Opcodes 3420 - 3427
N420:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #8,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-10,r7
shll2 r0
cmp/pl r7
bt/s fdl2043
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2043:
jmp @r4
mov #0x1C,r2
! Opcodes 3428 - 342F
N428:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2044
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2044:
jmp @r4
mov #0x1C,r2
! Opcodes 3430 - 3437
N430:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2045
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2045:
jmp @r4
mov #0x1C,r2
! Opcode 3438
N438:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2046
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2046:
jmp @r4
mov #0x1C,r2
! Opcode 3439
N439:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2047
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2047:
jmp @r4
mov #0x1C,r2
! Opcode 343A
N43A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2048
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2048:
jmp @r4
mov #0x1C,r2
! Opcode 343B
N43B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #8,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2049
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2049:
jmp @r4
mov #0x1C,r2
! Opcode 343C
N43C:
mov.w @r6+,r3
mov #8,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2050
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2050:
jmp @r4
mov #0x1C,r2
! Opcodes 3440 - 3447
N440:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.w @(r0,r13),r3
mov.l r3,@(40,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl2051
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2051:
jmp @r4
mov #0x1C,r2
! Opcodes 3448 - 344F
N448:
and r0,r2
mov.l r3,@-r15
add r14,r2
mov.w @r2,r3
mov.l r3,@(40,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl2052
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2052:
jmp @r4
mov #0x1C,r2
! Opcodes 3450 - 3457
N450:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(40,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2053
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2053:
jmp @r4
mov #0x1C,r2
! Opcodes 3458 - 345F
N458:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(40,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2054
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2054:
jmp @r4
mov #0x1C,r2
! Opcodes 3460 - 3467
N460:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(40,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-10,r7
shll2 r0
cmp/pl r7
bt/s fdl2055
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2055:
jmp @r4
mov #0x1C,r2
! Opcodes 3468 - 346F
N468:
and r0,r2
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(40,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2056
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2056:
jmp @r4
mov #0x1C,r2
! Opcodes 3470 - 3477
N470:
and r0,r2
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(40,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2057
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2057:
jmp @r4
mov #0x1C,r2
! Opcode 3478
N478:
mov.l r3,@-r15
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(40,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2058
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2058:
jmp @r4
mov #0x1C,r2
! Opcode 3479
N479:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(40,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2059
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2059:
jmp @r4
mov #0x1C,r2
! Opcode 347A
N47A:
mov.l r3,@-r15
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(40,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2060
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2060:
jmp @r4
mov #0x1C,r2
! Opcode 347B
N47B:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(40,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2061
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2061:
jmp @r4
mov #0x1C,r2
! Opcode 347C
N47C:
mov.l r3,@-r15
mov.w @r6+,r3
mov.l r3,@(40,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2062
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2062:
jmp @r4
mov #0x1C,r2
! Opcodes 3480 - 3487
N480:
and r0,r2
add r13,r2
mov.w @r2,r3
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2063
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2063:
jmp @r4
mov #0x1C,r2
! Opcodes 3488 - 348F
N488:
and r0,r2
add r14,r2
mov.w @r2,r3
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2064
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2064:
jmp @r4
mov #0x1C,r2
! Opcodes 3490 - 3497
N490:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2065
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2065:
jmp @r4
mov #0x1C,r2
! Opcodes 3498 - 349F
N498:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2066
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2066:
jmp @r4
mov #0x1C,r2
! Opcodes 34A0 - 34A7
N4A0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2067
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2067:
jmp @r4
mov #0x1C,r2
! Opcodes 34A8 - 34AF
N4A8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2068
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2068:
jmp @r4
mov #0x1C,r2
! Opcodes 34B0 - 34B7
N4B0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2069
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2069:
jmp @r4
mov #0x1C,r2
! Opcode 34B8
N4B8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2070
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2070:
jmp @r4
mov #0x1C,r2
! Opcode 34B9
N4B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2071
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2071:
jmp @r4
mov #0x1C,r2
! Opcode 34BA
N4BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2072
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2072:
jmp @r4
mov #0x1C,r2
! Opcode 34BB
N4BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2073
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2073:
jmp @r4
mov #0x1C,r2
! Opcode 34BC
N4BC:
mov.w @r6+,r3
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2074
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2074:
jmp @r4
mov #0x1C,r2
! Opcodes 34C0 - 34C7
N4C0:
and r0,r2
add r13,r2
mov.w @r2,r3
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2075
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2075:
jmp @r4
mov #0x1C,r2
! Opcodes 34C8 - 34CF
N4C8:
and r0,r2
add r14,r2
mov.w @r2,r3
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2076
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2076:
jmp @r4
mov #0x1C,r2
! Opcodes 34D0 - 34D7
N4D0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2077
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2077:
jmp @r4
mov #0x1C,r2
! Opcodes 34D8 - 34DF
N4D8:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2078
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2078:
jmp @r4
mov #0x1C,r2
! Opcodes 34E0 - 34E7
N4E0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2079
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2079:
jmp @r4
mov #0x1C,r2
! Opcodes 34E8 - 34EF
N4E8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2080
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2080:
jmp @r4
mov #0x1C,r2
! Opcodes 34F0 - 34F7
N4F0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2081
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2081:
jmp @r4
mov #0x1C,r2
! Opcode 34F8
N4F8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2082
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2082:
jmp @r4
mov #0x1C,r2
! Opcode 34F9
N4F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2083
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2083:
jmp @r4
mov #0x1C,r2
! Opcode 34FA
N4FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2084
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2084:
jmp @r4
mov #0x1C,r2
! Opcode 34FB
N4FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2085
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2085:
jmp @r4
mov #0x1C,r2
! Opcode 34FC
N4FC:
mov.w @r6+,r3
mov.l @(40,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2086
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2086:
jmp @r4
mov #0x1C,r2
! Opcodes 3500 - 3507
N500:
and r0,r2
add r13,r2
mov.w @r2,r3
mov.l @(40,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2087
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2087:
jmp @r4
mov #0x1C,r2
! Opcodes 3508 - 350F
N508:
and r0,r2
add r14,r2
mov.w @r2,r3
mov.l @(40,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2088
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2088:
jmp @r4
mov #0x1C,r2
! Opcodes 3510 - 3517
N510:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2089
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2089:
jmp @r4
mov #0x1C,r2
! Opcodes 3518 - 351F
N518:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(40,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2090
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2090:
jmp @r4
mov #0x1C,r2
! Opcodes 3520 - 3527
N520:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(40,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2091
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2091:
jmp @r4
mov #0x1C,r2
! Opcodes 3528 - 352F
N528:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2092
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2092:
jmp @r4
mov #0x1C,r2
! Opcodes 3530 - 3537
N530:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2093
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2093:
jmp @r4
mov #0x1C,r2
! Opcode 3538
N538:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2094
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2094:
jmp @r4
mov #0x1C,r2
! Opcode 3539
N539:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2095
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2095:
jmp @r4
mov #0x1C,r2
! Opcode 353A
N53A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2096
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2096:
jmp @r4
mov #0x1C,r2
! Opcode 353B
N53B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(40,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2097
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2097:
jmp @r4
mov #0x1C,r2
! Opcode 353C
N53C:
mov.w @r6+,r3
mov.l @(40,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(40,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2098
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2098:
jmp @r4
mov #0x1C,r2
! Opcodes 3540 - 3547
N540:
and r0,r2
add r13,r2
mov.w @r2,r3
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2099
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2099:
jmp @r4
mov #0x1C,r2
! Opcodes 3548 - 354F
N548:
and r0,r2
add r14,r2
mov.w @r2,r3
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2100
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2100:
jmp @r4
mov #0x1C,r2
! Opcodes 3550 - 3557
N550:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2101
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2101:
jmp @r4
mov #0x1C,r2
! Opcodes 3558 - 355F
N558:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2102
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2102:
jmp @r4
mov #0x1C,r2
! Opcodes 3560 - 3567
N560:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2103
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2103:
jmp @r4
mov #0x1C,r2
! Opcodes 3568 - 356F
N568:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2104
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2104:
jmp @r4
mov #0x1C,r2
! Opcodes 3570 - 3577
N570:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl2105
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2105:
jmp @r4
mov #0x1C,r2
! Opcode 3578
N578:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2106
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2106:
jmp @r4
mov #0x1C,r2
! Opcode 3579
N579:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl2107
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2107:
jmp @r4
mov #0x1C,r2
! Opcode 357A
N57A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2108
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2108:
jmp @r4
mov #0x1C,r2
! Opcode 357B
N57B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl2109
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2109:
jmp @r4
mov #0x1C,r2
! Opcode 357C
N57C:
mov.w @r6+,r3
mov.w @r6+,r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2110
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2110:
jmp @r4
mov #0x1C,r2
! Opcodes 3580 - 3587
N580:
and r0,r2
add r13,r2
mov.w @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2111
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2111:
jmp @r4
mov #0x1C,r2
! Opcodes 3588 - 358F
N588:
and r0,r2
add r14,r2
mov.w @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2112
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2112:
jmp @r4
mov #0x1C,r2
! Opcodes 3590 - 3597
N590:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2113
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2113:
jmp @r4
mov #0x1C,r2
! Opcodes 3598 - 359F
N598:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2114
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2114:
jmp @r4
mov #0x1C,r2
! Opcodes 35A0 - 35A7
N5A0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2115
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2115:
jmp @r4
mov #0x1C,r2
! Opcodes 35A8 - 35AF
N5A8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl2116
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2116:
jmp @r4
mov #0x1C,r2
! Opcodes 35B0 - 35B7
N5B0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl2117
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2117:
jmp @r4
mov #0x1C,r2
! Opcode 35B8
N5B8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl2118
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2118:
jmp @r4
mov #0x1C,r2
! Opcode 35B9
N5B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl2119
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2119:
jmp @r4
mov #0x1C,r2
! Opcode 35BA
N5BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl2120
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2120:
jmp @r4
mov #0x1C,r2
! Opcode 35BB
N5BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl2121
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2121:
jmp @r4
mov #0x1C,r2
! Opcode 35BC
N5BC:
mov.w @r6+,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(40,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2122
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2122:
jmp @r4
mov #0x1C,r2
! Opcodes 3600 - 3607
N600:
and r0,r2
add r13,r2
mov.w @r2,r3
mov #12,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl2123
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2123:
jmp @r4
mov #0x1C,r2
! Opcodes 3608 - 360F
N608:
and r0,r2
add r14,r2
mov.w @r2,r3
mov #12,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl2124
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2124:
jmp @r4
mov #0x1C,r2
! Opcodes 3610 - 3617
N610:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2125
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2125:
jmp @r4
mov #0x1C,r2
! Opcodes 3618 - 361F
N618:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #12,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2126
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2126:
jmp @r4
mov #0x1C,r2
! Opcodes 3620 - 3627
N620:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #12,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-10,r7
shll2 r0
cmp/pl r7
bt/s fdl2127
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2127:
jmp @r4
mov #0x1C,r2
! Opcodes 3628 - 362F
N628:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2128
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2128:
jmp @r4
mov #0x1C,r2
! Opcodes 3630 - 3637
N630:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2129
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2129:
jmp @r4
mov #0x1C,r2
! Opcode 3638
N638:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2130
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2130:
jmp @r4
mov #0x1C,r2
! Opcode 3639
N639:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2131
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2131:
jmp @r4
mov #0x1C,r2
! Opcode 363A
N63A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2132
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2132:
jmp @r4
mov #0x1C,r2
! Opcode 363B
N63B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #12,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2133
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2133:
jmp @r4
mov #0x1C,r2
! Opcode 363C
N63C:
mov.w @r6+,r3
mov #12,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2134
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2134:
jmp @r4
mov #0x1C,r2
! Opcodes 3640 - 3647
N640:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.w @(r0,r13),r3
mov.l r3,@(44,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl2135
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2135:
jmp @r4
mov #0x1C,r2
! Opcodes 3648 - 364F
N648:
and r0,r2
mov.l r3,@-r15
add r14,r2
mov.w @r2,r3
mov.l r3,@(44,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl2136
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2136:
jmp @r4
mov #0x1C,r2
! Opcodes 3650 - 3657
N650:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(44,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2137
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2137:
jmp @r4
mov #0x1C,r2
! Opcodes 3658 - 365F
N658:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(44,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2138
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2138:
jmp @r4
mov #0x1C,r2
! Opcodes 3660 - 3667
N660:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(44,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-10,r7
shll2 r0
cmp/pl r7
bt/s fdl2139
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2139:
jmp @r4
mov #0x1C,r2
! Opcodes 3668 - 366F
N668:
and r0,r2
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(44,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2140
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2140:
jmp @r4
mov #0x1C,r2
! Opcodes 3670 - 3677
N670:
and r0,r2
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(44,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2141
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2141:
jmp @r4
mov #0x1C,r2
! Opcode 3678
N678:
mov.l r3,@-r15
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(44,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2142
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2142:
jmp @r4
mov #0x1C,r2
! Opcode 3679
N679:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(44,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2143
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2143:
jmp @r4
mov #0x1C,r2
! Opcode 367A
N67A:
mov.l r3,@-r15
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(44,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2144
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2144:
jmp @r4
mov #0x1C,r2
! Opcode 367B
N67B:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(44,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2145
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2145:
jmp @r4
mov #0x1C,r2
! Opcode 367C
N67C:
mov.l r3,@-r15
mov.w @r6+,r3
mov.l r3,@(44,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2146
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2146:
jmp @r4
mov #0x1C,r2
! Opcodes 3680 - 3687
N680:
and r0,r2
add r13,r2
mov.w @r2,r3
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2147
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2147:
jmp @r4
mov #0x1C,r2
! Opcodes 3688 - 368F
N688:
and r0,r2
add r14,r2
mov.w @r2,r3
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2148
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2148:
jmp @r4
mov #0x1C,r2
! Opcodes 3690 - 3697
N690:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2149
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2149:
jmp @r4
mov #0x1C,r2
! Opcodes 3698 - 369F
N698:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2150
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2150:
jmp @r4
mov #0x1C,r2
! Opcodes 36A0 - 36A7
N6A0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2151
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2151:
jmp @r4
mov #0x1C,r2
! Opcodes 36A8 - 36AF
N6A8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2152
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2152:
jmp @r4
mov #0x1C,r2
! Opcodes 36B0 - 36B7
N6B0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2153
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2153:
jmp @r4
mov #0x1C,r2
! Opcode 36B8
N6B8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2154
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2154:
jmp @r4
mov #0x1C,r2
! Opcode 36B9
N6B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2155
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2155:
jmp @r4
mov #0x1C,r2
! Opcode 36BA
N6BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2156
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2156:
jmp @r4
mov #0x1C,r2
! Opcode 36BB
N6BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2157
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2157:
jmp @r4
mov #0x1C,r2
! Opcode 36BC
N6BC:
mov.w @r6+,r3
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2158
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2158:
jmp @r4
mov #0x1C,r2
! Opcodes 36C0 - 36C7
N6C0:
and r0,r2
add r13,r2
mov.w @r2,r3
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2159
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2159:
jmp @r4
mov #0x1C,r2
! Opcodes 36C8 - 36CF
N6C8:
and r0,r2
add r14,r2
mov.w @r2,r3
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2160
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2160:
jmp @r4
mov #0x1C,r2
! Opcodes 36D0 - 36D7
N6D0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2161
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2161:
jmp @r4
mov #0x1C,r2
! Opcodes 36D8 - 36DF
N6D8:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2162
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2162:
jmp @r4
mov #0x1C,r2
! Opcodes 36E0 - 36E7
N6E0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2163
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2163:
jmp @r4
mov #0x1C,r2
! Opcodes 36E8 - 36EF
N6E8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2164
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2164:
jmp @r4
mov #0x1C,r2
! Opcodes 36F0 - 36F7
N6F0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2165
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2165:
jmp @r4
mov #0x1C,r2
! Opcode 36F8
N6F8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2166
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2166:
jmp @r4
mov #0x1C,r2
! Opcode 36F9
N6F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2167
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2167:
jmp @r4
mov #0x1C,r2
! Opcode 36FA
N6FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2168
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2168:
jmp @r4
mov #0x1C,r2
! Opcode 36FB
N6FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2169
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2169:
jmp @r4
mov #0x1C,r2
! Opcode 36FC
N6FC:
mov.w @r6+,r3
mov.l @(44,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2170
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2170:
jmp @r4
mov #0x1C,r2
! Opcodes 3700 - 3707
N700:
and r0,r2
add r13,r2
mov.w @r2,r3
mov.l @(44,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2171
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2171:
jmp @r4
mov #0x1C,r2
! Opcodes 3708 - 370F
N708:
and r0,r2
add r14,r2
mov.w @r2,r3
mov.l @(44,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2172
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2172:
jmp @r4
mov #0x1C,r2
! Opcodes 3710 - 3717
N710:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2173
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2173:
jmp @r4
mov #0x1C,r2
! Opcodes 3718 - 371F
N718:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(44,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2174
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2174:
jmp @r4
mov #0x1C,r2
! Opcodes 3720 - 3727
N720:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(44,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2175
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2175:
jmp @r4
mov #0x1C,r2
! Opcodes 3728 - 372F
N728:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2176
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2176:
jmp @r4
mov #0x1C,r2
! Opcodes 3730 - 3737
N730:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2177
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2177:
jmp @r4
mov #0x1C,r2
! Opcode 3738
N738:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2178
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2178:
jmp @r4
mov #0x1C,r2
! Opcode 3739
N739:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2179
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2179:
jmp @r4
mov #0x1C,r2
! Opcode 373A
N73A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2180
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2180:
jmp @r4
mov #0x1C,r2
! Opcode 373B
N73B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(44,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2181
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2181:
jmp @r4
mov #0x1C,r2
! Opcode 373C
N73C:
mov.w @r6+,r3
mov.l @(44,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(44,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2182
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2182:
jmp @r4
mov #0x1C,r2
! Opcodes 3740 - 3747
N740:
and r0,r2
add r13,r2
mov.w @r2,r3
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2183
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2183:
jmp @r4
mov #0x1C,r2
! Opcodes 3748 - 374F
N748:
and r0,r2
add r14,r2
mov.w @r2,r3
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2184
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2184:
jmp @r4
mov #0x1C,r2
! Opcodes 3750 - 3757
N750:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2185
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2185:
jmp @r4
mov #0x1C,r2
! Opcodes 3758 - 375F
N758:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2186
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2186:
jmp @r4
mov #0x1C,r2
! Opcodes 3760 - 3767
N760:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2187
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2187:
jmp @r4
mov #0x1C,r2
! Opcodes 3768 - 376F
N768:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2188
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2188:
jmp @r4
mov #0x1C,r2
! Opcodes 3770 - 3777
N770:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl2189
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2189:
jmp @r4
mov #0x1C,r2
! Opcode 3778
N778:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2190
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2190:
jmp @r4
mov #0x1C,r2
! Opcode 3779
N779:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl2191
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2191:
jmp @r4
mov #0x1C,r2
! Opcode 377A
N77A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2192
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2192:
jmp @r4
mov #0x1C,r2
! Opcode 377B
N77B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl2193
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2193:
jmp @r4
mov #0x1C,r2
! Opcode 377C
N77C:
mov.w @r6+,r3
mov.w @r6+,r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2194
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2194:
jmp @r4
mov #0x1C,r2
! Opcodes 3780 - 3787
N780:
and r0,r2
add r13,r2
mov.w @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2195
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2195:
jmp @r4
mov #0x1C,r2
! Opcodes 3788 - 378F
N788:
and r0,r2
add r14,r2
mov.w @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2196
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2196:
jmp @r4
mov #0x1C,r2
! Opcodes 3790 - 3797
N790:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2197
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2197:
jmp @r4
mov #0x1C,r2
! Opcodes 3798 - 379F
N798:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2198
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2198:
jmp @r4
mov #0x1C,r2
! Opcodes 37A0 - 37A7
N7A0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2199
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2199:
jmp @r4
mov #0x1C,r2
! Opcodes 37A8 - 37AF
N7A8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl2200
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2200:
jmp @r4
mov #0x1C,r2
! Opcodes 37B0 - 37B7
N7B0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl2201
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2201:
jmp @r4
mov #0x1C,r2
! Opcode 37B8
N7B8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl2202
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2202:
jmp @r4
mov #0x1C,r2
! Opcode 37B9
N7B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl2203
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2203:
jmp @r4
mov #0x1C,r2
! Opcode 37BA
N7BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl2204
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2204:
jmp @r4
mov #0x1C,r2
! Opcode 37BB
N7BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl2205
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2205:
jmp @r4
mov #0x1C,r2
! Opcode 37BC
N7BC:
mov.w @r6+,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(44,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2206
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2206:
jmp @r4
mov #0x1C,r2
! Opcodes 3800 - 3807
N800:
and r0,r2
add r13,r2
mov.w @r2,r3
mov #16,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl2207
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2207:
jmp @r4
mov #0x1C,r2
! Opcodes 3808 - 380F
N808:
and r0,r2
add r14,r2
mov.w @r2,r3
mov #16,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl2208
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2208:
jmp @r4
mov #0x1C,r2
! Opcodes 3810 - 3817
N810:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2209
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2209:
jmp @r4
mov #0x1C,r2
! Opcodes 3818 - 381F
N818:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #16,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2210
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2210:
jmp @r4
mov #0x1C,r2
! Opcodes 3820 - 3827
N820:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #16,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-10,r7
shll2 r0
cmp/pl r7
bt/s fdl2211
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2211:
jmp @r4
mov #0x1C,r2
! Opcodes 3828 - 382F
N828:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2212
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2212:
jmp @r4
mov #0x1C,r2
! Opcodes 3830 - 3837
N830:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2213
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2213:
jmp @r4
mov #0x1C,r2
! Opcode 3838
N838:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2214
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2214:
jmp @r4
mov #0x1C,r2
! Opcode 3839
N839:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2215
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2215:
jmp @r4
mov #0x1C,r2
! Opcode 383A
N83A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2216
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2216:
jmp @r4
mov #0x1C,r2
! Opcode 383B
N83B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #16,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2217
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2217:
jmp @r4
mov #0x1C,r2
! Opcode 383C
N83C:
mov.w @r6+,r3
mov #16,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2218
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2218:
jmp @r4
mov #0x1C,r2
! Opcodes 3840 - 3847
N840:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.w @(r0,r13),r3
mov.l r3,@(48,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl2219
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2219:
jmp @r4
mov #0x1C,r2
! Opcodes 3848 - 384F
N848:
and r0,r2
mov.l r3,@-r15
add r14,r2
mov.w @r2,r3
mov.l r3,@(48,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl2220
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2220:
jmp @r4
mov #0x1C,r2
! Opcodes 3850 - 3857
N850:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(48,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2221
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2221:
jmp @r4
mov #0x1C,r2
! Opcodes 3858 - 385F
N858:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(48,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2222
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2222:
jmp @r4
mov #0x1C,r2
! Opcodes 3860 - 3867
N860:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(48,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-10,r7
shll2 r0
cmp/pl r7
bt/s fdl2223
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2223:
jmp @r4
mov #0x1C,r2
! Opcodes 3868 - 386F
N868:
and r0,r2
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(48,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2224
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2224:
jmp @r4
mov #0x1C,r2
! Opcodes 3870 - 3877
N870:
and r0,r2
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(48,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2225
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2225:
jmp @r4
mov #0x1C,r2
! Opcode 3878
N878:
mov.l r3,@-r15
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(48,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2226
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2226:
jmp @r4
mov #0x1C,r2
! Opcode 3879
N879:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(48,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2227
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2227:
jmp @r4
mov #0x1C,r2
! Opcode 387A
N87A:
mov.l r3,@-r15
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(48,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2228
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2228:
jmp @r4
mov #0x1C,r2
! Opcode 387B
N87B:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(48,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2229
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2229:
jmp @r4
mov #0x1C,r2
! Opcode 387C
N87C:
mov.l r3,@-r15
mov.w @r6+,r3
mov.l r3,@(48,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2230
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2230:
jmp @r4
mov #0x1C,r2
! Opcodes 3880 - 3887
N880:
and r0,r2
add r13,r2
mov.w @r2,r3
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2231
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2231:
jmp @r4
mov #0x1C,r2
! Opcodes 3888 - 388F
N888:
and r0,r2
add r14,r2
mov.w @r2,r3
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2232
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2232:
jmp @r4
mov #0x1C,r2
! Opcodes 3890 - 3897
N890:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2233
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2233:
jmp @r4
mov #0x1C,r2
! Opcodes 3898 - 389F
N898:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2234
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2234:
jmp @r4
mov #0x1C,r2
! Opcodes 38A0 - 38A7
N8A0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2235
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2235:
jmp @r4
mov #0x1C,r2
! Opcodes 38A8 - 38AF
N8A8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2236
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2236:
jmp @r4
mov #0x1C,r2
! Opcodes 38B0 - 38B7
N8B0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2237
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2237:
jmp @r4
mov #0x1C,r2
! Opcode 38B8
N8B8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2238
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2238:
jmp @r4
mov #0x1C,r2
! Opcode 38B9
N8B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2239
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2239:
jmp @r4
mov #0x1C,r2
! Opcode 38BA
N8BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2240
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2240:
jmp @r4
mov #0x1C,r2
! Opcode 38BB
N8BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2241
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2241:
jmp @r4
mov #0x1C,r2
! Opcode 38BC
N8BC:
mov.w @r6+,r3
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2242
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2242:
jmp @r4
mov #0x1C,r2
! Opcodes 38C0 - 38C7
N8C0:
and r0,r2
add r13,r2
mov.w @r2,r3
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2243
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2243:
jmp @r4
mov #0x1C,r2
! Opcodes 38C8 - 38CF
N8C8:
and r0,r2
add r14,r2
mov.w @r2,r3
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2244
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2244:
jmp @r4
mov #0x1C,r2
! Opcodes 38D0 - 38D7
N8D0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2245
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2245:
jmp @r4
mov #0x1C,r2
! Opcodes 38D8 - 38DF
N8D8:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2246
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2246:
jmp @r4
mov #0x1C,r2
! Opcodes 38E0 - 38E7
N8E0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2247
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2247:
jmp @r4
mov #0x1C,r2
! Opcodes 38E8 - 38EF
N8E8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2248
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2248:
jmp @r4
mov #0x1C,r2
! Opcodes 38F0 - 38F7
N8F0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2249
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2249:
jmp @r4
mov #0x1C,r2
! Opcode 38F8
N8F8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2250
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2250:
jmp @r4
mov #0x1C,r2
! Opcode 38F9
N8F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2251
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2251:
jmp @r4
mov #0x1C,r2
! Opcode 38FA
N8FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2252
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2252:
jmp @r4
mov #0x1C,r2
! Opcode 38FB
N8FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2253
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2253:
jmp @r4
mov #0x1C,r2
! Opcode 38FC
N8FC:
mov.w @r6+,r3
mov.l @(48,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2254
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2254:
jmp @r4
mov #0x1C,r2
! Opcodes 3900 - 3907
N900:
and r0,r2
add r13,r2
mov.w @r2,r3
mov.l @(48,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2255
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2255:
jmp @r4
mov #0x1C,r2
! Opcodes 3908 - 390F
N908:
and r0,r2
add r14,r2
mov.w @r2,r3
mov.l @(48,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2256
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2256:
jmp @r4
mov #0x1C,r2
! Opcodes 3910 - 3917
N910:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2257
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2257:
jmp @r4
mov #0x1C,r2
! Opcodes 3918 - 391F
N918:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(48,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2258
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2258:
jmp @r4
mov #0x1C,r2
! Opcodes 3920 - 3927
N920:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(48,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2259
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2259:
jmp @r4
mov #0x1C,r2
! Opcodes 3928 - 392F
N928:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2260
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2260:
jmp @r4
mov #0x1C,r2
! Opcodes 3930 - 3937
N930:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2261
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2261:
jmp @r4
mov #0x1C,r2
! Opcode 3938
N938:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2262
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2262:
jmp @r4
mov #0x1C,r2
! Opcode 3939
N939:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2263
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2263:
jmp @r4
mov #0x1C,r2
! Opcode 393A
N93A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2264
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2264:
jmp @r4
mov #0x1C,r2
! Opcode 393B
N93B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(48,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2265
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2265:
jmp @r4
mov #0x1C,r2
! Opcode 393C
N93C:
mov.w @r6+,r3
mov.l @(48,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(48,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2266
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2266:
jmp @r4
mov #0x1C,r2
! Opcodes 3940 - 3947
N940:
and r0,r2
add r13,r2
mov.w @r2,r3
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2267
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2267:
jmp @r4
mov #0x1C,r2
! Opcodes 3948 - 394F
N948:
and r0,r2
add r14,r2
mov.w @r2,r3
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2268
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2268:
jmp @r4
mov #0x1C,r2
! Opcodes 3950 - 3957
N950:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2269
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2269:
jmp @r4
mov #0x1C,r2
! Opcodes 3958 - 395F
N958:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2270
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2270:
jmp @r4
mov #0x1C,r2
! Opcodes 3960 - 3967
N960:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2271
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2271:
jmp @r4
mov #0x1C,r2
! Opcodes 3968 - 396F
N968:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2272
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2272:
jmp @r4
mov #0x1C,r2
! Opcodes 3970 - 3977
N970:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl2273
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2273:
jmp @r4
mov #0x1C,r2
! Opcode 3978
N978:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2274
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2274:
jmp @r4
mov #0x1C,r2
! Opcode 3979
N979:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl2275
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2275:
jmp @r4
mov #0x1C,r2
! Opcode 397A
N97A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2276
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2276:
jmp @r4
mov #0x1C,r2
! Opcode 397B
N97B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl2277
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2277:
jmp @r4
mov #0x1C,r2
! Opcode 397C
N97C:
mov.w @r6+,r3
mov.w @r6+,r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2278
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2278:
jmp @r4
mov #0x1C,r2
! Opcodes 3980 - 3987
N980:
and r0,r2
add r13,r2
mov.w @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2279
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2279:
jmp @r4
mov #0x1C,r2
! Opcodes 3988 - 398F
N988:
and r0,r2
add r14,r2
mov.w @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2280
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2280:
jmp @r4
mov #0x1C,r2
! Opcodes 3990 - 3997
N990:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2281
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2281:
jmp @r4
mov #0x1C,r2
! Opcodes 3998 - 399F
N998:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2282
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2282:
jmp @r4
mov #0x1C,r2
! Opcodes 39A0 - 39A7
N9A0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2283
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2283:
jmp @r4
mov #0x1C,r2
! Opcodes 39A8 - 39AF
N9A8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl2284
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2284:
jmp @r4
mov #0x1C,r2
! Opcodes 39B0 - 39B7
N9B0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl2285
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2285:
jmp @r4
mov #0x1C,r2
! Opcode 39B8
N9B8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl2286
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2286:
jmp @r4
mov #0x1C,r2
! Opcode 39B9
N9B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl2287
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2287:
jmp @r4
mov #0x1C,r2
! Opcode 39BA
N9BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl2288
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2288:
jmp @r4
mov #0x1C,r2
! Opcode 39BB
N9BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl2289
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2289:
jmp @r4
mov #0x1C,r2
! Opcode 39BC
N9BC:
mov.w @r6+,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(48,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2290
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2290:
jmp @r4
mov #0x1C,r2
! Opcodes 3A00 - 3A07
NA00:
and r0,r2
add r13,r2
mov.w @r2,r3
mov #20,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl2291
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2291:
jmp @r4
mov #0x1C,r2
! Opcodes 3A08 - 3A0F
NA08:
and r0,r2
add r14,r2
mov.w @r2,r3
mov #20,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl2292
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2292:
jmp @r4
mov #0x1C,r2
! Opcodes 3A10 - 3A17
NA10:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2293
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2293:
jmp @r4
mov #0x1C,r2
! Opcodes 3A18 - 3A1F
NA18:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #20,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2294
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2294:
jmp @r4
mov #0x1C,r2
! Opcodes 3A20 - 3A27
NA20:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #20,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-10,r7
shll2 r0
cmp/pl r7
bt/s fdl2295
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2295:
jmp @r4
mov #0x1C,r2
! Opcodes 3A28 - 3A2F
NA28:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2296
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2296:
jmp @r4
mov #0x1C,r2
! Opcodes 3A30 - 3A37
NA30:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2297
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2297:
jmp @r4
mov #0x1C,r2
! Opcode 3A38
NA38:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2298
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2298:
jmp @r4
mov #0x1C,r2
! Opcode 3A39
NA39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2299
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2299:
jmp @r4
mov #0x1C,r2
! Opcode 3A3A
NA3A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2300
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2300:
jmp @r4
mov #0x1C,r2
! Opcode 3A3B
NA3B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #20,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2301
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2301:
jmp @r4
mov #0x1C,r2
! Opcode 3A3C
NA3C:
mov.w @r6+,r3
mov #20,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2302
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2302:
jmp @r4
mov #0x1C,r2
! Opcodes 3A40 - 3A47
NA40:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.w @(r0,r13),r3
mov.l r3,@(52,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl2303
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2303:
jmp @r4
mov #0x1C,r2
! Opcodes 3A48 - 3A4F
NA48:
and r0,r2
mov.l r3,@-r15
add r14,r2
mov.w @r2,r3
mov.l r3,@(52,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl2304
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2304:
jmp @r4
mov #0x1C,r2
! Opcodes 3A50 - 3A57
NA50:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(52,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2305
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2305:
jmp @r4
mov #0x1C,r2
! Opcodes 3A58 - 3A5F
NA58:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(52,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2306
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2306:
jmp @r4
mov #0x1C,r2
! Opcodes 3A60 - 3A67
NA60:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(52,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-10,r7
shll2 r0
cmp/pl r7
bt/s fdl2307
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2307:
jmp @r4
mov #0x1C,r2
! Opcodes 3A68 - 3A6F
NA68:
and r0,r2
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(52,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2308
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2308:
jmp @r4
mov #0x1C,r2
! Opcodes 3A70 - 3A77
NA70:
and r0,r2
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(52,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2309
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2309:
jmp @r4
mov #0x1C,r2
! Opcode 3A78
NA78:
mov.l r3,@-r15
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(52,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2310
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2310:
jmp @r4
mov #0x1C,r2
! Opcode 3A79
NA79:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(52,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2311
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2311:
jmp @r4
mov #0x1C,r2
! Opcode 3A7A
NA7A:
mov.l r3,@-r15
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(52,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2312
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2312:
jmp @r4
mov #0x1C,r2
! Opcode 3A7B
NA7B:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(52,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2313
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2313:
jmp @r4
mov #0x1C,r2
! Opcode 3A7C
NA7C:
mov.l r3,@-r15
mov.w @r6+,r3
mov.l r3,@(52,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2314
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2314:
jmp @r4
mov #0x1C,r2
! Opcodes 3A80 - 3A87
NA80:
and r0,r2
add r13,r2
mov.w @r2,r3
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2315
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2315:
jmp @r4
mov #0x1C,r2
! Opcodes 3A88 - 3A8F
NA88:
and r0,r2
add r14,r2
mov.w @r2,r3
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2316
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2316:
jmp @r4
mov #0x1C,r2
! Opcodes 3A90 - 3A97
NA90:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2317
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2317:
jmp @r4
mov #0x1C,r2
! Opcodes 3A98 - 3A9F
NA98:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2318
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2318:
jmp @r4
mov #0x1C,r2
! Opcodes 3AA0 - 3AA7
NAA0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2319
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2319:
jmp @r4
mov #0x1C,r2
! Opcodes 3AA8 - 3AAF
NAA8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2320
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2320:
jmp @r4
mov #0x1C,r2
! Opcodes 3AB0 - 3AB7
NAB0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2321
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2321:
jmp @r4
mov #0x1C,r2
! Opcode 3AB8
NAB8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2322
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2322:
jmp @r4
mov #0x1C,r2
! Opcode 3AB9
NAB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2323
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2323:
jmp @r4
mov #0x1C,r2
! Opcode 3ABA
NABA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2324
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2324:
jmp @r4
mov #0x1C,r2
! Opcode 3ABB
NABB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2325
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2325:
jmp @r4
mov #0x1C,r2
! Opcode 3ABC
NABC:
mov.w @r6+,r3
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2326
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2326:
jmp @r4
mov #0x1C,r2
! Opcodes 3AC0 - 3AC7
NAC0:
and r0,r2
add r13,r2
mov.w @r2,r3
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2327
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2327:
jmp @r4
mov #0x1C,r2
! Opcodes 3AC8 - 3ACF
NAC8:
and r0,r2
add r14,r2
mov.w @r2,r3
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2328
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2328:
jmp @r4
mov #0x1C,r2
! Opcodes 3AD0 - 3AD7
NAD0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2329
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2329:
jmp @r4
mov #0x1C,r2
! Opcodes 3AD8 - 3ADF
NAD8:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2330
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2330:
jmp @r4
mov #0x1C,r2
! Opcodes 3AE0 - 3AE7
NAE0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2331
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2331:
jmp @r4
mov #0x1C,r2
! Opcodes 3AE8 - 3AEF
NAE8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2332
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2332:
jmp @r4
mov #0x1C,r2
! Opcodes 3AF0 - 3AF7
NAF0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2333
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2333:
jmp @r4
mov #0x1C,r2
! Opcode 3AF8
NAF8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2334
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2334:
jmp @r4
mov #0x1C,r2
! Opcode 3AF9
NAF9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2335
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2335:
jmp @r4
mov #0x1C,r2
! Opcode 3AFA
NAFA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2336
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2336:
jmp @r4
mov #0x1C,r2
! Opcode 3AFB
NAFB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2337
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2337:
jmp @r4
mov #0x1C,r2
! Opcode 3AFC
NAFC:
mov.w @r6+,r3
mov.l @(52,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2338
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2338:
jmp @r4
mov #0x1C,r2
! Opcodes 3B00 - 3B07
NB00:
and r0,r2
add r13,r2
mov.w @r2,r3
mov.l @(52,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2339
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2339:
jmp @r4
mov #0x1C,r2
! Opcodes 3B08 - 3B0F
NB08:
and r0,r2
add r14,r2
mov.w @r2,r3
mov.l @(52,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2340
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2340:
jmp @r4
mov #0x1C,r2
! Opcodes 3B10 - 3B17
NB10:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2341
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2341:
jmp @r4
mov #0x1C,r2
! Opcodes 3B18 - 3B1F
NB18:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(52,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2342
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2342:
jmp @r4
mov #0x1C,r2
! Opcodes 3B20 - 3B27
NB20:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(52,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2343
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2343:
jmp @r4
mov #0x1C,r2
! Opcodes 3B28 - 3B2F
NB28:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2344
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2344:
jmp @r4
mov #0x1C,r2
! Opcodes 3B30 - 3B37
NB30:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2345
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2345:
jmp @r4
mov #0x1C,r2
! Opcode 3B38
NB38:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2346
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2346:
jmp @r4
mov #0x1C,r2
! Opcode 3B39
NB39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2347
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2347:
jmp @r4
mov #0x1C,r2
! Opcode 3B3A
NB3A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2348
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2348:
jmp @r4
mov #0x1C,r2
! Opcode 3B3B
NB3B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(52,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2349
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2349:
jmp @r4
mov #0x1C,r2
! Opcode 3B3C
NB3C:
mov.w @r6+,r3
mov.l @(52,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(52,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2350
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2350:
jmp @r4
mov #0x1C,r2
! Opcodes 3B40 - 3B47
NB40:
and r0,r2
add r13,r2
mov.w @r2,r3
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2351
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2351:
jmp @r4
mov #0x1C,r2
! Opcodes 3B48 - 3B4F
NB48:
and r0,r2
add r14,r2
mov.w @r2,r3
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2352
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2352:
jmp @r4
mov #0x1C,r2
! Opcodes 3B50 - 3B57
NB50:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2353
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2353:
jmp @r4
mov #0x1C,r2
! Opcodes 3B58 - 3B5F
NB58:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2354
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2354:
jmp @r4
mov #0x1C,r2
! Opcodes 3B60 - 3B67
NB60:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2355
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2355:
jmp @r4
mov #0x1C,r2
! Opcodes 3B68 - 3B6F
NB68:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2356
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2356:
jmp @r4
mov #0x1C,r2
! Opcodes 3B70 - 3B77
NB70:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl2357
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2357:
jmp @r4
mov #0x1C,r2
! Opcode 3B78
NB78:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2358
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2358:
jmp @r4
mov #0x1C,r2
! Opcode 3B79
NB79:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl2359
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2359:
jmp @r4
mov #0x1C,r2
! Opcode 3B7A
NB7A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2360
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2360:
jmp @r4
mov #0x1C,r2
! Opcode 3B7B
NB7B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl2361
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2361:
jmp @r4
mov #0x1C,r2
! Opcode 3B7C
NB7C:
mov.w @r6+,r3
mov.w @r6+,r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2362
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2362:
jmp @r4
mov #0x1C,r2
! Opcodes 3B80 - 3B87
NB80:
and r0,r2
add r13,r2
mov.w @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2363
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2363:
jmp @r4
mov #0x1C,r2
! Opcodes 3B88 - 3B8F
NB88:
and r0,r2
add r14,r2
mov.w @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2364
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2364:
jmp @r4
mov #0x1C,r2
! Opcodes 3B90 - 3B97
NB90:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2365
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2365:
jmp @r4
mov #0x1C,r2
! Opcodes 3B98 - 3B9F
NB98:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2366
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2366:
jmp @r4
mov #0x1C,r2
! Opcodes 3BA0 - 3BA7
NBA0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2367
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2367:
jmp @r4
mov #0x1C,r2
! Opcodes 3BA8 - 3BAF
NBA8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl2368
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2368:
jmp @r4
mov #0x1C,r2
! Opcodes 3BB0 - 3BB7
NBB0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl2369
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2369:
jmp @r4
mov #0x1C,r2
! Opcode 3BB8
NBB8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl2370
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2370:
jmp @r4
mov #0x1C,r2
! Opcode 3BB9
NBB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl2371
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2371:
jmp @r4
mov #0x1C,r2
! Opcode 3BBA
NBBA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl2372
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2372:
jmp @r4
mov #0x1C,r2
! Opcode 3BBB
NBBB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl2373
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2373:
jmp @r4
mov #0x1C,r2
! Opcode 3BBC
NBBC:
mov.w @r6+,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(52,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2374
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2374:
jmp @r4
mov #0x1C,r2
! Opcodes 3C00 - 3C07
NC00:
and r0,r2
add r13,r2
mov.w @r2,r3
mov #24,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl2375
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2375:
jmp @r4
mov #0x1C,r2
! Opcodes 3C08 - 3C0F
NC08:
and r0,r2
add r14,r2
mov.w @r2,r3
mov #24,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl2376
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2376:
jmp @r4
mov #0x1C,r2
! Opcodes 3C10 - 3C17
NC10:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2377
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2377:
jmp @r4
mov #0x1C,r2
! Opcodes 3C18 - 3C1F
NC18:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #24,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2378
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2378:
jmp @r4
mov #0x1C,r2
! Opcodes 3C20 - 3C27
NC20:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #24,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-10,r7
shll2 r0
cmp/pl r7
bt/s fdl2379
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2379:
jmp @r4
mov #0x1C,r2
! Opcodes 3C28 - 3C2F
NC28:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2380
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2380:
jmp @r4
mov #0x1C,r2
! Opcodes 3C30 - 3C37
NC30:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2381
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2381:
jmp @r4
mov #0x1C,r2
! Opcode 3C38
NC38:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2382
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2382:
jmp @r4
mov #0x1C,r2
! Opcode 3C39
NC39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2383
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2383:
jmp @r4
mov #0x1C,r2
! Opcode 3C3A
NC3A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2384
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2384:
jmp @r4
mov #0x1C,r2
! Opcode 3C3B
NC3B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2385
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2385:
jmp @r4
mov #0x1C,r2
! Opcode 3C3C
NC3C:
mov.w @r6+,r3
mov #24,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2386
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2386:
jmp @r4
mov #0x1C,r2
! Opcodes 3C40 - 3C47
NC40:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.w @(r0,r13),r3
mov.l r3,@(56,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl2387
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2387:
jmp @r4
mov #0x1C,r2
! Opcodes 3C48 - 3C4F
NC48:
and r0,r2
mov.l r3,@-r15
add r14,r2
mov.w @r2,r3
mov.l r3,@(56,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl2388
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2388:
jmp @r4
mov #0x1C,r2
! Opcodes 3C50 - 3C57
NC50:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(56,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2389
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2389:
jmp @r4
mov #0x1C,r2
! Opcodes 3C58 - 3C5F
NC58:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(56,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2390
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2390:
jmp @r4
mov #0x1C,r2
! Opcodes 3C60 - 3C67
NC60:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(56,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-10,r7
shll2 r0
cmp/pl r7
bt/s fdl2391
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2391:
jmp @r4
mov #0x1C,r2
! Opcodes 3C68 - 3C6F
NC68:
and r0,r2
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(56,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2392
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2392:
jmp @r4
mov #0x1C,r2
! Opcodes 3C70 - 3C77
NC70:
and r0,r2
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(56,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2393
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2393:
jmp @r4
mov #0x1C,r2
! Opcode 3C78
NC78:
mov.l r3,@-r15
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(56,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2394
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2394:
jmp @r4
mov #0x1C,r2
! Opcode 3C79
NC79:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(56,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2395
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2395:
jmp @r4
mov #0x1C,r2
! Opcode 3C7A
NC7A:
mov.l r3,@-r15
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(56,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2396
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2396:
jmp @r4
mov #0x1C,r2
! Opcode 3C7B
NC7B:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(56,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2397
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2397:
jmp @r4
mov #0x1C,r2
! Opcode 3C7C
NC7C:
mov.l r3,@-r15
mov.w @r6+,r3
mov.l r3,@(56,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2398
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2398:
jmp @r4
mov #0x1C,r2
! Opcodes 3C80 - 3C87
NC80:
and r0,r2
add r13,r2
mov.w @r2,r3
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2399
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2399:
jmp @r4
mov #0x1C,r2
! Opcodes 3C88 - 3C8F
NC88:
and r0,r2
add r14,r2
mov.w @r2,r3
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2400
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2400:
jmp @r4
mov #0x1C,r2
! Opcodes 3C90 - 3C97
NC90:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2401
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2401:
jmp @r4
mov #0x1C,r2
! Opcodes 3C98 - 3C9F
NC98:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2402
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2402:
jmp @r4
mov #0x1C,r2
! Opcodes 3CA0 - 3CA7
NCA0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2403
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2403:
jmp @r4
mov #0x1C,r2
! Opcodes 3CA8 - 3CAF
NCA8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2404
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2404:
jmp @r4
mov #0x1C,r2
! Opcodes 3CB0 - 3CB7
NCB0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2405
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2405:
jmp @r4
mov #0x1C,r2
! Opcode 3CB8
NCB8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2406
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2406:
jmp @r4
mov #0x1C,r2
! Opcode 3CB9
NCB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2407
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2407:
jmp @r4
mov #0x1C,r2
! Opcode 3CBA
NCBA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2408
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2408:
jmp @r4
mov #0x1C,r2
! Opcode 3CBB
NCBB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2409
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2409:
jmp @r4
mov #0x1C,r2
! Opcode 3CBC
NCBC:
mov.w @r6+,r3
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2410
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2410:
jmp @r4
mov #0x1C,r2
! Opcodes 3CC0 - 3CC7
NCC0:
and r0,r2
add r13,r2
mov.w @r2,r3
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2411
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2411:
jmp @r4
mov #0x1C,r2
! Opcodes 3CC8 - 3CCF
NCC8:
and r0,r2
add r14,r2
mov.w @r2,r3
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2412
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2412:
jmp @r4
mov #0x1C,r2
! Opcodes 3CD0 - 3CD7
NCD0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2413
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2413:
jmp @r4
mov #0x1C,r2
! Opcodes 3CD8 - 3CDF
NCD8:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2414
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2414:
jmp @r4
mov #0x1C,r2
! Opcodes 3CE0 - 3CE7
NCE0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2415
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2415:
jmp @r4
mov #0x1C,r2
! Opcodes 3CE8 - 3CEF
NCE8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2416
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2416:
jmp @r4
mov #0x1C,r2
! Opcodes 3CF0 - 3CF7
NCF0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2417
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2417:
jmp @r4
mov #0x1C,r2
! Opcode 3CF8
NCF8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2418
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2418:
jmp @r4
mov #0x1C,r2
! Opcode 3CF9
NCF9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2419
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2419:
jmp @r4
mov #0x1C,r2
! Opcode 3CFA
NCFA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2420
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2420:
jmp @r4
mov #0x1C,r2
! Opcode 3CFB
NCFB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2421
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2421:
jmp @r4
mov #0x1C,r2
! Opcode 3CFC
NCFC:
mov.w @r6+,r3
mov.l @(56,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2422
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2422:
jmp @r4
mov #0x1C,r2
! Opcodes 3D00 - 3D07
ND00:
and r0,r2
add r13,r2
mov.w @r2,r3
mov.l @(56,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2423
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2423:
jmp @r4
mov #0x1C,r2
! Opcodes 3D08 - 3D0F
ND08:
and r0,r2
add r14,r2
mov.w @r2,r3
mov.l @(56,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2424
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2424:
jmp @r4
mov #0x1C,r2
! Opcodes 3D10 - 3D17
ND10:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2425
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2425:
jmp @r4
mov #0x1C,r2
! Opcodes 3D18 - 3D1F
ND18:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(56,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2426
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2426:
jmp @r4
mov #0x1C,r2
! Opcodes 3D20 - 3D27
ND20:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(56,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2427
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2427:
jmp @r4
mov #0x1C,r2
! Opcodes 3D28 - 3D2F
ND28:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2428
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2428:
jmp @r4
mov #0x1C,r2
! Opcodes 3D30 - 3D37
ND30:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2429
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2429:
jmp @r4
mov #0x1C,r2
! Opcode 3D38
ND38:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2430
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2430:
jmp @r4
mov #0x1C,r2
! Opcode 3D39
ND39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2431
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2431:
jmp @r4
mov #0x1C,r2
! Opcode 3D3A
ND3A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2432
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2432:
jmp @r4
mov #0x1C,r2
! Opcode 3D3B
ND3B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(56,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2433
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2433:
jmp @r4
mov #0x1C,r2
! Opcode 3D3C
ND3C:
mov.w @r6+,r3
mov.l @(56,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(56,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2434
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2434:
jmp @r4
mov #0x1C,r2
! Opcodes 3D40 - 3D47
ND40:
and r0,r2
add r13,r2
mov.w @r2,r3
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2435
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2435:
jmp @r4
mov #0x1C,r2
! Opcodes 3D48 - 3D4F
ND48:
and r0,r2
add r14,r2
mov.w @r2,r3
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2436
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2436:
jmp @r4
mov #0x1C,r2
! Opcodes 3D50 - 3D57
ND50:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2437
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2437:
jmp @r4
mov #0x1C,r2
! Opcodes 3D58 - 3D5F
ND58:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2438
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2438:
jmp @r4
mov #0x1C,r2
! Opcodes 3D60 - 3D67
ND60:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2439
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2439:
jmp @r4
mov #0x1C,r2
! Opcodes 3D68 - 3D6F
ND68:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2440
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2440:
jmp @r4
mov #0x1C,r2
! Opcodes 3D70 - 3D77
ND70:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl2441
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2441:
jmp @r4
mov #0x1C,r2
! Opcode 3D78
ND78:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2442
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2442:
jmp @r4
mov #0x1C,r2
! Opcode 3D79
ND79:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl2443
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2443:
jmp @r4
mov #0x1C,r2
! Opcode 3D7A
ND7A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2444
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2444:
jmp @r4
mov #0x1C,r2
! Opcode 3D7B
ND7B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl2445
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2445:
jmp @r4
mov #0x1C,r2
! Opcode 3D7C
ND7C:
mov.w @r6+,r3
mov.w @r6+,r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2446
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2446:
jmp @r4
mov #0x1C,r2
! Opcodes 3D80 - 3D87
ND80:
and r0,r2
add r13,r2
mov.w @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2447
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2447:
jmp @r4
mov #0x1C,r2
! Opcodes 3D88 - 3D8F
ND88:
and r0,r2
add r14,r2
mov.w @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2448
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2448:
jmp @r4
mov #0x1C,r2
! Opcodes 3D90 - 3D97
ND90:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2449
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2449:
jmp @r4
mov #0x1C,r2
! Opcodes 3D98 - 3D9F
ND98:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2450
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2450:
jmp @r4
mov #0x1C,r2
! Opcodes 3DA0 - 3DA7
NDA0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2451
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2451:
jmp @r4
mov #0x1C,r2
! Opcodes 3DA8 - 3DAF
NDA8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl2452
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2452:
jmp @r4
mov #0x1C,r2
! Opcodes 3DB0 - 3DB7
NDB0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl2453
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2453:
jmp @r4
mov #0x1C,r2
! Opcode 3DB8
NDB8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl2454
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2454:
jmp @r4
mov #0x1C,r2
! Opcode 3DB9
NDB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl2455
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2455:
jmp @r4
mov #0x1C,r2
! Opcode 3DBA
NDBA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl2456
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2456:
jmp @r4
mov #0x1C,r2
! Opcode 3DBB
NDBB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl2457
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2457:
jmp @r4
mov #0x1C,r2
! Opcode 3DBC
NDBC:
mov.w @r6+,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(56,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2458
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2458:
jmp @r4
mov #0x1C,r2
! Opcodes 3E00 - 3E07
NE00:
and r0,r2
add r13,r2
mov.w @r2,r3
mov #28,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl2459
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2459:
jmp @r4
mov #0x1C,r2
! Opcodes 3E08 - 3E0F
NE08:
and r0,r2
add r14,r2
mov.w @r2,r3
mov #28,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl2460
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2460:
jmp @r4
mov #0x1C,r2
! Opcodes 3E10 - 3E17
NE10:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2461
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2461:
jmp @r4
mov #0x1C,r2
! Opcodes 3E18 - 3E1F
NE18:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #28,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2462
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2462:
jmp @r4
mov #0x1C,r2
! Opcodes 3E20 - 3E27
NE20:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #28,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-10,r7
shll2 r0
cmp/pl r7
bt/s fdl2463
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2463:
jmp @r4
mov #0x1C,r2
! Opcodes 3E28 - 3E2F
NE28:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2464
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2464:
jmp @r4
mov #0x1C,r2
! Opcodes 3E30 - 3E37
NE30:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2465
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2465:
jmp @r4
mov #0x1C,r2
! Opcode 3E38
NE38:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2466
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2466:
jmp @r4
mov #0x1C,r2
! Opcode 3E39
NE39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2467
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2467:
jmp @r4
mov #0x1C,r2
! Opcode 3E3A
NE3A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2468
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2468:
jmp @r4
mov #0x1C,r2
! Opcode 3E3B
NE3B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2469
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2469:
jmp @r4
mov #0x1C,r2
! Opcode 3E3C
NE3C:
mov.w @r6+,r3
mov #28,r0
mov.w r3,@(r0,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2470
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2470:
jmp @r4
mov #0x1C,r2
! Opcodes 3E40 - 3E47
NE40:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.w @(r0,r13),r3
mov.l r3,@(60,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl2471
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2471:
jmp @r4
mov #0x1C,r2
! Opcodes 3E48 - 3E4F
NE48:
and r0,r2
mov.l r3,@-r15
add r14,r2
mov.w @r2,r3
mov.l r3,@(60,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl2472
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2472:
jmp @r4
mov #0x1C,r2
! Opcodes 3E50 - 3E57
NE50:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(60,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2473
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2473:
jmp @r4
mov #0x1C,r2
! Opcodes 3E58 - 3E5F
NE58:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(60,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2474
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2474:
jmp @r4
mov #0x1C,r2
! Opcodes 3E60 - 3E67
NE60:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l r3,@(60,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-10,r7
shll2 r0
cmp/pl r7
bt/s fdl2475
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2475:
jmp @r4
mov #0x1C,r2
! Opcodes 3E68 - 3E6F
NE68:
and r0,r2
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(60,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2476
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2476:
jmp @r4
mov #0x1C,r2
! Opcodes 3E70 - 3E77
NE70:
and r0,r2
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(60,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2477
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2477:
jmp @r4
mov #0x1C,r2
! Opcode 3E78
NE78:
mov.l r3,@-r15
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(60,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2478
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2478:
jmp @r4
mov #0x1C,r2
! Opcode 3E79
NE79:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(60,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2479
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2479:
jmp @r4
mov #0x1C,r2
! Opcode 3E7A
NE7A:
mov.l r3,@-r15
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(60,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2480
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2480:
jmp @r4
mov #0x1C,r2
! Opcode 3E7B
NE7B:
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r3,@(60,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2481
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2481:
jmp @r4
mov #0x1C,r2
! Opcode 3E7C
NE7C:
mov.l r3,@-r15
mov.w @r6+,r3
mov.l r3,@(60,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2482
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2482:
jmp @r4
mov #0x1C,r2
! Opcodes 3E80 - 3E87
NE80:
and r0,r2
add r13,r2
mov.w @r2,r3
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2483
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2483:
jmp @r4
mov #0x1C,r2
! Opcodes 3E88 - 3E8F
NE88:
and r0,r2
add r14,r2
mov.w @r2,r3
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2484
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2484:
jmp @r4
mov #0x1C,r2
! Opcodes 3E90 - 3E97
NE90:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2485
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2485:
jmp @r4
mov #0x1C,r2
! Opcodes 3E98 - 3E9F
NE98:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2486
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2486:
jmp @r4
mov #0x1C,r2
! Opcodes 3EA0 - 3EA7
NEA0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2487
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2487:
jmp @r4
mov #0x1C,r2
! Opcodes 3EA8 - 3EAF
NEA8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2488
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2488:
jmp @r4
mov #0x1C,r2
! Opcodes 3EB0 - 3EB7
NEB0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2489
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2489:
jmp @r4
mov #0x1C,r2
! Opcode 3EB8
NEB8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2490
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2490:
jmp @r4
mov #0x1C,r2
! Opcode 3EB9
NEB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2491
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2491:
jmp @r4
mov #0x1C,r2
! Opcode 3EBA
NEBA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2492
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2492:
jmp @r4
mov #0x1C,r2
! Opcode 3EBB
NEBB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2493
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2493:
jmp @r4
mov #0x1C,r2
! Opcode 3EBC
NEBC:
mov.w @r6+,r3
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2494
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2494:
jmp @r4
mov #0x1C,r2
! Opcodes 3EC0 - 3EC7
NEC0:
and r0,r2
add r13,r2
mov.w @r2,r3
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2495
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2495:
jmp @r4
mov #0x1C,r2
! Opcodes 3EC8 - 3ECF
NEC8:
and r0,r2
add r14,r2
mov.w @r2,r3
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2496
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2496:
jmp @r4
mov #0x1C,r2
! Opcodes 3ED0 - 3ED7
NED0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2497
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2497:
jmp @r4
mov #0x1C,r2
! Opcodes 3ED8 - 3EDF
NED8:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2498
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2498:
jmp @r4
mov #0x1C,r2
! Opcodes 3EE0 - 3EE7
NEE0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2499
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2499:
jmp @r4
mov #0x1C,r2
! Opcodes 3EE8 - 3EEF
NEE8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2500
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2500:
jmp @r4
mov #0x1C,r2
! Opcodes 3EF0 - 3EF7
NEF0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2501
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2501:
jmp @r4
mov #0x1C,r2
! Opcode 3EF8
NEF8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2502
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2502:
jmp @r4
mov #0x1C,r2
! Opcode 3EF9
NEF9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2503
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2503:
jmp @r4
mov #0x1C,r2
! Opcode 3EFA
NEFA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2504
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2504:
jmp @r4
mov #0x1C,r2
! Opcode 3EFB
NEFB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2505
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2505:
jmp @r4
mov #0x1C,r2
! Opcode 3EFC
NEFC:
mov.w @r6+,r3
mov.l @(60,r13),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2506
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2506:
jmp @r4
mov #0x1C,r2
! Opcodes 3F00 - 3F07
NF00:
and r0,r2
add r13,r2
mov.w @r2,r3
mov.l @(60,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2507
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2507:
jmp @r4
mov #0x1C,r2
! Opcodes 3F08 - 3F0F
NF08:
and r0,r2
add r14,r2
mov.w @r2,r3
mov.l @(60,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2508
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2508:
jmp @r4
mov #0x1C,r2
! Opcodes 3F10 - 3F17
NF10:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2509
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2509:
jmp @r4
mov #0x1C,r2
! Opcodes 3F18 - 3F1F
NF18:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(60,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2510
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2510:
jmp @r4
mov #0x1C,r2
! Opcodes 3F20 - 3F27
NF20:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(60,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2511
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2511:
jmp @r4
mov #0x1C,r2
! Opcodes 3F28 - 3F2F
NF28:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2512
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2512:
jmp @r4
mov #0x1C,r2
! Opcodes 3F30 - 3F37
NF30:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2513
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2513:
jmp @r4
mov #0x1C,r2
! Opcode 3F38
NF38:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2514
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2514:
jmp @r4
mov #0x1C,r2
! Opcode 3F39
NF39:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2515
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2515:
jmp @r4
mov #0x1C,r2
! Opcode 3F3A
NF3A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2516
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2516:
jmp @r4
mov #0x1C,r2
! Opcode 3F3B
NF3B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(60,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2517
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2517:
jmp @r4
mov #0x1C,r2
! Opcode 3F3C
NF3C:
mov.w @r6+,r3
mov.l @(60,r13),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l r4,@(60,r13)
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2518
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2518:
jmp @r4
mov #0x1C,r2
! Opcodes 3F40 - 3F47
NF40:
and r0,r2
add r13,r2
mov.w @r2,r3
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2519
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2519:
jmp @r4
mov #0x1C,r2
! Opcodes 3F48 - 3F4F
NF48:
and r0,r2
add r14,r2
mov.w @r2,r3
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2520
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2520:
jmp @r4
mov #0x1C,r2
! Opcodes 3F50 - 3F57
NF50:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2521
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2521:
jmp @r4
mov #0x1C,r2
! Opcodes 3F58 - 3F5F
NF58:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2522
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2522:
jmp @r4
mov #0x1C,r2
! Opcodes 3F60 - 3F67
NF60:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2523
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2523:
jmp @r4
mov #0x1C,r2
! Opcodes 3F68 - 3F6F
NF68:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2524
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2524:
jmp @r4
mov #0x1C,r2
! Opcodes 3F70 - 3F77
NF70:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl2525
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2525:
jmp @r4
mov #0x1C,r2
! Opcode 3F78
NF78:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2526
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2526:
jmp @r4
mov #0x1C,r2
! Opcode 3F79
NF79:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl2527
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2527:
jmp @r4
mov #0x1C,r2
! Opcode 3F7A
NF7A:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2528
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2528:
jmp @r4
mov #0x1C,r2
! Opcode 3F7B
NF7B:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl2529
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2529:
jmp @r4
mov #0x1C,r2
! Opcode 3F7C
NF7C:
mov.w @r6+,r3
mov.w @r6+,r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2530
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2530:
jmp @r4
mov #0x1C,r2
! Opcodes 3F80 - 3F87
NF80:
and r0,r2
add r13,r2
mov.w @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2531
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2531:
jmp @r4
mov #0x1C,r2
! Opcodes 3F88 - 3F8F
NF88:
and r0,r2
add r14,r2
mov.w @r2,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2532
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2532:
jmp @r4
mov #0x1C,r2
! Opcodes 3F90 - 3F97
NF90:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2533
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2533:
jmp @r4
mov #0x1C,r2
! Opcodes 3F98 - 3F9F
NF98:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2534
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2534:
jmp @r4
mov #0x1C,r2
! Opcodes 3FA0 - 3FA7
NFA0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2535
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2535:
jmp @r4
mov #0x1C,r2
! Opcodes 3FA8 - 3FAF
NFA8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl2536
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2536:
jmp @r4
mov #0x1C,r2
! Opcodes 3FB0 - 3FB7
NFB0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl2537
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2537:
jmp @r4
mov #0x1C,r2
! Opcode 3FB8
NFB8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl2538
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2538:
jmp @r4
mov #0x1C,r2
! Opcode 3FB9
NFB9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl2539
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2539:
jmp @r4
mov #0x1C,r2
! Opcode 3FBA
NFBA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl2540
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2540:
jmp @r4
mov #0x1C,r2
! Opcode 3FBB
NFBB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl2541
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2541:
jmp @r4
mov #0x1C,r2
! Opcode 3FBC
NFBC:
mov.w @r6+,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
mov.l @(60,r13),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
rotl r3
movt r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2542
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2542:
jmp @r4
mov #0x1C,r2
! Opcodes 4000 - 4007
O000:
and r0,r2
mov.l r3,@-r15
add r13,r2
mov.b @r2,r3
mov #24,r0
shld r0,r3
mov r3,r1
shlr r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov #-24,r0
shad r0,r3
mov.b r3,@r2
mov.l @r15+,r2
rotl r3
addc r8,r8
or r2,r3
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl2543
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2543:
jmp @r4
mov #0x1C,r2
! Opcodes 4010 - 4017
O010:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
shld r0,r3
mov r3,r1
shlr r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r2
rotl r3
addc r8,r8
or r2,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2544
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2544:
jmp @r4
mov #0x1C,r2
! Opcodes 4018 - 401F
O018:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
shld r0,r3
mov r3,r1
shlr r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r2
rotl r3
addc r8,r8
or r2,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2545
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2545:
jmp @r4
mov #0x1C,r2
! Opcodes 4020 - 4027
O020:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
shld r0,r3
mov r3,r1
shlr r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r2
rotl r3
addc r8,r8
or r2,r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2546
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2546:
jmp @r4
mov #0x1C,r2
! Opcodes 4028 - 402F
O028:
and r0,r2
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
shld r0,r3
mov r3,r1
shlr r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r2
rotl r3
addc r8,r8
or r2,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2547
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2547:
jmp @r4
mov #0x1C,r2
! Opcodes 4030 - 4037
O030:
and r0,r2
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
shld r0,r3
mov r3,r1
shlr r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r2
rotl r3
addc r8,r8
or r2,r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2548
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2548:
jmp @r4
mov #0x1C,r2
! Opcode 4038
O038:
mov.l r3,@-r15
mov.w @r6+,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
shld r0,r3
mov r3,r1
shlr r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r2
rotl r3
addc r8,r8
or r2,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2549
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2549:
jmp @r4
mov #0x1C,r2
! Opcode 4039
O039:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #24,r0
shld r0,r3
mov r3,r1
shlr r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov #-24,r0
shad r0,r3
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r2
rotl r3
addc r8,r8
or r2,r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2550
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2550:
jmp @r4
mov #0x1C,r2
! Opcodes 4040 - 4047
O040:
and r0,r2
mov.l r3,@-r15
add r13,r2
mov.w @r2,r3
shll16 r3
mov r3,r1
shlr r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov #-16,r0
shad r0,r3
mov.w r3,@r2
mov.l @r15+,r2
rotl r3
addc r8,r8
or r2,r3
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl2551
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2551:
jmp @r4
mov #0x1C,r2
! Opcodes 4050 - 4057
O050:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
shll16 r3
mov r3,r1
shlr r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r2
rotl r3
addc r8,r8
or r2,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2552
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2552:
jmp @r4
mov #0x1C,r2
! Opcodes 4058 - 405F
O058:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
shll16 r3
mov r3,r1
shlr r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r2
rotl r3
addc r8,r8
or r2,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2553
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2553:
jmp @r4
mov #0x1C,r2
! Opcodes 4060 - 4067
O060:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
shll16 r3
mov r3,r1
shlr r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r2
rotl r3
addc r8,r8
or r2,r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2554
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2554:
jmp @r4
mov #0x1C,r2
! Opcodes 4068 - 406F
O068:
and r0,r2
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
shll16 r3
mov r3,r1
shlr r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r2
rotl r3
addc r8,r8
or r2,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2555
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2555:
jmp @r4
mov #0x1C,r2
! Opcodes 4070 - 4077
O070:
and r0,r2
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
shll16 r3
mov r3,r1
shlr r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r2
rotl r3
addc r8,r8
or r2,r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2556
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2556:
jmp @r4
mov #0x1C,r2
! Opcode 4078
O078:
mov.l r3,@-r15
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
shll16 r3
mov r3,r1
shlr r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r2
rotl r3
addc r8,r8
or r2,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2557
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2557:
jmp @r4
mov #0x1C,r2
! Opcode 4079
O079:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
shll16 r3
mov r3,r1
shlr r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov #-16,r0
shad r0,r3
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r2
rotl r3
addc r8,r8
or r2,r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2558
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2558:
jmp @r4
mov #0x1C,r2
! Opcodes 4080 - 4087
O080:
and r0,r2
mov.l r3,@-r15
add r13,r2
mov.l @r2,r3
mov r3,r1
shlr r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov.l r3,@r2
mov.l @r15+,r2
rotl r3
addc r8,r8
or r2,r3
mov.w @r6+,r0
add #-6,r7
shll2 r0
cmp/pl r7
bt/s fdl2559
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2559:
jmp @r4
mov #0x1C,r2
! Opcodes 4090 - 4097
O090:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r1
shlr r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r2
rotl r3
addc r8,r8
or r2,r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2560
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2560:
jmp @r4
mov #0x1C,r2
! Opcodes 4098 - 409F
O098:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r1
shlr r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r2
rotl r3
addc r8,r8
or r2,r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2561
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2561:
jmp @r4
mov #0x1C,r2
! Opcodes 40A0 - 40A7
O0A0:
and r0,r2
mov.l r3,@-r15
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r1
shlr r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r2
rotl r3
addc r8,r8
or r2,r3
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl2562
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2562:
jmp @r4
mov #0x1C,r2
! Opcodes 40A8 - 40AF
O0A8:
and r0,r2
mov.l r3,@-r15
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r1
shlr r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r2
rotl r3
addc r8,r8
or r2,r3
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl2563
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2563:
jmp @r4
mov #0x1C,r2
! Opcodes 40B0 - 40B7
O0B0:
and r0,r2
mov.l r3,@-r15
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r1
shlr r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r2
rotl r3
addc r8,r8
or r2,r3
mov.w @r6+,r0
add #-26,r7
shll2 r0
cmp/pl r7
bt/s fdl2564
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2564:
jmp @r4
mov #0x1C,r2
! Opcode 40B8
O0B8:
mov.l r3,@-r15
mov.w @r6+,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r1
shlr r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r2
rotl r3
addc r8,r8
or r2,r3
mov.w @r6+,r0
add #-24,r7
shll2 r0
cmp/pl r7
bt/s fdl2565
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2565:
jmp @r4
mov #0x1C,r2
! Opcode 40B9
O0B9:
mov.l r3,@-r15
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r1
shlr r9
movt r8
negc r3,r3
movt r9
mov #0,r0
subv r8,r0
movt r3
subv r1,r0
movt r8
or r3,r8
cmp/pl r9
addc r8,r8
mov r0,r3
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r2
rotl r3
addc r8,r8
or r2,r3
mov.w @r6+,r0
add #-28,r7
shll2 r0
cmp/pl r7
bt/s fdl2566
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2566:
jmp @r4
mov #0x1C,r2
! Opcodes 40C0 - 40C7
O0C0:
and r0,r2
mov.l r3,@-r15
mov r8,r0
mov r9,r1
shlr r0
addc r1,r1
tst r3,r3
addc r1,r1
and #3,r0
mov r1,r3
shll2 r3
or r0,r3
mov r10,r0
shll8 r0
or r0,r3
mov r2,r0
mov.w r3,@(r0,r13)
mov.l @r15+,r3
mov.w @r6+,r0
add #-6,r7
shll2 r0
cmp/pl r7
bt/s fdl2567
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2567:
jmp @r4
mov #0x1C,r2
! Opcodes 40D0 - 40D7
O0D0:
and r0,r2
mov.l r3,@-r15
mov r8,r0
mov r9,r1
shlr r0
addc r1,r1
tst r3,r3
addc r1,r1
and #3,r0
mov r1,r3
shll2 r3
or r0,r3
mov r10,r0
shll8 r0
or r0,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2568
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2568:
jmp @r4
mov #0x1C,r2
! Opcodes 40D8 - 40DF
O0D8:
and r0,r2
mov.l r3,@-r15
mov r8,r0
mov r9,r1
shlr r0
addc r1,r1
tst r3,r3
addc r1,r1
and #3,r0
mov r1,r3
shll2 r3
or r0,r3
mov r10,r0
shll8 r0
or r0,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r3
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2569
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2569:
jmp @r4
mov #0x1C,r2
! Opcodes 40E0 - 40E7
O0E0:
and r0,r2
mov.l r3,@-r15
mov r8,r0
mov r9,r1
shlr r0
addc r1,r1
tst r3,r3
addc r1,r1
and #3,r0
mov r1,r3
shll2 r3
or r0,r3
mov r10,r0
shll8 r0
or r0,r3
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.l @r15+,r3
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2570
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2570:
jmp @r4
mov #0x1C,r2
! Opcodes 40E8 - 40EF
O0E8:
and r0,r2
mov.l r3,@-r15
mov r8,r0
mov r9,r1
shlr r0
addc r1,r1
tst r3,r3
addc r1,r1
and #3,r0
mov r1,r3
shll2 r3
or r0,r3
mov r10,r0
shll8 r0
or r0,r3
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2571
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2571:
jmp @r4
mov #0x1C,r2
! Opcodes 40F0 - 40F7
O0F0:
and r0,r2
mov.l r3,@-r15
mov r8,r0
mov r9,r1
shlr r0
addc r1,r1
tst r3,r3
addc r1,r1
and #3,r0
mov r1,r3
shll2 r3
or r0,r3
mov r10,r0
shll8 r0
or r0,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2572
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2572:
jmp @r4
mov #0x1C,r2
! Opcode 40F8
O0F8:
mov.l r3,@-r15
mov r8,r0
mov r9,r1
shlr r0
addc r1,r1
tst r3,r3
addc r1,r1
and #3,r0
mov r1,r3
shll2 r3
or r0,r3
mov r10,r0
shll8 r0
or r0,r3
mov.w @r6+,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2573
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2573:
jmp @r4
mov #0x1C,r2
! Opcode 40F9
O0F9:
mov.l r3,@-r15
mov r8,r0
mov r9,r1
shlr r0
addc r1,r1
tst r3,r3
addc r1,r1
and #3,r0
mov r1,r3
shll2 r3
or r0,r3
mov r10,r0
shll8 r0
or r0,r3
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.l @r15+,r3
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2574
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2574:
jmp @r4
mov #0x1C,r2
! Opcodes 4180 - 4187
O180:
and r0,r2
mov r2,r0
mov.w @(r0,r13),r3
mov.w @r13,r1
extu.w r1,r1
cmp/pz r1
bf setn2575
mov #0,r8
cmp/hi r3,r1
bt ln2575
mov.w @r6+,r0
add #-10,r7
shll2 r0
cmp/pl r7
bt/s fdl2576
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2576:
jmp @r4
mov #0x1C,r2
.align 5
setn2575:
mov #1,r8
ln2575:
mov.l r1,@-r15
mov.l g2_except_ptr2575,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr2575,r0
jsr @r0
nop
add r5,r6
mov.w @r6+,r0
add #-50,r7
shll2 r0
cmp/pl r7
bt/s fdl2577
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2577:
jmp @r4
mov #0x1C,r2
.align 2
g2_except_ptr2575: .long group_2_exception
bf_addr2575: .long basefunction
! Opcodes 4190 - 4197
O190:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r13,r1
extu.w r1,r1
cmp/pz r1
bf setn2578
mov #0,r8
cmp/hi r3,r1
bt ln2578
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2579
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2579:
jmp @r4
mov #0x1C,r2
.align 5
setn2578:
mov #1,r8
ln2578:
mov.l r1,@-r15
mov.l g2_except_ptr2578,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr2578,r0
jsr @r0
nop
add r5,r6
mov.w @r6+,r0
add #-54,r7
shll2 r0
cmp/pl r7
bt/s fdl2580
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2580:
jmp @r4
mov #0x1C,r2
.align 2
g2_except_ptr2578: .long group_2_exception
bf_addr2578: .long basefunction
! Opcodes 4198 - 419F
O198:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r13,r1
extu.w r1,r1
cmp/pz r1
bf setn2581
mov #0,r8
cmp/hi r3,r1
bt ln2581
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2582
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2582:
jmp @r4
mov #0x1C,r2
.align 5
setn2581:
mov #1,r8
ln2581:
mov.l r1,@-r15
mov.l g2_except_ptr2581,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr2581,r0
jsr @r0
nop
add r5,r6
mov.w @r6+,r0
add #-54,r7
shll2 r0
cmp/pl r7
bt/s fdl2583
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2583:
jmp @r4
mov #0x1C,r2
.align 2
g2_except_ptr2581: .long group_2_exception
bf_addr2581: .long basefunction
! Opcodes 41A0 - 41A7
O1A0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov.w @r13,r1
extu.w r1,r1
cmp/pz r1
bf setn2584
mov #0,r8
cmp/hi r3,r1
bt ln2584
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2585
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2585:
jmp @r4
mov #0x1C,r2
.align 5
setn2584:
mov #1,r8
ln2584:
mov.l r1,@-r15
mov.l g2_except_ptr2584,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr2584,r0
jsr @r0
nop
add r5,r6
mov.w @r6+,r0
add #-56,r7
shll2 r0
cmp/pl r7
bt/s fdl2586
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2586:
jmp @r4
mov #0x1C,r2
.align 2
g2_except_ptr2584: .long group_2_exception
bf_addr2584: .long basefunction
! Opcodes 41A8 - 41AF
O1A8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r13,r1
extu.w r1,r1
cmp/pz r1
bf setn2587
mov #0,r8
cmp/hi r3,r1
bt ln2587
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2588
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2588:
jmp @r4
mov #0x1C,r2
.align 5
setn2587:
mov #1,r8
ln2587:
mov.l r1,@-r15
mov.l g2_except_ptr2587,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr2587,r0
jsr @r0
nop
add r5,r6
mov.w @r6+,r0
add #-58,r7
shll2 r0
cmp/pl r7
bt/s fdl2589
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2589:
jmp @r4
mov #0x1C,r2
.align 2
g2_except_ptr2587: .long group_2_exception
bf_addr2587: .long basefunction
! Opcodes 41B0 - 41B7
O1B0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r13,r1
extu.w r1,r1
cmp/pz r1
bf setn2590
mov #0,r8
cmp/hi r3,r1
bt ln2590
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2591
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2591:
jmp @r4
mov #0x1C,r2
.align 5
setn2590:
mov #1,r8
ln2590:
mov.l r1,@-r15
mov.l g2_except_ptr2590,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr2590,r0
jsr @r0
nop
add r5,r6
mov.w @r6+,r0
add #-60,r7
shll2 r0
cmp/pl r7
bt/s fdl2592
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2592:
jmp @r4
mov #0x1C,r2
.align 2
g2_except_ptr2590: .long group_2_exception
bf_addr2590: .long basefunction
! Opcode 41B8
O1B8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r13,r1
extu.w r1,r1
cmp/pz r1
bf setn2593
mov #0,r8
cmp/hi r3,r1
bt ln2593
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2594
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2594:
jmp @r4
mov #0x1C,r2
.align 5
setn2593:
mov #1,r8
ln2593:
mov.l r1,@-r15
mov.l g2_except_ptr2593,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr2593,r0
jsr @r0
nop
add r5,r6
mov.w @r6+,r0
add #-58,r7
shll2 r0
cmp/pl r7
bt/s fdl2595
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2595:
jmp @r4
mov #0x1C,r2
.align 2
g2_except_ptr2593: .long group_2_exception
bf_addr2593: .long basefunction
! Opcode 41B9
O1B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r13,r1
extu.w r1,r1
cmp/pz r1
bf setn2596
mov #0,r8
cmp/hi r3,r1
bt ln2596
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl2597
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2597:
jmp @r4
mov #0x1C,r2
.align 5
setn2596:
mov #1,r8
ln2596:
mov.l r1,@-r15
mov.l g2_except_ptr2596,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr2596,r0
jsr @r0
nop
add r5,r6
mov.w @r6+,r0
add #-62,r7
shll2 r0
cmp/pl r7
bt/s fdl2598
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2598:
jmp @r4
mov #0x1C,r2
.align 2
g2_except_ptr2596: .long group_2_exception
bf_addr2596: .long basefunction
! Opcode 41BA
O1BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r13,r1
extu.w r1,r1
cmp/pz r1
bf setn2599
mov #0,r8
cmp/hi r3,r1
bt ln2599
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2600
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2600:
jmp @r4
mov #0x1C,r2
.align 5
setn2599:
mov #1,r8
ln2599:
mov.l r1,@-r15
mov.l g2_except_ptr2599,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr2599,r0
jsr @r0
nop
add r5,r6
mov.w @r6+,r0
add #-58,r7
shll2 r0
cmp/pl r7
bt/s fdl2601
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2601:
jmp @r4
mov #0x1C,r2
.align 2
g2_except_ptr2599: .long group_2_exception
bf_addr2599: .long basefunction
! Opcode 41BB
O1BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov.w @r13,r1
extu.w r1,r1
cmp/pz r1
bf setn2602
mov #0,r8
cmp/hi r3,r1
bt ln2602
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2603
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2603:
jmp @r4
mov #0x1C,r2
.align 5
setn2602:
mov #1,r8
ln2602:
mov.l r1,@-r15
mov.l g2_except_ptr2602,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr2602,r0
jsr @r0
nop
add r5,r6
mov.w @r6+,r0
add #-60,r7
shll2 r0
cmp/pl r7
bt/s fdl2604
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2604:
jmp @r4
mov #0x1C,r2
.align 2
g2_except_ptr2602: .long group_2_exception
bf_addr2602: .long basefunction
! Opcode 41BC
O1BC:
mov.w @r6+,r3
mov.w @r13,r1
extu.w r1,r1
cmp/pz r1
bf setn2605
mov #0,r8
cmp/hi r3,r1
bt ln2605
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2606
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2606:
jmp @r4
mov #0x1C,r2
.align 5
setn2605:
mov #1,r8
ln2605:
mov.l r1,@-r15
mov.l g2_except_ptr2605,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr2605,r0
jsr @r0
nop
add r5,r6
mov.w @r6+,r0
add #-54,r7
shll2 r0
cmp/pl r7
bt/s fdl2607
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2607:
jmp @r4
mov #0x1C,r2
.align 2
g2_except_ptr2605: .long group_2_exception
bf_addr2605: .long basefunction
! Opcodes 41D0 - 41D7
O1D0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l r4,@(32,r13)
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl2608
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2608:
jmp @r4
mov #0x1C,r2
! Opcodes 41E8 - 41EF
O1E8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l r4,@(32,r13)
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2609
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2609:
jmp @r4
mov #0x1C,r2
! Opcodes 41F0 - 41F7
O1F0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l r4,@(32,r13)
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2610
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2610:
jmp @r4
mov #0x1C,r2
! Opcode 41F8
O1F8:
mov.w @r6+,r4
mov.l r4,@(32,r13)
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2611
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2611:
jmp @r4
mov #0x1C,r2
! Opcode 41F9
O1F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l r4,@(32,r13)
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2612
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2612:
jmp @r4
mov #0x1C,r2
! Opcode 41FA
O1FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l r4,@(32,r13)
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2613
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2613:
jmp @r4
mov #0x1C,r2
! Opcode 41FB
O1FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l r4,@(32,r13)
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2614
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2614:
jmp @r4
mov #0x1C,r2
! Opcodes 4200 - 4207
O200:
and r0,r2
mov #0,r3
mov r2,r0
mov.b r3,@(r0,r13)
mov r3,r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl2615
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2615:
jmp @r4
mov #0x1C,r2
! Opcodes 4210 - 4217
O210:
and r0,r2
mov #0,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2616
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2616:
jmp @r4
mov #0x1C,r2
! Opcodes 4218 - 421F
O218:
and r0,r2
mov #0,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #28,r0
cmp/eq r0,r2
mov #1,r0
addc r0,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov r3,r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2617
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2617:
jmp @r4
mov #0x1C,r2
! Opcodes 4220 - 4227
O220:
and r0,r2
mov #0,r3
mov r2,r0
mov.l @(r0,r14),r4
mov #28,r0
cmp/eq r0,r2
mov #1,r0
subc r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov r3,r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2618
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2618:
jmp @r4
mov #0x1C,r2
! Opcodes 4228 - 422F
O228:
and r0,r2
mov #0,r3
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2619
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2619:
jmp @r4
mov #0x1C,r2
! Opcodes 4230 - 4237
O230:
and r0,r2
mov #0,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2620
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2620:
jmp @r4
mov #0x1C,r2
! Opcode 4238
O238:
mov #0,r3
mov.w @r6+,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2621
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2621:
jmp @r4
mov #0x1C,r2
! Opcode 4239
O239:
mov #0,r3
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wb_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2622
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2622:
jmp @r4
mov #0x1C,r2
! Opcodes 4240 - 4247
O240:
and r0,r2
mov #0,r3
mov r2,r0
mov.w r3,@(r0,r13)
mov r3,r8
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl2623
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2623:
jmp @r4
mov #0x1C,r2
! Opcodes 4250 - 4257
O250:
and r0,r2
mov #0,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2624
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2624:
jmp @r4
mov #0x1C,r2
! Opcodes 4258 - 425F
O258:
and r0,r2
mov #0,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov r3,r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2625
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2625:
jmp @r4
mov #0x1C,r2
! Opcodes 4260 - 4267
O260:
and r0,r2
mov #0,r3
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov r3,r8
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2626
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2626:
jmp @r4
mov #0x1C,r2
! Opcodes 4268 - 426F
O268:
and r0,r2
mov #0,r3
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2627
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2627:
jmp @r4
mov #0x1C,r2
! Opcodes 4270 - 4277
O270:
and r0,r2
mov #0,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r8
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2628
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2628:
jmp @r4
mov #0x1C,r2
! Opcode 4278
O278:
mov #0,r3
mov.w @r6+,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r8
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2629
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2629:
jmp @r4
mov #0x1C,r2
! Opcode 4279
O279:
mov #0,r3
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(ww_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r8
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2630
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2630:
jmp @r4
mov #0x1C,r2
! Opcodes 4280 - 4287
O280:
and r0,r2
mov #0,r3
mov r2,r0
mov.l r3,@(r0,r13)
mov r3,r8
mov.w @r6+,r0
add #-6,r7
shll2 r0
cmp/pl r7
bt/s fdl2631
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2631:
jmp @r4
mov #0x1C,r2
! Opcodes 4290 - 4297
O290:
and r0,r2
mov #0,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2632
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2632:
jmp @r4
mov #0x1C,r2
! Opcodes 4298 - 429F
O298:
and r0,r2
mov #0,r3
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
add #4,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov r3,r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2633
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2633:
jmp @r4
mov #0x1C,r2
! Opcodes 42A0 - 42A7
O2A0:
and r0,r2
mov #0,r3
mov r2,r0
mov.l @(r0,r14),r4
add #-4,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov r3,r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2634
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2634:
jmp @r4
mov #0x1C,r2
! Opcodes 42A8 - 42AF
O2A8:
and r0,r2
mov #0,r3
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2635
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2635:
jmp @r4
mov #0x1C,r2
! Opcodes 42B0 - 42B7
O2B0:
and r0,r2
mov #0,r3
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2636
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2636:
jmp @r4
mov #0x1C,r2
! Opcode 42B8
O2B8:
mov #0,r3
mov.w @r6+,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2637
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2637:
jmp @r4
mov #0x1C,r2
! Opcode 42B9
O2B9:
mov #0,r3
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(wl_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r3,r8
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2638
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2638:
jmp @r4
mov #0x1C,r2
! Opcodes 4380 - 4387
O380:
and r0,r2
mov r2,r0
mov.w @(r0,r13),r3
mov #4,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn2639
mov #0,r8
cmp/hi r3,r1
bt ln2639
mov.w @r6+,r0
add #-10,r7
shll2 r0
cmp/pl r7
bt/s fdl2640
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2640:
jmp @r4
mov #0x1C,r2
.align 5
setn2639:
mov #1,r8
ln2639:
mov.l r1,@-r15
mov.l g2_except_ptr2639,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr2639,r0
jsr @r0
nop
add r5,r6
mov.w @r6+,r0
add #-50,r7
shll2 r0
cmp/pl r7
bt/s fdl2641
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2641:
jmp @r4
mov #0x1C,r2
.align 2
g2_except_ptr2639: .long group_2_exception
bf_addr2639: .long basefunction
! Opcodes 4390 - 4397
O390:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn2642
mov #0,r8
cmp/hi r3,r1
bt ln2642
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2643
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2643:
jmp @r4
mov #0x1C,r2
.align 5
setn2642:
mov #1,r8
ln2642:
mov.l r1,@-r15
mov.l g2_except_ptr2642,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr2642,r0
jsr @r0
nop
add r5,r6
mov.w @r6+,r0
add #-54,r7
shll2 r0
cmp/pl r7
bt/s fdl2644
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2644:
jmp @r4
mov #0x1C,r2
.align 2
g2_except_ptr2642: .long group_2_exception
bf_addr2642: .long basefunction
! Opcodes 4398 - 439F
O398:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
add #2,r4
mov r2,r0
mov.l r4,@(r0,r14)
mov #4,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn2645
mov #0,r8
cmp/hi r3,r1
bt ln2645
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2646
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2646:
jmp @r4
mov #0x1C,r2
.align 5
setn2645:
mov #1,r8
ln2645:
mov.l r1,@-r15
mov.l g2_except_ptr2645,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr2645,r0
jsr @r0
nop
add r5,r6
mov.w @r6+,r0
add #-54,r7
shll2 r0
cmp/pl r7
bt/s fdl2647
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2647:
jmp @r4
mov #0x1C,r2
.align 2
g2_except_ptr2645: .long group_2_exception
bf_addr2645: .long basefunction
! Opcodes 43A0 - 43A7
O3A0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
add #-2,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov r2,r0
mov.l r4,@(r0,r14)
mov #4,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn2648
mov #0,r8
cmp/hi r3,r1
bt ln2648
mov.w @r6+,r0
add #-16,r7
shll2 r0
cmp/pl r7
bt/s fdl2649
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2649:
jmp @r4
mov #0x1C,r2
.align 5
setn2648:
mov #1,r8
ln2648:
mov.l r1,@-r15
mov.l g2_except_ptr2648,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr2648,r0
jsr @r0
nop
add r5,r6
mov.w @r6+,r0
add #-56,r7
shll2 r0
cmp/pl r7
bt/s fdl2650
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2650:
jmp @r4
mov #0x1C,r2
.align 2
g2_except_ptr2648: .long group_2_exception
bf_addr2648: .long basefunction
! Opcodes 43A8 - 43AF
O3A8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn2651
mov #0,r8
cmp/hi r3,r1
bt ln2651
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2652
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2652:
jmp @r4
mov #0x1C,r2
.align 5
setn2651:
mov #1,r8
ln2651:
mov.l r1,@-r15
mov.l g2_except_ptr2651,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr2651,r0
jsr @r0
nop
add r5,r6
mov.w @r6+,r0
add #-58,r7
shll2 r0
cmp/pl r7
bt/s fdl2653
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2653:
jmp @r4
mov #0x1C,r2
.align 2
g2_except_ptr2651: .long group_2_exception
bf_addr2651: .long basefunction
! Opcodes 43B0 - 43B7
O3B0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn2654
mov #0,r8
cmp/hi r3,r1
bt ln2654
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2655
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2655:
jmp @r4
mov #0x1C,r2
.align 5
setn2654:
mov #1,r8
ln2654:
mov.l r1,@-r15
mov.l g2_except_ptr2654,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr2654,r0
jsr @r0
nop
add r5,r6
mov.w @r6+,r0
add #-60,r7
shll2 r0
cmp/pl r7
bt/s fdl2656
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2656:
jmp @r4
mov #0x1C,r2
.align 2
g2_except_ptr2654: .long group_2_exception
bf_addr2654: .long basefunction
! Opcode 43B8
O3B8:
mov.w @r6+,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn2657
mov #0,r8
cmp/hi r3,r1
bt ln2657
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2658
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2658:
jmp @r4
mov #0x1C,r2
.align 5
setn2657:
mov #1,r8
ln2657:
mov.l r1,@-r15
mov.l g2_except_ptr2657,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr2657,r0
jsr @r0
nop
add r5,r6
mov.w @r6+,r0
add #-58,r7
shll2 r0
cmp/pl r7
bt/s fdl2659
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2659:
jmp @r4
mov #0x1C,r2
.align 2
g2_except_ptr2657: .long group_2_exception
bf_addr2657: .long basefunction
! Opcode 43B9
O3B9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn2660
mov #0,r8
cmp/hi r3,r1
bt ln2660
mov.w @r6+,r0
add #-22,r7
shll2 r0
cmp/pl r7
bt/s fdl2661
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2661:
jmp @r4
mov #0x1C,r2
.align 5
setn2660:
mov #1,r8
ln2660:
mov.l r1,@-r15
mov.l g2_except_ptr2660,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr2660,r0
jsr @r0
nop
add r5,r6
mov.w @r6+,r0
add #-62,r7
shll2 r0
cmp/pl r7
bt/s fdl2662
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2662:
jmp @r4
mov #0x1C,r2
.align 2
g2_except_ptr2660: .long group_2_exception
bf_addr2660: .long basefunction
! Opcode 43BA
O3BA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn2663
mov #0,r8
cmp/hi r3,r1
bt ln2663
mov.w @r6+,r0
add #-18,r7
shll2 r0
cmp/pl r7
bt/s fdl2664
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2664:
jmp @r4
mov #0x1C,r2
.align 5
setn2663:
mov #1,r8
ln2663:
mov.l r1,@-r15
mov.l g2_except_ptr2663,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr2663,r0
jsr @r0
nop
add r5,r6
mov.w @r6+,r0
add #-58,r7
shll2 r0
cmp/pl r7
bt/s fdl2665
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2665:
jmp @r4
mov #0x1C,r2
.align 2
g2_except_ptr2663: .long group_2_exception
bf_addr2663: .long basefunction
! Opcode 43BB
O3BB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l @(rw_addr-fetch_idx,r11),r0
jsr @r0
nop
mov #4,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn2666
mov #0,r8
cmp/hi r3,r1
bt ln2666
mov.w @r6+,r0
add #-20,r7
shll2 r0
cmp/pl r7
bt/s fdl2667
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2667:
jmp @r4
mov #0x1C,r2
.align 5
setn2666:
mov #1,r8
ln2666:
mov.l r1,@-r15
mov.l g2_except_ptr2666,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr2666,r0
jsr @r0
nop
add r5,r6
mov.w @r6+,r0
add #-60,r7
shll2 r0
cmp/pl r7
bt/s fdl2668
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2668:
jmp @r4
mov #0x1C,r2
.align 2
g2_except_ptr2666: .long group_2_exception
bf_addr2666: .long basefunction
! Opcode 43BC
O3BC:
mov.w @r6+,r3
mov #4,r0
mov.w @(r0,r13),r1
extu.w r1,r1
cmp/pz r1
bf setn2669
mov #0,r8
cmp/hi r3,r1
bt ln2669
mov.w @r6+,r0
add #-14,r7
shll2 r0
cmp/pl r7
bt/s fdl2670
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2670:
jmp @r4
mov #0x1C,r2
.align 5
setn2669:
mov #1,r8
ln2669:
mov.l r1,@-r15
mov.l g2_except_ptr2669,r0
jsr @r0
mov #0x18,r4
mov.l @r15+,r3
mov.l bf_addr2669,r0
jsr @r0
nop
add r5,r6
mov.w @r6+,r0
add #-54,r7
shll2 r0
cmp/pl r7
bt/s fdl2671
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2671:
jmp @r4
mov #0x1C,r2
.align 2
g2_except_ptr2669: .long group_2_exception
bf_addr2669: .long basefunction
! Opcodes 43D0 - 43D7
O3D0:
and r0,r2
mov r2,r0
mov.l @(r0,r14),r4
mov.l r4,@(36,r13)
mov.w @r6+,r0
add #-4,r7
shll2 r0
cmp/pl r7
bt/s fdl2672
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2672:
jmp @r4
mov #0x1C,r2
! Opcodes 43E8 - 43EF
O3E8:
and r0,r2
mov.w @r6+,r4
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l r4,@(36,r13)
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2673
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2673:
jmp @r4
mov #0x1C,r2
! Opcodes 43F0 - 43F7
O3F0:
and r0,r2
mov.l @(decode_extw_addr-fetch_idx,r11),r4
jsr @r4
nop
mov r2,r0
mov.l @(r0,r14),r1
add r1,r4
mov.l r4,@(36,r13)
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2674
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2674:
jmp @r4
mov #0x1C,r2
! Opcode 43F8
O3F8:
mov.w @r6+,r4
mov.l r4,@(36,r13)
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2675
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2675:
jmp @r4
mov #0x1C,r2
! Opcode 43F9
O3F9:
mov.w @r6+,r0
mov.w @r6+,r4
shll16 r4
xtrct r0,r4
mov.l r4,@(36,r13)
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2676
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2676:
jmp @r4
mov #0x1C,r2
! Opcode 43FA
O3FA:
mov r6,r0
mov.w @r6+,r4
sub r5,r0
add r0,r4
mov.l r4,@(36,r13)
mov.w @r6+,r0
add #-8,r7
shll2 r0
cmp/pl r7
bt/s fdl2677
mov.l @(r0,r12),r4
mov.l @(execexit_addr-areg,r14),r4
fdl2677:
jmp @r4
mov #0x1C,r2
! Opcode 43FB
O3FB:
mov.l @(decode_extw_addr-fetch_idx,r11),r4
mov r6,r1
jsr @r4
sub r5,r1
add r1,r4
mov.l r4,@(36,r13)
mov.w @r6+,r0
add #-12,r7
shll2 r0
cmp/pl r7
bt/s fdl2678