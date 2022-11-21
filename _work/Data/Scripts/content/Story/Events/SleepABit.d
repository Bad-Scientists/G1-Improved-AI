//****************************
// 		PC_Sleep
//****************************
var int PLAYER_MOBSI_PRODUCTION;
	const int MOBSI_None = 0;
	const int MOBSI_SleepAbit = 1;

func void PC_Sleep(var int t)
{
	AI_StopProcessInfos(self); // [SK] ->muss hier stehen um das update zu gewährleisten
	self.aivar[AIV_INVINCIBLE] = FALSE;
	if (Wld_IsTime(00, 00, t, 00))
	{
		Wld_SetTime(t, 00);
	}
	else
	{
		t = t + 24;
		Wld_SetTime(t, 00);
	};

	PrintScreen("You slept well and feel better", -1, -1, "font_old_20_white.tga", 3);
	hero.attribute[ATR_HITPOINTS] = hero.attribute[ATR_HITPOINTS_MAX];
	hero.attribute[ATR_MANA] = hero.attribute[ATR_MANA_MAX];

	// -------- AssessEnterRoom-Wahrnehmung versenden --------
	PrintGlobals(PD_ITEM_MOBSI);
	Npc_SendPassivePerc(hero, PERC_ASSESSENTERROOM, NULL, hero); // ...damit der Spieler dieses Feature nicht zum Hütteplündern ausnutzt!
};

func void SLEEPABIT_S1()
{
	var C_Npc her; her = Hlp_GetNpc(PC_Hero);
	var C_Npc rock; rock = Hlp_GetNpc(PC_Rockefeller);

	//***ALT** if(Hlp_GetInstanceID(self)== Hlp_GetInstanceID(Hero)) // MH: geändert, damit kontrollierte NSCs nicht schlafen können!
	if ((Hlp_GetInstanceID(self) == Hlp_GetInstanceID(her)) || (Hlp_GetInstanceID(self) == Hlp_GetInstanceID(rock)))
	{
		PLAYER_MOBSI_PRODUCTION = MOBSI_SleepAbit;
		self.aivar[AIV_INVINCIBLE] = TRUE;
		AI_ProcessInfos(her);
	};
};

// -------------------- Gar nicht schlafen -------------------------

instance PC_NoSleep(c_Info)
{
	npc = PC_Hero;
	nr = 999;
	condition = PC_NoSleep_Condition;
	information = PC_NoSleep_Info;
	important = 0;
	permanent = 1;
	description = DIALOG_ENDE;
};

func int PC_NoSleep_Condition()
{
	if (PLAYER_MOBSI_PRODUCTION == MOBSI_SleepAbit) {
		return 1;
	};

	return 0;
};

func void PC_NoSleep_Info()
{
	PLAYER_MOBSI_PRODUCTION = MOBSI_None;
	AI_StopProcessInfos(self);
	self.aivar[AIV_INVINCIBLE] = FALSE;
};

// ---------------------- morgens --------------------------------------

instance PC_SleepTime_Morning(C_INFO)
{
	npc = PC_Hero;
	condition = PC_SleepTime_Morning_Condition;
	information = PC_SleepTime_Morning_Info;
	important = 0;
	permanent = 1;
	description = "Sleep until next morning";
};

func int PC_SleepTime_Morning_Condition()
{
	if (PLAYER_MOBSI_PRODUCTION == MOBSI_SleepAbit) {
		return 1;
	};

	return 0;
};

func void PC_SleepTime_Morning_Info()
{
	PC_Sleep(8); // SN: geändert, da um 7 Uhr noch keiner der NSCs wach ist!
};

// --------------------- mittags -----------------------------------------

instance PC_SleepTime_Noon(C_INFO)
{
	npc = PC_Hero;
	condition = PC_SleepTime_Noon_Condition;
	information = PC_SleepTime_Noon_Info;
	important = 0;
	permanent = 1;
	description = "Sleep until midday";
};

func int PC_SleepTime_Noon_Condition()
{
	if (PLAYER_MOBSI_PRODUCTION == MOBSI_SleepAbit) {
		return 1;
	};

	return 0;
};

func void PC_SleepTime_Noon_Info()
{
	PC_Sleep(12);
};

// ---------------------- abend --------------------------------------

instance PC_SleepTime_Evening(C_INFO)
{
	npc = PC_Hero;
	condition = PC_SleepTime_Evening_Condition;
	information = PC_SleepTime_Evening_Info;
	important = 0;
	permanent = 1;
	description = "Sleep until next evening";
};

func int PC_SleepTime_Evening_Condition()
{
	if (PLAYER_MOBSI_PRODUCTION == MOBSI_SleepAbit) {
		return 1;
	};

	return 0;
};

func void PC_SleepTime_Evening_Info()
{
	PC_Sleep(19);
};

// ------------------------ nacht -----------------------------------------

instance PC_SleepTime_Midnight(C_INFO)
{
	npc = PC_Hero;
	condition = PC_SleepTime_Midnight_Condition;
	information = PC_SleepTime_Midnight_Info;
	important = 0;
	permanent = 1;
	description = "Sleep until midnight";
};

func int PC_SleepTime_Midnight_Condition()
{
	if (PLAYER_MOBSI_PRODUCTION == MOBSI_SleepAbit) {
		return 1;
	};

	return 0;
};

func void PC_SleepTime_Midnight_Info()
{
	PC_Sleep(0);
};
