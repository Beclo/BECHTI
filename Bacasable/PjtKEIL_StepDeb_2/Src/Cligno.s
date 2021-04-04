	PRESERVE8
	THUMB   
		
	
; ====================== zone de réservation de données,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly


;Section RAM (read write):
	area    maram,data,readwrite
FlagCligno dcb 0
	EXPORT FlagCligno

	
; ===============================================================================================
	EXPORT timer_callback


		
;Section ROM code (read only) :		
	area    moncode,code,readonly
; écrire le code ici
	include ./Driver/DriverJeuLaser.inc
	


; char FlagCligno;

;void timer_callback(void)
;{
;	if (FlagCligno==1)
;	{
;		FlagCligno=0;
;		GPIOB_Set(1);
;	}
;	else
;	{
;		FlagCligno=1;
;		GPIOB_Clear(1);
;	}
		
;}

timer_callback proc
	;char FlagCligno;
	push{lr}
;void timer_callback(void)
;{
;	if (FlagCligno==1)
	ldr r1,=FlagCligno
	ldrb r0,[r1]
	cmp r0,#1
	bne Sinon

;	{
;Alors
Alors

	mov r2,#0
	strb r2,[r1]
	mov r0,#1
	bl GPIOB_Set
	b FinSi
;		FlagCligno=0;
;		GPIOB_Set(1);
;	}
;	else
;Sinon
Sinon
	mov r2,#1
	strb r2,[r1]
	mov r0,#1
	bl GPIOB_Clear
;	{
;		FlagCligno=1;
;		GPIOB_Clear(1);
;	}

;FinSi
FinSi
    pop{lr} 
	bx lr
	endp




		
		
	END	