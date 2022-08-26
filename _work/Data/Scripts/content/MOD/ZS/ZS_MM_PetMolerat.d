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
	//Item detection - create vob list (within specified range)
	oCNpc_ClearVobList (self);
	oCNpc_CreateVobList (self, mkf (1600));

	//NPC_VobListDetectItem (var int slfInstance, var int mainflag, var int excludeMainFlag, var int flags, var int excludeFlags, var int searchFlags, var int distLimit, var int verticalLimit)
	//SEARCHVOBLIST_CANSEE - by default Npc will only detect items that it can see
	//SEARCHVOBLIST_CHECKPORTALROOMOWNER - and which are not in portal room (I guess - why not :))
	var int vobPtr; vobPtr = NPC_VobListDetectItem (self, 0, 0, 0, 0, SEARCHVOBLIST_CANSEE | SEARCHVOBLIST_CHECKPORTALROOMOWNER, 2000, 800);

	//If any item was detected
	if (vobPtr) {
		//We have to pick up items in separate ZS state.
		//Perceptions PERC_ASSESSENEMY & PERC_ASSESSPLAYER might interfere with AI - so while collecting items we will not enable these

		//Clear perceptions
		B_ClearPerceptions (self);

		//Start new AI state - item collection
		AI_StartState (self, ZS_MM_PetMolerat_CollectItem, 1, "");
		return LOOP_END;
	} else {
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
	};

	return LOOP_CONTINUE;
};

func void ZS_MM_PetMolerat_End()
{
};

func void ZS_MM_PetMolerat_CollectItem ()
{
	//Same as ZS_MM_SummonedByPC - but ignoring enemies and ignoring player
	Npc_SetTempAttitude(self, ATT_FRIENDLY);
	Npc_SetAttitude(self, ATT_FRIENDLY);

	//Npc_PercEnable(self, PERC_ASSESSENEMY, B_SummonedByPC_AssessEnemy);
	//Npc_PercEnable(self, PERC_ASSESSPLAYER, B_SummonedByPC_AssessSC);
	Npc_PercEnable(self, PERC_ASSESSFIGHTSOUND, B_MM_SummonedByPCAssessOthersDamage);
	Npc_SetPercTime(self, 0.5);

	Npc_PercEnable(self, PERC_ASSESSMAGIC, B_AssessMagic);
	Npc_PercEnable(self, PERC_ASSESSDAMAGE, ZS_MM_Attack);

	AI_StandUp(self);
};

func int ZS_MM_PetMolerat_CollectItem_Loop ()
{
};

func void ZS_MM_PetMolerat_CollectItem_End ()
{
};
