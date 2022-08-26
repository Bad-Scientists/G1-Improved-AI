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

/*
 *	_oCNpc_DoTakeDetectedVob
 *	 - function will be called from AI queue and will take item from the world
 */
func void _oCNpc_DoTakeDetectedVob (var int vobPtr) {
	//Sooooo ...
	//While Npc is walking towards an item - item itself might disappear (player can pick it up)
	//So we will double-check here whether this pointer is still in active vob list in the game - if yes we will try to pick it up

	//If it is still active - pick it up
	if (VobPtr_IsInActiveVobList (vobPtr)) {
		if (oCNpc_DoTakeVob (self, vobPtr)) {
			return;
		};
	};

	//If something went wrong (item was not there anymore or for some reason Npc didn't pick it up) - clear AI queue - this will remove T_DIG animation
	NPC_ClearAIQueue (self);
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
	//Item detection - create vob list (within specified range)
	oCNpc_ClearVobList (self);
	oCNpc_CreateVobList (self, mkf (1600));

	var int vobPtr; vobPtr = NPC_VobListDetectItem (self, 0, 0, 0, 0, SEARCHVOBLIST_CANSEE | SEARCHVOBLIST_CHECKPORTALROOMOWNER, 2000, 800);

	if (vobPtr) {
		//Goto item
		AI_GotoVobPtr (self, vobPtr);

		//If close enough - take item
		if (NPC_GetDistToVobPtr (self, vobPtr) < 300) {
			//--> This will not work with monster Npc - it is missing animations S_RUN & T_STAND_2_IGET > S_IGET > T_IGET_2_STAND + fight mode has to be FMODE_NONE
			//var oCItem itm; itm = _^ (vobPtr);
			//AI_GotoItem (self, itm);
			//AI_TakeItem (self, itm);
			//<--

			//Turn to vob
			AI_TurnToVobPtr (self, vobPtr);

			//Add _oCNpc_DoTakeDetectedVob (this will try to take item) into AI queue function and play animation
			AI_Function_I (self, _oCNpc_DoTakeDetectedVob, vobPtr);
			AI_PlayAni (self, "T_DIG");

			return LOOP_CONTINUE;
		};

		//Continue _LOOP state
		return LOOP_CONTINUE;
	};

	//If no item was detected exit _LOOP state
	return LOOP_END;
};

func void ZS_MM_PetMolerat_CollectItem_End ()
{
};
