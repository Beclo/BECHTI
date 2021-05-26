

#include "DriverJeuLaser.h"

extern int DFT_ModuleAuCarre(short int* Signal64ech, char k);
extern short int LeSignal[];

int main(void)
{

// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

// Après exécution : le coeur CPU est clocké à 72MHz ainsi que tous les timers
CLOCK_Configure();


	
	

//============================================================================	
//int resultat;
//resultat=DFT_ModuleAuCarre(&LeSignal[0],1);
	
int resultat[64];
	for(int i=0;i<64;i++){
		resultat[i]=DFT_ModuleAuCarre(&LeSignal[0],i);
	}
	
while	(1)
	{
	}
}

