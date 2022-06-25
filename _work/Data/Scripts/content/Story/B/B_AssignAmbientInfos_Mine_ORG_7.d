// *************************************************************************
// 									Kapitel 1
// *************************************************************************

// *************************************************************************
// 									EXIT
// *************************************************************************

instance Info_Mine_Org_7_EXIT(C_INFO)
{
	// npc wird in B_AssignAmbientInfos_Org_7 (s.u.) jeweils gesetzt
	nr = 999;
	condition = Info_Mine_Org_7_EXIT_Condition;
	information = Info_Mine_Org_7_EXIT_Info;
	permanent = 1;
	description = "END";
};

func int Info_Mine_Org_7_EXIT_Condition()
{
	return 1;
};

func void Info_Mine_Org_7_EXIT_Info()
{
	AI_StopProcessInfos(self);
};

// *************************************************************************
// 							Mine
// *************************************************************************

instance Info_Mine_Org_7_Mine(C_INFO) // E1
{
	nr = 1;
	condition = Info_Mine_Org_7_Mine_Condition;
	information = Info_Mine_Org_7_Mine_Info;
	permanent = 1;
	description = "Tell me something about this camp.";
};

func int Info_Mine_Org_7_Mine_Condition()
{
	return 1;
};

func void Info_Mine_Org_7_Mine_Info()
{
	AI_Output(other, self, "Info_Mine_Org_7_Mine_15_00"); //Tell me something about this camp.
	AI_Output(self, other, "Info_Mine_Org_7_Mine_07_01"); //The camp? You mean the Hollow. It ain't so bad, really. The scrapers collect ore, the mercenaries stand on guard, and we rogues keep 'em all under control.
};

// *************************************************************************
// 							Wichtige Personen
// *************************************************************************

instance Info_Mine_Org_7_WichtigePersonen(C_INFO)
{
	nr = 1;
	condition = Info_Mine_Org_7_WichtigePersonen_Condition;
	information = Info_Mine_Org_7_WichtigePersonen_Info;
	permanent = 1;
	description = "Who's in charge here then?";
};

func int Info_Mine_Org_7_WichtigePersonen_Condition()
{
	return 1;
};

func void Info_Mine_Org_7_WichtigePersonen_Info()
{
	AI_Output(other, self, "Info_Mine_Org_7_WichtigePersonen_15_00"); //Who's in charge here then?
	AI_Output(self, other, "Info_Mine_Org_7_WichtigePersonen_07_01"); //That depends on who you take your orders from.
	AI_Output(self, other, "Info_Mine_Org_7_WichtigePersonen_07_02"); //Whatever, if Okyl wants something, you'll do well not to object. He can get pretty ugly when he's pissed off.
};

// *************************************************************************
// 									Die Lage
// *************************************************************************

instance Info_Mine_Org_7_DieLage(C_INFO) // E1
{
	nr = 1;
	condition = Info_Mine_Org_7_DieLage_Condition;
	information = Info_Mine_Org_7_DieLage_Info;
	permanent = 1;
	description = "How are you?";
};

func int Info_Mine_Org_7_DieLage_Condition()
{
	return 1;
};

func void Info_Mine_Org_7_DieLage_Info()
{
	AI_Output(other, self, "Info_Mine_Org_7_DieLage_15_00"); //How are you?
	AI_Output(self, other, "Info_Mine_Org_7_DieLage_07_01"); //Man, you're getting on my nerves!
};

// *************************************************************************
// -------------------------------------------------------------------------

func void B_AssignAmbientInfos_Mine_Org_7(var C_Npc slf)
{
	Info_Mine_Org_7_EXIT.npc = Hlp_GetInstanceID(slf);
	Info_Mine_Org_7_Mine.npc = Hlp_GetInstanceID(slf);
	Info_Mine_Org_7_WichtigePersonen.npc = Hlp_GetInstanceID(slf);
	Info_Mine_Org_7_DieLage.npc = Hlp_GetInstanceID(slf);
};
