// ************************************************************
// 			  				   EXIT
// ************************************************************

instance DIA_ARTO_EXIT(C_INFO)
{
	npc = Ebr_102_Arto;
	nr = 999;
	condition = DIA_ARTO_EXIT_Condition;
	information = DIA_ARTO_EXIT_Info;
	permanent = 1;
	description = DIALOG_ENDE;
};

func int DIA_ARTO_EXIT_Condition()
{
	return 1;
};

func void DIA_ARTO_EXIT_Info()
{
	AI_StopProcessInfos(self);
};

// ************************************************************
// 							Hallo
// ************************************************************

instance DIA_ARTO_Hello(C_INFO)
{
	npc = Ebr_102_Arto;
	nr = 3;
	condition = DIA_ARTO_Hello_Condition;
	information = DIA_ARTO_Hello_Info;
	permanent = 0;
	description = "Who are you?";
};

func int DIA_ARTO_Hello_Condition()
{
	return 1;
};

func void DIA_ARTO_Hello_Info()
{
	AI_Output(other, self, "DIA_ARTO_Hello_15_00"); //Who are you?
	AI_Output(self, other, "DIA_ARTO_Hello_13_01"); //I'm Arto.
};

// ************************************************************
// 							What
// ************************************************************

instance DIA_ARTO_What(C_INFO)
{
	npc = Ebr_102_Arto;
	nr = 3;
	condition = DIA_ARTO_What_Condition;
	information = DIA_ARTO_What_Info;
	permanent = 0;
	description = "What do you do round here?";
};

func int DIA_ARTO_What_Condition()
{
	if (Npc_KnowsInfo(hero, DIA_ARTO_Hello))
	{
		return 1;
	};
};

func void DIA_ARTO_What_Info()
{
	AI_Output(other, self, "DIA_ARTO_What_15_00"); //What do you do around here?
	AI_Output(self, other, "DIA_ARTO_What_13_01"); //I'm Gomez' bodyguard.
};

// ************************************************************
// 							PERM
// ************************************************************

instance DIA_ARTO_PERM(C_INFO)
{
	npc = Ebr_102_Arto;
	nr = 3;
	condition = DIA_ARTO_PERM_Condition;
	information = DIA_ARTO_PERM_Info;
	permanent = 1;
	description = "You don't talk much, do you?";
};

func int DIA_ARTO_PERM_Condition()
{
	if (Npc_KnowsInfo(hero, DIA_ARTO_What))
	{
		return 1;
	};
};

func void DIA_ARTO_PERM_Info()
{
	AI_Output(other, self, "DIA_ARTO_PERM_15_00"); //You don't talk much, do you?
	AI_Output(self, other, "DIA_ARTO_PERM_13_01"); //Nope.
};
