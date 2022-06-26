/*
 *	Subtitles
 *	 - this function 'SVM_Subtitles' does not have to be called, what we need is only compilation in order to get outputs units below available for our cutscenes
 */
func void SVM_Subtitles () {
	//Bridge Guard
	AI_Output (null, null, "DIA_BridgeGuard_275_Intro_06_00"); //Fresh meat for our mine, it was about the time!
	AI_Output (null, null, "DIA_BridgeGuard_275_Intro_06_01"); //I am sure there is a pickaxe lying somewhere around here, haha!

	//Shady Business discussion
	AI_Output (null, null, "DIA_Guard_253_Business_07_00"); //I am telling you, he brought from swamps at least two kilograms.
	AI_Output (null, null, "DIA_Guard_304_Business_10_01"); //I don't know man, still thinking it's too risky. I've heard they know how to use magic.
	AI_Output (null, null, "DIA_Guard_253_Business_07_02"); //Nonsense. What will he do? Put us to sleep with his blabbering about their tiresome god?
	AI_Output (null, null, "DIA_Guard_253_Business_07_03"); //And anyway it's two of us against a single guy. He has no chance.
	AI_Output (null, null, "DIA_Guard_304_Business_10_04"); //Okay, so what do we do?
	AI_Output (null, null, "DIA_Guard_253_Business_07_05"); //We will wait till the evening. I know he wants to go to the New Camp.
	AI_Output (null, null, "DIA_Guard_253_Business_07_06"); //That's our chance get his stuff!
};
