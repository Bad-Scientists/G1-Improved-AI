//All you need for books is variable wasReadByPlayer_[item instance name] - hook will automatically print read/unread text in top right corner of description box
var int wasReadByPlayer_ItWr_Book_Circle_01_Example;

instance ItWr_Book_Circle_01_Example(C_Item)
{
	name = "The First Circle";

	mainflag = ITEM_KAT_DOCS;
	flags = 0;

	value = 50;

	visual = "ItWr_Book_02_03.3ds";
	material = MAT_LEATHER;

	scemeName = "MAP";
	description = "The First Circle of Magic";

	TEXT[5] = NAME_Value;
	COUNT[5] = value;
	on_state[0] = UseItWr_Book_Circle_01_Example;
};

func void UseItWr_Book_Circle_01_Example()
{
	var int nDocID;
	var string Text;
	Text = ConcatStrings(NAME_Manakosten, IntToString(SPL_SENDCAST_LIGHT));
	var string Text_1;
	Text_1 = ConcatStrings(NAME_Manakosten, IntToString(SPL_SENDCAST_THUNDERBOLT));
	var string Text_2;
	Text_2 = ConcatStrings(NAME_Manakosten, IntToString(SPL_SENDCAST_FIREBOLT));
	nDocID = Doc_Create(); // DocManager
	Doc_SetPages(nDocID, 2); // wieviel Pages

	Doc_SetPage(nDocID, 0, "Book_Mage_L.tga", 0);
	Doc_SetPage(nDocID, 1, "Book_Mage_R.tga", 0);

	// 1.Seite

	Doc_SetFont(nDocID, -1, "font_15_book.tga"); // -1 -> all pages
	Doc_SetMargins(nDocID, 0, 275, 20, 30, 20, 1); // 0 -> margins are in pixels
	Doc_PrintLine(nDocID, 0, "The First Circle");
	Doc_PrintLine(nDocID, 0, "---------------");
	Doc_SetFont(nDocID, -1, "font_10_book.TGA"); // -1 -> all pages
	Doc_PrintLine(nDocID, 0, "");
	Doc_PrintLines(nDocID, 0, "When the gods gave mankind the gift of magic, they taught them to make magic runes as well. The servants of the gods have taken over the glorious task of creating these artifacts of divine power and using them. The magician's Circle determines which kind of magic he is able to understand and to use. ");

	// 2.Seite
	Doc_SetMargins(nDocID, -1, 30, 20, 275, 20, 1); // 0 -> margins are in pixels (Position des Textes von den Ränder des TGAs aus, links,oben,rechts,unten)
	Doc_PrintLine(nDocID, 1, "");
	Doc_PrintLine(nDocID, 1, "Light");
	Doc_PrintLine(nDocID, 1, "---------------");
	Doc_PrintLines(nDocID, 1, "Innos' first gift to mankind. A shining ball appears over the magician.");
	Doc_PrintLine(nDocID, 1, Text);
	Doc_PrintLine(nDocID, 1, "");
	Doc_PrintLine(nDocID, 1, "Ice Bolt");
	Doc_PrintLine(nDocID, 1, "---------------");
	Doc_PrintLines(nDocID, 1, "A missile of magic energy.");
	Doc_PrintLine(nDocID, 1, Text_1);
	Doc_PrintLine(nDocID, 1, "");
	Doc_PrintLine(nDocID, 1, "Fire Bolt");
	Doc_PrintLine(nDocID, 1, "---------------");
	Doc_PrintLines(nDocID, 1, "A missile of magic Fire.");
	Doc_PrintLine(nDocID, 1, Text_2);
	Doc_Show(nDocID);

	wasReadByPlayer_ItWr_Book_Circle_01_Example = TRUE;
};
