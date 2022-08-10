const int TETRISROWS = 20;
const int TETRISCOLUMNS = 11;
const int TETRISMATRIXSIZE = 5;

const int TETRISTILEWIDTH = 20;
const int TETRISTILEHEIGHT = 20;

var int tetrisEnabled;
var int tetrisScore;

var int tetrisRow;
var int tetrisCol;

var int tetrominoeCurrent;
var int tetrominoeNext;

var int tetrisLineCompleted;
var int tetrisLineCompletedDelay;

var int tetrisGameOver;

//5 x 2 x 7
const int tetrominoes [70] = {
	1, 1, 1, 1, 0,
	0, 0, 0, 0, 0,

	0, 2, 0, 0, 0,
	0, 2, 2, 2, 0,

	0, 0, 0, 3, 0,
	0, 3, 3, 3, 0,

	0, 4, 4, 0, 0,
	0, 4, 4, 0, 0,

	0, 0, 5, 5, 0,
	0, 5, 5, 0, 0,

	0, 0, 6, 0, 0,
	0, 6, 6, 6, 0,

	0, 7, 7, 0, 0,
	0, 0, 7, 7, 0
};

var int tetrominoeMatrix[25]; //current tetrominoe
var int oldTetrominoeMatrix[25]; //used for rotation

var int tetrominoeMatrixNext[25]; //next tetrominoe

//Gothic arrays suck :-/
var int tetrisRow00[TETRISCOLUMNS];
var int tetrisRow01[TETRISCOLUMNS];
var int tetrisRow02[TETRISCOLUMNS];
var int tetrisRow03[TETRISCOLUMNS];
var int tetrisRow04[TETRISCOLUMNS];
var int tetrisRow05[TETRISCOLUMNS];
var int tetrisRow06[TETRISCOLUMNS];
var int tetrisRow07[TETRISCOLUMNS];
var int tetrisRow08[TETRISCOLUMNS];
var int tetrisRow09[TETRISCOLUMNS];
var int tetrisRow10[TETRISCOLUMNS];
var int tetrisRow11[TETRISCOLUMNS];
var int tetrisRow12[TETRISCOLUMNS];
var int tetrisRow13[TETRISCOLUMNS];
var int tetrisRow14[TETRISCOLUMNS];
var int tetrisRow15[TETRISCOLUMNS];
var int tetrisRow16[TETRISCOLUMNS];
var int tetrisRow17[TETRISCOLUMNS];
var int tetrisRow18[TETRISCOLUMNS];
var int tetrisRow19[TETRISCOLUMNS];

var int tetrisPreviewRow01[TETRISMATRIXSIZE];
var int tetrisPreviewRow02[TETRISMATRIXSIZE];
var int tetrisPreviewRow03[TETRISMATRIXSIZE];
var int tetrisPreviewRow04[TETRISMATRIXSIZE];
var int tetrisPreviewRow05[TETRISMATRIXSIZE];

var int tetrisGameOverView;

var int tetrisScoreView;
var int tetrisScoreViewFrame;

class TetrisTile {
	var int v; //view ptr
	var int tileType;
};

instance TetrisTile@ (TetrisTile);

func void TetrisTilePtr_SetType (var int ptr, var int tileType) {
	if (!ptr) { return; };

	var TetrisTile t; t = _^ (ptr);
	t.tileType = tileType;

	if (tileType == 0) { ViewPtr_SetTexture (t.v, "TILESBACK.TGA"); } else
	if (tileType == 1) { ViewPtr_SetTexture (t.v, "TILESYELLOW.TGA"); } else
	if (tileType == 2) { ViewPtr_SetTexture (t.v, "TILESORANGE.TGA"); } else
	if (tileType == 3) { ViewPtr_SetTexture (t.v, "TILESPINK.TGA"); } else
	if (tileType == 4) { ViewPtr_SetTexture (t.v, "TILESGREY.TGA"); } else
	if (tileType == 5) { ViewPtr_SetTexture (t.v, "TILESBLUE.TGA"); } else
	if (tileType == 6) { ViewPtr_SetTexture (t.v, "TILESGREEN.TGA"); } else
	if (tileType == 7) { ViewPtr_SetTexture (t.v, "TILESLIGHTBLUE.TGA"); };
};

func int Create_TetrisTilePtr (var int v, var int tileType) {
	var int ptr; ptr = create (TetrisTile@);

	var TetrisTile t; t = _^ (ptr);
	t.v = v;

	TetrisTilePtr_SetType (ptr, tileType);
	return ptr;
};

func void Tetris_SetTilePtr (var int row, var int col, var int tileData) {
	//Safety checks
	if ((row < 0) || (row >= TETRISROWS)) { return; };
	if ((col < 0) || (col >= TETRISCOLUMNS)) { return; }; //index starts at 0

	if (row == 00) { MEM_WriteStatArr (_@ (tetrisRow00[0]), col, tileData); } else
	if (row == 01) { MEM_WriteStatArr (_@ (tetrisRow01[0]), col, tileData); } else
	if (row == 02) { MEM_WriteStatArr (_@ (tetrisRow02[0]), col, tileData); } else
	if (row == 03) { MEM_WriteStatArr (_@ (tetrisRow03[0]), col, tileData); } else
	if (row == 04) { MEM_WriteStatArr (_@ (tetrisRow04[0]), col, tileData); } else
	if (row == 05) { MEM_WriteStatArr (_@ (tetrisRow05[0]), col, tileData); } else
	if (row == 06) { MEM_WriteStatArr (_@ (tetrisRow06[0]), col, tileData); } else
	if (row == 07) { MEM_WriteStatArr (_@ (tetrisRow07[0]), col, tileData); } else
	if (row == 08) { MEM_WriteStatArr (_@ (tetrisRow08[0]), col, tileData); } else
	if (row == 09) { MEM_WriteStatArr (_@ (tetrisRow09[0]), col, tileData); } else
	if (row == 10) { MEM_WriteStatArr (_@ (tetrisRow10[0]), col, tileData); } else
	if (row == 11) { MEM_WriteStatArr (_@ (tetrisRow11[0]), col, tileData); } else
	if (row == 12) { MEM_WriteStatArr (_@ (tetrisRow12[0]), col, tileData); } else
	if (row == 13) { MEM_WriteStatArr (_@ (tetrisRow13[0]), col, tileData); } else
	if (row == 14) { MEM_WriteStatArr (_@ (tetrisRow14[0]), col, tileData); } else
	if (row == 15) { MEM_WriteStatArr (_@ (tetrisRow15[0]), col, tileData); } else
	if (row == 16) { MEM_WriteStatArr (_@ (tetrisRow16[0]), col, tileData); } else
	if (row == 17) { MEM_WriteStatArr (_@ (tetrisRow17[0]), col, tileData); } else
	if (row == 18) { MEM_WriteStatArr (_@ (tetrisRow18[0]), col, tileData); } else
	if (row == 19) { MEM_WriteStatArr (_@ (tetrisRow19[0]), col, tileData); };
};

func int Tetris_GetTilePtr (var int row, var int col) {
	//Safety checks
	if ((row < 0) || (row >= TETRISROWS)) { return 0; };
	if ((col < 0) || (col >= TETRISCOLUMNS)) { return 0; };

	if (row == 00) { return MEM_ReadStatArr (_@ (tetrisRow00[0]), col); } else
	if (row == 01) { return MEM_ReadStatArr (_@ (tetrisRow01[0]), col); } else
	if (row == 02) { return MEM_ReadStatArr (_@ (tetrisRow02[0]), col); } else
	if (row == 03) { return MEM_ReadStatArr (_@ (tetrisRow03[0]), col); } else
	if (row == 04) { return MEM_ReadStatArr (_@ (tetrisRow04[0]), col); } else
	if (row == 05) { return MEM_ReadStatArr (_@ (tetrisRow05[0]), col); } else
	if (row == 06) { return MEM_ReadStatArr (_@ (tetrisRow06[0]), col); } else
	if (row == 07) { return MEM_ReadStatArr (_@ (tetrisRow07[0]), col); } else
	if (row == 08) { return MEM_ReadStatArr (_@ (tetrisRow08[0]), col); } else
	if (row == 09) { return MEM_ReadStatArr (_@ (tetrisRow09[0]), col); } else
	if (row == 10) { return MEM_ReadStatArr (_@ (tetrisRow10[0]), col); } else
	if (row == 11) { return MEM_ReadStatArr (_@ (tetrisRow11[0]), col); } else
	if (row == 12) { return MEM_ReadStatArr (_@ (tetrisRow12[0]), col); } else
	if (row == 13) { return MEM_ReadStatArr (_@ (tetrisRow13[0]), col); } else
	if (row == 14) { return MEM_ReadStatArr (_@ (tetrisRow14[0]), col); } else
	if (row == 15) { return MEM_ReadStatArr (_@ (tetrisRow15[0]), col); } else
	if (row == 16) { return MEM_ReadStatArr (_@ (tetrisRow16[0]), col); } else
	if (row == 17) { return MEM_ReadStatArr (_@ (tetrisRow17[0]), col); } else
	if (row == 18) { return MEM_ReadStatArr (_@ (tetrisRow18[0]), col); } else
	if (row == 19) { return MEM_ReadStatArr (_@ (tetrisRow19[0]), col); };

	return 0;
};

func void TetrisPreview_SetTilePtr (var int row, var int col, var int tileData) {
	//Safety checks
	if ((row < 0) || (row >= TETRISMATRIXSIZE)) { return; };
	if ((col < 0) || (col >= TETRISMATRIXSIZE)) { return; }; //index starts at 0

	if (row == 00) { MEM_WriteStatArr (_@ (tetrisPreviewRow01[0]), col, tileData); } else
	if (row == 01) { MEM_WriteStatArr (_@ (tetrisPreviewRow02[0]), col, tileData); } else
	if (row == 02) { MEM_WriteStatArr (_@ (tetrisPreviewRow03[0]), col, tileData); } else
	if (row == 03) { MEM_WriteStatArr (_@ (tetrisPreviewRow04[0]), col, tileData); } else
	if (row == 04) { MEM_WriteStatArr (_@ (tetrisPreviewRow05[0]), col, tileData); };
};

func int TetrisPreview_GetTilePtr (var int row, var int col) {
	//Safety checks
	if ((row < 0) || (row >= TETRISMATRIXSIZE)) { return 0; };
	if ((col < 0) || (col >= TETRISMATRIXSIZE)) { return 0; };

	if (row == 00) { return MEM_ReadStatArr (_@ (tetrisPreviewRow01[0]), col); } else
	if (row == 01) { return MEM_ReadStatArr (_@ (tetrisPreviewRow02[0]), col); } else
	if (row == 02) { return MEM_ReadStatArr (_@ (tetrisPreviewRow03[0]), col); } else
	if (row == 03) { return MEM_ReadStatArr (_@ (tetrisPreviewRow04[0]), col); } else
	if (row == 04) { return MEM_ReadStatArr (_@ (tetrisPreviewRow05[0]), col); };

	return 0;
};

func int Tetris_GetTileType (var int row, var int col) {
	var int ptr; ptr = Tetris_GetTilePtr (row, col);
	if (!ptr) { return -1; }; //out of bounds

	var TetrisTile t; t = _^ (ptr);
	return t.tileType;
};

func void Tetris_SetTileType (var int row, var int col, var int tileType) {
	var int ptr; ptr = Tetris_GetTilePtr (row, col);
	TetrisTilePtr_SetType (ptr, tileType);
};

func void TetrisPreview_SetTileType (var int row, var int col, var int tileType) {
	var int ptr; ptr = TetrisPreview_GetTilePtr (row, col);
	TetrisTilePtr_SetType (ptr, tileType);
};

func void Tetrominoe_Load () {
	//Reset values
	repeat (i, TETRISMATRIXSIZE * TETRISMATRIXSIZE); var int i;
		MEM_WriteStatArr (_@ (tetrominoeMatrix[0]), i, 0);
		MEM_WriteStatArr (_@ (tetrominoeMatrixNext[0]), i, 0);
	end;

	//Load tetrominoes
	repeat (i, 2 * TETRISMATRIXSIZE);
		MEM_WriteStatArr (_@ (tetrominoeMatrix[0]), TETRISMATRIXSIZE + i, MEM_ReadStatArr (_@ (tetrominoes[0]), tetrominoeCurrent * TETRISMATRIXSIZE * 2 + i));
		MEM_WriteStatArr (_@ (tetrominoeMatrixNext[0]), TETRISMATRIXSIZE + i, MEM_ReadStatArr (_@ (tetrominoes[0]), tetrominoeNext * TETRISMATRIXSIZE * 2 + i));
	end;

	//Draw preview
	repeat (i, TETRISMATRIXSIZE * TETRISMATRIXSIZE);
		var int row; row = i / TETRISMATRIXSIZE; //div
		var int col; col = i % TETRISMATRIXSIZE; //mod

		var int tileType; tileType = MEM_ReadStatArr (_@ (tetrominoeMatrixNext[0]), i);

		TetrisPreview_SetTileType (row, col, tileType);
	end;

	//Update score
	ViewPtr_DeleteText (tetrisScoreView);
	var string s; s = ConcatStrings ("Score: ", IntToString (tetrisScore));
	ViewPtr_AddText (tetrisScoreView, 0, 0, s, "font_old_10_white.tga", -1);
};

func void Tetrominoe_Clear () {
	repeat (i, TETRISMATRIXSIZE * TETRISMATRIXSIZE); var int i;
		var int row; row = i / TETRISMATRIXSIZE; //div
		var int col; col = i % TETRISMATRIXSIZE; //mod

		var int tileType; tileType = MEM_ReadStatArr (_@ (tetrominoeMatrix[0]), i);

		if (tileType != 0) {
			Tetris_SetTileType (tetrisRow + row, tetrisCol + col, 0);
		};
	end;
};

func void Tetrominoe_Draw () {
	repeat (i, TETRISMATRIXSIZE * TETRISMATRIXSIZE); var int i;
		var int row; row = i / TETRISMATRIXSIZE; //div
		var int col; col = i % TETRISMATRIXSIZE; //mod

		var int tileType; tileType = MEM_ReadStatArr (_@ (tetrominoeMatrix[0]), i);

		if (tileType != 0) {
			Tetris_SetTileType (tetrisRow + row, tetrisCol + col, tileType);
		};
	end;
};

func void Tetrominoe_Rotate () {
	//Remember old matrix
	MEM_CopyBytes (_@ (tetrominoeMatrix), _@ (oldTetrominoeMatrix), TETRISMATRIXSIZE * TETRISMATRIXSIZE * 4);

	//Rotate by 90 degrees - clock-wise
	repeat (i, TETRISMATRIXSIZE * TETRISMATRIXSIZE); var int i;
		var int row; row = i / TETRISMATRIXSIZE; //div
		var int col; col = i % TETRISMATRIXSIZE; //mod

		MEM_WriteStatArr (_@ (tetrominoeMatrix[0]), ((TETRISMATRIXSIZE - 1) - row) + (col * TETRISMATRIXSIZE), MEM_ReadStatArr (_@ (oldTetrominoeMatrix[0]), i));
	end;
};

func void Tetrominoe_ResetRotation () {
	MEM_CopyBytes (_@ (oldTetrominoeMatrix), _@ (tetrominoeMatrix), TETRISMATRIXSIZE * TETRISMATRIXSIZE * 4);
};

func int Tetrominoe_IsValidPosition () {
	repeat (i, TETRISMATRIXSIZE * TETRISMATRIXSIZE); var int i;
		var int row; row = i / TETRISMATRIXSIZE; //div
		var int col; col = i % TETRISMATRIXSIZE; //mod

		var int tileType; tileType = MEM_ReadStatArr (_@ (tetrominoeMatrix[0]), i);

		if (tileType != 0) {
			if (Tetris_GetTileType (tetrisRow + row, tetrisCol + col) != 0) {
				return FALSE;
			};
		};
	end;

	return TRUE;
};

func void FF_Tetris_GameOverFadeInOut () {
	var int alpha;
	var int fadeOut;

	if (fadeOut) {
		alpha -= 16;
	} else {
		alpha += 16;
	};

	//Check boundaries min/max and set alpha
	if (alpha < 0) {
		alpha = 0;
		fadeOut = !fadeOut;
	} else
	if (alpha > 255) {
		alpha = 255;
		fadeOut = !fadeOut;
	};

	ViewPtr_SetAlpha (tetrisGameOverView, alpha);
};

func void Tetris_GameOver () {
	FF_Remove (FF_Tetris_RemoveCompletedLines);
	FF_Remove (FF_Tetris_Move_1s);

	var int posX;
	var int posY;

	posY = (PS_VMax - Print_ToVirtual (289, PS_Y)) / 2;
	posY = Print_ToPixel (posY, PS_Y);

	posX = (PS_VMax - Print_ToVirtual (397, PS_X)) / 2;
	posX = Print_ToPixel (posX, PS_X);

	tetrisGameOver = TRUE;

	tetrisGameOverView = ViewPtr_CreatePxl (posX, posY, posX + 397, posY + 289);
	ViewPtr_SetTexture (tetrisGameOverView, "TETRISGAMEOVER.TGA");
	ViewPtr_Open (tetrisGameOverView);
	ViewPtr_SetAlpha (tetrisGameOverView, 0);

	FF_ApplyOnceExtGT (FF_Tetris_GameOverFadeInOut, 60, -1);
};

func void Tetris_Destroy () {
	tetrisEnabled = FALSE;

	FF_Remove (FF_Tetris_RemoveCompletedLines);
	FF_Remove (FF_Tetris_Move_1s);
	FF_Remove (FF_Tetris_GameOverFadeInOut);

	var int ptr;
	var TetrisTile t;

	//Delete views - game
	repeat (i, TETRISROWS); var int i;
		repeat (j, TETRISCOLUMNS); var int j;
			ptr = Tetris_GetTilePtr (i, j);
			if (ptr) {
				t = _^ (ptr);
				ViewPtr_Delete (t.v);
			};
		end;
	end;

	////Delete views - preview
	repeat (i, TETRISMATRIXSIZE);
		repeat (j, TETRISMATRIXSIZE);
			ptr = TetrisPreview_GetTilePtr (i, j);
			if (ptr) {
				t = _^ (ptr);
				ViewPtr_Delete (t.v);
			};
		end;
	end;

	ViewPtr_DeleteText (tetrisScoreView);
	ViewPtr_Delete (tetrisScoreView);
	ViewPtr_Delete (tetrisScoreViewFrame);
};

func void Tetrominoe_GetNext () {
	//Check if we can remove completed lines
	var int tileType;
	var int i; i = TETRISROWS - 1; //index starts at 0!

	while (i > 0);
		tetrisLineCompleted = TRUE;

		repeat (j, TETRISCOLUMNS); var int j;
			tileType = Tetris_GetTileType (i, j);

			//blank - break
			if (tileType == 0) {
				tetrisLineCompleted = FALSE;
				break;
			};
		end;

		//If line was completed - move remaining lines down
		if (tetrisLineCompleted) {
			//First ... add little 'delay' - add this function into frame-function loop
			if (!tetrisLineCompletedDelay) {
				//Add frame-function that will erase completed lines
				FF_ApplyOnceExtGT (FF_Tetris_RemoveCompletedLines, 100, -1);

				tetrisLineCompletedDelay = TRUE;
				return;
			};

			//Add 100 points to the score
			tetrisScore += 100;

			var int k; k = i;

			while (k > 0);
				repeat (l, TETRISCOLUMNS); var int l;
					tileType = Tetris_GetTileType (k - 1, l);
					Tetris_SetTileType (k, l, tileType);
				end;

				k -= 1;
			end;

			repeat (m, TETRISCOLUMNS); var int m;
				Tetris_SetTileType (0, m, 0);
			end;

			return;
		};

		i -= 1;
	end;

	//Initial position
	tetrisRow = -1;
	tetrisCol = (TETRISCOLUMNS - TETRISMATRIXSIZE) / 2;

	//Get next
	tetrominoeCurrent = tetrominoeNext;

	//Generate next
	tetrominoeNext = Hlp_Random (7);

	//Load new tetrominoe
	Tetrominoe_Load ();

	//If we can't move at this point - then player failed
	if (!Tetrominoe_IsValidPosition ()) {
		Tetris_GameOver ();
		return;
	};

	Tetrominoe_Draw ();

	//Re-insert frame-function (to reset timer)
	FF_Remove (FF_Tetris_Move_1s);
	FF_ApplyOnceExtGT (FF_Tetris_Move_1s, 1000, -1);
};

func void FF_Tetris_RemoveCompletedLines () {
	if (tetrisLineCompleted) {
		Tetrominoe_GetNext ();
	};

	if (!tetrisLineCompleted) {
		tetrisLineCompletedDelay = FALSE;
		FF_Remove (FF_Tetris_RemoveCompletedLines);
	};
};

func int GetKey__Tetris (var int key) {
	if ((key == MEM_GetKey ("keyLeft")) || (key == MEM_GetSecondaryKey ("keyLeft")) || (key == MEM_GetKey ("keyStrafeLeft")) || (key == MEM_GetSecondaryKey ("keyStrafeLeft")) || (key == MOUSE_WHEEL_UP)) {
		return KEY_LEFTARROW;
	};

	if ((key == MEM_GetKey ("keyRight")) || (key == MEM_GetSecondaryKey ("keyRight")) || (key == MEM_GetKey ("keyStrafeRight")) || (key == MEM_GetSecondaryKey ("keyStrafeRight")) || (key == MOUSE_WHEEL_DOWN)) {
		return KEY_RIGHTARROW;
	};

	if ((key == MEM_GetKey ("keyDown")) || (key == MEM_GetSecondaryKey ("keyDown")) || (key == MEM_GetKey ("keyDown")) || (key == MEM_GetSecondaryKey ("keyDown"))) {
		return KEY_DOWNARROW;
	};

	return key;
};

func void _hook_oCDocumentManager_HandleEvent__Tetris () {
	//If game is inactive - don't do anything
	if (!tetrisEnabled) { return; };

	var int cancel; cancel = FALSE;
	var int key; key = MEM_ReadInt (ESP + 4);

	//Ignore output if game is over
	if (tetrisGameOver) {
		ViewPtr_Delete (tetrisGameOverView);

		MEM_Call (Tetris_Destroy);
		MEM_Call (Tetris_Init);

		tetrisGameOver = FALSE;
		cancel = TRUE;
	} else
	//Ignore input while line is being erased
	if (tetrisLineCompleted) {
		cancel = TRUE;
	} else {
		//'Convert' key
		key = GetKey__Tetris (key);

		//Move to the left
		if (key == KEY_LEFTARROW) {
			Tetrominoe_Clear ();
			tetrisCol -= 1;

			//Check if we can't move - reset position
			if (!Tetrominoe_IsValidPosition ()) {
				tetrisCol += 1;
			};

			Tetrominoe_Draw ();

			cancel = TRUE;
		} else

		//Move to the right
		if (key == KEY_RIGHTARROW) {
			Tetrominoe_Clear ();
			tetrisCol += 1;

			//Check if we can't move - reset position
			if (!Tetrominoe_IsValidPosition ()) {
				tetrisCol -= 1;
			};

			Tetrominoe_Draw ();

			cancel = TRUE;
		} else

		//Rotate
		if (key == KEY_SPACE) {
			Tetrominoe_Clear ();
			Tetrominoe_Rotate ();

			//Check if we can't move - reset position
			if (!Tetrominoe_IsValidPosition ()) {
				Tetrominoe_ResetRotation ();
			};

			Tetrominoe_Draw ();
			cancel = TRUE;
		} else

		//Move down
		if (key == KEY_DOWNARROW) {
			Tetrominoe_Clear ();
			tetrisRow += 1;

			//Check if we can't move - reset position
			if (!Tetrominoe_IsValidPosition ()) {
				tetrisRow -= 1;
				Tetrominoe_Draw ();

				Tetrominoe_GetNext ();
			} else {
				Tetrominoe_Draw ();

				//Re-insert frame-function (to reset timer)
				FF_Remove (FF_Tetris_Move_1s);
				FF_ApplyOnceExtGT (FF_Tetris_Move_1s, 1000, -1);
			};

			cancel = TRUE;
		} else

		//Confirm position
		if (key == KEY_RETURN) {
			//Move down
			while (true);
				Tetrominoe_Clear ();

				tetrisRow += 1;

				//Check if we can't move - exit
				if (!Tetrominoe_IsValidPosition ()) {
					tetrisRow -= 1;
					Tetrominoe_Draw ();

					break;
				};

				Tetrominoe_Draw ();
			end;

			Tetrominoe_GetNext ();
			cancel = TRUE;
		} else

		//Exit game
		if (key == KEY_ESCAPE) {
			Tetris_Destroy ();
		};
	};

	//Cancel input
	if (cancel) {
		MEM_WriteInt (ESP + 4, 0);
		EDI = 0;
	};
};

func void FF_Tetris_Move_1s () {
	//Don't do anything while removing lines
	if (tetrisLineCompleted) { return; };

	//Move down 1 row
	Tetrominoe_Clear ();

	tetrisRow += 1;

	//Check if we can't move - exit
	if (!Tetrominoe_IsValidPosition ()) {
		tetrisRow -= 1;
		Tetrominoe_Draw ();

		Tetrominoe_GetNext ();
		return;
	};

	Tetrominoe_Draw ();
};

func void Tetris_Init () {
	//Create default view
	var int v;
	var int posX;
	var int posY;

	posY = (PS_VMax - Print_ToVirtual (TETRISROWS * TETRISTILEHEIGHT, PS_Y)) / 2;
	posY = Print_ToPixel (posY, PS_Y);

	repeat (i, TETRISROWS); var int i;
		posX = (PS_VMax - Print_ToVirtual (TETRISCOLUMNS * TETRISTILEWIDTH, PS_X)) / 2;
		posX = Print_ToPixel (posX, PS_X);

		repeat (j, TETRISCOLUMNS); var int j;
			v = ViewPtr_CreatePxl (posX, posY, posX + TETRISTILEWIDTH, posY + TETRISTILEHEIGHT);
			ViewPtr_Open (v);

			//Create new set of tiles
			Tetris_SetTilePtr (i, j, Create_TetrisTilePtr (v, 0));

			posX += TETRISTILEWIDTH;
		end;

		posY += TETRISTILEHEIGHT;
	end;

	//Create preview
	posY = (PS_VMax - Print_ToVirtual (TETRISROWS * TETRISTILEHEIGHT, PS_Y)) / 2;
	posY = Print_ToPixel (posY, PS_Y);

	repeat (i, TETRISMATRIXSIZE);
		posX = (PS_VMax - Print_ToVirtual (TETRISCOLUMNS * TETRISTILEWIDTH, PS_X)) / 2 + Print_ToVirtual ((TETRISCOLUMNS + 1) * TETRISTILEWIDTH, PS_X);
		posX = Print_ToPixel (posX, PS_X);

		repeat (j, TETRISMATRIXSIZE);
			v = ViewPtr_CreatePxl (posX, posY, posX + TETRISTILEWIDTH, posY + TETRISTILEHEIGHT);
			ViewPtr_Open (v);

			//Create new set of tiles
			TetrisPreview_SetTilePtr (i, j, Create_TetrisTilePtr (v, 0));

			posX += TETRISTILEWIDTH;
		end;

		posY += TETRISTILEHEIGHT;
	end;

	posX = (PS_VMax - Print_ToVirtual (TETRISCOLUMNS * TETRISTILEWIDTH, PS_X)) / 2 + Print_ToVirtual ((TETRISCOLUMNS + 1) * TETRISTILEWIDTH, PS_X);
	posX = Print_ToPixel (posX, PS_X);

	posY += TETRISTILEHEIGHT;

	//Create view for score
	tetrisScoreViewFrame = ViewPtr_CreatePxl (posX, posY, posX + TETRISTILEWIDTH * TETRISMATRIXSIZE, posY + 6 + Print_GetFontHeight ("font_old_10_white.tga"));
	ViewPtr_SetTexture (tetrisScoreViewFrame, "TILESBACK.TGA");
	ViewPtr_Open (tetrisScoreViewFrame);

	tetrisScoreView = ViewPtr_CreatePxl (posX + 6, posY + 3, posX + TETRISTILEWIDTH * TETRISMATRIXSIZE, posY + Print_GetFontHeight ("font_old_10_white.tga"));
	ViewPtr_Open (tetrisScoreView);

	//Reset values
	tetrisLineCompleted = FALSE;
	tetrisLineCompletedDelay = FALSE;
	tetrisGameOver = FALSE;
	tetrisEnabled = TRUE;

	tetrisScore = 0;

	//Generate first and next tetrominoe
	tetrominoeNext = Hlp_Random (7);

	Tetrominoe_GetNext ();

	const int once = 0;
	if (!once) {
		//0x00724D30 public: virtual int __thiscall oCDocumentManager::HandleEvent(int)
		const int oCDocumentManager__HandleEvent_G1 = 7490864;

		//0x0065F450 public: virtual int __thiscall oCDocumentManager::HandleEvent(int)
		const int oCDocumentManager__HandleEvent_G2 = 6681680;

		HookEngine (MEMINT_SwitchG1G2 (oCDocumentManager__HandleEvent_G1, oCDocumentManager__HandleEvent_G2), 6, "_hook_oCDocumentManager_HandleEvent__Tetris");
		once = 1;
	};
};

instance BookOfTetris (C_Item) {
	name = "Ancient book";
	mainflag = ITEM_KAT_DOCS;
	flags = 0;
	value = 0;
	visual = "ItWr_Book_Tetris_01.3ds";
	material = MAT_LEATHER;
	scemeName = "MAP";
	description = "Ancient book";
	on_state[0] = UseBookOfTetris;
};

func void UseBookOfTetris() {
	var int nDocID;
	nDocID = Doc_Create();

	Tetris_Init ();

	Doc_Show(nDocID);
};
