	PRESERVE8
	THUMB   
		

; ====================== zone de r?servation de donn?es,  ======================================
;Section RAM (read only) :
; doit ?tre mis dans la RAM, allocation m?moire en lecture seule
	area    mesdata,data,readonly


;Section RAM (read write):
;doit ?tre mis dans la RAM, allocation m?moire en lecture/?criture
	area    maram,data,readwrite
		
VarTime	dcd 0
	EXPORT VarTime

	
; ===============================================================================================
	
;constantes (?quivalent du #define en C)
TimeValue	equ 900000


	EXPORT Delay_100ms ; la fonction Delay_100ms est rendue publique donc utilisable par d'autres modules.

		
;Section ROM code (read only) :
;ce qui suit doit ?tre mis dans la ROM
	area    moncode,code,readonly
		


; REMARQUE IMPORTANTE 
; Cette mani?re de cr?er une temporisation n'est clairement pas la bonne mani?re de proc?der :
; - elle est peu pr?cise
; - la fonction prend tout le temps CPU pour... ne rien faire...
;
; Pour autant, la fonction montre :
; - les boucles en ASM
; - l'acc?s ?cr/lec de variable en RAM
; - le m?canisme d'appel / retour sous programme
;
; et donc poss?de un int?r?t pour d?buter en ASM pur

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