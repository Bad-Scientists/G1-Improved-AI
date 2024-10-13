/*
 *	Custom DrawItemInfo example for old sword ITMW_1H_SWORD_OLD_01
 */
func void DrawItemInfo_Mythrilklinge02(var int viewPtr, var int itemPtr)
{
	var int colorBright; colorBright = RGBA(255, 255, 255, 255); //White FFFFFF
	var int colorDefault; colorDefault = RGBA(208, 208, 208, 255); //Grayish D0D0D0
	var int colorOrange; colorOrange = RGBA(255, 178, 102, 255); //Orange FFB266
	var int colorGreen; colorGreen = RGBA(0, 255, 102, 255); //Green 00CC66
	var int colorRed; colorRed = RGBA(255, 70, 70, 255); //Red FF4646
	var int colorPurple; colorPurple = RGBA(191, 000, 255, 255); //Purple BF00FF

//-- Print description

	var oCItem itm; itm = _^(itemPtr);
	var string s; s = itm.description;

	if (!STR_Len(s)) {
		s = itm.name;
	};

	oCItem_DrawItemInfo_PrintDescription(viewPtr, s, colorGreen);

	oCItem_DrawItemInfo_TopRightCorner(viewPtr, "legendary", colorPurple);

//-- Default print: text[] & count[]

	oCItem_DrawItemInfo_PrintTextAndCountByIndex(viewPtr, itemPtr, 0, colorDefault);
	oCItem_DrawItemInfo_PrintTextAndCountByIndex(viewPtr, itemPtr, 1, colorDefault);
	oCItem_DrawItemInfo_PrintTextAndCountByIndex(viewPtr, itemPtr, 2, colorDefault);
	oCItem_DrawItemInfo_PrintTextAndCountByIndex(viewPtr, itemPtr, 3, colorDefault);
	oCItem_DrawItemInfo_PrintTextAndCountByIndex(viewPtr, itemPtr, 4, colorDefault);
	oCItem_DrawItemInfo_PrintTextAndCountByIndex(viewPtr, itemPtr, 5, colorDefault);
};
