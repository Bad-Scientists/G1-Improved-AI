/*
 *	Copy of ZS_Guard
 */
//variable tracking dialogue number for this conversation
var int smallTalk_275_diaNo;

func void ZS_Smalltalk_BridgeGuard()
{
	GuardPerception();
	Npc_PercEnable(self, PERC_ASSESSPLAYER, B_AssessSC);

	AI_StandUp(self);
	AI_SetWalkMode(self, NPC_WALK); // Walkmode für den Zustand
	AI_GotoWP(self, self.wp); // Gehe zum Tagesablaufstart
	B_InitArmor();
};

func void ZS_Smalltalk_BridgeGuard_Loop()
{
	B_GotoFP(self, "GUARD");

	if (Npc_GetDistToNpc(self, hero) < 800)
	{
		B_SmartTurnToNpc(self, hero);

		//--> Small talk
		if (smallTalk_275_diaNo < 2) {
			dialogManagerDiaSeqNo = smallTalk_275_diaNo;

			D_Say (00, 00, self, hero, "DIA_BridgeGuard_275_Intro_06_00");
			D_Say (01, 05, self, hero, "DIA_BridgeGuard_275_Intro_06_01");

			smallTalk_275_diaNo = dialogManagerDiaSeqNo;
		};
		//<--
	}
	else
	{
		AI_AlignToFP(self);
	};

	//Comment out B_PlayArmor - it is distracting (plays animation where NPC is looking around)
	//B_PlayArmor();

	// !!! AI_Wait is important here !!!
	//It will make sure that code within _LOOP function will be called only once per second
	AI_Wait(self, 1);
};

func void ZS_Smalltalk_BridgeGuard_End()
{
	B_ExitArmor();
};
