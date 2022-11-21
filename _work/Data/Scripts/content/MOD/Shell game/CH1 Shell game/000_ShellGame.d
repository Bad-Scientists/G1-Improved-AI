/*
 *	Shell game :)
 */

const string TEXT_SHELLGAME_CORRECT = "Correct"; //"Správně";
const string TEXT_SHELLGAME_INCORRECT = "Wrong!"; //"Špatně!";

//Status of the game
var int shellGame_Status;
	const int cShellGame_Idle = 0;
	const int cShellGame_NewGame = 1;
	const int cShellGame_Timer = 2;
	const int cShellGame_Start = 3;
	const int cShellGame_ShowCoin = 4;
	const int cShellGame_HideCoin = 5;
	const int cShellGame_Shuffle = 6;
	const int cShellGame_GameReady = 7;
	const int cShellGame_Dialogue = 8;
	const int cShellGame_RevealCoin = 9;
	const int cShellGame_CoinRevealed = 10;

const int cShellGame_Timer_NewGame = 5;

//
const int cShellGame_Position_Left = 43;
const int cShellGame_Position_Middle = 44;
const int cShellGame_Position_Right = 45;

//Flags for shell movement directions (2^n as cup can have multiple directions at one time - left + right...)
const int cShellGame_Dir_None = 0;
const int cShellGame_Dir_MoveUp = 1;
const int cShellGame_Dir_MoveDown = 2;
const int cShellGame_Dir_MoveLeftUp = 4;
const int cShellGame_Dir_MoveLeftDown = 8;
const int cShellGame_Dir_MoveMiddleUp = 16;
const int cShellGame_Dir_MoveMiddleDown = 32;
const int cShellGame_Dir_MoveRightUp = 64;
const int cShellGame_Dir_MoveRightDown = 128;

//3 main cups, which will move around
var int shellGame_Cup1;
var int shellGame_Cup1_Dir;

var int shellGame_Cup2;
var int shellGame_Cup2_Dir;

var int shellGame_Cup3;
var int shellGame_Cup3_Dir;

//No of shuffles
var int shellGame_Shuffles;
//Identifier of cup with coin
var int shellGame_CupCoin;
//Players tip
var int shellGame_PlayersTip;

//Movement speed
var int shellGame_DifficultyCounter;
var int shellGame_Speed;
var int shellGame_MinNoOfShuffles;

var int shellGame_WinsCounter;
var int shellGame_LossCounter;

var int shellGame_DexterityBonusCounter;
var int shellGame_DexterityBonusCounter_Total;

const int cShellGame_DexterityBonus_Max = 5;

func void ShellGame_Reset () {
	//Hide visuals of all help objects
	Vob_ChangeDataByName ("VOB_GAME_CUP_RIGHT", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_RIGHT_UP", 0, 0, 0, 0);

	Vob_ChangeDataByName ("VOB_GAME_CUP_MIDDLE", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_MIDDLE_UP", 0, 0, 0, 0);

	Vob_ChangeDataByName ("VOB_GAME_CUP_LEFT", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_LEFT_UP", 0, 0, 0, 0);

	Vob_ChangeDataByName ("VOB_GAME_COIN_LEFT", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_COIN_MIDDLE", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_COIN_RIGHT", 0, 0, 0, 0);

	Vob_ChangeDataByName ("VOB_GAME_CUP_01", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_02", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_03", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_04", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_05", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_06", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_07", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_08", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_09", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_10", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_11", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_12", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_13", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_14", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_15", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_16", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_17", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_18", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_19", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_20", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_21", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_22", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_23", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_24", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_25", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_26", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_27", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_28", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_29", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_30", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_31", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_32", 0, 0, 0, 0);

	Vob_ChangeDataByName ("VOB_GAME_CUP_33", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_34", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_35", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_36", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_37", 0, 0, 0, 0);

	Vob_ChangeDataByName ("VOB_GAME_CUP_38", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_39", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_40", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_41", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_42", 0, 0, 0, 0);

	//Move to starting position
	Vob_MoveToVob ("VOB_GAME_CUP_MAIN_RIGHT", "VOB_GAME_CUP_RIGHT");
	Vob_MoveToVob ("VOB_GAME_CUP_MAIN_MIDDLE", "VOB_GAME_CUP_MIDDLE");
	Vob_MoveToVob ("VOB_GAME_CUP_MAIN_LEFT", "VOB_GAME_CUP_LEFT");

	//Show visual of 3 main moving cups
	Vob_ChangeDataByName ("VOB_GAME_CUP_MAIN_RIGHT", 0, 0, 0, 1);
	Vob_ChangeDataByName ("VOB_GAME_CUP_MAIN_MIDDLE", 0, 0, 0, 1);
	Vob_ChangeDataByName ("VOB_GAME_CUP_MAIN_LEFT", 0, 0, 0, 1);

	//Show visual of the table
	Vob_ChangeDataByName ("VOB_SHELL_GAME_TABLE", 1, 1, 1, 1);

	//Reset positions and movement directinos
	shellGame_Cup1 = cShellGame_Position_Left;
	shellGame_Cup1_Dir = 0;

	shellGame_Cup2 = cShellGame_Position_Middle;
	shellGame_Cup2_Dir = 0;

	shellGame_Cup3 = cShellGame_Position_Right;
	shellGame_Cup3_Dir = 0;
};

func void InitQuest_CH1_ShellGame () {
	MEM_InitAll ();

	//Reset game (this will show some visuals ... so we have to hide them again :))
	ShellGame_Reset ();

	//Hide visuals of main 3 cups
	Vob_ChangeDataByName ("VOB_GAME_CUP_MAIN_RIGHT", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_MAIN_MIDDLE", 0, 0, 0, 0);
	Vob_ChangeDataByName ("VOB_GAME_CUP_MAIN_LEFT", 0, 0, 0, 0);

	//Hide visual of the table
	Vob_ChangeDataByName ("VOB_SHELL_GAME_TABLE", 0, 0, 0, 0);

	//Initial speed
	shellGame_Speed = mkf(3);

	//Min no of moves
	shellGame_MinNoOfShuffles = 6;

	//Reset counters
	shellGame_WinsCounter = 0;
	shellGame_LossCounter = 0;
	shellGame_DifficultyCounter = 0;

	shellGame_DexterityBonusCounter = 0;

	shellGame_Status = cShellGame_Idle;
};
