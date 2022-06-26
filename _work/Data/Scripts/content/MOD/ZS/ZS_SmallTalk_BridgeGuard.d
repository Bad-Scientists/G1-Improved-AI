/*
 *	Copy of ZS_Guard
 */
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
	}
	else
	{
		AI_AlignToFP(self);
	};

	B_PlayArmor();

	AI_Wait(self, 0.5);
};

func void ZS_Smalltalk_BridgeGuard_End()
{
	B_ExitArmor();
};
