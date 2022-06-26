# ZS cutscenes in vanilla Gothic 1

   [![ZS cutscenes in vanilla Gothic 1](https://img.youtube.com/vi/vEwIwRQjj6c/0.jpg)](https://www.youtube.com/watch?v=vEwIwRQjj6c)

### High level concept description

Dialogue has 2 main ingredients:
 - sequence
 - timing

Most challenging in vanilla Gothic is timing, but it can be done - we can use ZS state itself to keep track of time - we can simply add function `AI_Wait (self, 1);` to **_LOOP** part of our ZS state. This way each cycle will take min 1 second to complete.
```c++
func void ZS_Cutscene () {};

func void ZS_Cutscene_Loop () {
	AI_Wait (self, 1);
};

func void ZS_Cutscene_End () {};
```

Our dialogue 'system' will internally keep track of passed time - every time dialogue function `D_Talk` will be called, we will increase internal time-tracker by 1 second.
What we will have to provide will be **sequence**, **display time**, **talker**, **listener** and **output unit** information.
In then end cutscene ZS state with dialogue will look fairly simple:
```c++
//Dialogue sequence will have to be stored in new variable for every 'cutscene'
var int dialogue_sequence1;

func void ZS_Cutscene () {};

func void ZS_Cutscene_Loop () {
	dialogManagerDiaSeqNo = dialogue_sequence1;

	D_Talk (00, 00, self, npc, "DIA_Subject_voice_sequence");
	D_Talk (01, 07, npc, self, "DIA_Subject_voice_sequence");
	D_Talk (02, 10, self, npc, "DIA_Subject_voice_sequence");
	D_Talk (03, 10, self, npc, "DIA_Subject_voice_sequence");
	D_Talk (04, 10, npc, self, "DIA_Subject_voice_sequence");
	D_Talk (05, 05, self, npc, "DIA_Subject_voice_sequence");
	D_Talk (06, 08, self, npc, "DIA_Subject_voice_sequence");

	dialogue_sequence1 = dialogManagerDiaSeqNo;

	AI_Wait (self, 1);
};

func void ZS_Cutscene_End () {};
```

### Our solution will have 3 methods:
```c++
//Scenario #1 NPC talking with another NPC (both talker and listener will turn to each other every time one of them speaks)
D_Talk (var int diaSeqNo, var int diaTime, var int slfInstance, var int othInstance, var string ou)
//Scenario #2 NPC talking to a listener (only talking NPC will turn to his listener)
D_Say (var int diaSeqNo, var int diaTime, var int slfInstance, var int othInstance, var string ou)
//Scenario #3 NPC talking to no-one specific (no one will be turning)
D_Note (var int diaSeqNo, var int diaTime, var int slfInstance, var int othInstance, var string ou)
```
`diaSeqNo` - dialogue sequence number
`diaTime` - how long does it take till next output unit will be displayed
`slfInstance` - talker
`othInstance` - listener
`ou` - output unit

### ZS_Smalltalk_Partner

Additionally this solution has an extra ZS state **ZS_Smalltalk_Partner**.
We have to start this ZS state on our 'partner' in the dialogue. NPC in this ZS state will be just looking at other NPC (there are no output units here).
If we would leave other NPC in vanilla ZS_SmallTalk, then he could potentially interrupt us with nonsense SVM output units.
