func void ZS_MM_PetMolerat()
{
	Npc_SetTempAttitude(self, ATT_FRIENDLY);
	Npc_SetAttitude(self, ATT_FRIENDLY);

	Npc_PercEnable(self, PERC_ASSESSENEMY, B_SummonedByPC_AssessEnemy);
	Npc_PercEnable(self, PERC_ASSESSPLAYER, B_SummonedByPC_AssessSC);
	Npc_PercEnable(self, PERC_ASSESSFIGHTSOUND, B_MM_SummonedByPCAssessOthersDamage);
	Npc_SetPercTime(self, 0.5);

	Npc_PercEnable(self, PERC_ASSESSMAGIC, B_AssessMagic);
	Npc_PercEnable(self, PERC_ASSESSDAMAGE, ZS_MM_Attack);

	AI_StandUp(self);

	//Show AI - for debugging purposes
	NPC_SetShowAI (self, 1);
};

func int ZS_MM_PetMolerat_Loop()
{
		// -------- SC-Meister folgen ! --------
		if (Npc_GetDistToNpc(self, hero) > self.aivar[AIV_MM_DistToMaster])
		{
			AI_GotoNpc(self, hero);
		}
		else
		{
			if (!Npc_CanSeeNpc(self, hero))
			{
				AI_TurnToNpc(self, hero);
				AI_TurnToNpc(self, hero);
				AI_TurnToNpc(self, hero);
			};
		};

		return LOOP_CONTINUE;
};

func void ZS_MM_PetMolerat_End()
{
};
