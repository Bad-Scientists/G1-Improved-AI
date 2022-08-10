func void _hook_oCMobInter_IsInteractingWith__FirePlace () {
	if (!Hlp_Is_oCMobInter (ECX)) { return; };

	var int ptr; ptr = MEM_ReadInt (ESP + 4);
	if (!Hlp_Is_oCNpc (ptr)) { return; };

	var oCNpc slf; slf = _^ (ptr);

	if (!oCMobInter_IsAvailable (ECX, slf)) { return; };

	var ocMobInter mob; mob = _^ (ECX);

	if (Hlp_StrCmp (mob.sceme, "FIREPLACE")) {
		if (NPC_IsPlayer (slf)) {
			mob.useWithItem = "ITLSTORCHBURNING";
		} else {
			mob.useWithItem = "";
		};
	};
};

func void G12_FirePlaceLighter_Init () {
	const int once = 0;
	if (!once) {
		//0x0067FC70 public: virtual int __thiscall oCMobInter::IsInteractingWith(class oCNpc *)
		const int oCMobInter__IsInteractingWith_G1 = 6814832;

		//0x00721550 public: virtual int __thiscall oCMobInter::IsInteractingWith(class oCNpc *)
		const int oCMobInter__IsInteractingWith_G2 = 7476560;

		HookEngine (MEMINT_SwitchG1G2 (oCMobInter__IsInteractingWith_G1, oCMobInter__IsInteractingWith_G2), 6, "_hook_oCMobInter_IsInteractingWith__FirePlace");

		once = 1;
	};
};
