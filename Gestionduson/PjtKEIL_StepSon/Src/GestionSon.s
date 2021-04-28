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

	
callbackson proc
	push{R4-R5}
	
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
	strh R3, [R0]
	add R5,#1 ;Index++
	strh R5,[R2]
	
	b FinSi
	
; If Index >=LongueurSon
FinSi
	pop{R4-R5}
	bx lr
	endp
		
	END	