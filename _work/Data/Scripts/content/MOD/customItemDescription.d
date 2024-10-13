/*
 *	Custom Item Description
 *	 - this one replaces original Gothic item description prints
 */
const int DRAWITEMINFO_MARGINLEFT = 250;
const int DRAWITEMINFO_MARGINRIGHT = 250;

const int _DrawItemInfo_PrintWeaponType = 0;
const int _DrawItemInfo_PrintMagicCircle = 0;
const int _DrawItemInfo_PrintDocumentRead = 1;

/*
 *	Function resets X, Y position
 */
func void oCItem_DrawItemInfo_Reset(var int viewPtr) {
	if (!viewPtr) { return; };
	var zCView view; view = _^(viewPtr);
	var int fontPtr; fontPtr = zCViewPtr_GetFont(viewPtr);

	//Reset values (reset posX and posY)
	view.vposx = DRAWITEMINFO_MARGINLEFT;
	var int height; height = zCFont_GetFontY(fontPtr);
	view.vposy = Print_ToVirtual(height * 2 + height / 2, view.psizey);
};

/*
 *	Function sets posX either to left or right side of the view
 */
func void oCItem_DrawItemInfo_SetAlignment(var int viewPtr, var int alignment) {
	if (!viewPtr) { return; };
	var zCView view; view = _^(viewPtr);

	if (alignment == ALIGN_LEFT) {
		view.vposx = DRAWITEMINFO_MARGINLEFT;
	} else {
		view.vposx = 8192 - DRAWITEMINFO_MARGINRIGHT;
	};
};

/*
 *	Function prints text s and aligns it to last printed text either on left or right side
 */
func void oCItem_DrawItemInfo_Print(var int viewPtr, var string s, var int color, var int alignment) {
	if (!viewPtr) { return; };
	var zCView view; view = _^(viewPtr);
	var int fontPtr; fontPtr = zCViewPtr_GetFont(viewPtr);

	//Update X pos for this print
	if (alignment == ALIGN_RIGHT) {
		view.vposx -= Print_ToVirtual(Font_GetStringWidthPtr(s, fontPtr), view.psizex);
	};

	zCViewPtr_PrintTimed(viewPtr, view.vposx, view.vposy, s, Print_TimeInfinite, color);

	//Update X pos for next print
	if (alignment == ALIGN_LEFT) {
		view.vposx += Print_ToVirtual(Font_GetStringWidthPtr(s, fontPtr), view.psizex);
	};
};

/*
 *	Function prints text s
 *	Cursor moves to new line
 */
func void oCItem_DrawItemInfo_PrintLine(var int viewPtr, var string s, var int color)
{
	if (!viewPtr) { return; };
	var zCView view; view = _^(viewPtr);

	var int fontPtr; fontPtr = zCViewPtr_GetFont(viewPtr);

	if (STR_Len(s)) {
		zCViewPtr_PrintTimed(viewPtr, view.vposx, view.vposy, s, Print_TimeInfinite, color);
	};

	//Update X & Y pos for next print line
	view.vposx = DRAWITEMINFO_MARGINLEFT;
	var int height; height = zCFont_GetFontY(fontPtr);
	view.vposy += Print_ToVirtual(height, view.psizey);
};

/*
 *	Function prints item description - default vanilla logic
 */
func void oCItem_DrawItemInfo_PrintDescription(var int viewPtr, var string s, var int color)
{
	if (!viewPtr) { return; };
	var zCView view; view = _^(viewPtr);

	var int fontPtr; fontPtr = zCViewPtr_GetFont(viewPtr);
	var int fontHeight; fontHeight = zCFont_GetFontY(fontPtr);

	var int posY; posY = Print_ToVirtual(fontHeight / 2, view.psizey);

	zCViewPtr_PrintTimedCX(viewPtr, posY, s, Print_TimeInfinite, color);
};

/*
 *	Function prints info in top right corner of description next to item description
 */
func void oCItem_DrawItemInfo_TopRightCorner(var int viewPtr, var string s, var int color)
{
	if (!viewPtr) { return; };
	var zCView view; view = _^(viewPtr);

	var int fontPtr; fontPtr = zCViewPtr_GetFont(viewPtr);
	var int fontHeight; fontHeight = zCFont_GetFontY(fontPtr);

	var int posY; posY = Print_ToVirtual(fontHeight / 2, view.psizey);
	var int posX; posX = 8192 - DRAWITEMINFO_MARGINRIGHT;

	//Align from right side
	posX -= Print_ToVirtual(Font_GetStringWidthPtr(s, fontPtr), view.psizex);

	zCViewPtr_PrintTimed(viewPtr, posX, posY, s, Print_TimeInfinite, color);
};

/*
 *	Function prints info about document being read - custom modded logic
 *	 - this info is only printed for items that have [itemInstanceName]_WasReadByPlayer var available in symbol table
 */

/*
var int wasReadByPlayer_ItWr_Book_Circle_01;

func void UseItWr_Book_Circle_01()
{
	...
	ItWr_Book_Circle_01_WasReadByPlayer = TRUE;
};
*/
func void oCItem_DrawItemInfo_ItemWasRead(var int viewPtr, var int itemPtr)
{
	if (!viewPtr) { return; };
	if (!itemPtr) { return; };

	var oCItem itm; itm = _^(itemPtr);
	var string itemInstanceName; itemInstanceName = GetSymbolName(itm.instanz);
	itemInstanceName = ConcatStrings("wasReadByPlayer_", itemInstanceName);

	var int wasRead; wasRead = API_GetSymbolIntValue(itemInstanceName, -1);

	if (wasRead > -1)
	{
		var string s;
		var int color;

		if (wasRead) {
			s = "read";
			color = RGBA(102, 255, 178, 255); //Green 66FFB2
		} else {
			s = "unread";
			color = RGBA(255, 178, 102, 255); //Orange FFB266
		};

		oCItem_DrawItemInfo_TopRightCorner(viewPtr, s, color);
	};
};

/*
 *	Function prints text[index] - default vanilla logic
 *	Cursor is moved to right side of the view
 */
func void oCItem_DrawItemInfo_PrintTextByIndex(var int viewPtr, var int itemPtr, var int index, var int color)
{
	if (!viewPtr) { return; };
	var zCView view; view = _^(viewPtr);

	var int fontPtr; fontPtr = zCViewPtr_GetFont(viewPtr);

	var string s; s = GetItemTextByIndex(itemPtr, index);

	view.vposx = DRAWITEMINFO_MARGINLEFT;

	zCViewPtr_PrintTimed(viewPtr, view.vposx, view.vposy, s, Print_TimeInfinite, color);

	//Update X pos for next print (by default ALIGN_LEFT)
	view.vposx += Print_ToVirtual(Font_GetStringWidthPtr(s, fontPtr), view.psizex);
};

/*
 *	Function prints count[index] - default vanilla logic
 *	Cursor is moved to right side of the view
 */
func void oCItem_DrawItemInfo_PrintCountByIndex(var int viewPtr, var int itemPtr, var int index, var int color)
{
	if (!viewPtr) { return; };
	var int c; c = GetItemCountByIndex(itemPtr, index);
	if (!c) { return; };

	var zCView view; view = _^(viewPtr);
	var int fontPtr; fontPtr = zCViewPtr_GetFont(viewPtr);

	var string s; s = IntToString(c);

	//Align from right
	view.vposx = 8192 - DRAWITEMINFO_MARGINRIGHT;
	view.vposx -= Print_ToVirtual(Font_GetStringWidthPtr(s, fontPtr), view.psizex);

	zCViewPtr_PrintTimed(viewPtr, view.vposx, view.vposy, s, Print_TimeInfinite, color);
};

/*
 *	Function prints text[index] and count[index] - default vanilla logic
 *	count[] value is overriden in case of NAME_Value to sell value using sell multiplier
 *	Cursor moves to new line
 */
func void oCItem_DrawItemInfo_PrintTextAndCountByIndex(var int viewPtr, var int itemPtr, var int index, var int color) {
	if (!viewPtr) { return; };
	var zCView view; view = _^(viewPtr);

	var int fontPtr; fontPtr = zCViewPtr_GetFont(viewPtr);

	var int valueOverriden; valueOverriden = FALSE;

	var int c;
	var int v;

	var string s;
	var string s1;

	s = GetItemTextByIndex(itemPtr, index);

	//--

	//Override value for trading - we will print both selling & buying values
	if (Hlp_GetOpenInventoryType() == OpenInvType_Trading)
	{
		if (Hlp_StrCmp(s, NAME_Value))
		{
			//Print text[index]
			oCItem_DrawItemInfo_PrintTextByIndex(viewPtr, itemPtr, index, color);

			var oCItem itm; itm = _^(itemPtr);
			v = itm.value;

			//Get item value (ignore count[])
			if (Hlp_GetOpenInventoryType() == OpenInvType_Trading) {
				var int m; m = Trade_GetSellMultiplier(); //float
				v = RoundF(Mulf(Mkf(v), m));

				if ((itm.value > 0) && (v == 0)) {
					v = 1;
				};
			};

			c = v;

			oCItem_DrawItemInfo_SetAlignment(viewPtr, ALIGN_RIGHT);
			oCItem_DrawItemInfo_Print(viewPtr, s, color, ALIGN_RIGHT);

			valueOverriden = TRUE;
		};
	};

	//--> You can add some more custom logic here... (e.g. colored text for NAME_Bonus_HpMax text)
	var int valueColor;

	//Update 'bonus' texts
	// - display in green '+ ' & count[index] value if value is positive
	// - display in red '- ' & count[index] value if value is negative
	if (Hlp_StrCmp(s, NAME_Bonus_HpMax))
	|| (Hlp_StrCmp(s, NAME_Bonus_ManaMax))
	|| (Hlp_StrCmp(s, NAME_Bonus_Dex))
	|| (Hlp_StrCmp(s, NAME_Bonus_Str))
	{
		//Print text[index]
		oCItem_DrawItemInfo_PrintTextByIndex(viewPtr, itemPtr, index, color);

		//Get count[index] value
		c = GetItemCountByIndex(itemPtr, index);
		s = IntToString(abs(c));

		//Align from right
		oCItem_DrawItemInfo_SetAlignment(viewPtr, ALIGN_RIGHT);

		//Print in green positive bonus value
		if (c > 0) {
			s = ConcatStrings("+ ", s);
			valueColor = RGBA(102, 255, 178, 255); //Green 66FFB2
		} else {
			//Red negative bonus value
			s = ConcatStrings("- ", s);
			valueColor = RGBA(255, 70, 70, 255); //Red FF4646
		};

		oCItem_DrawItemInfo_Print(viewPtr, s, valueColor, ALIGN_RIGHT);

		valueOverriden = TRUE;
	};

	//<--

	//If value was not overriden - default vanilla prints
	if (!valueOverriden) {
		oCItem_DrawItemInfo_PrintTextByIndex(viewPtr, itemPtr, index, color);
		oCItem_DrawItemInfo_PrintCountByIndex(viewPtr, itemPtr, index, color);
	};

	//Update X & Y pos for next print line
	view.vposx = DRAWITEMINFO_MARGINLEFT;
	var int height; height = zCFont_GetFontY(fontPtr);
	view.vposy += Print_ToVirtual(height, view.psizey);
};

/*
 *	Hook implementation
 */
func void _hook_oCItemContainer_DrawItemInfo_PrintTexts() {
	//EBX 0x007DC054 const zCWorld::`vftable'
	//ESI 0x007DD004 const oCNpcInventory::`vftable'
	//EDI 0x007DD0CC const oCItem::`vftable'

	//Safety checks
	if (!ESI) { return; };
	if (!EDI) { return; };

	var oCItemContainer itemContainer; itemContainer = _^(ESI);
	if (!itemContainer.inventory2_oCItemContainer_viewItemInfo) { return; };

	var int itemPtr; itemPtr = EDI;
	var int viewPtr; viewPtr = itemContainer.inventory2_oCItemContainer_viewItemInfo;

	//Reset positions
	oCItem_DrawItemInfo_Reset(viewPtr);

	var oCItem itm; itm = _^(itemPtr);

//-- Custom DrawItemInfo print for specific items

	var string itemInstanceName; itemInstanceName = GetSymbolName(itm.instanz);
	itemInstanceName = ConcatStrings("DrawItemInfo_", itemInstanceName);

	var int symbID; symbID = MEM_GetSymbolIndex(itemInstanceName);

	if (symbID != -1) {
		MEM_PushIntParam(viewPtr);
		MEM_PushIntParam(itemPtr);
		MEM_CallByID(symbID);
		return;
	};

	var int color;
	var int colorBright; colorBright = RGBA(255, 255, 255, 255);
	var int colorDefault; colorDefault = RGBA(208, 208, 208, 255);

//-- Default (engine-like) DrawItemInfo print emulation

	var string s; s = itm.description;
	if (!STR_Len(s)) {
		s = itm.name;
	};

	oCItem_DrawItemInfo_PrintDescription(viewPtr, s, colorBright);

	//Print 1h / 2h info
	if (_DrawItemInfo_PrintWeaponType)
	{
		if (oCItem_IsOneHanded(itemPtr)) {
			oCItem_DrawItemInfo_TopRightCorner(viewPtr, NAME_OneHanded, colorDefault);
		};

		if (oCItem_IsTwoHanded(itemPtr)) {
			oCItem_DrawItemInfo_TopRightCorner(viewPtr, NAME_TwoHanded, colorDefault);
		};
	};

	//Print magic circle
	if (_DrawItemInfo_PrintMagicCircle)
	{
		if (itm.mag_circle) {
			if (Npc_GetTalentSkill(hero, NPC_TALENT_MAGE) >= itm.mag_circle) {
				color = RGBA(102, 255, 178, 255); //Green 66FFB2
			} else {
				color = RGBA(255, 178, 102, 255); //Orange FFB266
			};

			s = IntToString(itm.mag_circle);
			oCItem_DrawItemInfo_TopRightCorner(viewPtr, s, color);
		};
	};

	//Print info about books/notes being read
	if (_DrawItemInfo_PrintDocumentRead)
	{
		if (itm.mainflag == ITEM_KAT_DOCS) {
			oCItem_DrawItemInfo_ItemWasRead(viewPtr, itemPtr);
		};
	};

	oCItem_DrawItemInfo_PrintTextAndCountByIndex(viewPtr, itemPtr, 0, colorDefault);
	oCItem_DrawItemInfo_PrintTextAndCountByIndex(viewPtr, itemPtr, 1, colorDefault);
	oCItem_DrawItemInfo_PrintTextAndCountByIndex(viewPtr, itemPtr, 2, colorDefault);
	oCItem_DrawItemInfo_PrintTextAndCountByIndex(viewPtr, itemPtr, 3, colorDefault);
	oCItem_DrawItemInfo_PrintTextAndCountByIndex(viewPtr, itemPtr, 4, colorDefault);
	oCItem_DrawItemInfo_PrintTextAndCountByIndex(viewPtr, itemPtr, 5, colorDefault);
};

func void G12_CustomItemDescription_Init () {
	const int once = 0;

	if (!once) {
		//Custom Item description render logic
		//This removes texts printed by engine - now we have all the power, muhahaha!

		//0x00667220 protected: virtual void __thiscall oCItemContainer::DrawItemInfo(class oCItem *,class zCWorld *)

		//		LAB_006673a7                                    XREF[1]:     006673a1 (j)
		//		006673a7 3b  fd           CMP        EDI ,EBP
		//		006673a9 0f  84  6d       JZ         LAB_0066761c
		//				 02  00  00

		//006673a7
		const int oCItemContainer__DrawItemInfo_PrintTexts_G1 = 6714279;

		//00707082
		const int oCItemContainer__DrawItemInfo_PrintTexts_G2 = 7368834;

		var int addr1; addr1 = MEMINT_SwitchG1G2(oCItemContainer__DrawItemInfo_PrintTexts_G1, oCItemContainer__DrawItemInfo_PrintTexts_G2);

		//0066761c
		const int oCItemContainer__DrawItemInfo_Blit_G1 = 6714908;

		//0070764d
		const int oCItemContainer__DrawItemInfo_Blit_G2 = 7370317;

		var int addr2; addr2 = MEMINT_SwitchG1G2(oCItemContainer__DrawItemInfo_Blit_G1, oCItemContainer__DrawItemInfo_Blit_G2);

		//Nuke original engine function
		MEM_WriteNOP(addr1, (addr2 - addr1));

		//Replace with custom hook
		HookEngine(addr1, 5, "_hook_oCItemContainer_DrawItemInfo_PrintTexts");

		once = 1;
	};
};
