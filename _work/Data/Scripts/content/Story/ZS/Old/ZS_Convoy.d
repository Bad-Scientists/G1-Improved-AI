/******************************************
* NSC hebt Tragekorb auf, geht *
* zum angegebenen WP und legt ihn dort ab *
* Achtung !UrsprungsWP muss Tragekorb *
* in der Nähe haben ! *
******************************************/

func void ZS_Convoy()
{
	PrintDebugNpc(PD_TA_FRAME, "ZS_Convoy");

	B_SetPerception(self);

	AI_SetWalkMode(self, NPC_WALK); // Walkmode für den Zustand
	AI_TakeMob(self, "BACKPACK");

	AI_GotoWP(self, self.wp); // Gehe zum Tagesablaufstart
};

func void ZS_Convoy_Loop()
{
	PrintDebugNpc(PD_TA_LOOP, "ZS_Convoy_Loop");

	if (Hlp_StrCmp(self.wp, Npc_GetNearestWP(self)))
	{
		AI_DropMob(self);
	};

	AI_Wait(self, 1);
};

func void ZS_Convoy_End()
{
	PrintDebugNpc(PD_TA_FRAME, "ZS_Convoy_End");
};
