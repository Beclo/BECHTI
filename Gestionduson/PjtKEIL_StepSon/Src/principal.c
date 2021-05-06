

#include "DriverJeuLaser.h"

extern void callbackson(void);

int main(void)
{

// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

// Après exécution : le coeur CPU est clocké à 72MHz ainsi que tous les timers
CLOCK_Configure();

// configuration de CallbackSon sur Timer 4 en débordement 100ms
	Timer_1234_Init_ff(TIM4, 6552);
	Active_IT_Debordement_Timer(TIM4,2,callbackson);

// Activation des interruptions issues du Timer 4
// Association de la fonction à exécuter lors de l'interruption : timer_callback
// cette fonction (si écrite en ASM) doit être conforme à l'AAPCS
	
//** Placez votre code là ** // 	
	
//configuration de la PWM Timer 3 canal 3 sur PB.0
	PWM_Init_ff(TIM3,3,720);
	GPIO_Configure(GPIOB,0,OUTPUT,ALT_PPULL);
	
	

//============================================================================	
	
	
while	(1)
	{
	}
}

