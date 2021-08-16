scriptName ConsoleHelper hidden
{Utility for working with the Skyrim ~ console menu}

; ConsoleHelper.SetHeaderText("Hello, world!")
; ConsoleHelper.SetBodyText("Hello\nWorld\nFoo\nBar\n")
; ConsoleHelper.SetInputText("Hi there.")
; ConsoleHelper.Open()

; Opens the Skyrim ~ console menu
function Open() global
    ; Conside setting the Body Text in here / OnMenuOpen ...
    int openCloseConsoleKey = Input.GetMappedKey("Console")
    Input.TapKey(openCloseConsoleKey)
endFunction

; DOCS
; Can be set while menu is closed
function SetHeaderText(string text) global
    UI.SetString("Console", "_global.Console.ConsoleInstance.CurrentSelection.text", text)
endFunction

; DOCS
; Can only be set when menu is open (?)
function SetBodyText(string text) global
    UI.SetString("Console", "_global.Console.ConsoleInstance.CommandHistory.text", text)
    UI.SetString("Console", "_global.Console.ConsoleInstance.CommandHistory.text", text)
endFunction

; DOCS
function SetInputText(string text) global
    UI.SetString("Console", "_global.Console.ConsoleInstance.CommandEntry.text", text)
endFunction
