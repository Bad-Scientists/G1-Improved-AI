// *************************************************************************
// 									Kapitel 1
// *************************************************************************

// *************************************************************************
// 									EXIT
// *************************************************************************

instance Info_Mine_Grd_13_EXIT(C_INFO)
{
	// npc wird in B_AssignAmbientInfos_grd_13 (s.u.) jeweils gesetzt
	nr = 999;
	condition = Info_Mine_Grd_13_EXIT_Condition;
	information = Info_Mine_Grd_13_EXIT_Info;
	permanent = 1;
	description = "END";
};

func int Info_Mine_Grd_13_EXIT_Condition()
{
	return 1;
};

func void Info_Mine_Grd_13_EXIT_Info()
{
	AI_StopProcessInfos(self);
};

// *************************************************************************
// 								Mine
// *************************************************************************

instance Info_Mine_Grd_13_Mine(C_INFO) // E1
{
	nr = 1;
	condition = Info_Mine_Grd_13_Mine_Condition;
	information = Info_Mine_Grd_13_Mine_Info;
	permanent = 1;
	description = "What goes on in the mine?";
};

func int Info_Mine_Grd_13_Mine_Condition()
{
	if (Kapitel < 3)
	{
		return 1;
	};
};

func void Info_Mine_Grd_13_Mine_Info()
{
	AI_Output(other, self, "Info_Mine_Grd_13_Mine_15_00"); //What goes on in the mine?
	AI_Output(self, other, "Info_Mine_Grd_13_Mine_13_01"); //The mine's the heart of the Old Camp. No mine, no ore. No ore, no goods. Get it?
};

// *************************************************************************
// 							Wichtige Personen
// *************************************************************************

instance Info_Mine_Grd_13_WichtigePersonen(C_INFO)
{
	nr = 1;
	condition = Info_Mine_Grd_13_WichtigePersonen_Condition;
	information = Info_Mine_Grd_13_WichtigePersonen_Info;
	permanent = 1;
	description = "Who calls the shots around here?";
};

func int Info_Mine_Grd_13_WichtigePersonen_Condition()
{
	if (Kapitel < 3)
	{
		return 1;
	};
};

func void Info_Mine_Grd_13_WichtigePersonen_Info()
{
	AI_Output(other, self, "Info_Mine_Grd_13_WichtigePersonen_15_00"); //Who calls the shots around here?
	AI_Output(self, other, "Info_Mine_Grd_13_WichtigePersonen_13_01"); //Asghan's our boss. But you leave him alone. Ian's the one that deals with guys like you.
};

// *************************************************************************
// 								Minecrawler
// *************************************************************************

instance Info_Mine_Grd_13_DasLager(C_INFO)
{
	nr = 1;
	condition = Info_Mine_Grd_13_DasLager_Condition;
	information = Info_Mine_Grd_13_DasLager_Info;
	permanent = 1;
	description = "Tell me about the crawlers.";
};

func int Info_Mine_Grd_13_DasLager_Condition()
{
	if (Kapitel < 3)
	{
		return 1;
	};
};

func void Info_Mine_Grd_13_DasLager_Info()
{
	AI_Output(other, self, "Info_Mine_Grd_13_DasLager_15_00"); //Tell me about the crawlers.
	AI_Output(self, other, "Info_Mine_Grd_13_DasLager_13_01"); //The Brotherhood pays the Old Camp in swampweed, so they let them hunt crawlers in the mine.
};

// *************************************************************************
// 									Die Lage
// *************************************************************************

instance Info_Mine_Grd_13_DieLage(C_INFO) // E1
{
	nr = 1;
	condition = Info_Mine_Grd_13_DieLage_Condition;
	information = Info_Mine_Grd_13_DieLage_Info;
	permanent = 1;
	description = "How's things?";
};

func int Info_Mine_Grd_13_DieLage_Condition()
{
	if (Kapitel < 3)
	{
		return 1;
	};
};

func void Info_Mine_Grd_13_DieLage_Info()
{
	AI_Output(other, self, "Info_Mine_Grd_13_DieLage_15_00"); //How's things?
	AI_Output(self, other, "Info_Mine_Grd_13_DieLage_13_01"); //I ain't had a fight in ages!
};

// *************************************************************************
// -------------------------------------------------------------------------

func void B_AssignAmbientInfos_Mine_grd_13(var C_Npc slf)
{
	Info_Mine_Grd_13_EXIT.npc = Hlp_GetInstanceID(slf);
	Info_Mine_Grd_13_Mine.npc = Hlp_GetInstanceID(slf);
	Info_Mine_Grd_13_WichtigePersonen.npc = Hlp_GetInstanceID(slf);
	Info_Mine_Grd_13_DasLager.npc = Hlp_GetInstanceID(slf);
	Info_Mine_Grd_13_DieLage.npc = Hlp_GetInstanceID(slf);
};
