
# Rain freepoints
Hiding from rain

### High Level concept description
Each ZS state (where we want to make sure NPCs are hiding from rain) will try to search for proper freepoint via`B_GotoFreePoint`:
```c++
func void ZS_Smalltalk() {
	//PrintDebugNpc(PD_TA_FRAME,"ZS_Smalltalk");
	Perception_Set_Normal ();
	B_ResetAll (self);
	B_StandUp (self); //Stand up (always)
	B_GotoWaypoint (self); //Goto waypoint (if too far)
	B_GotoFreePoint (self, "SMALLTALK", 1);
};
```
#### B_GotoFreePoint
Will search for specified freepoint/list of freepoints.
 - when it's raining, function will **prioritize** 'RAIN' freepoint
 - when it's not raining, function will **deprioritize** 'RAIN' freepoint

In example below NPC is searching for freepoint **SMALLTALK**.
We have 2 sets of freepoints here:
`FP_SMALLTALK_A_OC_JOCKEL` and `FP_SMALLTALK_B_OC_JOCKEL` for normal weather.
`FP_SMALLTALK_RAIN_A_OC_JOCKEL` and `FP_SMALLTALK_RAIN_B_OC_JOCKEL` for rainy weather.
![Rain freepoints - normal weather](https://i.ibb.co/CtbT65j/Rain-freepoints.png)

#### B_CheckRainFreePoints
How do we make sure NPC will go to 'RAIN' freepoints once it is raining?
We will have in the `_Loop` function of ZS state a check - function `B_CheckRainFreePoints` that will check whether it is raining. If it is function will check on what freepoint NPC is standing. If NPC is standing on **SMALLTALK** freepoint, then function will search in specified range for **SMALLTALK_RAIN** freepoint. If such freepoint is found function returns `true`.
When function returns `true` we will exit from `_Loop` function - this effectively 'resets' ZS state - `ZS_SmallTalk ()` above is called, where function `B_GotoFreePoint` makes sure NPC will go to 'RAIN' freepoint:
```c++
func int ZS_Smalltalk_Loop() {
...
...
...
	//Check weather conditions - should NPC go to different freepoints?
	if (B_CheckRainFreePoints (self, mkf (1200))) {
		return LOOP_END;
	};

	AI_Wait(self,1);
	return LOOP_CONTINUE;
};
```
![Rain freepoints - rainy weather](https://i.ibb.co/G7PmvRT/Rain-freepoints-raining.png)