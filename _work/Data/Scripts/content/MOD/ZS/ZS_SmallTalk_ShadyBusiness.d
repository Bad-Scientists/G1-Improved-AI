/*
 *	Copy of ZS_Smalltalk
 */
func void ZS_Smalltalk_ShadyBusiness()
{
	B_SetPerception(self);
	AI_SetWalkMode(self, NPC_WALK);

	// -------- Grobpositionierung --------
	if (!Npc_IsOnFP(self, "SMALLTALK"))
	{
		AI_GotoWP(self, self.wp); // Gehe zum Tagesablaufstart
	};

	// ----------------------------
	AI_GotoFP(self, "SMALLTALK");
	AI_AlignToFP(self); // Richte Dich aus
};

func void ZS_Smalltalk_ShadyBusiness_Loop()
{
	AI_Wait(self, 1);
};

func void ZS_Smalltalk_ShadyBusiness_End()
{
};
