//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
// Publikum 1 ////////////////////////////////////////
//////////////////////////////////////////////////////////////

instance IEFan1_EXIT(C_INFO)
{
	npc = IEFan1;
	nr = 999;
	condition = IEFan1_EXIT_Condition;
	information = IEFan1_EXIT_Info;
	important = 0;
	permanent = 1;
	description = DIALOG_ENDE;
};

func int IEFan1_EXIT_Condition()
{
	return 1;
};

func void IEFan1_EXIT_Info()
{
	AI_StopProcessInfos(self);
};

//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
// Publikum 2 ////////////////////////////////////////
//////////////////////////////////////////////////////////////

instance IEFan2_EXIT(C_INFO)
{
	npc = IEFan2;
	nr = 999;
	condition = IEFan2_EXIT_Condition;
	information = IEFan2_EXIT_Info;
	important = 0;
	permanent = 1;
	description = DIALOG_ENDE;
};

func int IEFan2_EXIT_Condition()
{
	return 1;
};

func void IEFan2_EXIT_Info()
{
	AI_StopProcessInfos(self);
};

//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
// Publikum 3 ////////////////////////////////////////
//////////////////////////////////////////////////////////////

instance IEFan3_EXIT(C_INFO)
{
	npc = IEFan3;
	nr = 999;
	condition = IEFan3_EXIT_Condition;
	information = IEFan3_EXIT_Info;
	important = 0;
	permanent = 1;
	description = DIALOG_ENDE;
};

func int IEFan3_EXIT_Condition()
{
	return 1;
};

func void IEFan3_EXIT_Info()
{
	AI_StopProcessInfos(self);
};

//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
// Publikum 4 ////////////////////////////////////////
//////////////////////////////////////////////////////////////

instance IEFan4_EXIT(C_INFO)
{
	npc = IEFan4;
	nr = 999;
	condition = IEFan4_EXIT_Condition;
	information = IEFan4_EXIT_Info;
	important = 0;
	permanent = 1;
	description = DIALOG_ENDE;
};

func int IEFan4_EXIT_Condition()
{
	return 1;
};

func void IEFan4_EXIT_Info()
{
	AI_StopProcessInfos(self);
};
