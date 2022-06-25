// *** Phoenix Externals ***

// *******************************************************************************************
// *** PRINT ***
// *******************************************************************************************

func void Print(var string s0) { };
// Ausgabebefehl, der Text ins Game schreibt (wie OutputunitTexte)
func void PrintMulti(var string s0, var string s1, var string s2, var string s3, var string s4) { };
// Printbefehl, der aus den angegebenen Strings einen Auswählt und auf den Bildschirm schreibt
func void PrintDebug(var string s) { };
// Printausgabe, die nur bei eingeschaltetem Debugmodus (Alt+D) im Spy/logfile ausgegeben wird
func void PrintScreen(var int dialogNr, var string msg, var int posx, var int posy, var string font, var int timeSec) { };
// Gibt den Text 'msg' auf dem Bildschrim aus und benutzt dabei den Font 'font'.
// Die Position ist für jede Koordinate eine Zahl zwischen 0 und 99 und gibt die prozentuale Position an.
// Der Ursprung befindet sich oben links (also 0% X und 0% Y)

// *******************************************************************************************
// *** MISC ***
// *******************************************************************************************

func int Hlp_Random(var int n0) { return 0; };
// erzeugt einen Zufallswert (wobei n0 Obergrenze : [0..n0-1] ) Rückgabewert integer
func int Hlp_StrCmp(var string s1, var string s2) { return 0; };
// Hilfsfunktion um zwei Strings miteinander zu vergleichen liefert bei Gleichheit eins zurück
func int Hlp_IsValidNpc(var C_Npc self) { return 0; };
// Prüfe ob NSC-Instanz gültig und initialisiert ist. True/False
func int Hlp_IsValidItem(VAR C_ITEM item) { return 0; };
// Prüfe ob Item-Instanz gültig und initialisiert ist True/False
// -------------------------------------------------------------------------------------------
func int Hlp_IsItem(VAR C_Item item, var int instanceName)
// Prüft, ob der Gegenstand 'item' den Instanznamen 'instanceName' trägt. Will man z.B. testen,
// ob die globale Variable item Pfeile sind (ItMuArrow) ruft man Hlp_IsItem(item,ItMuArrow) auf.
// Gribt bei Gleichheit TRUE, sonst FALSE zurück.
FUNC C_NPC Hlp_GetNpc(var int instanceName) { };
// Ermittle einen NSC über den Instanznamen. Dieser kann einer Variablen zugewiesen werden und ist somit gezielt verfügbar
func int Hlp_GetInstanceID(var C_Npc npc) { return 0; };
// liefert die interne ID ( nicht Var aus der Instanz) zurück, um z.B. other mit self vergleichen zu können ( integer Vergleich)
func int Hlp_GetInstanceID(VAR C_ITEM item) { return 0; };
// liefert die interne ID ( nicht Var aus der Instanz) zurück, um zwei items miteinander vergleichen zu können ( integer Vergleich)
// *******************************************************************************************
// *** WARTEN / ZEIT ***
// *******************************************************************************************

func void AI_Wait(var C_Npc n0, var float n1) { };
// Character wird für n1 Sekunden in einen Wait-Zustand versetzt,
// d.h. er tut nichts, aber Treffer etc.(passive Wahrnehmung) werden registriert

func int Npc_GetStateTime(var C_Npc self) { return 0; };
// Liefert Anzahl Sekunden, wie lange der NSC sich in diesem Zustand im "Loop" befindet.
func void Npc_SetStateTime(var C_Npc self, var int seconds) { };
// _Setzt_ Anzahl Sekunden, wie lange der NSC sich in diesem Zustand im "Loop" befindet.
// --> Das ist dann über Npc_GetStateTime abfragbar.

func int Wld_GetDay() { };
// Liefert den aktuellen Tag zurück (Zähler), hierbei ist der StartTag (Gamestart) = 0.
func int Wld_IsTime(var int hour1, var int min1, var int hour2, var int min2) { return 0; };
// Liefert "1" wenn aktuelle Weltzeit zwischen den beiden angegebenen Zeiten liegt (von - bis)

// *******************************************************************************************
// *** NSC-STEUERUNG ***
// *******************************************************************************************

// --------------------------------------- NSC EINFUEGEN -------------------------------------
func void Wld_InsertNpc(var int npcInstance, var string spawnPoint) { };
// Füge NSC in Welt ein. Wobei SPawnpoint entweder ein WP oder ein FP sein darf.
func void Wld_InsertNpcAndRespawn(var int instance, var string spawnPoint, var float spawnDelay)
// !!!!!!!! weiß ich nicht Genau Ulf

// ------------------------------------- ANIMATIONEN SPIELEN ---------------------------------

func void AI_PlayAni(var C_Npc n0, var string s0) { };
// Npc-Instanz spielt die angegebene Animation ab
func void AI_StandUp(var C_Npc self) { };
// - Ist der Nsc in einem Animatinsstate, wird die passende Rücktransition abgespielt.
// - Benutzt der NSC gerade ein MOBSI, poppt er ins stehen.
func void AI_StandUpQuick(var C_Npc self)
// Wie AI_StandUp(), jedoch werden keine Rücktransitionen abgespielt, sondern auch dort wird
// sofort in den Grundzustand "gepoppt". Wichtig für sehr eilige Situationen!
func void AI_QuickLook(var C_Npc self, var C_Npc other) { };
// NSC kurz ( 2 sec) anschauen ( nur Kopf bewegt sich )
func void AI_LookAt(var C_Npc self, var string name) { };
// Schaue auf einen Wegpunkt (Wegpunktname angeben) oder auf ein anderes Objekt (Vobname angeben)
func void AI_LookAtNpc(var C_Npc self, var C_Npc other) { };
// Schaue zu einem NSC
func void AI_StopLookAt(var C_Npc self) { };
// wieder geradeaus schauen
func void AI_PointAt(var C_Npc self, var string name) { };
// Zeige auf einen Wegpunkt (Wegpunktname angeben) oder auf ein anderes Objekt (Vobname angeben)
func void AI_PointAtNpc(var C_Npc self, var C_Npc other) { };
// Zeige auf einen NSC
func void AI_StopPointAt(var C_Npc self) { };
// nicht mehr auf etwas zeigen

// ------------------------------------- NSC NIMMT / LEGT WEG -------------------------------
func void AI_TakeItem(var C_Npc self, VAR C_ITEM item) { };
// der Npc nimmt mit dieser Funktion die globale Item-Instanz auf
func void AI_DropItem(var C_Npc self, var int itemid) { };
// Item(itemid) wird auf den Boden fallen gelassen

// ------------------------------------------- USE ITEM -------------------------------------
func void AI_UseItem(var C_Npc self, var int itemInstance) { };
// Item bis zum Ende benutzen
func void AI_UseItemToState(var C_Npc self, var int itemInstance, var int state) { };
// Item benutzen bis zum angegebenen State

// ---------------------------------------- NSC BENUTZT MOB ---------------------------------

func int AI_UseMob(var C_Npc self, var string schemeName, var int targetState) { return 0; };
// Benutze Mob mit angegebenen Schema-Namen bis zum Zustand "targetState". Wird diese Funktion aufgerufen
// und der angegebene 'targetState' ist bereits vorhanden, läuft der NSC zwar trotzdem zum MOB, tut dann aber nichts
func int Wld_IsMobAvailable(var C_Npc self, var string schemeName) { };
// Sucht sich ein Mobsi im Umkreis von 10m und liefert TRUE falls gefunden. MOB wird nur zurückgeliefert, wenn es nicht besetzt ist.
func int Wld_GetMobState(var C_Npc self, var string schemeName);
// Liefert den State zum nächsten Mob mit 'schemeName' zurück bzw. '-1' wenn kein solches Mob gefunden wurde

// -------------------------------------------- GEHEN ----------------------------------------

func void AI_SetWalkMode(var C_Npc n, var int n0) { };
// gibt an mit welchem Walkmode Run etc der Character durch das Level läuft
// NPC_RUN : Rennen
// NPC_WALK : Gehen
// NPC_SNEAK : Schleichen
// NPC_RUN_WEAPON : Rennen mit gezogener Waffe
// NPC_WALK_WEAPON : Gehen mit gezogener Waffe
// NPC_SNEAK_WEAPON : Schleichen mit gezogener Waffe
// -------------------------------------------------------------------------------------------
func void AI_GotoWP(var C_Npc n0, var string s0) { };
// Npc-Instanz läuft zum namentlich angegeben Waypoint
func void AI_GotoFP(var C_Npc self, var string fpName) { };
// Sucht sich einen Freepoint im Umkreis von 20m vom NSC, bewegt sich dorthin und richtet sich entsprechend aus.
// Suchkriterium wie bei Wld_IsFPAvailable()
func void AI_GotoNextFP(var C_Npc self, var string fpName) { };
// wie AI_GotoFP() allerdings Suchkriterium wie bei Wld_IsNextFPAvailable()
func void AI_GotoNpc(var C_Npc self, var C_Npc other) { };
// "self" geht zu "other"
func void AI_GotoItem(var C_Npc self, VAR C_ITEM item) { };
// "self" geht zu "item"
func void AI_GotoSound(var C_Npc n0) { };
// Npc läuft zum Sound
func void AI_Teleport(var C_Npc self, var string waypoint);
// teleportiert den NSC zur angegebenene Location

// -------------------------------------------------------------------------------------------
func string Npc_GetNearestWP(var C_Npc self) { return ""; };
// liefert den Namen des am nächsten gelegenen Waypoints zurück
func string Npc_GetNextWP(var C_Npc self) { return ""; };
// Liefert den zweitnahesten WP vom NSC zurück
// -------------------------------------------------------------------------------------------
func int Wld_IsFPAvailable(var C_Npc self, var string fpName) { };
// Sucht einen Freepoint im Umkreis von 20m vom NSC und liefert TRUE falls vorhanden und frei ('self' zählt als Blockierer nicht!) und sichtbar
func int Wld_IsNextFPAvailable(var C_Npc self, var string fpName)
//  wie Wld_IsFPAvailable(), aber es wird immer der nahegelegenste genommen und 'self' zählt als Blockierer!
func int Npc_IsOnFP(var C_Npc self, var string name)
// Abfrage darauf, ob der Nsc auf einem Freepoint mit name Teilstring steht
func int Npc_IsWayBlocked(var C_Npc self) { };
// Liefert "1", falls Weg von NSC durch Hindernis versperrt ist.

// -------------------------------- DREHEN / AUSRICHTEN -------------------------------------

func void AI_TurnToNpc(var C_Npc n0, var C_Npc n1) { };
// drehe Dich zum angegeben (zweiten) Npc um
func void AI_TurnAway(var C_Npc n0, var C_Npc n1) { };
// Der NSC "self" dreht dem NSC "other" den Rücken zu.
func void AI_WhirlAround(var C_Npc self, var C_Npc other) { };
// schnelle Drehung zu other
func void AI_TurnToSound(var C_Npc self) { };
// Charakter dreht sich zur Geräuschquelle
func void AI_AlignToWP(var C_Npc self) { };
// richtet den Nsc am Waypoint aus (im Spacer gesetzte Pfeilrichtung)
func void AI_Dodge(var C_Npc npc) { };
// Der Nsc weicht ein Stück nach hinten aus

// ----------------------------------- OVERLAY-MDS -------------------------------------------

func void Mdl_ApplyOverlayMDS(var C_Npc n0, var string s1) { };
// mit diesem Befehl werden Animationen auf einem höheren Layer gestartet
// (z.B. hat der Zombie ein Overlay über die normalen Human-Animationen)
func void Mdl_RemoveOverlayMDS(var C_Npc self, var string overlayName) { };
// Entferne ein Overlay-MDS
func void Mdl_ApplyOverlayMDSTimed(var C_Npc self, var string overlayname, var float timeTicks);
// Overlay-MDS wird gestartet und automatisch nach der angegebenen Zeit abgeschaltet

// ----------------------------------- RANDOM-ANIS -------------------------------------------

func void Mdl_ApplyRandomAni(var C_Npc n0, var string s1, var string s2) { };
// Fügt Zufallsanimationen (am Kopf kratzen, an den Sack packen etc (s2)) für bestimmte Animationszustände (s1) ein
func void Mdl_ApplyRandomAniFreq(var C_Npc n0, var string s1, var float f2) { };
// hiermit kann die Frequenz betimmt werden, wie oft die für den Animationszustand (s1) deklarierten Randomanis abgespielt werden

// ----------------------------------- FACE-ANIS ----------------------------------------------

func void Mdl_StartFaceAni(var C_Npc self, var string name, var float intensity, var float holdTime) { };
// Starte Gesichtsanimation // intensity 1 = 100% // holdTime -1 = forever
func void Mdl_ApplyRandomFaceAni(var C_Npc self, var string name, var float timeMin, var float timeMinVar, var float timeMax, var float timeMaxVar, var float probMin) { };
// Starte zufällige Gesichtsanimation
// Mdl_ApplyRandomFaceAni( self, ANINAME, minTime, minTimeVar, maxTime, maxTimeVar, probMin)
// minTime = Minimum an Zeit nachdem Ani startet (in Sekunden)
// maxTime = Maximum an Zeit nachdem Ani startet (in Sekunden)
// minTimeVar = Abweichung von minTime (in Sekunden)
// maxTimeVar = Abweichung von maxTime (in Sekunden)
// probMin = Wahrscheinlichkeit [0..1] ob obere oder untere Grenze der Abweichung benutzt wird

// --------------------------------------- BODYSTATES ----------------------------------------

func int Npc_GetBodyState(var C_Npc self) { return 0; };
// Ermittle BodyState ( Liefert BS_-Konstanten )
// !!! VORSICHT !!!: Diese Funktion gibt den Bodystate mit allen eventuellen
// ver-oderten Modifiern wie "brennend". Besser 'C_BodyStateContains(self,bodystate)' benutzen
func int Npc_HasBodyFlag(var C_Npc self, var int bodyFlag) { };
// Liefert >0, falls BodyFlag gesetzt ist.
func void AI_PlayAniBS(var C_Npc npc, var string aniname, var int bodystate) { };
// Beim Abspielen einer Ani mit diesem Befehl kann ein Bodystate angemeldet werden

// *******************************************************************************************
// *** KAMPF ***
// *******************************************************************************************

// --------------------------------------- KAMPFMODUS ----------------------------------------

func void Npc_SetToFistMode(var C_Npc self) { };
// Setzt den NSC beim Start in den Faustkampfmodus (zB.Monster)
func void Npc_SetToFightMode(var C_Npc self, var int weapon) { };
// Setzt den NSC beim Start in den der Waffe entsprechenden Kampfmodus (Waffe wird erzeugt)
func int Npc_IsInFightMode(var C_Npc self, var int fmode) { return 0; };
// liefert eins zurück, wenn der Charakter im angegebenen Fightmode (z.B. FMODE_MAGIC) ist

// ----------------------------------------- WEAPONS -----------------------------------------

func void AI_DrawWeapon(var C_Npc n0) { };
// Equipte Waffe wird gezogen
func void AI_ReadyMeleeWeapon(var C_Npc self) { };
// Ziehe equippte Nahkampfwaffe
func void AI_ReadyRangedWeapon(var C_Npc self) { };
// Ziehe equippte Fernkampfwaffe
func void AI_RemoveWeapon(var C_Npc n0) { };
// Gezogene Waffe wird weggesteckt
// -------------------------------------------------------------------------------------------
FUNC C_Item Npc_GetReadiedWeapon(var C_Npc n0) { };
// Liefert die gezogene Waffe des NSCs.
// -------------------------------------------------------------------------------------------
func int Npc_HasReadiedWeapon(var C_Npc self) { return 0; };
// gibt eins zurück, wenn die Waffe schon in der Hand ist
func int Npc_HasReadiedMeleeWeapon(var C_Npc self) { return 0; };
// Nahkampfwaffe in der Hand
func int Npc_HasReadiedRangedWeapon(var C_Npc self) { return 0; };
// Fernkampfwaffe in der Hand
func int Npc_HasRangedWeaponWithAmmo(var C_Npc npc)
// Gibt TRUE zurück, wenn 'npc' irgendeine Fernkampfwaffe im Inventory oder in der Hand hat UND
// dazu auch passende Munition vorhanden ist. Sonst FALSE.

// ----------------------------------------- ANGRIFF -----------------------------------------
func int Npc_GetTarget(var C_Npc self)
// Befüllt 'other' mit dem aktuellen Ziel. Das aktuelle Ziel wird intern gespeichert, wird
// durch Npc_SetTarget() bzw. Npc_GetNextTarget() gesetzt.
// - return: aktuelles Ziel gespeichert -> TRUE
//				kein Ziel gespeichert -> FALSE
func int Npc_GetNextTarget(var C_Npc self)
// Aktive Suche nach einem Gegner. Wird ein Gegner gefunden, so wird er als internes Ziel
// übernommen und in 'other' geschrieben, wenn kein Gegner gefunden wurde wird das
// interne Ziel gelöscht und 'other' ungültig gemacht.
// Kriterien: 1. gesetzter Gegner, der nicht tot/bewußtlos ist wird genommen...
//				2. ...dann der nächstbeste aNSC demgegenüber 'self' HOSTILE ist (auch weder tot noch bewußtlos)
// - return: neues Ziel gefunden -> TRUE
//				kein Ziel gefunden -> FALSE
// VORSICHT: Beruht auf der aktuellsten VOB-Liste, die durch aktive Wahrnehmungen oder durch
//				Npc_PerceiveAll() erstellt wurde. Wird diese Funktion in einem Zustand ohne aktive
//				Wahrnehmungen benutzt, muß vorher ein Npc_PerceiveAll() aufgerufen werden
func int Npc_IsNextTargetAvailable(var C_Npc self)
// Sucht genauso wie Npc_GetNextTarget nach einem neuen Ziel, überschreibt aber weder
// das interne Ziel, noch 'other'
// - return: neues Ziel gefunden -> TRUE
//				kein Ziel gefunden -> FALSE
// VORSICHT: Beruht auf der aktuellsten VOB-Liste, die durch aktive Wahrnehmungen oder durch
//				Npc_PerceiveAll() erstellt wurde. Wird diese Funktion in einem Zustand ohne aktive
//				Wahrnehmungen benutzt, muß vorher ein Npc_PerceiveAll() aufgerufen werden
func void Npc_SetTarget(var C_Npc self, var C_Npc other)
// Gibt dem Nsc 'self' das interne Ziel 'other'. --> Nur wenn per GetTarget auch der other "geholt" wird ist er vorhanden, da hier interne Variablen, die in den Skripten nicht vorhanden sind verwendet werden
func void AI_Attack(var C_Npc self)
// Startet Kampf AI (sollte in der ZS_Attack-Loop stehen)
// Es wird das interne Ziel verwendet, das mit Npc_SetTarget() oder Npc_GetNextTarget() gesetzt
// wurde.
func void AI_FinishingMove(var C_Npc self, var C_Npc other)
// Führt den logischen Finishing Move inklusive Anis aus den Skripten heraus aus
func void AI_Defend(var C_Npc self)
// Der Befehl ist als Overlay-Message implementiert. Das heisst, dass er neben anderen Nachrichten
// aktiv bleibt. Er wird erst beendet, wenn der NPC eine Parade (ausgeloest durch die Attacke eines
// anderen NPCs) durchgefuert hat.

func void AI_Flee(var C_Npc self) { };
// Der Befehl muss, wie AI_Attack(), in der ZS-Loop regelmaessig aufgerufen werden und setzt voraus, dass
// vorher mit Npc_SetTarget( self, <var C_Npc enemy> ) ein Gegner gesetzt wurde, vor dem der Npc fliehen soll.
func void AI_AimAt(var C_Npc attacker, var C_Npc target) { };
// !!! zielen mit FK???
func void AI_ShootAt(var C_Npc attacker, var C_Npc target) { };
// !!! schießen mit FK
func void AI_StopAim(var C_Npc attacker) { };
// !!! stoppt das zielen mit FK ???
// ------------------------------------- SONSTIGE CHECKS ------------------------------------

func int Npc_AreWeStronger(var C_Npc self, var C_Npc other) { return 0; };
// ermittelt den stärkeren Nsc,
// Wenn die Summe der Level aller NPCs (human, Monster), die zu mir feindlich sind und die zu <other> freundlich sind
// MEHR ALS DOPPELT SO HOCH ist (x > 2*y), wie die Summe der Level aller Leute, die zu mir freundlich sind, und die
// zu <other> feindlich sind, dann NEIN,
// sonst JA (= wir SIND stärker, nicht echt, aber ab doppelter Gegnerstärke zu fliehen ist früh genug, sonst kommen
// die Jungs aus dem Rennen nicht mehr raus
// Beachten:
// 1) Monster können feindlich zu beiden Menschen sein --> egal, zählen auf beiden Seiten
// 2) Jemand, der z.B. zu mir freundlich und zu <other> feindlich ist, wird demnach doppelt gewertet --> ok so
func int Npc_IsAiming(var C_Npc self, var C_Npc other) { return 0; };
// liefert eins zurück, wenn der zweite Character auf den ersten zielt (Fernkampfwaffen und Zauber)

// *******************************************************************************************
// *** ITEMS ***
// *******************************************************************************************

// ------------------------------------ ITEMS IN DER WELT ------------------------------------
func void Wld_InsertItem(var int itemInstance, var string spawnPoint) { };
// Füge Item in Welt ein entweder an einem WP oder einem FP
// Vorsicht, funktioniert nicht, Items werden immer im Mittelpunkt der Welt inserted
func void AI_LookForItem(var C_Npc self, var int instance) { };
// gibt die Möglichkeit nach bestimmten Items zu suchen (z.B.:Das goldene Schwert der Zerstörung, wenn vorhanden)
func int Wld_RemoveItem(VAR C_ITEM item) { };
// !!! hiermit wird das globale Item aus der Welt gelöscht ???

// ---------------------------------------- INVENTORY ----------------------------------------
func void CreateInvItem(var C_Npc n0, var int n1) { };
//  gibt der angegebenen Instanz (self oder other) ein Item ins Inventory
func void CreateInvItems(var C_Npc n0, var int n1, var int n2) { };
// wie vorherige Funktion, nur das Multi-Items (z.B.: 100 Pfeile) ins Inventory kreiert werden
FUNC C_Item Npc_GetInvItem(var C_Npc self, var int itemInstance) { };
// Ermittle ItemInstanz aus Inventory
func int Npc_HasItems(var C_Npc n0, var int itemInstance) { return 0; };
// Liefert "1", wenn NSC die angegebene Anzahl von Items besitzt.-> NpcHasItem ist damit obsolete
func int Npc_GetInvItemBySlot(var C_Npc self, var int category, var int slotNr)
// Mit diesem Befehl läßt sich nachsehen, ob in einem bestimmten Slot einer bestimmten Kategorie ein item vorhanden ist
// ist das der Fall, wird dieses Item in die globale Variable item geschrieben
// gibt jetzt die Anzahl zurueck, wenn das Item stackable ist
// . Den Transfer machst Du dann per Npc_RemoveInvItems() und Npc_CreateInvItems().
func void Npc_RemoveInvItem(var C_Npc owner, var int itemInstance) { };
// !!! das globale Item wird gelöscht ???
func void Npc_RemoveInvItems(var C_Npc owner, var int itemInstance, var int amount) { };
// !!! wie Npc_RemoveInvItem, nur das Multislotgegenstände gelöscht werden ???
// ------------------------------------------ TRUHEN -----------------------------------------
func void Mob_CreateItems(var string mobName, var int itemInstance, var int amount) { };
// Erzeuge "amount" Items der Instanz "itemInstance" in oCMobContainer mit angegebenen Vobnamen.
func int Mob_HasItems(var string mobName, var int itemInstance) { return 0; };
// Liefere Anzahl der Items der Instanz "itemInstance" in oCMobContainer mit angegebenen Vobnamen

// ------------------------------------ EQUIPPEN / UNEQUIPPEN --------------------------------
func void EquipItem(var C_Npc n0, var int n1) { };
// gibt dem Nsc direkt das angegebene Item an den Gürtel
func void AI_EquipBestMeleeWeapon(var C_Npc self) { };
// sucht im Inventory nach der besten Nahkampfwaffe und hängt sie an den Gürtel
func void AI_EquipBestRangedWeapon(var C_Npc self) { };
// sucht im Inventory nach der besten Fernkampfwaffe und ploppt sie auf den Rücken der Instanz
func void AI_EquipBestArmor(var C_Npc self) { };
// Wunder, Wunder hier wird die beste im Inventory vorhandene Rüstung angezogen
func void AI_UnequipWeapons(var C_Npc self) { };
// Unequippe alle Waffen
func void AI_UnequipArmor(var C_Npc self) { };
// Unequippe aktuelle Rüstung
func void AI_EquipArmor(var C_Npc owner, VAR C_ITEM armor_from_owners_inventory)
// !!! was ist diese armor_from_owners_inventory ???
// -------------------------------------------------------------------------------------------
FUNC C_Item Npc_GetEquippedMeleeWeapon(var C_Npc n0) { };
// Liefert die gegurtete Nahkampfwaffe des NSCs.
FUNC C_Item Npc_GetEquippedRangedWeapon(var C_Npc n0) { };
// Liefert die gegurtete Fernkampfwaffe des NSCs.
FUNC C_Item Npc_GetEquippedArmor(var C_Npc n0) { };
// Liefert die angelegte Rüstung des NSCs.
// -------------------------------------------------------------------------------------------
func int Npc_HasEquippedWeapon(var C_Npc self) { return 0; };
// gibt eins zurück, wenn die abgefragte Instanz (self oder other) eine Waffe sichtbar mit sich rumträgt
func int Npc_HasEquippedMeleeWeapon(var C_Npc self) { return 0; };
// gibt eins zurück, wenn eine Nahkampfwaffe Equipped ist
func int Npc_HasEquippedRangedWeapon(var C_Npc self) { return 0; };
// Fernkampwaffe auf dem Rücken True/False
func int Npc_HasEquippedArmor(var C_Npc self) { return 0; };
// Armor angezogen True/False

// ------------------------------------------- BESITZ ---------------------------------------
func int Npc_OwnedByNpc(VAR C_ITEM item, var C_Npc npc) { return 0; };
// Liefert "1", wenn dem NSC das Item gehört ( persönliches Besitzflag )
func int Npc_OwnedByGuild(VAR C_ITEM item, var int guild) { return 0; };
// Liefert "1", wenn der angegebenen Gilde das Item gehört ( Gildenbesitz )
func int Npc_IsDetectedMobOwnedByNpc(var C_Npc user, var C_Npc owner) { return 0; };
// Liefert >0, falls "owner" der Besitzer des vom "user" benutzten Mob ist.
// VORSICHT: Diese Funktion ist nur in Verbindung mit PERC_MOVEMOB erlaubt !!!
func int Npc_IsDetectedMobOwnedByGuild(var C_Npc user, var int ownerguild) { return 0; };
// Liefert >0, falls "ownerguild" der Besitzer des vom "user" benutzten Mob ist.
// VORSICHT: Diese Funktion ist nur in Verbindung mit PERC_MOVEMOB erlaubt !!!
// ------------------------------------------ TRADE -----------------------------------------
func void Npc_GiveItem(var C_Npc n0, VAR C_ITEM n1, var C_Npc n2) { };
// Der NSC "self" gibt den NSC "other" den angegebenen Gegenstand "item". Der Gegenstand wandert sofort ins Inventory des anderen.
func int Npc_StartItemReactModules(var C_Npc self, var C_Npc other, VAR C_ITEM item) { return 0; };
// Prüfe alle ItemReact-Module von "self" auf Gegenstand "item" von Geber "other" und starte passende Reaction-Funktion
// liefert True beim finden eines Moduls
func int Npc_HasOffered(var C_Npc self, var C_Npc other, var int itemInstance) { return 0; };
// Bietet Spieler dem NSC einen Gegenstand übers Trade-Modul an ? True/False

// ---------------------------------------- MAPS & DOCS -------------------------------------
func void Doc_Open(var string picName) { };
// Öffnet ein Dokument mit dem Bild "picName" als Hintergrund
func void Doc_Font(var string fontName) { };
// Benutzt den angegebenen Font für nachfolgende "Doc_Print"s.
func void Doc_Print(var string text) { };
// Angegebener Text wird in das aktuelle (vorher mit Doc_Open geöffnete) Dokument geschrieben
func void Doc_MapCoordinates(var string levelName, var float gamex1, var float gamey1, var float pixelx1, var float pixely1, var float gamex2, var float gamey2, var float pixelx2, var float pixely2) { };
// Karte initialisieren : levelName = Name des Levels (.ZEN) aus dem die Karte einen Ausschnitt zeigt
// gamex1,gamey1 : Koordinaten im Spiel (linke obere Ecke der Karte)
// pixelx1,pixely1 : PixelKoordinaten linke obere Ecke // der Rest : alles nochmal für die rechte untere Ecke

// *******************************************************************************************
// *** DIALOGE ***
// *******************************************************************************************

func void AI_Output(var C_Npc self, var C_Npc target, var string outputName) { };
// Cutscene mit entsprechender Id wird abgenudelt
func void AI_OutputSVM(var C_Npc self, var C_Npc target, var string svmname) { };
// Outputbefehl um Svms abzuspielen
func void AI_OutputSVM_Overlay(var C_Npc self, var C_Npc target, var string svmname) { };
// wie AI_OutputSVM, wartet jedoch NICHT mit der Ausführung des nächsten AI_...-Befehls, bis
// das SVM zuende gespielt wird. (Für Kommentare kurz vor und während dem Kampf!)
func void AI_WaitTillEnd(var C_Npc self, var C_Npc other) { };
// 'self' wartet bis 'other' seinen laufenden AI-Befehl zu Ende gespielt hat (funzt allerdings nicht bei AI-Overlays!)
// -------------------------------------------------------------------------------------------
func void AI_Ask(var C_Npc self, var func anserYes, var func answerNo) { };
// die angegeben Instanz (self), gibt eine Frage aus und verweist auf die selbst zu definierenden Funktionen,
// die für die Fälle Spieler sagt ja (Daumen nach oben) und Spieler sagt nein (Daumen unten) vorhanden sein müssen
func void AI_AskText(var C_Npc self, var func funcYes, var func funcNo, var string strYes, var string strNo);
// wie AI_Ask, nur das außer den Funktionen auch noch Strings für die Antworten Ja/Nein mit angegeben werden können
func void AI_WaitForQuestion(var C_Npc self, var func scriptFunc) { };
// NSC wartet 20 Sekunden, wird er in dieser Zeit vom Spieler angesprochen, wird die angegebene SkriptFunktion ausgeführt.
// -------------------------------------------------------------------------------------------
func void Npc_SetRefuseTalk(var C_Npc self, var int timeSec) { };
// Dialog Refuse Counter aus "x" Sekunden setzen
func int Npc_RefuseTalk(var C_Npc self) { return 0; };
// Abfrage ob Dialog-Refuse Counter noch aktiv ist True/False

// *******************************************************************************************
// *** NEWS ***
// *******************************************************************************************

func void Npc_MemoryEntry(var C_Npc self, var int source, var C_Npc offender, var int newsid, var C_Npc victim) { };
// mit dieser Funktion wird eine NSC bezogene News geschrieben newsid : News ID source > 0 : "gossip", ansonsten "witness",
// self: NSC, bei dem News eingespeist werden soll, other: Täter victim : Opfer
func void Npc_MemoryEntryGuild(var C_Npc self, var int source, var C_Npc offender, var int newsid, var C_Npc victimguild) { };
// wie MemoryEntry nur, das die Memory für die ganze Gilde kreiert wird
func int Npc_HasNews(var C_Npc self, var int newsID, var C_Npc offender, var C_Npc victim) { };
// Liefert Newsnummer>0 (für weitere Referenzen) falls entsprechende News vorhanden.
// Nicht benötigte Parameter können mit "NULL" leergelassen werden
func int Npc_IsNewsGossip(var C_Npc self, var int newsNumber) { };
// Liefert >0, falls News "Gossip" ist
FUNC C_NPC Npc_GetNewsWitness(var C_Npc self, var int newsNumber) { };
// Ermittle Zeuge der News und gibt eine INstanz der Klasse C_Npc zurück
FUNC C_NPC Npc_GetNewsVictim(var C_Npc self, var int newsNumber) { };
// Ermittle Opfer der News und gibt eine INstanz der Klasse C_Npc zurück
FUNC C_NPC Npc_GetNewsOffender(var C_Npc self, var int newsNumber) { return 0; };
// Ermittelt Täter der News und gibt eine INstanz der Klasse C_Npc zurück

// *******************************************************************************************
// *** MISSIONS ***
// *******************************************************************************************

func int Npc_IsDead(var C_Npc n0) { return 0; };
// Funktion liefert einen Wert zurück, falls Dead true ist
func int Npc_KnowsInfo(var C_Npc self, var int infoInstance) { return 0; };
// Liefert TRUE, wenn der angegebene Spieler die Info schon einmal erhalten hat.
// VORSICHT: auch wenn eine permanente Info schon einmal dem Spieler erzählt wurde, so gibt diese Funktion trotzdem FALSE zurück!
func int Npc_CheckInfo(var C_Npc npc, var int important) { return 0; };
// Überprüft,ob der NSC gültige Infos für den Spieler hat und startet diese gegebenenfalls (Returnwert "1").
func int Npc_GiveInfo(var C_Npc npc, var int important) { return 0; };
// Überprüft,ob der NSC eine (!) gültige Info für den Spieler hat und startet diese gegebenenfalls (Returnwert "1").
func int Npc_CheckAvailableMission(var C_Npc npc, var int missionState, var int important) { return 0; };
// Prüfe ob zwischen dem NSC eine aktuelle Mission (AVAILABLE,RUNNING) besteht und vergleiche den Status mit den angegebenen.
// Falls dieser identisch ist, wird "1" geliefert.
func int Npc_CheckRunningMission(var C_Npc npc, var int important) { return 0; };
// Überprueft ob zwischen dem NSC und dem Spieler eine laufende Mission besteht und startet den entsprechenden Skriptblock.
// (Returnwert 1 : Mission aktiv)
func int Npc_CheckOfferMission(var C_Npc npc, var int important) { return 0; };
// Überprueft ob der NSC dem Spieler einen Auftrag anbieten kann, wenn ja, wird der Offer-Block gestartet und "1" zurückgeliefert.
func void Mis_SetStatus(var int missionName, var int newStatus) { };
// Setzt den Status einer Mission ( Bezogen auf den Spieler ) -> RUNNING, SUCCESS, FAILED etc. )
func int Mis_GetStatus(var int missionName) { return 0; };
// Liefert aktuellen Status einer Mission zurück ( Bezogen auf den Spieler ) -> RUNNING, SUCCESS, FAILED etc.
func int Mis_OnTime(var int missionName) { return 0; };
// Liefert TRUE, wenn sich Spieler noch innerhalb des Zeitlimits für diese Mission befindet
func void AI_StopProcessInfos(var C_Npc npc)
// ???

// *******************************************************************************************
// *** PLAYER ***
// *******************************************************************************************

func int Npc_IsPlayer(var C_Npc player) { return 0; };
// liefert eins zurück, wenn der geprüfte Charakter der Spieler himself ist
func int Wld_DetectPlayer(var C_Npc self) { return 0; };
// liefert eins zurück, wenn der Player in der Nähe ist
func int Npc_HasDetectedNpc(var C_Npc self, var C_Npc other) { return 0; };
// liefert eins zurück, wenn der Spieler in Sinnesreichweite und entdeckt ist // SPIELER ???

// *******************************************************************************************
// *** ENTFERNUNGEN ***
// *******************************************************************************************

func int Npc_IsNear(var C_Npc self, var C_Npc other) { return 0; };
// liefert eins zurück, wenn geprüfte Instanz sich im Bereich von drei Metern zur prüfenden Instanz befindet
func int Npc_GetDistToNpc(var C_Npc npc1, var C_Npc npc2) { return 0; };
// Liefert Entfernung ( ín cm ! ) zwischend den beiden NSCs
func int Npc_GetDistToWP(var C_Npc self, var string wpName)
// liefert die Entfernung vom NSC 'self' zum angegebenen Waypoint in cm
func int Npc_GetDistToItem(var C_Npc npc, VAR C_ITEM item) { return 0; };
// Liefert Entfernung ( ín cm ! ) zwischend NSC und Gegenstand
func int Npc_GetDistToPlayer(var C_Npc npc1) { return 0; };
// Liefert Entfernung ( ín cm ! ) zwischend den beiden NSCs
func int Snd_GetDistToSource(var C_Npc self) { return 0; };
// Liefert Entfernung ( in cm ! ) zum letzten logischen Sound

// *******************************************************************************************
// *** GILDEN / ATTITUEDEN / KENNE SC ***
// *******************************************************************************************

func int Npc_GetTrueGuild(var C_Npc npc) { return 0; };
// liefert immer!!! die wahre Gilde zurück, ignoriert also auch ohne die Regeln die Verkleidung
func void Npc_SetAttitude(var C_Npc self, var int att) { };
//  setzt die permanente Attitüde auf einen festen Wert
func void Npc_SetTempAttitude(var C_Npc self, var int att) { };
//   setzt die temporäre Attitüde auf einen Wert (att)
func int Npc_GetAttitude(var C_Npc self, var C_Npc other) { return 0; };
// Gibt die Attitüde von self zu other zurück (temp. / perm. / Gilden )
func int Npc_SetTrueGuild(var C_Npc npc, var int guildID) { };
// Setzt die wahre Gilde des NSCs
func void Wld_SetGuildAttitude(var int guild1, var int attitude, var int guild2) { };
// Setze Gildenattitude neu
func int Wld_GetGuildAttitude(var int guild1, var int guild2) { return 0; };
// Ermittle Gildenattitude
func int Npc_GetPermAttitude(var C_Npc self, var C_Npc other) { };
// Ermittle die permanente Attitude von "self" zu "other"
func void Wld_ExchangeGuildAttitudes(var string name) { };
// Tausche Gilden-AttitudenTabelle aus.
func int Npc_GetGuildAttitude(var C_Npc npc, var C_Npc npc) { return 0; };
// Ermittelt die Gildenattitüde von zwei Nsc´s direkt im Gegensatz zu Wld_GetGuildAttitude
// -------------------------------------------------------------------------------------------
func void Npc_SetKnowsPlayer(var C_Npc self, var C_Npc player) { };
// NSC kennt SC
func int Npc_KnowsPlayer(var C_Npc self, var C_Npc player) { return 0; };
// Kennt der NSC den Spieler? True/False

// *******************************************************************************************
// *** TA / ZS ***
// *******************************************************************************************

// ---------------------------------------------- ZS -----------------------------------------
func void AI_StartState(var C_Npc self, var func what, var int stateBehaviour, var string wpName) { };
// Versetzt den Nsc aus den Skripten heraus in den entsprechenden ZS (what),
// stateBehaviour sagt : "0"-aktuellen Zustand abbrechen "1"-aktuellen Zustand erst ordnungsgemäß beenden (End-Funktion aufrufen) ).
func void Npc_ClearAIQueue(var C_Npc self) { };
// hiermit werden alle Befehle mit sofortiger Wirkung aus der AI_Queue rausgeworfen
func void AI_SetNpcsToState(var C_Npc self, var func aiStateFunc, var int radius) { };
// Setze alle NSCs im Umkreis von x cm in entsprechenden AI-Zustand
// VORSICHT: Diese Funktion ist Buggy, wird aber derzeit auch NICHT verwendet!
// -> FINGER WEG!!! (SN)
// -------------------------------------------------------------------------------------------
func int Npc_IsInState(var C_Npc self, var func state) { return 0; };
// Abfrage auf den aktuellen Zustand einer Spielfigur True/False
func int Npc_WasInState(var C_Npc self, var func state) { return 0; };
// Abfrage auf den vorherigen Zustand einer Spielfigur True/False

// ---------------------------------------------- TA -----------------------------------------
func void TA(var C_Npc self, var int start_h, var int stop_h, var func state, var string waypoint) { };
// Mit _(Zustandsname) wird ein neuer Tagesablauf generiert, siehe TA.d
func void TA_Min(var C_Npc self, var int start_h, var int start_m, var int stop_h, var int stop_m, var func state, var string waypoint) { };
// Tagesablaufpunkt minutengenau angeben
func void AI_ContinueRoutine(var C_Npc self) { };
// Setze Tagesablauf fort
// Enthält Standup
// -------------------------------------------------------------------------------------------
func int Npc_IsInRoutine(var C_Npc self, var func state) { return 0; };
// Check ob der angegebene Zustand der aktuelle TA des NSCs ist. True/FAlse
func void Npc_ExchangeRoutine(var C_Npc self, var string routineName) { };
// Tausche meherere Tagesabläufe aus

// ------------------------------------- OBJEKT-TAs ------------------------------------------
func void Wld_SetObjectRoutine(var int hour1, var int min1, var string objName, var int state) { };
// _Ein_ Objekt mit diesem _Vobnamen_ wird getriggert
func void Wld_SetMobRoutine(var int hour1, var int min1, var string objName, var int state) { };
// _Alle_ Mobs mit diesem _Schemanamen_ werden getriggert.

// ------------------------------------- Overlay-TAs -----------------------------------------
func void Rtn_Exchange(var string oldRoutine, var string newRoutine) { };
// Tausche aktuellen Tagesablauf des NSC "self" gegen angegebenen aus
// (Name wird automatisch mit "RTN_" am Anfang und NSC-Skript-ID am Ende ergänzt)
func void TA_BeginOverlay(var C_Npc self) { };
// Melde einen Overlay-Tagesablauf an
func void TA_EndOverlay(var C_Npc self) { };
// Beende einen Overlay-Tagesablauf
func void TA_RemoveOverlay(var C_Npc self) { };
// Entferne aktiven TA-Overlay

// *******************************************************************************************
// *** SCALING ***
// *******************************************************************************************

func void Mdl_SetModelScale(var C_Npc self, var float x, var float y, var float z) { };
// zum skalieren des Meshes (Breite,Höhe,Tiefe) 1 = 100%, also Normalgröße!
func void Mdl_SetModelFatness(var C_Npc self, var float fatness) { };
// Setzt Model-Z-Skalierung

// *******************************************************************************************
// *** ATTRIBUTE ***
// *******************************************************************************************

func void Npc_ChangeAttribute(var C_Npc self, var int atr, var int value) { };
// ändert den Wert des Attributs (atr) um (value) Einheiten.

// *******************************************************************************************
// *** TALENTE ***
// *******************************************************************************************

func int Npc_HasTalent(var C_Npc self, var int tal) { return 0; };
// liefert eins zurück, wenn der geprüfte Charakter das Talent tal hat
func int Npc_HasFightTalent(var C_Npc self, var int tal) { return 0; };
// Spezialabfrage auf Kampftalente (z.B. 1hSword) ansonsten wie Npc_HasTalent

// *******************************************************************************************
// *** MAGIE ***
// *******************************************************************************************

func void Npc_CreateSpell(var C_Npc self, var int spellnr) { };
// NSc bekommt Zauberspruch zugewiesen kann diesen aber noch nicht gebrauchen
// (erscheint ausgegraut im Auswahlkranz)
func void Npc_LearnSpell(var C_Npc self, var int spellnr) { };
// Was könnte das wohl heißen ? Ich glaube damit kann man den (spellnr) Zauber zuweisen
func void Npc_SetTeleportPos(var C_Npc self) { };
// Magie/Zauberstein Teleport Spruch : letzte Position des NSCs merken, zwecks späteren dahinbeamens.
func int Npc_GetActiveSpell(var C_Npc self) { return 0; };
// liefert den Zauber zurück, der auf der Hand ist (self oder other)
// liefert -1 zurück, wenn kein Zauber auf der Hand ist
func int Npc_GetActiveSpellCat(var C_Npc self) { return 0; };
// Unterscheidet zwischen den drei Kategorien (Spell_Bad, Spell_neutral,Spell_Good) Spellkat ist Rückgabewert
func int Npc_SetActiveSpellInfo(var C_Npc npc, var int i1) { return 0; };
// liefert den Spell-Level des Zaubers zurück, der auf der Hand ist
func int Npc_GetActiveSpellLevel(var C_Npc self)

// ????
func void AI_ReadySpell(var C_Npc self, var int spellID, var int investMana);
func void AI_UnreadySpell(var C_Npc self);
func int Npc_HasSpell(var C_Npc self, var int spellID);

// *******************************************************************************************
// *** WAHRNEHMUNGEN ***
// *******************************************************************************************

func void Npc_PercEnable(var C_Npc self, var int percID, var func function) { };
// Aktiviere Perception
func void Npc_PercDisable(var C_Npc self, var int percID) { };
// Deaktiviere Perception
func void Npc_SetPercTime(var C_Npc self, var float seconds) { };
// Setze Zeitdelta für aktive Wahrnehmungen, alle Zeitdelta-Sekunden wird WN gesendet
// -------------------------------------------------------------------------------------------
func void Perc_SetRange(var int percID, var int range) { };
// Setze Reichweite fuer eine passive Wahrnehmung int cm
func void Npc_SendPassivePerc(var C_Npc npc1, var int Perc_type, var C_Npc npc2, var C_Npc npc3) { };
// Sende eine passive Wahrnehmung aus.Npc1 = wer schickt Npc2 = Opfer, Npc3 = Täter
func void Npc_SendSinglePerc(var C_Npc self, var C_Npc target, var int percID) { };
// verschicke Wahrnehmung an einzelnen NSC
// --------------------------------------------------------------------------------------------
func void Npc_PerceiveAll(var C_Npc self) { };
// Nimm alle Objekte in Wahrnehmungsreichweite wahr, die dann mit Wld_DetectNpc und Wld_DetectItem auswertbar sind
func int Wld_DetectNpc(var C_Npc self, var int instance, var func aiState, var int guild) { return 0; };
// Diese Methode initilisiert die globale Skriptvariable "other" mit einem NSC, den "self" beim letzten Warnehmungscheck wargenommen hat.
// instance = Name der zu suchenden Instanz ( "-1" angeben, wenn Instanzname unwichtig )
// guild = Der zu suchende NSC muss Mitglied dieser Gilde sein ( "-1" angeben, wenn Gilde unwichtig )
// aiState = Der AI-Zustandsname, in dem sich der NSC befinden soll ( NOFUNC angeben, wenn AI-State unwichtig )
// Wenn die Methode einen entsprechenden NSC gefunden hat, liefert diese "1" und 'other' ist initialisiert
// ansonsten wird "0" geliefert und "other" wird nicht verändert.
var int Wld_DetectNpcEx(var C_Npc self, var int npcInstance, var func aiState, var int guild, var int detectPlayer)
// Wie Wld_DetectNpc(). Zusätzlich kann per detectPlayer=0 der Spieler ignoriert werden.
func int Wld_DetectItem(var C_Npc self, var int flags) { return 0; };
// liefert eins zurück, wenn ein Item mit dem Entsprechende Flag (z.B.ITEM_KAT_FOOD )gefunden wurde
// Globale Variable 'item' wird mit dem gefundenen Gegenstand initialisiert
func string Npc_GetDetectedMob(var C_Npc self) { return 0; };
// liefert den Schemanamen des Mobsi zurück, das der Nsc entdeckt hat. Schemaname ist das String-Kürzel des Mobs, daß im Visualnamen vor dem ersten "_"-Zeichen steht, also z.B. "DOOR" wenn der Visualname "DOOR_OCR__135" ist.
// VORSICHT: Diese Funktion ist nur in Verbindung mit PERC_MOVEMOB erlaubt !!!
// WORKAROUND: zur Zeit werden hiermit nur Tür-MOBSIs zurückgegeben, dies soll aber wieder zurückgebaut werden
// --------------------------------------------------------------------------------------------
func int Npc_CanSeeNpc(var C_Npc npc1, var C_Npc npc2) { return 0; };
// Prueft ob Npc1 den Npc2 sehen kann ( ein Ray wird gecastet -> Bitte sparsam einsetzen ) True/False Blickwinkelabhängig (+,-100°)+LOS von der Hüfte aus
func int Npc_CanSeeNpcFreeLOS(var C_Npc self, var C_Npc other) { };
// Prüft ob NSC anderen NSC sehen kann, ohne dabei den Winkel zu berücksichtigen (nur LineOfSight-Check)
func int Npc_CanSeeItem(var C_Npc npc1, VAR C_ITEM item) { return 0; };
// Prueft ob Npc1 den Gegenstand sehen kann ( ein Ray wird gecastet -> Bitte sparsam einsetzen ) True/False
func int Npc_CanSeeSource(var C_Npc self) { return 0; };
// Checkt, ob NSC die Soundquelle sehen kann True/False

// *******************************************************************************************
// *** CUTSCENES ***
// *******************************************************************************************

func void TA_CS(var C_Npc self, var string csName, var string roleName) { };
// Cutscene an den zuletzt angegebenen Tagesablaufpunkt hängen
// csName : Name der Cutscene ( der Name des "CS" - Files )
// roleName : Die Rolle die der NSC dabei übernehmen soll.
func void AI_PlayCutscene(var C_Npc self, var string csName) { };
// Eine Cutscene aus den Scripten heraus starten
func int Hlp_CutscenePlayed(var string csName) { return 0; };
// Abfrage, ob Cutscene schon gespielt wurde (0 = Nein / 1 = Ja)
func int Npc_IsInCutscene(var C_Npc self) { return 0; };
// liefert eins zurück, wenn der entsprechende Nsc in einer Cutscene ist

// *******************************************************************************************
// *** SOUND ***
// *******************************************************************************************

func void Snd_Play(var string s0) { };
// spielt einen Sound ab
func void Snd_Play3D(var C_Npc n0, var string s1) { };
// spielt einen 3D-Sound ab.
// -------------------------------------------------------------------------------------------
func int Snd_IsSourceNpc(var C_Npc self) { return 0; };
// Check, ob Quelle des letzten Sound NPC war (Return >0) und setzt "other" auf diesen NPC
func int Snd_IsSourceItem(var C_Npc self) { return 0; };
// Check, ob Quelle des letzten Sound Item war (Return >0) und setzt "item" auf diesen Gegenstand

// *******************************************************************************************
// *** PORTALRÄUME ***
// *******************************************************************************************
func void Wld_AssignRoomToGuild(var string s0, var int guild) { };
// Ordnet den Raum: 's0' der Gilde 'guild' zu
func void Wld_AssignRoomToNpc(var string s0, var C_Npc roomowner) { };
// Ordnet den Raum: 's0' dem speziellen Nsc 'roomowner' zu
FUNC C_NPC Wld_GetPlayerPortalOwner()
// liefert den NSC des aktiven Raums, in dem sich der SC gerade befindet, zurück
// - wenn der SC 'draußen' ist, dann ist der Rückgabe-Npc 'notValid'
// - wenn der aktive Raum besitzerlos ist, dann ist der Rückgabe-Npc 'notValid'
func int Wld_GetPlayerPortalGuild()
// liefert Gilde des aktiven Raums, in dem sich der SC gerade befindet, zurück
// - wenn der SC 'draußen' ist, dann wird GIL_NONE zurückgegeben
// - wenn der aktive Raum gildenlos ist, dann wird GIL_NONE zurückgeliefert
FUNC C_NPC Wld_GetFormerPlayerPortalOwner()
// liefert den NSC des Raums, in dem sich der SC vor dem letzten "Raumwechsel" befunden hat, zurück
// Raumwechsel ist dabei: Außen->Raum1, Raum1->Raum2, -> Raum1->Außen
// - wenn der SC 'draußen' ist, dann ist der Rückgabe-Npc 'notValid'
// - wenn der aktive Raum besitzerlos ist, dann ist der Rückgabe-Npc 'notValid'
func int Wld_GetFormerPlayerPortalGuild()
// liefert den NSC des Raums, in dem sich der SC vor dem letzten "Raumwechsel" befunden hat, zurück
// Raumwechsel ist dabei: Außen->Raum1, Raum1->Raum2, -> Raum1->Außen
// - wenn der SC 'draußen' ist, dann wird GIL_NONE zurückgegeben
// - wenn der aktive Raum gildenlos ist, dann wird GIL_NONE zurückgeliefert
func int Npc_IsPlayerInMyRoom(var C_Npc npc)
// gibt TRUE zurück, wenn sich SC im Raum des 'npc' oder seiner Gilde befindet, sonst FALSE
func int Npc_WasPlayerInMyRoom(var C_Npc npc)
// gibt TRUE zurück, wenn sich SC vor dem letzten Raumwechsel im Raum des 'npc' oder seiner Gilde befindet, sonst FALSE
// Raumwechsel ist dabei: Außen->Raum1, Raum1->Raum2, -> Raum1->Außen

// *******************************************************************************************
// *** sonstige Hilfsfunktionen ***
// *******************************************************************************************
func string IntToString(var int x) { };
// !!!Funktion überträgt eine Integer variable in eine Stringvariable (Rückgabewert : string)???

func int FloatToInt(var float x) { };
// !!! konvertiert einen float in einen int, hier wäre es noch ganz schön zu wissen, wie mit dem float umgesprungen wird --> schneiden oder runden ???

func float IntToFloat(var int x) { };
// !!! wie float to int, nur daß ein integer in float umgewandelt wird ???
func string ConcatStrings(var string str1, var string str2)
// !!!Erzeugt eine Kopie von dem ersten angegebenen String, hängt den zweiten an diesen an und gibt den neuen String zurück ???

// Die folgenden Methoden geben den Text nur unter bestimmten zusätzlichen Bedingungen aus. Für die Methoden mit dem Suffix Inst trifft dies zu, wenn die Instanz von der die Debug-Methode aufgerufen wird, zum Debuggen aktiviert wurde. Die Methoden mit dem Suffix Ch geben den Text nur aus, wenn der angegebene Channel zum Debuggen aktiviert wurde.

func void PrintDebugInst(String text) { };
// !!! gibt nur den Debugtext der eingeschalteten (SetDebugFocus --> siehe Intranetpage Erweitertes Skript-Debugging) Instanz aus ???
func void PrintDebugInstCh(int ch, String text) { };
// !!! gibt nur in einem bestimmten channel liegende Debuginfos einer Instanz aus ???
func void PrintDebugCh(int ch, String text) { };
// gibt nur den Text eines bestimmten Channels wieder, unabhängig von der Instanz ???

// *******************************************************************************************
// *** Log-Entries (ab v1.01) ***
// *******************************************************************************************
func void Log_CreateTopic(var string name, var int section)
//	Der Befehl fügt unter der Sektion 'section' ein neues Topic mit Namen 'name' ein.
//	Sollte bereits ein Topic dieses Names in irgendeiner Sektion existieren, wird das Topic nicht hinzugefügt.
//
//	Parameter:
//	- name Eine eindeutige Zeichenkette, die sowohl zur Identifikation als auch zur Anzeige des Topics verwendet wird.
//	- section Eine, in der Constants.d definierte Konstante, die besagt, in welcher Sektion das Topic angezeigt werden soll.
//				Die Konstante kann folgende Werte annehmen:
//					- LOG_MISSION
//					- LOG_NOTE

func void Log_SetTopicStatus(var string name, var int status)
//	Der Befehl ändert den Status des Topics 'name' in 'status'.
//	Er sollte nur für Topics verwendet werden, die für die Sektion LOG_MISSION erzeugt wurden.
//
//	Parameter:
//	- name Diejenige Zeichenkette, die bei der Erstellung des Topics per Log_CreateTopic() angegeben wurde.
//	- status Eine, in der Constants.d definierte Konstante, die besagt, unter welchem Status die Mission dargestellt werden soll.
//				Folgende Werte sind möglich:
//					- LOG_RUNNING
//					- LOG_SUCCESS
//					- LOG_FAILED
//					- LOG_OBSOLETE

func void Log_AddEntry(var string topic, var string entry)
//	Der Befehl fügt dem Topics topic ein neues Entrz namens entry hinzu. Wie auch bei der Erzeugung von Topics dient hier der
//	Name sowohl zur Identifikation als auch zur Anzeige und muss somit eindeutig sein. Doppelte Einträge werden auch hier ignoriert.
//
//	Parameter
//	topic Diejenige Zeichenkette, die bei der Erstellung des Topics per Log_CreateTopic() angegeben wurde.
//	entry Eine eindeutige Zeichenkette, die sowohl zur Identifikation als auch zur Anzeige des Eintrags verwendet wird.

// *******************************************************************************************
// *** Docs (ab v1.01) ***
// *******************************************************************************************
func int Doc_Create()
// erstellet ein Dokument und liefert ein Handle zurück, daß für alle weiteren Doc_...-Befehle nötig ist
func void Doc_SetPages(var int handle, var int pages)
// setzt die Anzahl der Seiten dieses Dokuments. Bei mehr als zwei Seiten wird versucht ALLE
// Seiten auf den Bildschrim zu bekommen
func void Doc_SetPage(var int handle, var int page, var string pageimage, 0?)
// setzt für die Seite 'page' die Grafik-Datei 'pageimage'. Diese muß im TGA-Format vorliegen und
// z.B. "aufgeschlagenesBuch_links.tga" heißen
// wird bei 'page' -1 übergeben, so bezieht sich der Befehl auf ALLE Seiten des Dokuments
func void Doc_SetFont(var int handle, var int page, var string fontname)
// setzt den Font für die angegebene Seite 'page' oder für das ganze Dokument ('page':-1)
// Fontname z.B. "Scrolls.tga"
func void Doc_SetMargins(var int handle, var int page, var int leftMargin, var int topMargin, var int rightMargin, var int bottomMargin, 1?);
// setzt die Ränder (gerechnet vom Rand der TGA-Datei, die in Doc_SetPage() gesetzt wird). Die Ränder sind in Pixeln angegeben.
func void Doc_PrintLine(var int handle, var int page, var string text)
// Gibt Text für die Seite 'page' an. Der Text wird NICHT umgebrochen
func void Doc_PrintLines(var int handle, var int page, var string text)
// Gibt Text für die Seite 'page' an. Der Text WIRD umgebrochen, falls er nicht auf die in Doc_SetPage() angegebene Grafik passt.
func void Doc_Show(var int handle)
// nachdem das Dokument mit den obenstehenden Befehlen befüllt und formatiert wurde, wird es hiermit nun auf den Bildschirm geschrieben!
