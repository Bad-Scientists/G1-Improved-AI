/*
 *	Author: szapp
 *	Original post: https://forum.worldofplayers.de/forum/threads/1493643-Script-function-via-Gothic-Konsole?p=25621202&viewfull=1#post25621202
 */

/*
 * Call any function (including externals) from console
 */

/*
 * Initialization function
 */
func void CC_CallInit() {
    CC_Register(CC_Call, "call ", "Call any daedalus or external function");
};


/*
 * Push symbol of almost any type onto the stack
 */
func int CC_Call_PushSymbol(var int symbID) {
    var zCPar_Symbol symb; symb = _^(MEM_GetSymbolByIndex(symbID));

    if ((symb.bitfield & zCPar_Symbol_bitfield_type) == zPAR_TYPE_INSTANCE) {
        // What is this: See MEMINT_PushStringParamSub()
        var int n; n += 1; if (n == 10) { n = 0; };
        if (n == 0) { var MEMINT_HelperClass inst0; inst0 = _^(symb.offset); MEM_PushInstParam(inst0); };
        if (n == 1) { var MEMINT_HelperClass inst1; inst1 = _^(symb.offset); MEM_PushInstParam(inst1); };
        if (n == 2) { var MEMINT_HelperClass inst2; inst2 = _^(symb.offset); MEM_PushInstParam(inst2); };
        if (n == 3) { var MEMINT_HelperClass inst3; inst3 = _^(symb.offset); MEM_PushInstParam(inst3); };
        if (n == 4) { var MEMINT_HelperClass inst4; inst4 = _^(symb.offset); MEM_PushInstParam(inst4); };
        if (n == 5) { var MEMINT_HelperClass inst5; inst5 = _^(symb.offset); MEM_PushInstParam(inst5); };
        if (n == 6) { var MEMINT_HelperClass inst6; inst6 = _^(symb.offset); MEM_PushInstParam(inst6); };
        if (n == 7) { var MEMINT_HelperClass inst7; inst7 = _^(symb.offset); MEM_PushInstParam(inst7); };
        if (n == 8) { var MEMINT_HelperClass inst8; inst8 = _^(symb.offset); MEM_PushInstParam(inst8); };
        if (n == 9) { var MEMINT_HelperClass inst9; inst9 = _^(symb.offset); MEM_PushInstParam(inst9); };
        return TRUE;
    } else if ((symb.bitfield & zCPar_Symbol_bitfield_type) == zPAR_TYPE_INT)
    || ((symb.bitfield & zCPar_Symbol_bitfield_type) == zPAR_TYPE_FLOAT) {
        MEM_PushIntParam(symb.content);
        return TRUE;
    } else if ((symb.bitfield & zCPar_Symbol_bitfield_type) == zPAR_TYPE_STRING) {
        MEM_PushStringParam(MEM_ReadString(symb.content));
        return TRUE;
    } else if ((symb.bitfield & zCPar_Symbol_bitfield_type) == zPAR_TYPE_FUNC) {
        MEM_PushIntParam(symbID);
        return TRUE;
    } else {
        // zPAR_TYPE_CLASS
        // zPAR_TYPE_PROTOTYPE
        return FALSE;
    };
};


/*
 * Console command function to call any deadalus or external function from the console in-game
 */
func string CC_Call(var string query) {
    if (Hlp_StrCmp(query, "")) || (Hlp_StrCmp(query, " ")) {
        return "";
    };

    // Find function name
    var string funcName;
    var string args;
    var int i; i = STR_IndexOf(query, " ");
    if (i != -1) {
        funcName = STR_SubStr(query, 0, i);
        args = STR_SubStr(query, i, STR_Len(query)-i);
    } else {
        funcName = query;
        args = "";
    };

    // Find function symbol by function name
    var int fSymbID; fSymbID = MEM_GetSymbolIndex(funcName);
    if (fSymbID < 0) || (fSymbID >= currSymbolTableLength) {
        return ConcatStrings("Function not found: ", funcName);
    };
    var zCPar_Symbol fSymb; fSymb = _^(MEM_GetSymbolByIndex(fSymbID));

    // Verify that it is a function
    if ((fSymb.bitfield & zCPar_Symbol_bitfield_type) != zPAR_TYPE_FUNC) {
        return ConcatStrings("Symbol is not a function: ", funcName);
    };

    // Get number of function paramerters
    var int numParams; numParams = (fSymb.bitfield & zCPar_Symbol_bitfield_ele);

    // Get return type
    var int retType; retType = fSymb.offset << 12;

    // Validate arguments against parameters
    if (numParams) {
        // Remaining argument string
        var string rArgs; rArgs = args;
        var zString zrArgs; zrArgs = _^(_@s(rArgs));

        // Parameter types
        const string SYMBOL_TYPES[8] = {
            "void",         // zPAR_TYPE_VOID
            "float",        // zPAR_TYPE_FLOAT
            "int",          // zPAR_TYPE_INT
            "string",       // zPAR_TYPE_STRING
            "class",        // zPAR_TYPE_CLASS
            "func",         // zPAR_TYPE_FUNC
            "prototype",    // zPAR_TYPE_PROTOTYPE
            "instance"      // zPAR_TYPE_INSTANCE
        };

        // Loop over paramter-argument pairs and see if they match in type and push argument if so
        repeat(i, numParams);
            // Get next parameter type
            var zCPar_Symbol pSymb; pSymb = _^(MEM_GetSymbolByIndex(fSymbID+1+i));
            var int pType; pType = pSymb.bitfield & zCPar_Symbol_bitfield_type;
            var string pTypeS; pTypeS = MEM_ReadStatStringArr(SYMBOL_TYPES, pType >> 12);

            // Set up error message
            var string errStr1;
            errStr1 = ConcatStrings("Argument #", IntToString(i+1));
            errStr1 = ConcatStrings(errStr1, ": ");

            // Check if any arguments provided
            if (zrArgs.len < 1) {
                return ConcatStrings("Not enough arguments. Expected ", IntToString(numParams));
            };

            // Extract start of next argument from query
            var int j; j = 0;
            var int l; l = MEM_ReadByte(zrArgs.ptr+j);
            while(l == 32); // Skip spaces
                if (zrArgs.len <= j+1) {
                    return ConcatStrings("Not enough arguments. Expected ", IntToString(numParams));
                };
                j += 1;
                l = MEM_ReadByte(zrArgs.ptr+j);
            end;

            // Update remaining argument string
            rArgs = STR_SubStr(rArgs, j, zrArgs.len-j);

            // Check first character
            var int firstChar; firstChar = MEM_ReadByte(zrArgs.ptr);
            var int argIsStr; argIsStr = (firstChar == 34); // Double quotes
            var int argIsNumber; argIsNumber = ((firstChar >= 48) && (firstChar <= 57)) || (firstChar == 45); // Digit

            // Match types
            if (argIsStr) {
                if (pType != zPAR_TYPE_STRING) {
                    return ConcatStrings(ConcatStrings(errStr1, "Expected type "), pTypeS);
                };

                // Iterate over query to find end of string
                j = 1;
                l = MEM_ReadByte(zrArgs.ptr+j);
                while(l != 34); // Double quote
                    if (zrArgs.len <= j+1) {
                        return ConcatStrings(errStr1, "Unexpected end of string");
                    };
                    j += 1;
                    l = MEM_ReadByte(zrArgs.ptr+j);
                end;

                // Push string parameter
                MEM_PushStringParam(STR_SubStr(rArgs, 1, j-1));

                // Update remaining arguments string
                rArgs = STR_SubStr(rArgs, j+1, zrArgs.len-(j+1));
            } else if (argIsNumber) {
                var int argIsFloat; argIsFloat = FALSE;
                var string argInt; argInt = "";
                var string argDec; argDec = "";

                // Iterate over query to find argument offset (space) or decimal point
                j = 0;
                l = MEM_ReadByte(zrArgs.ptr+j);
                while(l != 32); // Space
                    if (MEM_ReadByte(zrArgs.ptr+j) == 46) { // Decimal point
                        if (argIsFloat) {
                            return ConcatStrings(errStr1, "Syntax error '.'");
                        };
                        argIsFloat = TRUE;
                    } else if (MEM_ReadByte(zrArgs.ptr+j) == 45) {
                        if (j != 0) {
                            return ConcatStrings(errStr1, "Syntax error '-'");
                        };
                        argInt = "-";
                    } else if (MEM_ReadByte(zrArgs.ptr+j) < 48) || (MEM_ReadByte(zrArgs.ptr+j) > 57) {
                        return ConcatStrings(ConcatStrings(errStr1, "Syntax error "), STR_SubStr(rArgs, j, 1));
                    } else {
                        if (argIsFloat) {
                            argDec = ConcatStrings(argDec, STR_SubStr(rArgs, j, 1));
                        } else {
                            argInt = ConcatStrings(argInt, STR_SubStr(rArgs, j, 1));
                        };
                    };
                    if (zrArgs.len <= j+1) {
                        break;
                    };
                    j += 1;
                    l = MEM_ReadByte(zrArgs.ptr+j);
                end;
                rArgs = STR_SubStr(rArgs, j, zrArgs.len-j);

                var int argIntI; argIntI = STR_ToInt(argInt);
                // If an integer is expected and a float is provided, it will not be rounded but passed as integer float

                if (argIsFloat) {
                    if (pType != zPAR_TYPE_FLOAT) {
                        return ConcatStrings(ConcatStrings(errStr1, "Expected type "), pTypeS);
                    };

                    // Shift decimal numbers to the left beyond decimal point
                    var int argDecF; argDecF = mkf(STR_ToInt(argDec));
                    repeat(k, STR_Len(argDec)); var int k;
                        argDecF = mulf(argDecF, castToIntf(0.1)); // n*0.1 = 0.n
                    end;

                    // Add integer to decimal points
                    argIntI = addf(mkf(argIntI), argDecF);
                } else if (pType == zPAR_TYPE_FLOAT) {
                    // Turn integer into integer float
                    argIntI = mkf(argIntI);
                } else if (pType != zPAR_TYPE_INT) {
                    // Check if it might be a valid symbol ID
                    if (argIntI < 0) || (argIntI >= currSymbolTableLength) {
                        return ConcatStrings(errStr1, "Invalid symbol index");
                    };

                    // Check symbol type (exception: expected float, given integer)
                    var zCPar_Symbol iSymb; iSymb = _^(MEM_GetSymbolByIndex(argIntI));
                    if ((iSymb.bitfield & zCPar_Symbol_bitfield_type) != pType)
                    && (!(((iSymb.bitfield & zCPar_Symbol_bitfield_type) == zPAR_TYPE_INT)
                            && (pType == zPAR_TYPE_FLOAT))) {
                        return ConcatStrings(ConcatStrings(errStr1, "Expected type "), pTypeS);
                    };

                    // Self, other and item are difficult to control
                    if (Hlp_StrCmp(iSymb.name, "self"))
                    || (Hlp_StrCmp(iSymb.name, "other"))
                    || (Hlp_StrCmp(iSymb.name, "victim"))
                    || (Hlp_StrCmp(iSymb.name, "item")) {
                        return ConcatStrings(errStr1, "Symbol is not allowed");
                    };

                    // Push symbol
                    if (!CC_Call_PushSymbol(argIntI)) {
                        return ConcatStrings(ConcatStrings(errStr1, "Don't know how to push type "), pTypeS);
                    };
                    continue;
                };

                // Push integer or float integer parameter
                MEM_PushIntParam(argIntI);
            } else { // Symbol name
                // Get end of argument
                j = 0;
                l = MEM_ReadByte(zrArgs.ptr+j);
                while(l != 32); // Space
                    j += 1;
                    l = MEM_ReadByte(zrArgs.ptr+j);
                    if (zrArgs.len <= j) {
                        break;
                    };
                end;

                // Check if valid symbol
                var int aSymbID; aSymbID = MEM_GetSymbolIndex(STR_Prefix(rArgs, j));
                if (aSymbID < 0) || (aSymbID >= currSymbolTableLength) {
                    return ConcatStrings(errStr1, "Invalid symbol name");
                };

                // Validate symbol type (exception: expected float, given integer)
                var zCPar_Symbol aSymb; aSymb = _^(MEM_GetSymbolByIndex(aSymbID));
                if ((aSymb.bitfield & zCPar_Symbol_bitfield_type) != pType)
                && (!(((aSymb.bitfield & zCPar_Symbol_bitfield_type) == zPAR_TYPE_INT) && (pType == zPAR_TYPE_FLOAT))) {
                    return ConcatStrings(ConcatStrings(errStr1, "Expected type "), pTypeS);
                };

                // Self, other and item are difficult to control
                if (Hlp_StrCmp(aSymb.name, "self"))
                || (Hlp_StrCmp(aSymb.name, "other"))
                || (Hlp_StrCmp(aSymb.name, "victim"))
                || (Hlp_StrCmp(aSymb.name, "item")) {
                    return ConcatStrings(errStr1, "Symbol is not allowed");
                };

                // Push symbol
                if (!CC_Call_PushSymbol(aSymbID)) {
                    return ConcatStrings(ConcatStrings(errStr1, "Don't know how to push type "), pTypeS);
                };

                // Update remaining arguments string
                rArgs = STR_SubStr(rArgs, j, zrArgs.len-j);
            };
        end;
    } else if (!Hlp_StrCmp(args, "")) && (!Hlp_StrCmp(args, " ")) {
        return "Function does not take arguments";
    };

    // Check if return type can be popped, otherwise don't allow the call!
    if (retType > zPAR_TYPE_CLASS) && (retType < zPAR_TYPE_INSTANCE) {
        return "Return type of function not supported";
    };

    // Call function
    MEM_CallByID(fSymbID);

    // Pop return value if
    if (retType == zPAR_TYPE_VOID) {
        return "return (void)";
    } else if (retType == zPAR_TYPE_STRING) {
        var string resStr; resStr = MEM_PopStringResult();
        return ConcatStrings(ConcatStrings("return '", resStr), "'");
    } else if (retType == zPAR_TYPE_INT) {
        var int resInt; resInt = MEM_PopIntResult();
        return ConcatStrings(ConcatStrings("return ", IntToString(resInt)), " (int)");
    } else if (retType == zPAR_TYPE_FLOAT) {
        var int resF; resF = MEM_PopIntResult();
        return ConcatStrings(ConcatStrings("return ", toStringf(resF)), " (float)");
    } else { // zPAR_TYPE_INSTANCE
        var MEMINT_HelperClass result; result = MEM_PopInstResult();
        // The instance is now CC_CALL.RESULT (no gain in information ever)
        // Instead return the pointer
        var int rPtr; rPtr = _@(result);
        return ConcatStrings(ConcatStrings("return *", IntToString(rPtr)), " (instance)");
    };
};



/*
 * Example getter and setter functions for strings, integers and floats
 */
func string getS(var string s) {
    return s;
};
func int getI(var int i) {
    return i;
};
func float getF(var float f) {
    MEM_ReadInt(_@f(f));
};
func float getIF(var int f) {  // From floats.d
    f;
};
func int getFI(var float f) {  // From floats.d
    return MEM_ReadInt(_@f(f));
};


func int verifySymbol(var string name, var int type) {
    var int symPtr; symPtr = MEM_GetParserSymbol(name);
    if (symPtr) {
        var zCPar_Symbol sym; sym = _^(symPtr);
        if ((sym.bitfield & zCPar_Symbol_bitfield_type) == type)
        && ((sym.bitfield & zCPar_Symbol_bitfield_ele)  == 1) {
            return symPtr;
        };
    };
    return 0;
};

func string setS(var string name, var string val) {
    var int symPtr; symPtr = verifySymbol(name, zPAR_TYPE_STRING);
    if (symPtr) {
        var zCPar_Symbol sym; sym = _^(symPtr);
        MEM_WriteString(sym.content, val);
        return "Done";
    };
    return "Invalid symbol";
};
func string setI(var string name, var int val) {
    var int symPtr; symPtr = verifySymbol(name, zPAR_TYPE_INT);
    if (symPtr) {
        var zCPar_Symbol sym; sym = _^(symPtr);
        sym.content = val;
        return "Done";
    };
    return "Invalid symbol";
};
func string setF(var string name, var float val) {
    var int symPtr; symPtr = verifySymbol(name, zPAR_TYPE_FLOAT);
    if (symPtr) {
        var zCPar_Symbol sym; sym = _^(symPtr);
        sym.content = castToIntf(val);
        return "Done";
    };
    return "Invalid symbol";
};
func string setIF(var string name, var float val) {
    var int symPtr; symPtr = verifySymbol(name, zPAR_TYPE_INT);
    if (symPtr) {
        var zCPar_Symbol sym; sym = _^(symPtr);
        sym.content = castToIntf(val);
        return "Done";
    };
    return "Invalid symbol";
};
func string setFI(var string name, var int val) {
    var int symPtr; symPtr = verifySymbol(name, zPAR_TYPE_FLOAT);
    if (symPtr) {
        var zCPar_Symbol sym; sym = _^(symPtr);
        sym.content = val;
        return "Done";
    };
    return "Invalid symbol";
};
