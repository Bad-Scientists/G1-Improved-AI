/*
												33 34		35   36 37
										04				MU				13
								01		-		08				09				16

						L		LM				ML		 M		MR				RM		R

								17				24				25				32
										20				MD				29
												38 39		40   41		42
*/

func void ShellGame_HandleMovement (var int shellNo, var int shellPosition, var int shellDir, var string shellName) {
	/*
	Figure out to which 'targetVob' our 'movingVob' has to move based on:
		shellDir - (movement direction, left + up, right + down, etc.
		shellPosition - current position of cup
	*/

	var int targetVobPtr; targetVobPtr = 0;

	//Up
	if (shellDir & cShellGame_Dir_MoveUp)
	{
		if (shellPosition == cShellGame_Position_Left) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_LEFT_UP");	} else
		if (shellPosition == cShellGame_Position_Middle) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_MIDDLE_UP"); } else
		if (shellPosition == cShellGame_Position_Right) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_RIGHT_UP"); };
	} else

	//Down
	if (shellDir & cShellGame_Dir_MoveDown)
	{
		if (shellPosition == cShellGame_Position_Left) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_LEFT"); } else
		if (shellPosition == cShellGame_Position_Middle) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_MIDDLE"); } else
		if (shellPosition == cShellGame_Position_Right) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_RIGHT"); };
	} else

//---

	if (shellDir & cShellGame_Dir_MoveRightUp)
	{
		//LEFT -> RIGHT
		if (shellPosition == cShellGame_Position_Left) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_01"); } else
		if (shellPosition == 01) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_02"); } else
		if (shellPosition == 02) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_03"); } else
		if (shellPosition == 03) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_04"); } else
		if (shellPosition == 04) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_33"); } else

		if (shellPosition == 33) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_34"); } else
		if (shellPosition == 34) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_35"); } else
		if (shellPosition == 35) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_36"); } else
		if (shellPosition == 36) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_37"); } else
		if (shellPosition == 37) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_13"); } else

		//MIDDLE -> RIGHT
		if (shellPosition == cShellGame_Position_Middle) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_09"); } else
		if (shellPosition == 09) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_10"); } else
		if (shellPosition == 10) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_11"); } else
		if (shellPosition == 11) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_12"); } else
		if (shellPosition == 12) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_13"); } else
		if (shellPosition == 13) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_14"); } else
		if (shellPosition == 14) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_15"); } else
		if (shellPosition == 15) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_16"); } else

		if (shellPosition == 16) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_RIGHT"); };
	} else

	if (shellDir & cShellGame_Dir_MoveRightDown)
	{
		//LEFT -> RIGHT
		if (shellPosition == cShellGame_Position_Left) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_17"); } else
		if (shellPosition == 17) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_18"); } else
		if (shellPosition == 18) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_19"); } else
		if (shellPosition == 19) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_20"); } else
		if (shellPosition == 20) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_38"); } else

		if (shellPosition == 38) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_39"); } else
		if (shellPosition == 39) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_40"); } else
		if (shellPosition == 40) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_41"); } else
		if (shellPosition == 41) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_42"); } else
		if (shellPosition == 42) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_29"); } else

		//MIDDLE -> RIGHT
		if (shellPosition == cShellGame_Position_Middle) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_25"); } else
		if (shellPosition == 25) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_26"); } else
		if (shellPosition == 26) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_27"); } else
		if (shellPosition == 27) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_28"); } else
		if (shellPosition == 28) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_29"); } else
		if (shellPosition == 29) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_30"); } else
		if (shellPosition == 30) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_31"); } else
		if (shellPosition == 31) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_32"); } else
		if (shellPosition == 32) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_RIGHT"); };
	} else

	//To middle
	if (shellDir & cShellGame_Dir_MoveMiddleUp)
	{
		//LEFT -> MIDDLE
		if (shellPosition == cShellGame_Position_Left) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_01"); } else
		if (shellPosition == 01) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_02"); } else
		if (shellPosition == 02) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_03"); } else
		if (shellPosition == 03) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_04"); } else
		if (shellPosition == 04) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_05"); } else
		if (shellPosition == 05) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_06"); } else
		if (shellPosition == 06) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_07"); } else
		if (shellPosition == 07) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_08"); } else
		if (shellPosition == 08) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_MIDDLE"); } else

		//RIGHT -> MIDDLE
		if (shellPosition == cShellGame_Position_Right) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_16"); } else
		if (shellPosition == 16) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_15"); } else
		if (shellPosition == 15) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_14"); } else
		if (shellPosition == 14) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_13"); } else
		if (shellPosition == 13) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_12"); } else
		if (shellPosition == 12) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_11"); } else
		if (shellPosition == 11) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_10"); } else
		if (shellPosition == 10) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_09"); } else
		if (shellPosition == 09) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_MIDDLE"); };
	} else

	if (shellDir & cShellGame_Dir_MoveMiddleDown)
	{
		//LEFT -> MIDDLE
		if (shellPosition == cShellGame_Position_Left) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_17"); } else
		if (shellPosition == 17) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_18"); } else
		if (shellPosition == 18) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_19"); } else
		if (shellPosition == 19) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_20"); } else
		if (shellPosition == 20) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_21"); } else
		if (shellPosition == 21) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_22"); } else
		if (shellPosition == 22) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_23"); } else
		if (shellPosition == 23) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_24"); } else
		if (shellPosition == 24) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_MIDDLE"); } else

		//RIGHT -> MIDDLE
		if (shellPosition == cShellGame_Position_Right) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_32"); } else
		if (shellPosition == 32) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_31"); } else
		if (shellPosition == 31) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_30"); } else
		if (shellPosition == 30) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_29"); } else
		if (shellPosition == 29) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_28"); } else
		if (shellPosition == 28) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_27"); } else
		if (shellPosition == 27) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_26"); } else
		if (shellPosition == 26) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_25"); } else
		if (shellPosition == 25) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_MIDDLE"); };
	} else

	//To left
	if (shellDir & cShellGame_Dir_MoveLeftUp)
	{
		//RIGHT -> LEFT
		if (shellPosition == cShellGame_Position_Right) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_16"); } else
		if (shellPosition == 16) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_15"); } else
		if (shellPosition == 15) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_14"); } else
		if (shellPosition == 14) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_13"); } else
		if (shellPosition == 13) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_37"); } else

		if (shellPosition == 37) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_36"); } else
		if (shellPosition == 36) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_35"); } else
		if (shellPosition == 35) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_34"); } else
		if (shellPosition == 34) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_33"); } else
		if (shellPosition == 33) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_04"); } else

		//MIDDLE -> LEFT
		if (shellPosition == cShellGame_Position_Middle) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_08"); } else
		if (shellPosition == 08) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_07"); } else
		if (shellPosition == 07) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_06"); } else
		if (shellPosition == 06) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_05"); } else
		if (shellPosition == 05) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_04"); } else
		if (shellPosition == 04) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_03"); } else
		if (shellPosition == 03) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_02"); } else
		if (shellPosition == 02) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_01"); } else
		if (shellPosition == 01) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_LEFT"); };
	} else

	if (shellDir & cShellGame_Dir_MoveLeftDown)
	{
		//RIGHT -> LEFT
		if (shellPosition == cShellGame_Position_Right) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_32"); } else
		if (shellPosition == 32) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_31"); } else
		if (shellPosition == 31) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_30"); } else
		if (shellPosition == 30) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_29"); } else
		if (shellPosition == 29) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_42"); } else

		if (shellPosition == 42) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_41"); } else
		if (shellPosition == 41) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_40"); } else
		if (shellPosition == 40) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_39"); } else
		if (shellPosition == 39) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_38"); } else
		if (shellPosition == 38) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_20"); } else

		//MIDDLE -> LEFT
		if (shellPosition == cShellGame_Position_Middle) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_24"); } else
		if (shellPosition == 24) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_23"); } else
		if (shellPosition == 23) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_22"); } else
		if (shellPosition == 22) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_21"); } else
		if (shellPosition == 21) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_20"); } else
		if (shellPosition == 20) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_19"); } else
		if (shellPosition == 19) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_18"); } else
		if (shellPosition == 18) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_17"); } else
		if (shellPosition == 17) { targetVobPtr = MEM_SearchVobByName ("VOB_GAME_CUP_LEFT"); };
	};

	//Safety check!
	if (!targetVobPtr) { return; };

	//Get moving vob
	var int movingVobPtr; movingVobPtr = MEM_SearchVobByName (shellName);

	//Safety check!
	if (!movingVobPtr) { return; };

	//Figure out movements
	if (shellDir & cShellGame_Dir_MoveUp)
	|| (shellDir & cShellGame_Dir_MoveDown)

	|| (shellDir & cShellGame_Dir_MoveRightUp)
	|| (shellDir & cShellGame_Dir_MoveRightDown)

	|| (shellDir & cShellGame_Dir_MoveMiddleUp)
	|| (shellDir & cShellGame_Dir_MoveMiddleDown)

	|| (shellDir & cShellGame_Dir_MoveLeftUp)
	|| (shellDir & cShellGame_Dir_MoveLeftDown)
	{
		//Get position of targetVobPtr
		var int pos[3];
		if (!zCVob_GetPositionWorldToPos (targetVobPtr, _@ (pos))) { return; };

		var int X; X = pos[0];
		var int Y; Y = pos[1];
		var int Z; Z = pos[2];

		var int deltaX;
		var int deltaY;
		var int deltaZ;

		var zCVob movingVob; movingVob = _^ (movingVobPtr);

		/*
		deltaX = 0; deltaY = 0; deltaZ = 0;

		if (movingVob.trafoObjToWorld[03] > X) { deltaX = X - movingVob.trafoObjToWorld[03]; } else
		if (movingVob.trafoObjToWorld[03] < X) { deltaX = X - movingVob.trafoObjToWorld[03]; };

		if (movingVob.trafoObjToWorld[07] > Y) { deltaY = Y - movingVob.trafoObjToWorld[07]; } else
		if (movingVob.trafoObjToWorld[07] < Y) { deltaY = Y - movingVob.trafoObjToWorld[07]; };

		if (movingVob.trafoObjToWorld[11] > Z) { deltaZ = Z - movingVob.trafoObjToWorld[11]; } else
		if (movingVob.trafoObjToWorld[11] < Z) { deltaZ = Z - movingVob.trafoObjToWorld[11]; };

		if (deltaX > shellGame_Speed) { deltaX = shellGame_Speed; } else
		if (deltaX < -shellGame_Speed) { deltaX = -shellGame_Speed; };

		if (deltaY > shellGame_Speed) { deltaY = shellGame_Speed; } else
		if (deltaY < -shellGame_Speed) { deltaY = -shellGame_Speed; };

		if (deltaZ > shellGame_Speed) { deltaZ = shellGame_Speed; } else
		if (deltaZ < -shellGame_Speed) { deltaZ = -shellGame_Speed; };

		movingVob.trafoObjToWorld[03] = movingVob.trafoObjToWorld[03] + deltaX;

		if (shellDir & cShellGame_Dir_MoveUp)
		|| (shellDir & cShellGame_Dir_MoveDown)
		{
			movingVob.trafoObjToWorld[07] = movingVob.trafoObjToWorld[07] + deltaY;
		};

		movingVob.trafoObjToWorld[11] = movingVob.trafoObjToWorld[11] + deltaZ;
		*/

		//-- Figure out next movement step
		deltaX = FLOATNULL; deltaY = FLOATNULL; deltaZ = FLOATNULL;

		if (gf (movingVob.trafoObjToWorld[03], X)) { deltaX = subf (X, movingVob.trafoObjToWorld[03]); } else
		if (lf (movingVob.trafoObjToWorld[03], X)) { deltaX = subf (X, movingVob.trafoObjToWorld[03]); };

		if (gf (movingVob.trafoObjToWorld[07], Y)) { deltaY = subf (Y, movingVob.trafoObjToWorld[07]); } else
		if (lf (movingVob.trafoObjToWorld[07], Y)) { deltaY = subf (Y, movingVob.trafoObjToWorld[07]); };

		if (gf (movingVob.trafoObjToWorld[11], Z)) { deltaZ = subf (Z, movingVob.trafoObjToWorld[11]); } else
		if (lf (movingVob.trafoObjToWorld[11], Z)) { deltaZ = subf (Z, movingVob.trafoObjToWorld[11]); };

		if (gf (deltaX, shellGame_Speed)) { deltaX = shellGame_Speed; } else
		if (lf (deltaX, negf(shellGame_Speed))) { deltaX = negf(shellGame_Speed); };

		//-- Vertical movement will be constant - FLOATONE
		if (gf (deltaY, FLOATONE)) { deltaY = FLOATONE; } else
		if (lf (deltaY, negf(FLOATONE))) { deltaY = negf(FLOATONE); };

		if (gf (deltaZ, shellGame_Speed)) { deltaZ = shellGame_Speed; } else
		if (lf (deltaZ, negf(shellGame_Speed))) { deltaZ = negf(shellGame_Speed); };

		//-- Adjust position of movingVob
		movingVob.trafoObjToWorld[03] = addf (movingVob.trafoObjToWorld[03], deltaX);

		if (shellDir & cShellGame_Dir_MoveUp)
		|| (shellDir & cShellGame_Dir_MoveDown)
		{
			movingVob.trafoObjToWorld[07] = addf (movingVob.trafoObjToWorld[07], deltaY);
		};

		movingVob.trafoObjToWorld[11] = addf (movingVob.trafoObjToWorld[11], deltaZ);

		//--

		//If movingVob reached it's position, then remove direction
		if (movingVob.trafoObjToWorld[03] == X)
		&& (movingVob.trafoObjToWorld[11] == Z)
		{
			if (movingVob.trafoObjToWorld[07] == Y)
			{
				if (shellDir & cShellGame_Dir_MoveUp)
				{
					//Remove Move Up
					shellDir = shellDir & ~ cShellGame_Dir_MoveUp;

					//Add Move Down
					shellDir = shellDir | cShellGame_Dir_MoveDown;
				} else
				if (shellDir & cShellGame_Dir_MoveDown)
				{
					//Remove Move Down
					shellDir = shellDir & ~ cShellGame_Dir_MoveDown;
				};
			};

			//To Right
			if (shellDir & cShellGame_Dir_MoveRightUp)
			|| (shellDir & cShellGame_Dir_MoveRightDown)
			{
				//LEFT -> RIGHT
				if (shellPosition == cShellGame_Position_Left)
				|| (shellPosition == 01)
				|| (shellPosition == 02)
				|| (shellPosition == 03)
				|| (shellPosition == 04)

				|| (shellPosition == 05)
				|| (shellPosition == 06)
				|| (shellPosition == 07)
				|| (shellPosition == 08)

				|| (shellPosition == 09)
				|| (shellPosition == 10)
				|| (shellPosition == 11)
				|| (shellPosition == 12)
				|| (shellPosition == 13)
				|| (shellPosition == 14)
				|| (shellPosition == 15)

				|| (shellPosition == 17)
				|| (shellPosition == 18)
				|| (shellPosition == 19)
				|| (shellPosition == 20)
				|| (shellPosition == 21)
				|| (shellPosition == 22)
				|| (shellPosition == 23)
				|| (shellPosition == 24)

				|| (shellPosition == 25)
				|| (shellPosition == 26)
				|| (shellPosition == 27)
				|| (shellPosition == 28)
				|| (shellPosition == 29)
				|| (shellPosition == 30)
				|| (shellPosition == 31)

				|| (shellPosition == cShellGame_Position_Middle)

				|| (shellPosition == 33)
				|| (shellPosition == 34)
				|| (shellPosition == 35)
				|| (shellPosition == 36)
				|| (shellPosition == 37)

				|| (shellPosition == 38)
				|| (shellPosition == 39)
				|| (shellPosition == 40)
				|| (shellPosition == 41)
				|| (shellPosition == 42)

				{
					if (shellPosition == cShellGame_Position_Left)
					{
						if (shellDir & cShellGame_Dir_MoveRightUp)
						{
							shellPosition = 01;
						} else
						{
							shellPosition = 17;
						};
					} else
					if (shellPosition == 01) { shellPosition = 02; } else
					if (shellPosition == 02) { shellPosition = 03; } else
					if (shellPosition == 03) { shellPosition = 04; } else
					if (shellPosition == 04) { shellPosition = 33; } else

					if (shellPosition == 33) { shellPosition = 34; } else
					if (shellPosition == 34) { shellPosition = 35; } else
					if (shellPosition == 35) { shellPosition = 36; } else
					if (shellPosition == 36) { shellPosition = 37; } else
					if (shellPosition == 37) { shellPosition = 13; } else

					if (shellPosition == cShellGame_Position_Middle)
					{
						if (shellDir & cShellGame_Dir_MoveRightUp)
						{
							shellPosition = 09;
						} else
						{
							shellPosition = 25;
						};
					} else

					if (shellPosition == 09) { shellPosition = 10; } else
					if (shellPosition == 10) { shellPosition = 11; } else
					if (shellPosition == 11) { shellPosition = 12; } else
					if (shellPosition == 12) { shellPosition = 13; } else
					if (shellPosition == 13) { shellPosition = 14; } else
					if (shellPosition == 14) { shellPosition = 15; } else
					if (shellPosition == 15) { shellPosition = 16; } else

					if (shellPosition == 17) { shellPosition = 18; } else
					if (shellPosition == 18) { shellPosition = 19; } else
					if (shellPosition == 19) { shellPosition = 20; } else
					if (shellPosition == 20) { shellPosition = 38; } else

					if (shellPosition == 38) { shellPosition = 39; } else
					if (shellPosition == 39) { shellPosition = 40; } else
					if (shellPosition == 40) { shellPosition = 41; } else
					if (shellPosition == 41) { shellPosition = 42; } else
					if (shellPosition == 42) { shellPosition = 29; } else

					if (shellPosition == 25) { shellPosition = 26; } else
					if (shellPosition == 26) { shellPosition = 27; } else
					if (shellPosition == 27) { shellPosition = 28; } else
					if (shellPosition == 28) { shellPosition = 29; } else
					if (shellPosition == 29) { shellPosition = 30; } else
					if (shellPosition == 30) { shellPosition = 31; } else
					if (shellPosition == 31) { shellPosition = 32; };
				} else
				{
					shellDir = shellDir & ~ cShellGame_Dir_MoveRightUp;
					shellDir = shellDir & ~ cShellGame_Dir_MoveRightDown;

					shellPosition = cShellGame_Position_Right;
				};
			} else
			//To Middle
			if (shellDir & cShellGame_Dir_MoveMiddleUp)
			|| (shellDir & cShellGame_Dir_MoveMiddleDown)
			{
				//LEFT -> MIDDLE
				if (shellPosition == cShellGame_Position_Left)
				|| (shellPosition == 01)
				|| (shellPosition == 02)
				|| (shellPosition == 03)
				|| (shellPosition == 04)
				|| (shellPosition == 05)
				|| (shellPosition == 06)
				|| (shellPosition == 07)

				|| (shellPosition == 17)
				|| (shellPosition == 18)
				|| (shellPosition == 19)
				|| (shellPosition == 20)
				|| (shellPosition == 21)
				|| (shellPosition == 22)
				|| (shellPosition == 23)

				//RIGHT -> MIDDLE
				|| (shellPosition == cShellGame_Position_Right)
				|| (shellPosition == 32)
				|| (shellPosition == 31)
				|| (shellPosition == 30)
				|| (shellPosition == 29)
				|| (shellPosition == 28)
				|| (shellPosition == 27)
				|| (shellPosition == 26)

				|| (shellPosition == 16)
				|| (shellPosition == 15)
				|| (shellPosition == 14)
				|| (shellPosition == 13)
				|| (shellPosition == 12)
				|| (shellPosition == 11)
				|| (shellPosition == 10)
				{
					if (shellPosition == cShellGame_Position_Left)
					{
						if (shellDir & cShellGame_Dir_MoveMiddleUp)
						{
							shellPosition = 01;
						} else
						{
							shellPosition = 17;
						};
					} else
					if (shellPosition == 01) { shellPosition = 02; } else
					if (shellPosition == 02) { shellPosition = 03; } else
					if (shellPosition == 03) { shellPosition = 04; } else
					if (shellPosition == 04) { shellPosition = 05; } else
					if (shellPosition == 05) { shellPosition = 06; } else
					if (shellPosition == 06) { shellPosition = 07; } else
					if (shellPosition == 07) { shellPosition = 08; } else

					if (shellPosition == 17) { shellPosition = 18; } else
					if (shellPosition == 18) { shellPosition = 19; } else
					if (shellPosition == 19) { shellPosition = 20; } else
					if (shellPosition == 20) { shellPosition = 21; } else
					if (shellPosition == 21) { shellPosition = 22; } else
					if (shellPosition == 22) { shellPosition = 23; } else
					if (shellPosition == 23) { shellPosition = 24; } else

					if (shellPosition == cShellGame_Position_Right)
					{
						if (shellDir & cShellGame_Dir_MoveMiddleUp)
						{
							shellPosition = 16;
						} else
						{
							shellPosition = 32;
						};
					} else

					if (shellPosition == 16) { shellPosition = 15; } else
					if (shellPosition == 15) { shellPosition = 14; } else
					if (shellPosition == 14) { shellPosition = 13; } else
					if (shellPosition == 13) { shellPosition = 12; } else
					if (shellPosition == 12) { shellPosition = 11; } else
					if (shellPosition == 11) { shellPosition = 10; } else
					if (shellPosition == 10) { shellPosition = 09; } else

					if (shellPosition == 32) { shellPosition = 31; } else
					if (shellPosition == 31) { shellPosition = 30; } else
					if (shellPosition == 30) { shellPosition = 29; } else
					if (shellPosition == 29) { shellPosition = 28; } else
					if (shellPosition == 28) { shellPosition = 27; } else
					if (shellPosition == 27) { shellPosition = 26; } else
					if (shellPosition == 26) { shellPosition = 25; };
				} else
				{
					shellDir = shellDir & ~ cShellGame_Dir_MoveMiddleUp;
					shellDir = shellDir & ~ cShellGame_Dir_MoveMiddleDown;

					shellPosition = cShellGame_Position_Middle;
				};
			} else

			//To Left
			if (shellDir & cShellGame_Dir_MoveLeftUp)
			|| (shellDir & cShellGame_Dir_MoveLeftDown)
			{
				//RIGHT -> LEFT
				if (shellPosition == cShellGame_Position_Right)
				|| (shellPosition == 13)
				|| (shellPosition == 14)
				|| (shellPosition == 15)
				|| (shellPosition == 16)

				|| (shellPosition == cShellGame_Position_Middle)

				|| (shellPosition == 02)
				|| (shellPosition == 03)
				|| (shellPosition == 04)
				|| (shellPosition == 05)
				|| (shellPosition == 06)
				|| (shellPosition == 07)
				|| (shellPosition == 08)

				|| (shellPosition == 18)
				|| (shellPosition == 19)
				|| (shellPosition == 20)
				|| (shellPosition == 21)
				|| (shellPosition == 22)
				|| (shellPosition == 23)
				|| (shellPosition == 24)

				|| (shellPosition == 29)
				|| (shellPosition == 30)
				|| (shellPosition == 31)
				|| (shellPosition == 32)

				|| (shellPosition == 33)
				|| (shellPosition == 34)
				|| (shellPosition == 35)
				|| (shellPosition == 36)
				|| (shellPosition == 37)

				|| (shellPosition == 38)
				|| (shellPosition == 39)
				|| (shellPosition == 40)
				|| (shellPosition == 41)
				|| (shellPosition == 42)

				{
					if (shellPosition == cShellGame_Position_Right)
					{
						if (shellDir & cShellGame_Dir_MoveLeftUp)
						{
							shellPosition = 16;
						} else
						{
							shellPosition = 32;
						};
					} else
					if (shellPosition == 16) { shellPosition = 15; } else
					if (shellPosition == 15) { shellPosition = 14; } else
					if (shellPosition == 14) { shellPosition = 13; } else
					if (shellPosition == 13) { shellPosition = 37; } else

					if (shellPosition == 37) { shellPosition = 36; } else
					if (shellPosition == 36) { shellPosition = 35; } else
					if (shellPosition == 35) { shellPosition = 34; } else
					if (shellPosition == 34) { shellPosition = 33; } else
					if (shellPosition == 33) { shellPosition = 04; } else

					if (shellPosition == cShellGame_Position_Middle)
					{
						if (shellDir & cShellGame_Dir_MoveLeftUp)
						{
							shellPosition = 08;
						} else
						{
							shellPosition = 24;
						};
					} else
					if (shellPosition == 08) { shellPosition = 07; } else
					if (shellPosition == 07) { shellPosition = 06; } else
					if (shellPosition == 06) { shellPosition = 05; } else
					if (shellPosition == 05) { shellPosition = 04; } else
					if (shellPosition == 04) { shellPosition = 03; } else
					if (shellPosition == 03) { shellPosition = 02; } else
					if (shellPosition == 02) { shellPosition = 01; } else

					if (shellPosition == 32) { shellPosition = 31; } else
					if (shellPosition == 31) { shellPosition = 30; } else
					if (shellPosition == 30) { shellPosition = 29; } else
					if (shellPosition == 29) { shellPosition = 42; } else

					if (shellPosition == 42) { shellPosition = 41; } else
					if (shellPosition == 41) { shellPosition = 40; } else
					if (shellPosition == 40) { shellPosition = 39; } else
					if (shellPosition == 39) { shellPosition = 38; } else
					if (shellPosition == 38) { shellPosition = 20; } else

					if (shellPosition == 24) { shellPosition = 23; } else
					if (shellPosition == 23) { shellPosition = 22; } else
					if (shellPosition == 22) { shellPosition = 21; } else
					if (shellPosition == 21) { shellPosition = 20; } else
					if (shellPosition == 20) { shellPosition = 19; } else
					if (shellPosition == 19) { shellPosition = 18; } else
					if (shellPosition == 18) { shellPosition = 17; };
				} else
				{
					shellDir = shellDir & ~ cShellGame_Dir_MoveLeftUp;
					shellDir = shellDir & ~ cShellGame_Dir_MoveLeftDown;

					shellPosition = cShellGame_Position_Left;
				};
			};
		};
	};

	if (shellNo == 1) { shellGame_Cup1 = shellPosition; shellGame_Cup1_Dir = shellDir; };
	if (shellNo == 2) { shellGame_Cup2 = shellPosition; shellGame_Cup2_Dir = shellDir; };
	if (shellNo == 3) { shellGame_Cup3 = shellPosition; shellGame_Cup3_Dir = shellDir; };
};

func int ShellGame_CheckPlayersTip (var int playersTip)
{
	//Translate players tip into 'physical' cup number
	var int playersTipTranslated; playersTipTranslated = 0;

	//LEFT
	if (playersTip == 1) {
		if (shellGame_Cup3 == cShellGame_Position_Left) { playersTipTranslated = 3; } else
		if (shellGame_Cup2 == cShellGame_Position_Left) { playersTipTranslated = 2; } else
		if (shellGame_Cup1 == cShellGame_Position_Left) { playersTipTranslated = 1; };
	} else
	//MIDDLE
	if (playersTip == 2) {
		if (shellGame_Cup3 == cShellGame_Position_Middle) { playersTipTranslated = 3; } else
		if (shellGame_Cup2 == cShellGame_Position_Middle) { playersTipTranslated = 2; } else
		if (shellGame_Cup1 == cShellGame_Position_Middle) { playersTipTranslated = 1; };
	} else
	//RIGHT
	if (playersTip == 3) {
		if (shellGame_Cup3 == cShellGame_Position_Right) { playersTipTranslated = 3; } else
		if (shellGame_Cup2 == cShellGame_Position_Right) { playersTipTranslated = 2; } else
		if (shellGame_Cup1 == cShellGame_Position_Right) { playersTipTranslated = 1; };
	};

	var int cupCoinTranslated; cupCoinTranslated = 0;

	//LEFT
	if (shellGame_CupCoin == 1) {
		if (shellGame_Cup1 == cShellGame_Position_Left) { cupCoinTranslated = 1; } else
		if (shellGame_Cup1 == cShellGame_Position_Middle) { cupCoinTranslated = 2; } else
		if (shellGame_Cup1 == cShellGame_Position_Right) { cupCoinTranslated = 3; };
	} else
	//MIDDLE
	if (shellGame_CupCoin == 2) {
		if (shellGame_Cup2 == cShellGame_Position_Left) { cupCoinTranslated = 1; } else
		if (shellGame_Cup2 == cShellGame_Position_Middle) { cupCoinTranslated = 2; } else
		if (shellGame_Cup2 == cShellGame_Position_Right) { cupCoinTranslated = 3; };
	} else
	//RIGHT
	if (shellGame_CupCoin == 3) {
		if (shellGame_Cup3 == cShellGame_Position_Left) { cupCoinTranslated = 1; } else
		if (shellGame_Cup3 == cShellGame_Position_Middle) { cupCoinTranslated = 2; } else
		if (shellGame_Cup3 == cShellGame_Position_Right) { cupCoinTranslated = 3; };
	};

	//Add flag cShellGame_Dir_MoveUp to Vob which player selected
	if (playersTipTranslated == 1) { shellGame_Cup1_Dir = shellGame_Cup1_Dir | cShellGame_Dir_MoveUp; } else
	if (playersTipTranslated == 2) { shellGame_Cup2_Dir = shellGame_Cup2_Dir | cShellGame_Dir_MoveUp; } else
	if (playersTipTranslated == 3) { shellGame_Cup3_Dir = shellGame_Cup3_Dir | cShellGame_Dir_MoveUp; };

	//Turn on visibility for coin
	if (cupCoinTranslated == 1) { Vob_ChangeDataByName ("VOB_GAME_COIN_LEFT", 0, 0, 0, 1); } else
	if (cupCoinTranslated == 2) { Vob_ChangeDataByName ("VOB_GAME_COIN_MIDDLE", 0, 0, 0, 1); } else
	if (cupCoinTranslated == 3) { Vob_ChangeDataByName ("VOB_GAME_COIN_RIGHT", 0, 0, 0, 1); };

	//Add flag cShellGame_Dir_MoveUp to Vob which really contains coin
	if (shellGame_CupCoin == 1) { shellGame_Cup1_Dir = shellGame_Cup1_Dir | cShellGame_Dir_MoveUp; } else
	if (shellGame_CupCoin == 2) { shellGame_Cup2_Dir = shellGame_Cup2_Dir | cShellGame_Dir_MoveUp; } else
	if (shellGame_CupCoin == 3) { shellGame_Cup3_Dir = shellGame_Cup3_Dir | cShellGame_Dir_MoveUp; };

	shellGame_Status = cShellGame_RevealCoin;

	//Return TRUE if player guessed correctly
	if (playersTipTranslated == shellGame_CupCoin) {
		return TRUE;
	};

	//Return FALSE if he did not
	return FALSE;
};

func void FF_Surface_ShellGame_Timer_1s () {
	if (shellGame_Status == cShellGame_Start) {
		if (cShellGame_Timer < cShellGame_Timer_NewGame) {
			cShellGame_Timer = cShellGame_Timer + 1;
		};
	};
};

func void FF_Surface_ShellGame_Timer_10ms () {

//-- New Game

	if (shellGame_Status == cShellGame_NewGame) {
		if (InfoManager_HasFinished ()) {
			//Reset timer - wait for 8 seconds
			cShellGame_Timer = 0;
			shellGame_Status = cShellGame_Start;
		};
	};

//-- Setup game

	if (shellGame_Status == cShellGame_Start) {
		if (cShellGame_Timer == cShellGame_Timer_NewGame) {
			ShellGame_Reset ();

			shellGame_Shuffles = shellGame_MinNoOfShuffles;

			shellGame_CupCoin = Hlp_Random (3) + 1; //1 .. 3

			//1. show player where coin is
			shellGame_Status = cShellGame_ShowCoin;
		};
	};

	if (shellGame_Shuffles > 0) {

//-- Show coin

		if (shellGame_Status == cShellGame_ShowCoin) {
			//Show visual for coin
			//Add flag cShellGame_Dir_MoveUp to Vob which really contains coin
			if (shellGame_CupCoin == 1) {
				shellGame_Cup1_Dir = shellGame_Cup1_Dir | cShellGame_Dir_MoveUp;
				Vob_ChangeDataByName ("VOB_GAME_COIN_LEFT", 0, 0, 0, 1);
			} else
			if (shellGame_CupCoin == 2) {
				shellGame_Cup2_Dir = shellGame_Cup2_Dir | cShellGame_Dir_MoveUp;
				Vob_ChangeDataByName ("VOB_GAME_COIN_MIDDLE", 0, 0, 0, 1);
			} else
			if (shellGame_CupCoin == 3) {
				shellGame_Cup3_Dir = shellGame_Cup3_Dir | cShellGame_Dir_MoveUp;
				Vob_ChangeDataByName ("VOB_GAME_COIN_RIGHT", 0, 0, 0, 1);
			};

			//2. hide coin
			shellGame_Status = cShellGame_HideCoin;
		};

//-- Hide coin

		if (shellGame_Status == cShellGame_HideCoin) {
			if ((shellGame_Cup1 == cShellGame_Position_Left) || (shellGame_Cup1 == cShellGame_Position_Middle) || (shellGame_Cup1 == cShellGame_Position_Right))
			&& ((shellGame_Cup2 == cShellGame_Position_Left) || (shellGame_Cup2 == cShellGame_Position_Middle) || (shellGame_Cup2 == cShellGame_Position_Right))
			&& ((shellGame_Cup3 == cShellGame_Position_Left) || (shellGame_Cup3 == cShellGame_Position_Middle) || (shellGame_Cup3 == cShellGame_Position_Right))

			&& (shellGame_Cup1_Dir == 0)
			&& (shellGame_Cup2_Dir == 0)
			&& (shellGame_Cup3_Dir == 0)
			{
				//Hide visual for ocin
				if (shellGame_CupCoin == 1) { Vob_ChangeDataByName ("VOB_GAME_COIN_LEFT", 0, 0, 0, 0); } else
				if (shellGame_CupCoin == 2) { Vob_ChangeDataByName ("VOB_GAME_COIN_MIDDLE", 0, 0, 0, 0); } else
				if (shellGame_CupCoin == 3) { Vob_ChangeDataByName ("VOB_GAME_COIN_RIGHT", 0, 0, 0, 0); };

				//3. Shuffle
				shellGame_Status = cShellGame_Shuffle;
			};
		};

//-- Shuffle

		if (shellGame_Status == cShellGame_Shuffle)
		{
			if ((shellGame_Cup1 == cShellGame_Position_Left) || (shellGame_Cup1 == cShellGame_Position_Middle) || (shellGame_Cup1 == cShellGame_Position_Right))
			&& ((shellGame_Cup2 == cShellGame_Position_Left) || (shellGame_Cup2 == cShellGame_Position_Middle) || (shellGame_Cup2 == cShellGame_Position_Right))
			&& ((shellGame_Cup3 == cShellGame_Position_Left) || (shellGame_Cup3 == cShellGame_Position_Middle) || (shellGame_Cup3 == cShellGame_Position_Right))

			&& (shellGame_Cup1_Dir == 0)
			&& (shellGame_Cup2_Dir == 0)
			&& (shellGame_Cup3_Dir == 0)
			{
				var int leftOne; leftOne = 0;
				var int middleOne; middleOne = 0;
				var int rightOne; rightOne = 0;

				//10 random moves
				var int randomMove; randomMove = Hlp_Random (10) + 1; //1 - 10

				//Move 'presets'
				if (randomMove == 1) {
					leftOne = cShellGame_Dir_MoveMiddleUp;
					middleOne = cShellGame_Dir_MoveLeftDown;
				} else
				if (randomMove == 2) {
					leftOne = cShellGame_Dir_MoveMiddleDown;
					middleOne = cShellGame_Dir_MoveLeftUp;
				} else
				if (randomMove == 3) {
					leftOne = cShellGame_Dir_MoveRightUp;
					rightOne = cShellGame_Dir_MoveLeftDown;
				} else
				if (randomMove == 4) {
					leftOne = cShellGame_Dir_MoveRightDown;
					rightOne = cShellGame_Dir_MoveLeftUp;
				} else
				if (randomMove == 5) {
					middleOne = cShellGame_Dir_MoveRightUp;
					rightOne = cShellGame_Dir_MoveMiddleDown;
				} else
				if (randomMove == 6) {
					middleOne = cShellGame_Dir_MoveRightDown;
					rightOne = cShellGame_Dir_MoveMiddleUp;
				} else
				if (randomMove == 7) {
					leftOne = cShellGame_Dir_MoveMiddleUp;
					middleOne = cShellGame_Dir_MoveRightUp;
					rightOne = cShellGame_Dir_MoveLeftDown;
				} else
				if (randomMove == 8) {
					leftOne = cShellGame_Dir_MoveMiddleDown;
					middleOne = cShellGame_Dir_MoveRightDown;
					rightOne = cShellGame_Dir_MoveLeftUp;
				} else
				if (randomMove == 9) {
					leftOne = cShellGame_Dir_MoveRightDown;
					middleOne = cShellGame_Dir_MoveLeftUp;
					rightOne = cShellGame_Dir_MoveMiddleUp;
				} else
				if (randomMove == 10) {
					leftOne = cShellGame_Dir_MoveRightUp;
					rightOne = cShellGame_Dir_MoveMiddleDown;
					middleOne = cShellGame_Dir_MoveLeftDown;
				};

				//Add move flags
				if (shellGame_Cup1 == cShellGame_Position_Left) { shellGame_Cup1_Dir = shellGame_Cup1_Dir | leftOne; } else
				if (shellGame_Cup1 == cShellGame_Position_Middle) { shellGame_Cup1_Dir = shellGame_Cup1_Dir | middleOne; } else
				if (shellGame_Cup1 == cShellGame_Position_Right) { shellGame_Cup1_Dir = shellGame_Cup1_Dir | rightOne; };

				if (shellGame_Cup2 == cShellGame_Position_Left) { shellGame_Cup2_Dir = shellGame_Cup2_Dir | leftOne; } else
				if (shellGame_Cup2 == cShellGame_Position_Middle) { shellGame_Cup2_Dir = shellGame_Cup2_Dir | middleOne; } else
				if (shellGame_Cup2 == cShellGame_Position_Right) { shellGame_Cup2_Dir = shellGame_Cup2_Dir | rightOne; };

				if (shellGame_Cup3 == cShellGame_Position_Left) { shellGame_Cup3_Dir = shellGame_Cup3_Dir | leftOne; } else
				if (shellGame_Cup3 == cShellGame_Position_Middle) { shellGame_Cup3_Dir = shellGame_Cup3_Dir | middleOne; } else
				if (shellGame_Cup3 == cShellGame_Position_Right) { shellGame_Cup3_Dir = shellGame_Cup3_Dir | rightOne; };

				//Deduct suffle move
				shellGame_Shuffles = shellGame_Shuffles - 1;
			};
		};
	};

	if (shellGame_Status == cShellGame_Shuffle)
	{
		//If there are no more shuffle moves - game is ready
		if (shellGame_Shuffles == 0) {
			if ((shellGame_Cup1 == cShellGame_Position_Left) || (shellGame_Cup1 == cShellGame_Position_Middle) || (shellGame_Cup1 == cShellGame_Position_Right))
			&& ((shellGame_Cup2 == cShellGame_Position_Left) || (shellGame_Cup2 == cShellGame_Position_Middle) || (shellGame_Cup2 == cShellGame_Position_Right))
			&& ((shellGame_Cup3 == cShellGame_Position_Left) || (shellGame_Cup3 == cShellGame_Position_Middle) || (shellGame_Cup3 == cShellGame_Position_Right))

			&& (shellGame_Cup1_Dir == 0)
			&& (shellGame_Cup2_Dir == 0)
			&& (shellGame_Cup3_Dir == 0)
			{
				//4. Game is ready
				shellGame_Status = cShellGame_GameReady;
			};
		};
	};

//-- Game ready - process infos for player

	if (shellGame_Status == cShellGame_GameReady)
	{
		//Show dialog options
		hero.aivar [AIV_INVINCIBLE] = TRUE;
		AI_ProcessInfos (hero);

		//5. Wait for players answer
		shellGame_Status = cShellGame_Dialogue;
	};

//-- Wait for players tip

	if (shellGame_PlayersTip != 0) {
		if (InfoManager_HasFinished ()) {

			//Evaluate players tip
			if (ShellGame_CheckPlayersTip (shellGame_PlayersTip))
			{
				PrintScreen (TEXT_SHELLGAME_CORRECT, -1, _YPOS_MESSAGE_LOGENTRY, "font_old_10_white.tga", _TIME_MESSAGE_LOGENTRY);

				CreateInvItems (hero, itmiNugget, 10);

				shellGame_WinsCounter = shellGame_WinsCounter + 1;

				shellGame_DifficultyCounter = shellGame_DifficultyCounter + 1;

				if (shellGame_DifficultyCounter == 1) {
					shellGame_Speed = addf (shellGame_Speed, divf(mkf(1), mkf(10)));
					shellGame_MinNoOfShuffles = shellGame_MinNoOfShuffles + 1;
					shellGame_DifficultyCounter = 0;
				};

				shellGame_DexterityBonusCounter = shellGame_DexterityBonusCounter + 1;

				//Every 10 wins - we increase players dexterity by 1 point
				if (shellGame_DexterityBonusCounter >= 10) {
					shellGame_DexterityBonusCounter = shellGame_DexterityBonusCounter - 10;

					if (shellGame_DexterityBonusCounter_Total < cShellGame_DexterityBonus_Max) {
						shellGame_DexterityBonusCounter_Total += 1;
						B_RaiseAttribute (ATR_DEXTERITY, 1);
					};
				};
			} else
			{
				PrintScreen (TEXT_SHELLGAME_INCORRECT, -1, _YPOS_MESSAGE_LOGENTRY, "font_old_10_white.tga", _TIME_MESSAGE_LOGENTRY);
				shellGame_LossCounter = shellGame_LossCounter + 1;
			};

			//hero.aivar [AIV_INVINCIBLE] = TRUE;
			AI_ProcessInfos (hero);

			shellGame_PlayersTip = 0;
		};
	};

//-- Reveal coin

	if (shellGame_Status == cShellGame_RevealCoin)
	{
		if ((shellGame_Cup1 == cShellGame_Position_Left) || (shellGame_Cup1 == cShellGame_Position_Middle) || (shellGame_Cup1 == cShellGame_Position_Right))
		&& ((shellGame_Cup2 == cShellGame_Position_Left) || (shellGame_Cup2 == cShellGame_Position_Middle) || (shellGame_Cup2 == cShellGame_Position_Right))
		&& ((shellGame_Cup3 == cShellGame_Position_Left) || (shellGame_Cup3 == cShellGame_Position_Middle) || (shellGame_Cup3 == cShellGame_Position_Right))

		&& (shellGame_Cup1_Dir == 0)
		&& (shellGame_Cup2_Dir == 0)
		&& (shellGame_Cup3_Dir == 0)
		{
			//6. Coin was revealed
			shellGame_Status = cShellGame_CoinRevealed;
		};
	};

//-- Handle movements - if game is not idle

	if (shellGame_Status != cShellGame_Idle)
	&& (shellGame_Status != cShellGame_CoinRevealed)
	{
		ShellGame_HandleMovement (01, shellGame_Cup1, shellGame_Cup1_Dir, "VOB_GAME_CUP_MAIN_LEFT");
		ShellGame_HandleMovement (02, shellGame_Cup2, shellGame_Cup2_Dir, "VOB_GAME_CUP_MAIN_MIDDLE");
		ShellGame_HandleMovement (03, shellGame_Cup3, shellGame_Cup3_Dir, "VOB_GAME_CUP_MAIN_RIGHT");
	};
};

func void testShellGame () {
	//Shell Game
	FF_Remove (FF_Surface_ShellGame_Timer_1s);
	FF_ApplyOnceExtGT (FF_Surface_ShellGame_Timer_1s, 1000, -1);

	FF_Remove (FF_Surface_ShellGame_Timer_10ms);
	FF_ApplyOnceExtGT (FF_Surface_ShellGame_Timer_10ms, 10, -1);

	shellGame_Status = cShellGame_NewGame;
};
