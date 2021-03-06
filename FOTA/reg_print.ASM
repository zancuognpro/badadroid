 ;
 ; This file is part of Badadroid project.
 ;
 ; Copyright (C) 2012 Rebellos, mijoma, b_kubica
 ;
 ;
 ; Badadroid is free software: you can redistribute it and/or modify
 ; it under the terms of the GNU General Public License as published by
 ; the Free Software Foundation, either version 3 of the License, or
 ; (at your option) any later version.
 ;
 ; Badadroid is distributed in the hope that it will be useful,
 ; but WITHOUT ANY WARRANTY; without even the implied warranty of
 ; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 ; GNU General Public License for more details.
 ;
 ; You should have received a copy of the GNU General Public License
 ; along with Badadroid.  If not, see <http://www.gnu.org/licenses/>.
 ;
 ;
 
include 'inc/settings.inc'              ; user dependend settings

;simple printing some useful infoz
START
	SUB	SP, SP, #16

	bl	enable_output

	MOV	R0, 12345
	BL	int_debugprint

	ADD	R1, SP, 8
	ADD	R0, SP, 4
	BL	__GetNvPos
	LDR	R0, [SP,4]
	BL	hex_debugprint
	LDR	R0, [SP,8]
	BL	hex_debugprint
		BL dloadmode
BL     DRV_Modem_BootingStart
LDR	R0, [semaphore]
MOV	R1, #0
STR	R1, [R0]
LDR	R0, [mailboxba]
LDR	R1, [amss_run_req]
STR	R1, [R0]

get_sem:
;BL      Get_Onedram_Semaphore
CMP	R0, #0
;BEQ     get_sem

LDR	R9, [mailboxab]
LDR	R0, [R9]
BL	hex_debugprint
;BL      Onedram_Release_Semaphore
b	 get_sem
	BL dloadmode
	mailboxba dw 0x25FFF840
	mailboxab dw 0x25FFF820
	semaphore dw 0x25FFF000
	amss_run_req dw 0x89EF89EF


	LDR	R0, [_hwrev]
	LDRB	R0, [R0]
	BL	hex_debugprint
;        LDR     R0, [_gLCDType]
	LDR	R0, [R0]
	BL	hex_debugprint
	MOV	R0, 12345
	BL	int_debugprint

	LDR	R1, [DWORD_LOOP_BEGIN]
	LDR	R2, [DWORD_LOOP_END]
loopek3:
	CMP	R1, R2
	BGT	end_print3
	LDR	R0, [R1], 4
	;BL      hex_debugprint
	B	loopek3
end_print3:


	LDR	R0, [TZIC0FIQEnable]
	LDR	R0, [R0]
	BL	hex_debugprint

	LDR	R0, [TZIC1FIQEnable]
	LDR	R0, [R0]
	BL	hex_debugprint

	LDR	R0, [TZIC2FIQEnable]
	LDR	R0, [R0]
	BL	hex_debugprint

	LDR	R0, [TZIC3FIQEnable]
	LDR	R0, [R0]
	BL	hex_debugprint


	LDR	R0, [SYSCON_NORMAL_CFG]
	LDR	R1, [R0]
	BIC	R1, R1, 0x3E ;turn off everything
	STR	R1, [R0]

	LDR	R0, [SYSCON_NORMAL_CFG]
	MOV	R1, 0xFFFFFFFF
	STR	R1, [R0]


	LDR	R0, [TZIC2FIQEnable]
	LDR	R0, [R0]
	BL	hex_debugprint

	LDR	R0, [TZIC3FIQEnable]
	LDR	R0, [R0]
	BL	hex_debugprint
	BL	dloadmode

       ; BL      boot_hw_power_down

FUNCTIONS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;; variables below
DEFAULT_VARIABLES
    pagetable		dw gMMUL1PageTable
    _hwrev		dw hwrev
    const_0x186A0	dw 0x186A0
    dump_what		dw 0xE010C010
    watchdog		dw 0xE2700000
    rst_status		dw 0xE010A000
    USBSW_I2C_CH_adr	dw USBSW_I2C_CH
    GPIO_FIRST_MASK	dw 0xE0200900
    GPIO_LAST_MASK	dw 0xE0200954
    EXT_FIRST_MASK	dw 0xE0200F00
    EXT_LAST_MASK	dw 0xE0200F0C
    DWORD_LOOP_BEGIN	dw 0xE0200E00
    DWORD_LOOP_END	dw 0xE0200E0C
    SYSCON_NORMAL_CFG	dw 0xE010C010

    TZIC0FIQEnable	dw 0xB0601024;0xF2800004;0xF2000F00
    TZIC1FIQEnable	dw 0xB0601028;0xF2900004;0xF2100F00
    TZIC2FIQEnable	dw 0xF8000130;0xF2200f00
    TZIC3FIQEnable	dw 0xF8000134;0xF2300f00



;;;;;;;;;;;;;;;;;;;;;;;;;;;;; add custom strings addresses below (for using by LDR op)

DEFAULT_STRINGS
;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;add custom strings below
    
END
