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
string function GetCommandHistoryText() global
    return GetInstanceString("CommandHistory.text")
endFunction

; DOC
function SetCommandHistoryText(string text) global
    SetInstanceString("CommandHistory.text", text)
    SetInstanceString("CommandHistory.text", text) ; XXX works most consistently when set twice :shrug:
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

; Opens the Skyrim ~ console menu
function Open() global
    ; Conside setting the Body Text in here / OnMenuOpen ...
    int openCloseConsoleKey = Input.GetMappedKey("Console")
    Input.TapKey(openCloseConsoleKey)
endFunction