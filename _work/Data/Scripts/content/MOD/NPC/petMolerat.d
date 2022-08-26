instance PetMolerat(Mst_Default_Molerat)
{
	Set_Molerat_Visuals();
	Npc_SetToFistMode(self);

	//By default our Npc will not have anything in its inventory.
	//It's because it will be picking up items ... and 'throwing them up' onto player :)
	//CreateInvItems(self, ItFoMuttonRaw, 2);

	//Same senses as summoned creatures - will ignore enemies unless it sees them
	senses = SENSE_HEAR | SENSE_SEE;

	//Distance to player and partymember
	self.aivar[AIV_MM_DistToMaster] = 500;
	self.aivar[AIV_MM_PARTYMEMBER] = TRUE;

	start_aistate = ZS_MM_PetMolerat;
};

