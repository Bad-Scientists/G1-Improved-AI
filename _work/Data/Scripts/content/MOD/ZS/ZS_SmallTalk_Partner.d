/*
 *	ZS_Smalltalk_Partner
 *	 - pretty much same as ZS_Smalltalk - just without any output units
 */

func void ZS_Smalltalk_Partner()
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

func int ZS_Smalltalk_Partner_Loop()
{
	Npc_GetTarget (self);
	if (Hlp_IsValidNpc (other)) {
		B_SmartTurnToNpc(self, other);
	};
	return LOOP_CONTINUE;
};

func void ZS_Smalltalk_Partner_End()
{
};
