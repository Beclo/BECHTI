

#include "DriverJeuLaser.h"

extern int DFT_ModuleAuCarre(short int* Signal64ech, char k);
extern short int LeSignal[];

int resultat[64];
short int dma_buf[64];

void callbacksystick(void){
	Start_DMA1(64);
	Wait_On_End_Of_DMA1();
	Stop_DMA1;
	for(int i=0;i<64;i++){
		resultat[i]=DFT_ModuleAuCarre(dma_buf,i);
	}
}

int main(void)
{

// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

// Après exécution : le coeur CPU est clocké à 72MHz ainsi que tous les timers
CLOCK_Configure();

// Configuration Systick interruption 5ms
Systick_Period_ff(360000);
Systick_Prio_IT(1,callbacksystick);
SysTick_On;
SysTick_Enable_IT;
	
// Configuration mesure, acquisition bloc de 64 valeurs à 320kHz
Init_TimingADC_ActiveADC_ff(ADC1,72);
Single_Channel_ADC(ADC1,2);
Init_Conversion_On_Trig_Timer_ff(ADC1,TIM2_CC2,225);
Init_ADC1_DMA1(0,dma_buf);

	
	

//============================================================================	
//int resultat;
//resultat=DFT_ModuleAuCarre(&LeSignal[0],1);
	
while	(1)
	{
	}
}

