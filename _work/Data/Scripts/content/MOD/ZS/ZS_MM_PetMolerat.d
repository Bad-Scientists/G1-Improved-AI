func void ZS_MM_SummonedByPC()
func void ZS_MM_PetMolerat()
{
	PrintDebugNpc(PD_MST_FRAME, "ZS_MM_SummonedByPC");

	Npc_SetTempAttitude(self, ATT_FRIENDLY);
	Npc_SetAttitude(self, ATT_FRIENDLY);

	Npc_PercEnable(self, PERC_ASSESSENEMY, B_SummonedByPC_AssessEnemy);
	Npc_PercEnable(self, PERC_ASSESSPLAYER, B_SummonedByPC_AssessSC);
	Npc_PercEnable(self, PERC_ASSESSFIGHTSOUND, B_MM_SummonedByPCAssessOthersDamage);
	Npc_SetPercTime(self, 0.5);

	Npc_PercEnable(self, PERC_ASSESSMAGIC, B_AssessMagic);
	Npc_PercEnable(self, PERC_ASSESSDAMAGE, ZS_MM_Attack);

	AI_StandUp(self);
};

func int ZS_MM_SummonedByPC_Loop()
func int ZS_MM_PetMolerat_Loop()
{
	PrintDebugNpc(PD_MST_LOOP, "ZS_MM_SummonedByPC_Loop");
	PrintGlobals(PD_MST_DETAIL);

	if (Npc_GetStateTime(self) > self.aivar[AIV_MM_TimeLooseHP])
	{
		// -------- Kreatur wird nach einiger Zeit schwächer !--------
		Npc_ChangeAttribute(self, ATR_HITPOINTS, -1);
		Npc_SetStateTime(self, 0);
	};

	if (Npc_GetNextTarget(self))
	{
		// -------- neues Ziel entdeckt ! --------
		PrintDebugNpc(PD_MST_CHECK, "...neuer Gegner gefunden");
		Npc_SetTarget(self, other);
		Npc_ClearAIQueue(self);
		AI_StartState(self, ZS_MM_Attack, 0, "");
	}
	else
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

		// AI_Wait(self, 1);
		return LOOP_CONTINUE;
	};
};

func void ZS_MM_SummonedByPC_End()
func void ZS_MM_PetMolerat_End()
{
	PrintDebugNpc(PD_MST_FRAME, "ZS_MM_SummonedByPC_End");
};