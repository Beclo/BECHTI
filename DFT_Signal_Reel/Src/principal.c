

#include "DriverJeuLaser.h"
#include "GestionSon.h"

extern void callbackson(void);
extern void startson(void);

extern int DFT_ModuleAuCarre(short int* Signal64ech, char k);
extern short int LeSignal[];

int resultat[64];
short int dma_buf[64];

// Tableau des scores
int scores[4]={0};
// Tableau de compteurs
int compteur[4]={0};

void callbacksystick(void){
	Start_DMA1(64);
	Wait_On_End_Of_DMA1();
	Stop_DMA1;
	for(int i=0;i<64;i++){
		resultat[i]=DFT_ModuleAuCarre(dma_buf,i);
	}
	
	//Qui a marqu� ?
	// Joueur 1 - 85kHz
	if (resultat[17]>=0x56a8c){
		compteur[0]+=1;
		if(compteur[0]==20){
			scores[0]+=1;
			compteur[0]=0;
			startson();
		}
	}
	
	// Joueur 2 - 95kHz
	if (resultat[19]>=0x568c){
		compteur[1]+=1;
		if(compteur[1]==20){
			scores[1]+=1;
			compteur[1]=0;
			startson();
		}
	}
	
	// Joueur 3 - 100kHz
	if (resultat[20]>=0x56a8c){
		compteur[2]+=1;
		if(compteur[2]==20){
			scores[2]+=1;
			compteur[2]=0;
			startson();
		}
	}
	
	// Joueur 4 - 115khz
	if (resultat[23]>=0x56a8c){
		compteur[3]+=1;
		if(compteur[3]==20){
			scores[3]+=1;
			compteur[3]=0;
			startson();
		}
	}
}

int main(void)
{

// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

// Apr�s ex�cution : le coeur CPU est clock� � 72MHz ainsi que tous les timers
CLOCK_Configure();

// Configuration Systick interruption 5ms
Systick_Period_ff(360000);
Systick_Prio_IT(1,callbacksystick);
SysTick_On;
SysTick_Enable_IT;
	
// Configuration mesure, acquisition bloc de 64 valeurs � 320kHz
Init_TimingADC_ActiveADC_ff(ADC1,72);
Single_Channel_ADC(ADC1,2);
Init_Conversion_On_Trig_Timer_ff(ADC1,TIM2_CC2,225);
Init_ADC1_DMA1(0,dma_buf);
	
// configuration de CallbackSon sur Timer 4 en d�bordement 100ms
	Timer_1234_Init_ff(TIM4, 6552);
	Active_IT_Debordement_Timer(TIM4,2,callbackson);

// Activation des interruptions issues du Timer 4
// Association de la fonction � ex�cuter lors de l'interruption : timer_callback
// cette fonction (si �crite en ASM) doit �tre conforme � l'AAPCS
	
//configuration de la PWM Timer 3 canal 3 sur PB.0
	PWM_Init_ff(TIM3,3,720);
	GPIO_Configure(GPIOB,0,OUTPUT,ALT_PPULL);

	
	

//============================================================================	
//int resultat;
//resultat=DFT_ModuleAuCarre(&LeSignal[0],1);
	
while	(1)
	{
	}
}

