	PRESERVE8
	THUMB   
		

; ====================== zone de réservation de données,  ======================================
;Section RAM (read only) :
; doit être mis dans la RAM, allocation mémoire en lecture seule
	area    mesdata,data,readonly


;Section RAM (read write):
;doit être mis dans la RAM, allocation mémoire en lecture/écriture
	area    maram,data,readwrite
		
VarTime	dcd 0
	EXPORT VarTime

	
; ===============================================================================================
	
;constantes (équivalent du #define en C)
TimeValue	equ 900000


	EXPORT Delay_100ms ; la fonction Delay_100ms est rendue publique donc utilisable par d'autres modules.

		
;Section ROM code (read only) :
;ce qui suit doit être mis dans la ROM
	area    moncode,code,readonly
		


; REMARQUE IMPORTANTE 
; Cette manière de créer une temporisation n'est clairement pas la bonne manière de procéder :
; - elle est peu précise
; - la fonction prend tout le temps CPU pour... ne rien faire...
;
; Pour autant, la fonction montre :
; - les boucles en ASM
; - l'accés écr/lec de variable en RAM
; - le mécanisme d'appel / retour sous programme
;
; et donc possède un intérêt pour débuter en ASM pur

Delay_100ms proc
	
	    ldr r0,=VarTime  		  ;r0 = VarTime
						  
		ldr r1,=TimeValue		  ;r1 = &TimeValue
		str r1,[r0]				  ;VarTime = TimeValue
		
BoucleTempo	
		ldr r1,[r0]     		  ;r1 = VarTime
						
		subs r1,#1				  
		str  r1,[r0]			  ;VarTime = VarTime-1
		bne	 BoucleTempo		  ; branch if not equel rebranche si VarTime diff de 0
			
		bx lr					  ;return VarTime
		endp
		
		
	END	