
# Chargeable spells
### How do they work? (observation)
Chargeable spells have 4 `KEY_INVEST` vfx effects defined in `VisualFxInst.d` file, for example **Windfist**:
```c++
INSTANCE spellFX_Windfist_KEY_INVEST_1 (C_ParticleFXEmitKey) { emCreateFXID = "spellFX_Windfist_INVESTBLAST"; };
INSTANCE spellFX_Windfist_KEY_INVEST_2 (C_ParticleFXEmitKey) { emCreateFXID = "spellFX_Windfist_INVESTBLAST"; };
INSTANCE spellFX_Windfist_KEY_INVEST_3 (C_ParticleFXEmitKey) { emCreateFXID = "spellFX_Windfist_INVESTBLAST"; };
INSTANCE spellFX_Windfist_KEY_INVEST_4 (C_ParticleFXEmitKey) { emCreateFXID = "spellFX_Windfist_INVESTBLAST"; };
```
By default in G1 `spellLevel` is set to 0 when player draws spell, VFX that will be played is determined by this `spellLevel`. `spellLevel` 0 does not have any VFX effect.

As soon as player starts investing mana `spellLevel` is increased by `SPL_NEXTLEVEL`:
```c++
func int Spell_Logic_Windfist (var int manaInvested) {
	//Vanilla logic here is messed up, spell is fully charged in 750 ms and is casted in 1000 ms
	//const int SPL_DAMAGE_WINDFIST = 10;
	//const int SPL_SENDCAST_WINDFIST = 3;
	//time_per_mana = 250;
	if (manaInvested == (SPL_SENDCAST_WINDFIST*3)/10) //0.9 rounded to 0	250 ms
	|| (manaInvested == (SPL_SENDCAST_WINDFIST*5)/10) //1.5 rounded to 1	500 ms
	|| (manaInvested == (SPL_SENDCAST_WINDFIST*8)/10) //2.4 rounded to 2	750 ms
	{ return SPL_NEXTLEVEL; };

	if (manaInvested >= SPL_SENDCAST_WINDFIST) {
		return SPL_SENDCAST;
	};

	return SPL_RECEIVEINVEST;
};
```
In the code above, `spellLevel` is increaded by mana consumption (3 points of mana!) to level `3`.
As soon as spell is casted `SPL_SENDCAST`  increases `spellLevel` by 1 more level to level `4`.
Fully charged WindFist spell deals `40` points of damage.

Another problem is **Spell_ProcessMana_Release** that straight up casts spell as soon as player stops with mana investment:
```c++
func int Spell_ProcessMana_Release(var int manaInvested) {
	if(Npc_GetActiveSpell(self) == SPL_WINDFIST) {
		return SPL_SENDCAST;
	};
```
This means player can spam-click spell casting (spell does not consume any mana at all!) and  function `Spell_Logic_Windfist` increases `spellLevel` to level 1 with `0` invested mana, then `Spell_ProcessMana_Release` casts spell with `SPL_SENDCAST` which increases `spellLevel` to level 2. Spam-clicking therefore does not cost any mana at all and causes 20 points of damage. With rune - this is incredibly exploitable.

### Let's fix them: High Level concept description
#### Spell logic
1. We will not allow player to invest any mana in `Spell_Logic_Windfist` if he does not have enough mana to invest into a single level. This way player wont loose any mana, and wont be able to exploit casting by spam-clicking.
2. `Spell_ProcessMana_Release` will consume remaining mana required for next `spellLevel`. Let's say 1 level requires 10 mana points, player invested 11 mana points and released spell afterwards - we will consume additional 9 points of mana immediately.
3. `Spell_Logic_Windfist` will always double-check if player has enough mana for investment into next level - if he does not - function will cast spell immediately.

#### VFX
Our solution will have 4 mana-investing cycles (we have to start from lvl 0, because `SPL_SENDCAST` always increases `spellLevel`):
 - lvl 0 `SPL_SENDCAST` increases to lvl 1 dmg 10
 - lvl 1 `SPL_SENDCAST` increases to lvl  2 dmg 20
 - lvl 2 `SPL_SENDCAST`increases to lvl 3 dmg 30
 - lvl 3 `SPL_SENDCAST`increases to lvl 4 dmg 40

 Level 0 has a disadvantage - there is no vfx effect for mana investing, but we can fix that as well.

After some investigation it seems like in G1 `oCSpell.spellLevel` is passed to vfx effect `oCVisualFX.level` and from here after a collision with target `oCVisualFX.level` defines  how much damage is dealt to taget in `oSDamageDescriptor`.

So here is the idea: as soon as player starts investing mana we will increase `oCVisualFX.level` by 1 extra level, so if `oCSpell.spellLevel` is `0`, we will set `oCVisualFX.level` to `1`.
At the same time we will decrease output of function `oCVisualFX::GetLevel`.

This way spell requires 4 mana-investing cycles and we will fix all the issues :fire: