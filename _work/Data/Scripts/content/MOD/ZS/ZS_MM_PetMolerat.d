//Default inventory slot - inside head
const string MOLERAT_ITEM_SLOT_NAME = "BIP01 HEAD";

/*
 *	PetMolerat_CanThrowUpItems
 *	 - returns true if Npc has any items in its inventory
 *	 - function by default puts item into the inventory slot
 */
func int PetMolerat_CanThrowUpItems (var C_NPC slf) {
	//Start from slot 0
	var int itmSlot; itmSlot = 0;

	//Loop through all inventory categories
	repeat (invCategory, INV_CAT_MAX); var int invCategory;

		//Is there any item?
		var int amount; amount = NPC_GetInvItemBySlot (slf, invCategory, itmSlot);
		if (amount > 0) {
			//Remove item from inventory - 1 piece
			var int vobPtr; vobPtr = _@ (item);
			vobPtr = oCNpc_RemoveFromInvByPtr (self, vobPtr, 1);

			//Create inventory slot (force creation if it does not exist already)
			NPC_CreateInvSlot (self, MOLERAT_ITEM_SLOT_NAME);

			//Put item into item slot
			oCNpc_PutInSlot_Fixed (self, MOLERAT_ITEM_SLOT_NAME, vobPtr, 0);
			return TRUE;
		};
	end;

	return FALSE;
};

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
			//If Npc is not looking within range of 10 degrees - turn to player
			if (!NPC_IsVobPtrInAngleX (self, _@ (hero), 10)) {
				AI_TurnToNpc(self, hero);
			} else
			{
				//If Npc does not have anything in its item slot
				if (!oCNpc_GetSlotItem (self, MOLERAT_ITEM_SLOT_NAME)) {
					//Check if it can throw up anything inside it's belly :)
					if (PetMolerat_CanThrowUpItems (self)) {
						//We have to 'throw up' items in separate ZS state.
						//Perceptions PERC_ASSESSENEMY & PERC_ASSESSPLAYER might interfere with AI - so while collecting items we will not enable these

						//Clear perceptions
						B_ClearPerceptions (self);

						//Start new AI state - item throw up
						AI_StartState (self, ZS_MM_PetMolerat_ThrowUpItems, 1, "");
						return LOOP_END;
					};
				};
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

func void ZS_MM_PetMolerat_ThrowUpItems () {
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

func int ZS_MM_PetMolerat_ThrowUpItems_Loop () {
};

func void ZS_MM_PetMolerat_ThrowUpItems_End () {
};
