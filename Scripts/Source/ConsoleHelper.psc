scriptName ConsoleHelper hidden
{Utility for working with the Skyrim ~ console menu}

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
; function InvokeInstance(string str) global
; endFunction

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
string function GetCurrentSelectionText() global
    return GetInstanceString("CurrentSelection.text")
endFunction

; DOC
function SetCurrentSelectionText(string text) global
    SetInstanceString("CurrentSelection.text", text)
endFunction

; DOCS
; Can be set while menu is closed
; Alias for CurrentSelectionText
function SetHeaderText(string text) global
    SetCurrentSelectionText(text)
endFunction

; DOCS
; Can be set while menu is closed
; Alias for CurrentSelectionText
string function GetHeaderText() global
    return GetCurrentSelectionText()
endFunction

; DOC
function SetHeaderTextColor(string hexColorWithHash) global
    ;
    SetInstanceString("CurrentSelection.textColor", hexColorWithHash)
    ;
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
    SetInstanceString("CommandEntry.text", text)
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