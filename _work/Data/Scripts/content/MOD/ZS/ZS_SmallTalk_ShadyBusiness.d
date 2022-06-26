/*
 *	Copy of ZS_Smalltalk
 */

//variable tracking dialogue number for this conversation
var int smallTalk_253_diaNo;

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

		//--> Small talk
		//We can trigger cutscene dialogue only if NPC is in ZS_Smalltalk_Partner state
		if (NPC_IsInState (npc, ZS_Smalltalk_Partner)) {
			if (smallTalk_253_diaNo < 7) {
				dialogManagerDiaSeqNo = smallTalk_253_diaNo;

				D_Talk (00, 00, self, npc, "DIA_Guard_253_Business_07_00");
				D_Talk (01, 07, npc, self, "DIA_Guard_304_Business_10_01");
				D_Talk (02, 10, self, npc, "DIA_Guard_253_Business_07_02");
				D_Talk (03, 10, self, npc, "DIA_Guard_253_Business_07_03");
				D_Talk (04, 10, npc, self, "DIA_Guard_304_Business_10_04");
				D_Talk (05, 05, self, npc, "DIA_Guard_253_Business_07_05");
				D_Talk (06, 08, self, npc, "DIA_Guard_253_Business_07_06");

				if (dialogManagerDiaSeqNo == 07) {
					const string CH1_ShadyBusiness = "Shady business";
					Log_CreateTopic(CH1_ShadyBusiness, LOG_MISSION);
					Log_SetTopicStatus(CH1_ShadyBusiness, LOG_RUNNING);
					B_LogEntry(CH1_ShadyBusiness, "... some notes ...");
				};

				smallTalk_253_diaNo = dialogManagerDiaSeqNo;
			};
		};
		//<--
	};

	// !!! AI_Wait is important here !!!
	//It will make sure that code within _LOOP function will be called only once per second
	AI_Wait(self, 1);
};

func void ZS_Smalltalk_ShadyBusiness_End()
{
};
