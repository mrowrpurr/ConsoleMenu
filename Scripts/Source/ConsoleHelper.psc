scriptName ConsoleHelper hidden
{Utility for working with the Skyrim ~ console menu}

    ; TODO
    ; ConsoleHelper.SetInstanceBool("CommandEntry.background", true)
    ; ConsoleHelper.SetInstanceString("CommandEntry.backgroundColor", "0xff0000")

    ; TODO
    ; ConsoleHelper.SetInstanceBool("CommandEntry.border", true)
    ; ConsoleHelper.SetInstanceString("CommandEntry.borderColor", "0xff0000")

; Gets the 'Console' menu name
string function GetMenuName() global
    return "Console"
endFunction

; DOC
string function GetConsoleTarget(string suffix = "") global
    if suffix
        return "_global.Console." + suffix
    else
        return "_global.Console"
    endIf
endFunction

; DOC
string function GetConsoleInstanceTarget(string suffix = "") global
    if suffix
        return GetConsoleTarget("ConsoleInstance." + suffix)
    else
        return GetConsoleTarget("ConsoleInstance")
    endIf
endFunction

; DOC
function Invoke(string functionName) global
    UI.Invoke(GetMenuName(), GetConsoleTarget(functionName))
endFunction

; DOC
function InvokeString(string functionName, string str) global
    UI.InvokeString(GetMenuName(), GetConsoleTarget(functionName), str)
endFunction

; DOC
function InvokeInstance(string functionName) global
    UI.Invoke(GetMenuName(), GetConsoleInstanceTarget(functionName))
endFunction

; DOC
function InvokeInstanceString(string functionName, string value) global
    UI.InvokeString(GetMenuName(), GetConsoleInstanceTarget(functionName), value)
endFunction

; DOC
function InvokeInstanceIntArray(string functionName, int[] values) global
    UI.InvokeIntA(GetMenuName(), GetConsoleInstanceTarget(functionName), values)
endFunction

; DOC
string function GetString(string target) global
    return UI.GetString(GetMenuName(), GetConsoleTarget(target))
endFunction

; DOC
function SetString(string target, string value) global
    UI.SetString(GetMenuName(), GetConsoleTarget(target), value)
endFunction

; DOC
string function GetInstanceString(string target) global
    return UI.GetString(GetMenuName(), GetConsoleInstanceTarget(target))
endFunction

; DOC
function SetInstanceString(string target, string value) global
    UI.SetString(GetMenuName(), GetConsoleInstanceTarget(target), value)
endFunction

; DOC
bool function GetBool(string target) global
    return UI.GetBool(GetMenuName(), GetConsoleTarget(target))
endFunction

; DOC
function SetBool(string target, bool value) global
    UI.SetBool(GetMenuName(), GetConsoleTarget(target), value)
endFunction

; DOC
bool function GetInstanceBool(string target) global
    return UI.GetBool(GetMenuName(), GetConsoleInstanceTarget(target))
endFunction

; DOC
function SetInstanceBool(string target, bool value) global
    UI.SetBool(GetMenuName(), GetConsoleInstanceTarget(target), value)
endFunction

; DOC
int function GetInt(string target) global
    return UI.GetInt(GetMenuName(), GetConsoleTarget(target))
endFunction

; DOC
function SetInt(string target, int value) global
    UI.SetInt(GetMenuName(), GetConsoleTarget(target), value)
endFunction

; DOC
int function GetInstanceInt(string target) global
    return UI.GetInt(GetMenuName(), GetConsoleInstanceTarget(target))
endFunction

; DOC
function SetInstanceInt(string target, int value) global
    UI.SetInt(GetMenuName(), GetConsoleInstanceTarget(target), value)
endFunction

; DOC
; Can be set while menu is closed
string function GetCurrentSelectionText() global
    return GetInstanceString("CurrentSelection.text")
endFunction

; DOC
function SetCurrentSelectionText(string text) global
    SetInstanceString("CurrentSelection.text", text)
endFunction

; Alias for GetCurrentSelectionText
string function GetHeaderText() global
    return GetCurrentSelectionText()
endFunction

; Alias for SetCurrentSelectionText
function SetHeaderText(string text) global
    SetCurrentSelectionText(text)
endFunction

; DOC
function SetCurrentSelectionTextColor(string color) global
    SetInstanceString("CurrentSelection.textColor", GetColor(color))
endFunction

; Alias for SetCurrentSelectionTextColor
function SetHeaderTextColor(string color) global
    SetCurrentSelectionTextColor(color)
endFunction

; DOC
; ResetHeaderTextColor

; DOC
string function GetCommandHistoryText() global
    return GetInstanceString("CommandHistory.text")
endFunction

; DOC
function SetCommandHistoryText(string text) global
    SetInstanceString("CommandHistory.text", text)
    ; SetInstanceString("CommandHistory.text", text) ; XXX works most consistently when set twice :shrug:
endFunction

; DOC
function SetCommandHistoryTextColor(string color) global
    SetInstanceString("CommandHistory.textColor", GetColor(color))
endFunction

; Alias for SetCommandHistoryTextColor
function SetBodyTextColor(string color) global
    SetCommandHistoryTextColor(color)
endFunction

; DOCS
; Can only be set when menu is open (?)
; Alias for CommandHistory
function SetBodyText(string text) global
    SetCommandHistoryText(text)
endFunction

; DOCS
; Alias for CommandHistory
string function GetBodyText() global
    return GetCommandHistoryText()
endFunction

; DOC
string function GetCommandEntryText() global
    return GetInstanceString("CommandEntry.text")
endFunction

; DOC
function SetCommandEntryText(string text) global
    ; Use function if available (check via variable)
    ; SetInstanceString("CommandEntry.text", text)
    InvokeInstanceString("SetCommandEntryText", text)
endFunction

; DOCS
; Alias for CommandEntry
function SetInputText(string text) global
    SetCommandHistoryText(text)
endFunction

; DOCS
; Alias for CommandEntry
string function GetInputText() global
    return GetCommandHistoryText()
endFunction

; DOC
function SetCommandEntryTextColor(string color) global
    SetInstanceString("CommandEntry.textColor", GetColor(color))
endFunction

; Alias for SetCommandEntryTextColor
function SetInputTextColor(string color) global
    SetCommandEntryTextColor(color)
endFunction

; DOC
function SetColor(string color) global
    SetCurrentSelectionTextColor(color)
    SetCommandHistoryTextColor(color)
    SetCommandEntryTextColor(color)
endFunction

; DOC
bool function IsShown() global
    return GetInstanceBool("Shown")
endFunction

; Alias for IsShown()
bool function IsOpen() global
    IsShown()
endFunction

; DOC
bool function IsMinimized() global
    Debug.Notification("Does " + GetHeight() + " equal " + GetOriginalHeight() + " minus " + GetCommandHistoryHeight() + " ??? " + (GetOriginalHeight() - GetCommandHistoryHeight()))
    bool result = GetHeight() == (GetOriginalHeight() - GetCommandHistoryHeight())
    Debug.Notification("Minimized: " + result)
    return result
    return GetHeight() == (GetOriginalHeight() - GetCommandHistoryHeight())
endFunction

; Opens the Skyrim ~ console menu
function Open(bool force = false) global
    if force || ! IsShown() || IsMinimized()
        if IsMinimized()
            Restore()
        else
            int openCloseConsoleKey = Input.GetMappedKey("Console")
            Input.TapKey(openCloseConsoleKey)
        endIf
    endIf
endFunction

; Alias for Open()
function Show(bool force = false) global
    Open(force)
endFunction

; Alias for Hide()
function Close(bool force = false) global
    Hide(force)
endFunction

; DOCHide
function Hide(bool force = false) global
    if force || IsShown()
        Invoke("Hide")
    endIf
endFunction

; DOC Minimize
function Minimize(bool force = false) global
    if force || IsShown()
        Invoke("Minimize")
    endIf
endFunction

function Restore(bool force = true) global
    if force || IsMinimized()
        SetHeight(GetOriginalHeight())
    endIf
endFunction

; DOC
function SetHeight(int height) global ; Maybe rename to ParentHeight or I dunno yet.
    SetInstanceInt("_parent._y", height)
endFunction

; DOC
int function GetHeight() global
    return GetInstanceInt("_parent._y")
endFunction

; DOC
int function GetOriginalHeight() global
    return GetInstanceInt("OriginalHeight")
endFunction

; DOC
int function GetCommandHistoryHeight() global
    return GetInstanceInt("CommandHistory._y")
endFunction

; DOC
function AddHistory(string text) global
    InvokeString("AddHistory", text)
endFunction

; DOC
function AddHistoryLine(string text) global
    AddHistory(text + "\n")
endFunction

; DOC
; Alias AddHistory
function Print(string text) global
    AddHistoryLine(text)
endFunction

string function GetColor(string color) global
    ; If it starts with "0x" then return it directly
    if StringUtil.Find(color, "0x") == 0
        return color
    endIf

    ; If it starts with a "#" then return it in "0x" style
    if StringUtil.Find(color, "#") == 0
        return "0x" + StringUtil.Substring(color, 1)
    endIf

    ; Else load up the color names and see if one matches (we remove any provided spaces)
    string[] ColorNames = Utility.CreateStringArray(140)
    string[] ColorValues = Utility.CreateStringArray(140)
    ColorNames[1] = "maroon"
    ColorValues[1] = "0x800000"
    ColorNames[2] = "darkred"
    ColorValues[2] = "0x8B0000"
    ColorNames[3] = "brown"
    ColorValues[3] = "0xA52A2A"
    ColorNames[4] = "firebrick"
    ColorValues[4] = "0xB22222"
    ColorNames[5] = "crimson"
    ColorValues[5] = "0xDC143C"
    ColorNames[6] = "red"
    ColorValues[6] = "0xFF0000"
    ColorNames[7] = "tomato"
    ColorValues[7] = "0xFF6347"
    ColorNames[8] = "coral"
    ColorValues[8] = "0xFF7F50"
    ColorNames[9] = "indianred"
    ColorValues[9] = "0xCD5C5C"
    ColorNames[10] = "lightcoral"
    ColorValues[10] = "0xF08080"
    ColorNames[11] = "darksalmon"
    ColorValues[11] = "0xE9967A"
    ColorNames[12] = "salmon"
    ColorValues[12] = "0xFA8072"
    ColorNames[13] = "lightsalmon"
    ColorValues[13] = "0xFFA07A"
    ColorNames[14] = "orangered"
    ColorValues[14] = "0xFF4500"
    ColorNames[15] = "darkorange"
    ColorValues[15] = "0xFF8C00"
    ColorNames[16] = "orange"
    ColorValues[16] = "0xFFA500"
    ColorNames[17] = "gold"
    ColorValues[17] = "0xFFD700"
    ColorNames[18] = "darkgoldenrod"
    ColorValues[18] = "0xB8860B"
    ColorNames[19] = "goldenrod"
    ColorValues[19] = "0xDAA520"
    ColorNames[20] = "palegoldenrod"
    ColorValues[20] = "0xEEE8AA"
    ColorNames[21] = "darkkhaki"
    ColorValues[21] = "0xBDB76B"
    ColorNames[22] = "khaki"
    ColorValues[22] = "0xF0E68C"
    ColorNames[23] = "olive"
    ColorValues[23] = "0x808000"
    ColorNames[24] = "yellow"
    ColorValues[24] = "0xFFFF00"
    ColorNames[25] = "yellowgreen"
    ColorValues[25] = "0x9ACD32"
    ColorNames[26] = "darkolivegreen"
    ColorValues[26] = "0x556B2F"
    ColorNames[27] = "olivedrab"
    ColorValues[27] = "0x6B8E23"
    ColorNames[28] = "lawngreen"
    ColorValues[28] = "0x7CFC00"
    ColorNames[29] = "chartreuse"
    ColorValues[29] = "0x7FFF00"
    ColorNames[30] = "greenyellow"
    ColorValues[30] = "0xADFF2F"
    ColorNames[31] = "darkgreen"
    ColorValues[31] = "0x006400"
    ColorNames[32] = "green"
    ColorValues[32] = "0x008000"
    ColorNames[33] = "forestgreen"
    ColorValues[33] = "0x228B22"
    ColorNames[34] = "lime"
    ColorValues[34] = "0x00FF00"
    ColorNames[35] = "limegreen"
    ColorValues[35] = "0x32CD32"
    ColorNames[36] = "lightgreen"
    ColorValues[36] = "0x90EE90"
    ColorNames[37] = "palegreen"
    ColorValues[37] = "0x98FB98"
    ColorNames[38] = "darkseagreen"
    ColorValues[38] = "0x8FBC8F"
    ColorNames[39] = "mediumspringgreen"
    ColorValues[39] = "0x00FA9A"
    ColorNames[40] = "springgreen"
    ColorValues[40] = "0x00FF7F"
    ColorNames[41] = "seagreen"
    ColorValues[41] = "0x2E8B57"
    ColorNames[42] = "mediumaquamarine"
    ColorValues[42] = "0x66CDAA"
    ColorNames[43] = "mediumseagreen"
    ColorValues[43] = "0x3CB371"
    ColorNames[44] = "lightseagreen"
    ColorValues[44] = "0x20B2AA"
    ColorNames[45] = "darkslategray"
    ColorValues[45] = "0x2F4F4F"
    ColorNames[46] = "teal"
    ColorValues[46] = "0x008080"
    ColorNames[47] = "darkcyan"
    ColorValues[47] = "0x008B8B"
    ColorNames[48] = "aqua"
    ColorValues[48] = "0x00FFFF"
    ColorNames[49] = "cyan"
    ColorValues[49] = "0x00FFFF"
    ColorNames[50] = "lightcyan"
    ColorValues[50] = "0xE0FFFF"
    ColorNames[51] = "darkturquoise"
    ColorValues[51] = "0x00CED1"
    ColorNames[52] = "turquoise"
    ColorValues[52] = "0x40E0D0"
    ColorNames[53] = "mediumturquoise"
    ColorValues[53] = "0x48D1CC"
    ColorNames[54] = "paleturquoise"
    ColorValues[54] = "0xAFEEEE"
    ColorNames[55] = "aquamarine"
    ColorValues[55] = "0x7FFFD4"
    ColorNames[56] = "powderblue"
    ColorValues[56] = "0xB0E0E6"
    ColorNames[57] = "cadetblue"
    ColorValues[57] = "0x5F9EA0"
    ColorNames[58] = "steelblue"
    ColorValues[58] = "0x4682B4"
    ColorNames[59] = "cornflowerblue"
    ColorValues[59] = "0x6495ED"
    ColorNames[60] = "deepskyblue"
    ColorValues[60] = "0x00BFFF"
    ColorNames[61] = "dodgerblue"
    ColorValues[61] = "0x1E90FF"
    ColorNames[62] = "lightblue"
    ColorValues[62] = "0xADD8E6"
    ColorNames[63] = "skyblue"
    ColorValues[63] = "0x87CEEB"
    ColorNames[64] = "lightskyblue"
    ColorValues[64] = "0x87CEFA"
    ColorNames[65] = "midnightblue"
    ColorValues[65] = "0x191970"
    ColorNames[66] = "navy"
    ColorValues[66] = "0x000080"
    ColorNames[67] = "darkblue"
    ColorValues[67] = "0x00008B"
    ColorNames[68] = "mediumblue"
    ColorValues[68] = "0x0000CD"
    ColorNames[69] = "blue"
    ColorValues[69] = "0x0000FF"
    ColorNames[70] = "royalblue"
    ColorValues[70] = "0x4169E1"
    ColorNames[71] = "blueviolet"
    ColorValues[71] = "0x8A2BE2"
    ColorNames[72] = "indigo"
    ColorValues[72] = "0x4B0082"
    ColorNames[73] = "darkslateblue"
    ColorValues[73] = "0x483D8B"
    ColorNames[74] = "slateblue"
    ColorValues[74] = "0x6A5ACD"
    ColorNames[75] = "mediumslateblue"
    ColorValues[75] = "0x7B68EE"
    ColorNames[76] = "mediumpurple"
    ColorValues[76] = "0x9370DB"
    ColorNames[77] = "darkmagenta"
    ColorValues[77] = "0x8B008B"
    ColorNames[78] = "darkviolet"
    ColorValues[78] = "0x9400D3"
    ColorNames[79] = "darkorchid"
    ColorValues[79] = "0x9932CC"
    ColorNames[80] = "mediumorchid"
    ColorValues[80] = "0xBA55D3"
    ColorNames[81] = "purple"
    ColorValues[81] = "0x800080"
    ColorNames[82] = "thistle"
    ColorValues[82] = "0xD8BFD8"
    ColorNames[83] = "plum"
    ColorValues[83] = "0xDDA0DD"
    ColorNames[84] = "violet"
    ColorValues[84] = "0xEE82EE"
    ColorNames[85] = "fuchsia"
    ColorValues[85] = "0xFF00FF"
    ColorNames[86] = "orchid"
    ColorValues[86] = "0xDA70D6"
    ColorNames[87] = "mediumvioletred"
    ColorValues[87] = "0xC71585"
    ColorNames[88] = "palevioletred"
    ColorValues[88] = "0xDB7093"
    ColorNames[89] = "deeppink"
    ColorValues[89] = "0xFF1493"
    ColorNames[90] = "hotpink"
    ColorValues[90] = "0xFF69B4"
    ColorNames[91] = "lightpink"
    ColorValues[91] = "0xFFB6C1"
    ColorNames[92] = "pink"
    ColorValues[92] = "0xFFC0CB"
    ColorNames[93] = "antiquewhite"
    ColorValues[93] = "0xFAEBD7"
    ColorNames[94] = "beige"
    ColorValues[94] = "0xF5F5DC"
    ColorNames[95] = "bisque"
    ColorValues[95] = "0xFFE4C4"
    ColorNames[96] = "blanchedalmond"
    ColorValues[96] = "0xFFEBCD"
    ColorNames[97] = "wheat"
    ColorValues[97] = "0xF5DEB3"
    ColorNames[98] = "cornsilk"
    ColorValues[98] = "0xFFF8DC"
    ColorNames[99] = "lemonchiffon"
    ColorValues[99] = "0xFFFACD"
    ColorNames[100] = "lightgoldenrodyellow"
    ColorValues[100] = "0xFAFAD2"
    ColorNames[101] = "lightyellow"
    ColorValues[101] = "0xFFFFE0"
    ColorNames[102] = "saddlebrown"
    ColorValues[102] = "0x8B4513"
    ColorNames[103] = "sienna"
    ColorValues[103] = "0xA0522D"
    ColorNames[104] = "chocolate"
    ColorValues[104] = "0xD2691E"
    ColorNames[105] = "peru"
    ColorValues[105] = "0xCD853F"
    ColorNames[106] = "sandybrown"
    ColorValues[106] = "0xF4A460"
    ColorNames[107] = "burlywood"
    ColorValues[107] = "0xDEB887"
    ColorNames[108] = "tan"
    ColorValues[108] = "0xD2B48C"
    ColorNames[109] = "rosybrown"
    ColorValues[109] = "0xBC8F8F"
    ColorNames[110] = "moccasin"
    ColorValues[110] = "0xFFE4B5"
    ColorNames[111] = "navajowhite"
    ColorValues[111] = "0xFFDEAD"
    ColorNames[112] = "peachpuff"
    ColorValues[112] = "0xFFDAB9"
    ColorNames[113] = "mistyrose"
    ColorValues[113] = "0xFFE4E1"
    ColorNames[114] = "lavenderblush"
    ColorValues[114] = "0xFFF0F5"
    ColorNames[115] = "linen"
    ColorValues[115] = "0xFAF0E6"
    ColorNames[116] = "oldlace"
    ColorValues[116] = "0xFDF5E6"
    ColorNames[117] = "papayawhip"
    ColorValues[117] = "0xFFEFD5"
    ColorNames[118] = "seashell"
    ColorValues[118] = "0xFFF5EE"
    ColorNames[119] = "mintcream"
    ColorValues[119] = "0xF5FFFA"
    ColorNames[120] = "slategray"
    ColorValues[120] = "0x708090"
    ColorNames[121] = "lightslategray"
    ColorValues[121] = "0x778899"
    ColorNames[122] = "lightsteelblue"
    ColorValues[122] = "0xB0C4DE"
    ColorNames[123] = "lavender"
    ColorValues[123] = "0xE6E6FA"
    ColorNames[124] = "floralwhite"
    ColorValues[124] = "0xFFFAF0"
    ColorNames[125] = "aliceblue"
    ColorValues[125] = "0xF0F8FF"
    ColorNames[126] = "ghostwhite"
    ColorValues[126] = "0xF8F8FF"
    ColorNames[127] = "honeydew"
    ColorValues[127] = "0xF0FFF0"
    ColorNames[128] = "ivory"
    ColorValues[128] = "0xFFFFF0"
    ColorNames[129] = "azure"
    ColorValues[129] = "0xF0FFFF"
    ColorNames[130] = "snow"
    ColorValues[130] = "0xFFFAFA"
    ColorNames[131] = "black"
    ColorValues[131] = "0x000000"
    ColorNames[132] = "dimgray"
    ColorValues[132] = "0x696969"
    ColorNames[133] = "gray"
    ColorValues[133] = "0x808080"
    ColorNames[134] = "darkgray"
    ColorValues[134] = "0xA9A9A9"
    ColorNames[135] = "silver"
    ColorValues[135] = "0xC0C0C0"
    ColorNames[136] = "lightgray"
    ColorValues[136] = "0xD3D3D3"
    ColorNames[137] = "gainsboro"
    ColorValues[137] = "0xDCDCDC"
    ColorNames[138] = "whitesmoke"
    ColorValues[138] = "0xF5F5F5"
    ColorNames[139] = "white"
    ColorValues[139] = "0xFFFFFF"

    ; Remove all provided spaces (spaces are allowed, e.g. "light gray")
    string[] colorNameParts = StringUtil.Split(color, " ")
    string colorName = ""
    int index = 0
    while index < colorNameParts.Length
        colorName += colorNameParts[index]
        index += 1
    endWhile

    ; See if one matches!
    index = 0
    while index < ColorNames.Length
        if ColorNames[index] == colorName
            return ColorValues[index]
        endIf
        index += 1
    endWhile

    ; If nothing matches, return ""
    return ""
endFunction