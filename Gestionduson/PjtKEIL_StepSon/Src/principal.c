

#include "DriverJeuLaser.h"

extern void callbackson(void);

int main(void)
{

// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

// Apr�s ex�cution : le coeur CPU est clock� � 72MHz ainsi que tous les timers
CLOCK_Configure();

// configuration du Timer 4 en d�bordement 100ms
	Timer_1234_Init_ff(TIM4, 6552);

// Activation des interruptions issues du Timer 4
// Association de la fonction � ex�cuter lors de l'interruption : timer_callback
// cette fonction (si �crite en ASM) doit �tre conforme � l'AAPCS
	
//** Placez votre code l� ** // 	
	Active_IT_Debordement_Timer(TIM4,2,callbackson);
	
	

//============================================================================	
	
	
while	(1)
	{
	}
}

