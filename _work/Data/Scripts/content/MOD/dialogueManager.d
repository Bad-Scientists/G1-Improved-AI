/*
 *	Dialogue manager
 */
var int dialogManagerTimer;
var int dialogManagerDiaSeqNo;

//Wrapper function
func void _D_Say (var int diaSeqNo, var int diaTime, var int slfInstance, var int othInstance, var string ou, var int turnTalker, var int turnListener) {
	var C_NPC slf; slf = Hlp_GetNpc (slfInstance);
	var C_NPC oth; oth = Hlp_GetNpc (othInstance);

	if (dialogManagerDiaSeqNo == diaSeqNo) {
		//SVM outputs will be displayed only within certain range - safe distance is 500 meters
		if ((NPC_GetDistToNPC (slf, hero) <= 500) && (NPC_GetDistToNPC (oth, hero) <= 500)) {
			if (dialogManagerTimer >= diaTime) {
				//If NPC is already talking ... ignore
				if ((NPC_IsVoiceActive (slf)) || (NPC_IsVoiceActive (oth))) {
					return;
				};

				//If any participant of the discussion is invincible - then it is safe to assume they are already in another dialogue
				if ((slf.aivar[AIV_INVINCIBLE])
				|| (oth.aivar[AIV_INVINCIBLE])
				|| (hero.aivar[AIV_INVINCIBLE])
				|| (!InfoManager_HasFinished())) {
					return;
				};

				//If NPC is not talking to itself ... then turn to NPC
				if (Hlp_GetInstanceID (slf) != Hlp_GetInstanceID (oth)) {
					if (turnTalker) {
						if (!NPC_CanSeeNPC (slf, oth)) {
							AI_TurnToNpc (slf, oth);
						};
					};

					if (turnListener) {
						if (!NPC_CanSeeNPC (oth, slf)) {
							AI_TurnToNpc (oth, slf);
						};
					};
				};

				//SVM outputing is broken!
				//If player is moving around, output will be interrupted. That's why we have to use here AI_OutputSVM_Overlay instead of AI_OutputSVM

				//Disadvantage with AI_OutputSVM_Overlay - there are no dialogue gestures, so here we have a workaround
				var int randomizer; randomizer = Hlp_Random (21) + 1; //1 - 21
				var string aniName; aniName = "T_DIALOGGESTURE_";

				if (randomizer < 10) {
					aniName = ConcatStrings (aniName, "0");
				};

				aniName = ConcatStrings (aniName, IntToString (randomizer));

				NPC_PlayAni (slf, aniName);

				//If player is talking - let him be talking
				if (Hlp_GetInstanceID (hero) == Hlp_GetInstanceID (slf)) {
					//AI_OutputSVM (hero, oth, ou);
					AI_OutputSVM_Overlay (hero, oth, ou);
				} else {
				//NPC does not have to talk back to hero
					//AI_OutputSVM (slf, null, ou);
					AI_OutputSVM_Overlay (slf, null, ou);
				};

				dialogManagerDiaSeqNo += 1;
				dialogManagerTimer = 0;
			} else {
				dialogManagerTimer += 1;
			};
		};
	};
};

//Turn both talker and listener to each other
func void D_Talk (var int diaSeqNo, var int diaTime, var int slfInstance, var int othInstance, var string ou) {
	_D_Say (diaSeqNo, diaTime, slfInstance, othInstance, ou, TRUE, TRUE);
};

//Only talking NPC will turn to their listener
func void D_Say (var int diaSeqNo, var int diaTime, var int slfInstance, var int othInstance, var string ou) {
	_D_Say (diaSeqNo, diaTime, slfInstance, othInstance, ou, TRUE, FALSE);
};

//Do not turn anyone
func void D_Note (var int diaSeqNo, var int diaTime, var int slfInstance, var int othInstance, var string ou) {
	_D_Say (diaSeqNo, diaTime, slfInstance, othInstance, ou, FALSE, FALSE);
};
