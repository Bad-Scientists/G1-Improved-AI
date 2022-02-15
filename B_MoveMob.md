# B_MoveMob
How to open doors

### High Level concept description

`oCMobDoor` object has 2 free positions:
1. FRONT
2. BACK

![oCMobDoor FRONT & BACK](https://i.ibb.co/zP2K0Cr/Doors-FRONT-and-BACK.png)

This information is stored in `zCList<TMobOptPos> oCMobInter.optimalPosList` in `nodeName`:
```c++
class TMobOptPos {
	var int trafo[16];	//zMAT4
	var int distance;	//int
	var int npc;		//oCNpc*
	var string nodeName;	//zSTRING
};
```

When engine searches for free positions `oCMobInter::SearchFreePosition` for NPC, it will update `oCMobDoor.addName` with `nodeName` of a position that is closer to NPC.

With this we can figure out where NPC is standing and where it needs to go:
![oCMobDoor BACK & FRONT vector](https://i.ibb.co/TPRGyGn/Doors-FRONT-and-BACK-vector.png)

So how do we open and close doors then?
1. NPC goes to the doors.
1. With `AI_UseMobPtr_Ext (self, vobPtr, 1, "UNLOCK");` (function from AFSP) NPC will unlock doors (if locked) and will open them.
1. We will use both free positions (FRONT & BACK) to calculate target position, where NPC needs to go to once doors are open.
1. NPC goes to new calculated target position.
1. NPC will either use `AI_UseMobPtr (self, vobPtr, 0);` function or `AI_UseMobPtr_Ext (self, vobPtr, 0, "LOCK");` if doors were locked before to close them.
1. NPC goes to position of next waypoint in its route `AI_GotoPos (self, _@ (nextWP.pos));` - this is important, because if NPC would try to use 'vanilla' navigation method, it might go back to previous waypoint (if it is nearest one, and would get stuck on the door opening/closing them)

