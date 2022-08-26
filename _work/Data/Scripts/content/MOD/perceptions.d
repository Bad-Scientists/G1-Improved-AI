func void B_ClearPerceptions (var C_NPC slf) {
	// ------ Active perceptions Perception_Set_Normal and minimum disablen -------
	NPC_PercDisable (slf, PERC_ASSESSPLAYER);
	NPC_PercDisable (slf, PERC_ASSESSENEMY);

	// ------ Active perceptions of monsters be used disablen ------
	NPC_PercDisable (slf, PERC_ASSESSBODY);

	// disablen ------ Passive perceptions Perception_Set_Normal and minimum -------
	NPC_PercDisable (slf, PERC_ASSESSMAGIC);
	NPC_PercDisable (slf, PERC_ASSESSDAMAGE );
	NPC_PercDisable (slf, PERC_ASSESSMURDER);
	NPC_PercDisable (slf, PERC_ASSESSTHEFT);
	NPC_PercDisable (slf, PERC_ASSESSUSEMOB);
	NPC_PercDisable (slf, PERC_ASSESSENTERROOM);
	NPC_PercDisable (slf, PERC_ASSESSTHREAT);
	NPC_PercDisable (slf, PERC_DRAWWEAPON);
	NPC_PercDisable (slf, PERC_ASSESSFIGHTSOUND) ;
	NPC_PercDisable (slf, PERC_ASSESSQUIETSOUND);
	NPC_PercDisable (slf, PERC_ASSESSWARN);
	NPC_PercDisable (slf, PERC_ASSESSTALK);
	NPC_PercDisable (slf, PERC_MOVEMOB);

	// ------ perceptions disablen used elsewhere ------
	NPC_PercDisable (slf, PERC_ASSESSOTHERSDAMAGE); // is usually only of Monster AI USER (some ZS) and locally in ZS_WatchFight
	NPC_PercDisable (slf, PERC_ASSESSSTOPMAGIC); // Used locally in some ZS_Magic and shipped from Spell_ProcessMana_Release
	NPC_PercDisable (slf, PERC_ASSESSSURPRISE);

	// ------ perceptions, are not used up by the AI ------
	// NPC_PercDisable (slf, PERC_ASSESSFIGHTER) ;
	// NPC_PercDisable (slf, PERC_ASSESSITEM);
	// NPC_PercDisable (slf, PERC_OBSERVEINTRUDER);
	// NPC_PercDisable (slf, PERC_ASSESSREMOVEWEAPON);
	// NPC_PercDisable (slf, PERC_CATCHTHIEF);
	// NPC_PercDisable (slf, PERC_ASSESSDEFEAT);
	// NPC_PercDisable (slf, PERC_ASSESSCALL);
	// NPC_PercDisable (slf, PERC_MOVENPC);
	// NPC_PercDisable (slf, PERC_ASSESSCASTER);
	// NPC_PercDisable (slf, PERC_NPCCOMMAND);
	// NPC_PercDisable (slf, PERC_OBSERVESUSPECT);
};
