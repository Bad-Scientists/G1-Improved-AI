instance PC_ShellGame_Exit (C_Info) {
	npc		= PC_Hero;
	nr		= 999;
	condition	= PC_ShellGame_Exit_Condition;
	information	= PC_ShellGame_Exit_Info;
	permanent	= TRUE;
	description	= DIALOG_ENDE;
};

func int PC_ShellGame_Exit_Condition () {
	if (shellGame_Status != cShellGame_Idle) {
		return TRUE;
	};

	return FALSE;
};

func void PC_ShellGame_Exit_Info () {
	//Ak je hra Skorapky aktivna tak ju ukoncenim dialogu 'vypneme'
	if (shellGame_Status == cShellGame_Dialogue)
	|| (shellGame_Status == cShellGame_RevealCoin)
	|| (shellGame_Status == cShellGame_CoinRevealed)
	{
		shellGame_Status = cShellGame_Idle;
	};

	//Remove frame functions
	FF_Remove (FF_Surface_ShellGame_Timer_1s);
	FF_Remove (FF_Surface_ShellGame_Timer_10ms);

	hero.aivar [AIV_INVINCIBLE] = FALSE;
	AI_StopProcessInfos (hero);
};

//---

instance PC_ShellGame_Tip (C_Info) {
	npc		= PC_Hero;
	nr		= 1;
	condition	= PC_ShellGame_Tip_Condition;
	information	= PC_ShellGame_Tip_Info;
	permanent	= TRUE;
	important	= FALSE;
	description	= "dummy";
};

func int PC_ShellGame_Tip_Condition () {
	if (shellGame_Status == cShellGame_Dialogue) {

		//These are in fact Global variables - we can exploit that for this feature - they will retain their value ;-)
		var string lastSpinnerID;

		var int playersTip;
		var int lastPlayersTip;

		//Default tip - left
		if (playersTip == 0) { playersTip = 1; };

		//What is current InfoManagerSpinnerID ?
		if (Hlp_StrCmp (InfoManagerSpinnerID, "ShellGame")) {
			//Setup spinner if spinner ID has changed
			if (!Hlp_StrCmp (InfoManagerSpinnerID, lastSpinnerID)) {
				//Restore value
				InfoManagerSpinnerValue = playersTip;
			};

			//Page Up/Down quantity
			InfoManagerSpinnerPageSize = 1;

			//Min/Max value (Home/End keys)
			InfoManagerSpinnerValueMin = 1;
			InfoManagerSpinnerValueMax = 3;

			//Update
			playersTip = InfoManagerSpinnerValue;
		};

		lastSpinnerID = InfoManagerSpinnerID;

		var string newDescription; newDescription = "";

		//Spinner ID ShellGame
		newDescription = ConcatStrings (newDescription, "indOff@ s@ShellGame "); //Shell game

		if (playersTip == 1) {
			newDescription = ConcatStrings (newDescription, "al@ LEFT one o@h@666666 hs@666666:>~"); //Mince je VLEVO
		};

		if (playersTip == 2) {
			newDescription = ConcatStrings (newDescription, "ac@ o@h@666666 hs@666666:<~ MIDDLE one o@h@666666 hs@666666:>~"); //Mince je VE STŘEDU
		};

		if (playersTip == 3) {
			newDescription = ConcatStrings (newDescription, "ar@ o@h@666666 hs@666666:<~ RIGHT one"); //Mince je VPRAVO
		};

		/*
		if (playersTip != lastPlayersTip) {
			//Npc_StopPointAt (hero);

			var int vobPtr; vobPtr = 0;

			if (playersTip == 1) {
				vobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_LEFT");
				//AI_TurnToVobPtr (hero, vobPtr);
				//AI_PointAt (hero, "VOB_GAME_CUP_LEFT");
			};

			if (playersTip == 2) {
				vobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_MIDDLE");
				//AI_TurnToVobPtr (hero, vobPtr);
				//AI_PointAt (hero, "VOB_GAME_CUP_MIDDLE");
			};

			if (playersTip == 3) {
				vobPtr = MEM_SearchVobByName  ("VOB_GAME_CUP_RIGHT");
				//AI_TurnToVobPtr (hero, vobPtr);
				//AI_PointAt (hero, "VOB_GAME_CUP_RIGHT");
			};

			//oCNpc_SetFocusVob (hero, vobPtr);
		};
		*/

		lastPlayersTip = playersTip;

		//Update description
		PC_ShellGame_Tip.description = newDescription;

		return TRUE;
	};

	return FALSE;
};

func void PC_ShellGame_Tip_Info ()
{
	shellGame_PlayersTip = InfoManagerSpinnerValue;
	hero.aivar [AIV_INVINCIBLE] = FALSE;
	AI_StopProcessInfos (hero);
};

//---

instance PC_ShellGame_NewGame (C_Info)
{
	npc		= PC_Hero;
	nr		= 1;
	condition	= PC_ShellGame_NewGame_Condition;
	information	= PC_ShellGame_NewGame_Info;
	permanent	= TRUE;
	important	= FALSE;
	description	= "dummy text";
};

func int PC_ShellGame_NewGame_Condition ()
{
	if (shellGame_Status == cShellGame_RevealCoin)
	|| (shellGame_Status == cShellGame_CoinRevealed)
	{
		if (NPC_HasItems (hero, itmiNugget) >= 5) {
			PC_ShellGame_NewGame.description = "New game. (5x ore)"; //Nová hra. (5 kusů rudy)
		} else {
			PC_ShellGame_NewGame.description = "New game. (you need: 5x ore)";
		};

		return TRUE;
	};

	return FALSE;
};

func void PC_ShellGame_NewGame_Info ()
{
	if (NPC_HasItems (hero, itmiNugget) < 5) {
		PrintS ("You don't have enough ore!"); //"Nemáš dost rudy."
		return;
	};

	Npc_RemoveInvItems (hero, itmiNugget, 5);

	shellGame_Status = cShellGame_NewGame;
	hero.aivar [AIV_INVINCIBLE] = FALSE;
	AI_StopProcessInfos (hero);
};

//Function that will start the game - for example to be called via console
func void StartShellGame () {
	//Reset everything
	ShellGame_Reset ();

	//Add frame functions for shell game
	FF_ApplyOnceExtGT (FF_Surface_ShellGame_Timer_1s, 1000, -1);
	FF_ApplyOnceExtGT (FF_Surface_ShellGame_Timer_10ms, 10, -1);

	//Start new game
	shellGame_Status = cShellGame_NewGame;
};
