	PRESERVE8
	THUMB   
		

; ====================== zone de réservation de données,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly


;Section RAM (read write):
	area    maram,data,readwrite
SortieSon dcw 0
	EXPORT SortieSon
Index dcd 0	

	import Son;
	import LongueurSon;

	
; ===============================================================================================
	EXPORT callbackson


		
;Section ROM code (read only) :		
	area    moncode,code,readonly
; écrire le code ici
	; Import du fichier DriverJeuLaser.inc
	include ./Driver/DriverJeuLaser.inc

	
callbackson proc
	push{lr,R4-R7}
	
	ldr R0,=SortieSon
	ldr R1,=Son
	ldr R2,=Index
	ldrsh R5, [R2]
	ldr R4,=LongueurSon

	cmp R5,R4 
	beq FinSi ;If Index==LongueurSon

;If Index!=LongueurSon
Alors
	ldrsh R3,[R1, R5, LSL #1] ;SortieSon=Son[Index]
	
	mov R6,#32768 
	add R3,R6 ;valeurs comprises entre [0,65535]
	
	mov R7,#92
	udiv R3,R7 ;valeurs comprises entre [0,719]
	
	strh R3, [R0] ;mise à jour valeur SortieSon
	
	add R5,#1 ;Index++
	strh R5,[R2] ;mise à jour valeur Index
	
	mov R0,#360
	bl PWM_Set_Value_TIM3_Ch3 ;appel de la fct PWM_Set_Value_TIM3_Ch3 pour mettre à jour rapport cyclique
	
	b FinSi
	
; If Index >=LongueurSon
FinSi
	pop{lr,R4-R7}
	bx lr
	endp
		
	END	