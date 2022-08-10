const int PERC_DIST_HEIGHT_FIREPLACE = 300;

func void B_FirePlaceLighter_AssessSelf () {
	//Check the time
	if (!Wld_IsTime (18, 30, 21, 30)) { return; };

	//Only if Npc has torch (torch in hand is not returned by Npc_HasItems)
	if ((!NPC_CarriesTorch (self)) && (!Npc_HasItems (self, ItLsTorch))) { return; };

	var string wpNext; wpNext = NPC_Route_GetWPName (self, 0);
	if (!STR_Len (wpNext)) {
		wpNext = self.WP;
	};

	//If Npc is close to it's waypoint / next waypoint in route - search for FIREPLACE objects
	if (Npc_GetDistToWp(self, wpNext) < 500) {
		var int multiplier; multiplier = clamp (Npc_GetStateTime (self), 1, 3);
		var int checkDistance; checkDistance = 600 * multiplier;

		oCNpc_ClearVobList (self);
		oCNpc_CreateVobList (self, mkf (checkDistance));

		var int vobPtr;
		//func int NPC_VobListDetectScemeName (var int slfInstance, var string scemeName, var int state, var int canSeeCheck, var int verticalDist) {
		//vobPtr = NPC_VobListDetectScemeName (self, "FIREPLACE", 0, 1, 1, PERC_DIST_HEIGHT_FIREPLACE);
		vobPtr = NPC_VobListDetectScemeName (self, "FIREPLACE", 0, 1, SEARCHVOBLIST_CANSEE | SEARCHVOBLIST_USEWAYNET, MAX_DIST_MOB, MAX_HEIGHT_MOB);

		if (vobPtr) {
			//Remove perception
			Npc_RemovePercFunc (self, B_FirePlaceLighter_AssessSelf);
			Npc_ClearAIQueue (self);
			AI_StartState (self, ZS_FirePlaceLighter, 0, "");
		};
	};
};

func void ZS_FirePlaceLighter () {
	GuardPerception();
	//Npc_PercEnable (self,PERC_ASSESSPLAYER,B_AssessSC);

	AI_StandUp(self);
	AI_SetWalkMode(self, NPC_WALK); // Walkmode für den Zustand
	AI_GotoWP(self, self.wp); // Gehe zum Tagesablaufstart

	NPC_TorchSwitchOn (self);
};

func int ZS_FirePlaceLighter_Loop () {
	var int multiplier; multiplier = clamp (Npc_GetStateTime (self), 1, 3);
	var int checkDistance; checkDistance = 600 * multiplier;

	oCNpc_ClearVobList (self);
	oCNpc_CreateVobList (self, mkf (checkDistance));

	var int vobPtr;
	//func int NPC_VobListDetectScemeName (var int slfInstance, var string scemeName, var int state, var int canSeeCheck, var int verticalDist) {
	//vobPtr = NPC_VobListDetectScemeName (self, "FIREPLACE", 0, 1, 1, PERC_DIST_HEIGHT_FIREPLACE);
	vobPtr = NPC_VobListDetectScemeName (self, "FIREPLACE", 0, 1, SEARCHVOBLIST_CANSEE | SEARCHVOBLIST_USEWAYNET, MAX_DIST_MOB, MAX_HEIGHT_MOB);

	if (vobPtr) {
		NPC_TorchSwitchOn (self);

		//Mark temporarily (for 1.5s) as used - so no other NPC will try to go to the same mob
		oCMobInter_MarkAsUsed (vobPtr, mkf (1500), _@ (self));

		if (AI_GotoMobPtr (self, vobPtr)) {
			//Here we have 3 problems:
			//1. Seems like AI_UseMob is generating its own list of vobs :-/ Even if mob is unavailable, NPC will walk to it.
			//2. Torches (FIREPLACE) are 'available' even when lit (state 1) --> but it is not possible to interact with them ... NPC will get stuck in interaction
			//3. Mob cannot have useWithItem (ItLsTorchBurning), seems like NPCs having burning torch in hand cannot for some reason interact with FIREPLACE objects ...

			//AI_UseMob (self, "FIREPLACE", -1);
			//AI_UseMob (self, "FIREPLACE", 1);
			//AI_UseMob (self, "FIREPLACE", -1);

			//Using slf.interactMob will freeze NPC AI
			//var oCNPC slf; slf = Hlp_GetNPC (self);
			//slf.interactMob = vobPtr;

			//So our solution is custom AI function - that works with mob pointer!
			//This function will set targetVob - and NPC will use our detected vob, hooray!
			AI_UseMobPtr (self, vobPtr, -1);
			AI_UseMobPtr (self, vobPtr, 1);
			AI_UseMobPtr (self, vobPtr, -1);

			//Reset state time
			AI_ResetStateTime (self);
		};
	} else {
		//If nothing was detected ... exit ZS state
		if (Npc_GetStateTime(self) > 8) {
			//ZS_FirePlaceLighter_End will try to go back to the waypoint
			//At the same time it will enable perception B_FirePlaceLighter_AssessSelf
			return LOOP_END;
		};
	};

	AI_Wait (self, 1);
	return LOOP_CONTINUE;
};

func void ZS_FirePlaceLighter_End () {
	Npc_PercEnableCustom (self, B_FirePlaceLighter_AssessSelf);

	AI_UseMob(self,"FIREPLACE",-1);
	AI_GotoWP (self, self.WP);
};
