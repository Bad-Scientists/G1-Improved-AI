// *************************************************************************
// 									Kapitel 1
// *************************************************************************

// *************************************************************************
// 									EXIT
// *************************************************************************

instance Info_Nov_3_EXIT(C_INFO)
{
	// npc wird in B_AssignAmbientInfos_Nov_3 (s.u.) jeweils gesetzt
	nr = 999;
	condition = Info_Nov_3_EXIT_Condition;
	information = Info_Nov_3_EXIT_Info;
	permanent = 1;
	description = "END";
};

func int Info_Nov_3_EXIT_Condition()
{
	return 1;
};

func void Info_Nov_3_EXIT_Info()
{
	AI_StopProcessInfos(self);
};

// *************************************************************************
// 								Einer von Euch werden
// *************************************************************************

instance Info_Nov_3_EinerVonEuchWerden(C_INFO) // E1
{
	nr = 4;
	condition = Info_Nov_3_EinerVonEuchWerden_Condition;
	information = Info_Nov_3_EinerVonEuchWerden_Info;
	permanent = 1;
	description = "How can I join this camp?";
};

func int Info_Nov_3_EinerVonEuchWerden_Condition()
{
	if (Npc_GetTrueGuild(other) == GIL_NONE)
	{
		return TRUE;
	};
};

func void Info_Nov_3_EinerVonEuchWerden_Info()
{
	AI_Output(other, self, "Info_Nov_3_EinerVonEuchWerden_15_00"); //How can I join this camp?
	AI_Output(self, other, "Info_Nov_3_EinerVonEuchWerden_03_01"); //It's simple. Just let go, man.
	AI_Output(self, other, "Info_Nov_3_EinerVonEuchWerden_03_02"); //Talk to the Gurus, they will guide you!
};

// *************************************************************************
// 							Wichtige Personen
// *************************************************************************

instance Info_Nov_3_WichtigePersonen(C_INFO)
{
	nr = 3;
	condition = Info_Nov_3_WichtigePersonen_Condition;
	information = Info_Nov_3_WichtigePersonen_Info;
	permanent = 1;
	description = "Who's the boss round here?";
};

func int Info_Nov_3_WichtigePersonen_Condition()
{
	return 1;
};

func void Info_Nov_3_WichtigePersonen_Info()
{
	AI_Output(other, self, "Info_Nov_3_WichtigePersonen_15_00"); //Who's the boss round here?
	AI_Output(self, other, "Info_Nov_3_WichtigePersonen_03_01"); //Y'Berion! The Sleeper be praised! He brought us to this glorious place.
	AI_Output(self, other, "Info_Nov_3_WichtigePersonen_03_02"); //All this was created through his visions.
};

// *************************************************************************
// 								Das Lager (Orts-Infos)
// *************************************************************************

instance Info_Nov_3_DasLager(C_INFO)
{
	nr = 2;
	condition = Info_Nov_3_DasLager_Condition;
	information = Info_Nov_3_DasLager_Info;
	permanent = 1;
	description = "Is there anywhere important here where I should go?";
};

func int Info_Nov_3_DasLager_Condition()
{
	return 1;
};

func void Info_Nov_3_DasLager_Info()
{
	AI_Output(other, self, "Info_Nov_3_DasLager_15_00"); //Is there anywhere important here where I should go?
	AI_Output(self, other, "Info_Nov_3_DasLager_03_01"); //There's Fortuno. He gives free swampweed to all the followers of the sect.
	AI_Output(self, other, "Info_Nov_3_DasLager_03_02"); //You'll find him under Cor Kalom's alchemy lab.

	var C_Npc CorKalom; CorKalom = Hlp_GetNpc(Gur_1201_CorKalom);
	CorKalom.aivar[AIV_FINDABLE] = TRUE;
};

// *************************************************************************
// 									Die Lage
// *************************************************************************

instance Info_Nov_3_DieLage(C_INFO) // E1
{
	nr = 1;
	condition = Info_Nov_3_DieLage_Condition;
	information = Info_Nov_3_DieLage_Info;
	permanent = 1;
	description = "How are you?";
};

func int Info_Nov_3_DieLage_Condition()
{
	return 1;
};

func void Info_Nov_3_DieLage_Info()
{
	AI_Output(other, self, "Info_Nov_3_DieLage_15_00"); //How are you?
	AI_Output(self, other, "Info_Nov_3_DieLage_03_01"); //I'm real high, man!
};

// *************************************************************************
// -------------------------------------------------------------------------

func void B_AssignAmbientInfos_Nov_3(var C_Npc slf)
{
	B_AssignFindNpc_ST(slf);

	Info_Nov_3_EXIT.npc = Hlp_GetInstanceID(slf);
	Info_Nov_3_EinerVonEuchWerden.npc = Hlp_GetInstanceID(slf);
	Info_Nov_3_WichtigePersonen.npc = Hlp_GetInstanceID(slf);
	Info_Nov_3_DasLager.npc = Hlp_GetInstanceID(slf);
	Info_Nov_3_DieLage.npc = Hlp_GetInstanceID(slf);
};
