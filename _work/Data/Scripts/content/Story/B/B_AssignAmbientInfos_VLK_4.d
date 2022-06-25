// *************************************************************************
// 									Kapitel 1
// *************************************************************************

// *************************************************************************
// 									EXIT
// *************************************************************************

instance Info_Vlk_4_EXIT(C_INFO)
{
	// npc wird in B_AssignAmbientInfos_Vlk_4 (s.u.) jeweils gesetzt
	nr = 999;
	condition = Info_Vlk_4_EXIT_Condition;
	information = Info_Vlk_4_EXIT_Info;
	permanent = 1;
	description = "END";
};

func int Info_Vlk_4_EXIT_Condition()
{
	return 1;
};

func void Info_Vlk_4_EXIT_Info()
{
	AI_Output(other, self, "Info_Vlk_4_EinerVonEuchWerden_15_00"); //Thanks. Good luck.
	AI_Output(self, other, "Info_Vlk_4_EinerVonEuchWerden_04_01"); //Chin up, boy.
	AI_StopProcessInfos(self);
};

// *************************************************************************
// 								Einer von Euch werden
// *************************************************************************

instance Info_Vlk_4_EinerVonEuchWerden(C_INFO) // E1
{
	nr = 4;
	condition = Info_Vlk_4_EinerVonEuchWerden_Condition;
	information = Info_Vlk_4_EinerVonEuchWerden_Info;
	permanent = 1;
	description = "What do I have to do to join this camp?";
};

func int Info_Vlk_4_EinerVonEuchWerden_Condition()
{
	if (Npc_GetTrueGuild(other) == GIL_NONE)
	{
		return TRUE;
	};
};

func void Info_Vlk_4_EinerVonEuchWerden_Info()
{
	AI_Output(other, self, "Info_Vlk_4_EinerVonEuchWerden_15_01"); //What do I have to do to join this camp?
	AI_Output(self, other, "Info_Vlk_4_EinerVonEuchWerden_04_04"); //You mean as a Shadow or a guard? That won't be easy, man. You'll have to pass a few tests before old Thorus'll let you see Gomez.
	AI_Output(self, other, "Info_Vlk_4_EinerVonEuchWerden_04_02"); //And you'll have to get on the right side of people here. But as long as you don't belong to any camp, nobody's gonna take you seriously.
	AI_Output(self, other, "Info_Vlk_4_EinerVonEuchWerden_04_03"); //if I were you, I'd have a word with some of the Shadows. Maybe you'll find one of them who's willing to help you. if you offer them something in return, that is.

	var C_Npc Thorus; Thorus = Hlp_GetNpc(GRD_200_Thorus);
	Thorus.aivar[AIV_FINDABLE] = TRUE;
};

// *************************************************************************
// 							Wichtige Personen
// *************************************************************************

instance Info_Vlk_4_WichtigePersonen(C_INFO)
{
	nr = 3;
	condition = Info_Vlk_4_WichtigePersonen_Condition;
	information = Info_Vlk_4_WichtigePersonen_Info;
	permanent = 1;
	description = "Is there anyone special here I should know?";
};

func int Info_Vlk_4_WichtigePersonen_Condition()
{
	return 1;
};

func void Info_Vlk_4_WichtigePersonen_Info()
{
	AI_Output(other, self, "Info_Vlk_4_WichtigePersonen_15_00"); //Is there anyone special here who I should know?
	AI_Output(self, other, "Info_Vlk_4_WichtigePersonen_04_01"); //Being new, you'd better make sure you don't fall out with Gravo. He may only be a digger, but he knows how to deal with the Ore Barons.
	AI_Output(self, other, "Info_Vlk_4_WichtigePersonen_04_02"); //if you get into trouble with Gomez' bunch, he can help you get out of it.
};

// *************************************************************************
// 								Das Lager (Orts-Infos)
// *************************************************************************

instance Info_Vlk_4_DasLager(C_INFO)
{
	nr = 2;
	condition = Info_Vlk_4_DasLager_Condition;
	information = Info_Vlk_4_DasLager_Info;
	permanent = 1;
	description = "What places around here should I know about?";
};

func int Info_Vlk_4_DasLager_Condition()
{
	if (Npc_GetTrueGuild(hero) == GIL_NONE)
	{
		return 1;
	};
};

func void Info_Vlk_4_DasLager_Info()
{
	AI_Output(other, self, "Info_Vlk_4_DasLager_15_00"); //What places around here should I know about?
	AI_Output(self, other, "Info_Vlk_4_DasLager_04_01"); //Unless you fancy digging in the mines, you should hang around in between the northern gate and the castle gate.
	AI_Output(self, other, "Info_Vlk_4_DasLager_04_02"); //if you're lucky, Thorus or Diego might give you something to do for them - that'll give you a chance to get on the right side of them. It can't hurt to get in with Gomez' people.
	AI_Output(self, other, "Info_Vlk_4_DasLager_04_03"); //Or you might meet a mage. They sometimes ask folks to do errands for 'em. And they pay well.
	AI_Output(other, self, "Info_Vlk_4_DasLager_15_04"); //The mages come out of the castle? When?
	AI_Output(self, other, "Info_Vlk_4_DasLager_04_05"); //What do I know. Ask the folks that live there.
};

// *************************************************************************
// 									Die Lage
// *************************************************************************

instance Info_Vlk_4_DieLage(C_INFO) // E1
{
	nr = 1;
	condition = Info_Vlk_4_DieLage_Condition;
	information = Info_Vlk_4_DieLage_Info;
	permanent = 1;
	description = "You okay?";
};

func int Info_Vlk_4_DieLage_Condition()
{
	return 1;
};

func void Info_Vlk_4_DieLage_Info()
{
	AI_Output(other, self, "Info_Vlk_4_DieLage_15_00"); //You okay?
	AI_Output(self, other, "Info_Vlk_4_DieLage_04_01"); //As okay as I was 20 years ago. Nothing much has changed since then.
};

// *************************************************************************
// -------------------------------------------------------------------------

func void B_AssignAmbientInfos_Vlk_4(var C_Npc slf)
{
	B_AssignFindNpc_OC(slf);

	Info_Vlk_4_EXIT.npc = Hlp_GetInstanceID(slf);
	Info_Vlk_4_EinerVonEuchWerden.npc = Hlp_GetInstanceID(slf);
	Info_Vlk_4_WichtigePersonen.npc = Hlp_GetInstanceID(slf);
	Info_Vlk_4_DasLager.npc = Hlp_GetInstanceID(slf);
	Info_Vlk_4_DieLage.npc = Hlp_GetInstanceID(slf);
};
