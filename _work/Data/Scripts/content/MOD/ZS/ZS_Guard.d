//////////////////////////////////////////////////////////////////////////
//	ZS_Guard
//	========
//	Dieser Tagesablauf wird allen NSCs gegeben, die einfach nur
//	imposant herumstehen und Wache halten sollen.
//
//	Es passiert folgendes:
//	1. Wie in allen Wachzuständen werden nette Posen und Zufalls-
//		Animationen abgespielt.
//////////////////////////////////////////////////////////////////////////
func void ZS_Guard()
{
	PrintDebugNpc(PD_TA_FRAME, "ZS_Guard");

	GuardPerception();
	Npc_PercEnable(self, PERC_ASSESSPLAYER, B_AssessSC);

	AI_StandUp(self);
	AI_SetWalkMode(self, NPC_WALK); // Walkmode für den Zustand
	AI_GotoWP(self, self.wp); // Gehe zum Tagesablaufstart

	if (Wld_IsTime (21, 30, 05, 30)) {
		if (NPC_GetDistToWP (self, self.WP) > 1000) {
			NPC_TorchSwitchOn (self);
		};
	} else {
		NPC_TorchSwitchOff (self);
	};

	if (!NPC_CarriesTorch (self)) {
		B_InitArmor();
	};
};

func void ZS_Guard_Loop()
{
	PrintDebugNpc(PD_TA_LOOP, "ZS_Guard_Loop");

	//Remove torch if on target waypoint
	if (NPC_GetDistToWP (self, self.WP) < 500) {
		NPC_TorchSwitchOff (self);
	};

	B_GotoFP(self, "GUARD");

	if (Npc_GetDistToNpc(self, hero) < 800)
	{
		B_SmartTurnToNpc(self, hero);
	} else {
		AI_AlignToFP(self);
	};

	if (!NPC_CarriesTorch (self)) {
		B_PlayArmor();
	};

	AI_Wait(self, 0.5);
};

func void ZS_Guard_End()
{
	PrintDebugNpc(PD_TA_FRAME, "ZS_Guard_End");

	NPC_TorchSwitchOff (self);
	B_ExitArmor();
};
