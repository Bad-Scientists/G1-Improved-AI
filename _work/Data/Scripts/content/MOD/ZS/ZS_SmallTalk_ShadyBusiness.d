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
	/*
	 *	GRD_253_Gardist (self) talking with STT_304_Schatten
	 */
	var C_NPC npc; npc = Hlp_GetNpc (STT_304_Schatten);

	if (Hlp_IsValidNpc (npc)) {
		//If NPC is not in ZS_Smalltalk_Partner state - start the state
		if (!NPC_IsInState (npc, ZS_Smalltalk_Partner)) {
			Npc_SetTarget (npc, self);
			AI_StartState (npc, ZS_Smalltalk_Partner, 1, "");
		};

		B_SmartTurnToNpc(self, npc);
	};
	AI_Wait(self, 1);
};

func void ZS_Smalltalk_ShadyBusiness_End()
{
};
