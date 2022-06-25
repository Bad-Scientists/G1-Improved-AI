// *************************************************************************
// 									Kapitel 1
// *************************************************************************

// *************************************************************************
// 									EXIT
// *************************************************************************

instance Info_Mine_Grd_7_EXIT(C_INFO)
{
	// npc wird in B_AssignAmbientInfos_grd_7 (s.u.) jeweils gesetzt
	nr = 999;
	condition = Info_Mine_Grd_7_EXIT_Condition;
	information = Info_Mine_Grd_7_EXIT_Info;
	permanent = 1;
	description = "END";
};

func int Info_Mine_Grd_7_EXIT_Condition()
{
	return 1;
};

func void Info_Mine_Grd_7_EXIT_Info()
{
	AI_StopProcessInfos(self);
};

// *************************************************************************
// 							Mine
// *************************************************************************

instance Info_Mine_Grd_7_Mine(C_INFO) // E1
{
	nr = 1;
	condition = Info_Mine_Grd_7_Mine_Condition;
	information = Info_Mine_Grd_7_Mine_Info;
	permanent = 1;
	description = "Tell me about the mine.";
};

func int Info_Mine_Grd_7_Mine_Condition()
{
	if (Kapitel < 3)
	{
		return 1;
	};
};

func void Info_Mine_Grd_7_Mine_Info()
{
	AI_Output(other, self, "Info_Mine_Grd_7_Mine_15_00"); //Tell me about the mine.
	AI_Output(self, other, "Info_Mine_Grd_7_Mine_07_01"); //The diggers collect the ore and we protect them from the crawlers.
};

// *************************************************************************
// 							Wichtige Personen
// *************************************************************************

instance Info_Mine_Grd_7_WichtigePersonen(C_INFO)
{
	nr = 1;
	condition = Info_Mine_Grd_7_WichtigePersonen_Condition;
	information = Info_Mine_Grd_7_WichtigePersonen_Info;
	permanent = 1;
	description = "Who calls the shots around here?";
};

func int Info_Mine_Grd_7_WichtigePersonen_Condition()
{
	if (Kapitel < 3)
	{
		return 1;
	};
};

func void Info_Mine_Grd_7_WichtigePersonen_Info()
{
	AI_Output(other, self, "Info_Mine_Grd_7_WichtigePersonen_15_00"); //Who calls the shots around here?
	AI_Output(self, other, "Info_Mine_Grd_7_WichtigePersonen_07_01"); //Ian and Asghan. if you want anything, you'd better talk to them.
};

// *************************************************************************
// 								Minecrawler
// *************************************************************************

instance Info_Mine_Grd_7_Minecrawler(C_INFO)
{
	nr = 1;
	condition = Info_Mine_Grd_7_Minecrawler_Condition;
	information = Info_Mine_Grd_7_Minecrawler_Info;
	permanent = 1;
	description = "What do you know about the crawlers?";
};

func int Info_Mine_Grd_7_Minecrawler_Condition()
{
	if (Kapitel < 3)
	{
		return 1;
	};
};

func void Info_Mine_Grd_7_Minecrawler_Info()
{
	AI_Output(other, self, "Info_Mine_Grd_7_Minecrawler_15_00"); //What do you know about the crawlers?
	AI_Output(self, other, "Info_Mine_Grd_7_Minecrawler_07_01"); //The whole lot of 'em should be wiped out, if you ask me!
};

// *************************************************************************
// 									Die Lage
// *************************************************************************

instance Info_Mine_Grd_7_DieLage(C_INFO) // E1
{
	nr = 1;
	condition = Info_Mine_Grd_7_DieLage_Condition;
	information = Info_Mine_Grd_7_DieLage_Info;
	permanent = 1;
	description = "How are you?";
};

func int Info_Mine_Grd_7_DieLage_Condition()
{
	if (Kapitel < 3)
	{
		return 1;
	};
};

func void Info_Mine_Grd_7_DieLage_Info()
{
	AI_Output(other, self, "Info_Mine_Grd_7_DieLage_15_00"); //How are you?
	AI_Output(self, other, "Info_Mine_Grd_7_DieLage_07_01"); //Man, you're getting on my nerves!
};

// *************************************************************************
// -------------------------------------------------------------------------

func void B_AssignAmbientInfos_Mine_grd_7(var C_Npc slf)
{
	Info_Mine_Grd_7_EXIT.npc = Hlp_GetInstanceID(slf);
	Info_Mine_Grd_7_Mine.npc = Hlp_GetInstanceID(slf);
	Info_Mine_Grd_7_WichtigePersonen.npc = Hlp_GetInstanceID(slf);
	Info_Mine_Grd_7_Minecrawler.npc = Hlp_GetInstanceID(slf);
	Info_Mine_Grd_7_DieLage.npc = Hlp_GetInstanceID(slf);
};
