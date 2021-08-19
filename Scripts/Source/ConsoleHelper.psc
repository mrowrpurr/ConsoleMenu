scriptName ConsoleHelper hidden
{Utility for working with the Skyrim ~ console menu}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ConsoleHelper version
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Returns the version of the ConsoleHelper mod
float function GetConsoleHelperVersion() global
    return 1.0
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Helper to get the menu name
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Gets the 'Console' menu name
string function GetMenuName() global
    return "Console"
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Check if ConsoleHelper console.swf is available
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Returns whether the ConsoleHelper custom .swf is installed (built-in to the mod package)
bool function IsConsoleHelperConsoleInstalled() global
    return __consoleHelper__.GetIsConsoleHelperConsoleInstalled()
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Execute Command
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; *Requires ConsoleHelper's custom console.swf (built-in to the mod package)*
;
; Delegates the provided command to the default command runner used in the Console
function ExecuteCommand(string command) global
    UI.InvokeString(GetMenuName(), GetInstanceTarget("ExecuteCommand"), command)
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Print to Console
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Prints to the console
; Alias for AddHistoryline()
function Print(string text) global
    AddHistoryLine(text)
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Console Size & Position Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Helper function to provide full screen height
int function GetScreenHeight() global
    return Utility.GetINIINt("iSize H:Display")
endFunction

; Helper function to provide full screen width
int function GetScreenWidth() global
    return Utility.GetINIInt("iSize W:Display")
endFunction

function ScrollUp() global
    if IsConsoleHelperConsoleInstalled()
        UI.Invoke(GetMenuName(), GetInstanceTarget("ScrollUp"))
    else
        ; var _loc2_ = this.CommandHistory.bottomScroll - this.CommandHistory.scroll;
        ;   var _loc3_ = this.CommandHistory.scroll - _loc2_;
        ;   this.CommandHistory.scroll = _loc3_ <= 0 ? 0 : _loc3_;
    endIf
endFunction

function ScrollDown() global
    if IsConsoleHelperConsoleInstalled()
        UI.Invoke(GetMenuName(), GetInstanceTarget("ScrollDown"))
    else
        ;   _loc1_ = this.CommandHistory.bottomScroll - this.CommandHistory.scroll;
        ;   _loc2_ = this.CommandHistory.scroll + _loc1_;
        ;   this.CommandHistory.scroll = _loc2_ > this.CommandHistory.maxscroll ? this.CommandHistory.maxscroll : _loc2_;
    endif
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; TextInput Sections Overview
;;
;; ~ Target Helpers ~
;; ~ Show/Hide/Toggle ~
;; ~ Get/Set/Clear Text ~
;; ~ Text Size ~
;; ~ Text Color ~
;; ~ Opacity ~
;; ~ Background Color ~
;; ~ Background Opacity ~
;; ~ Border Color ~
;; ~ Border Opacity ~
;; ~ Adjust Size and Position ~
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Batch Functions for working across multiple elements
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ~ Target Helpers ~

; Returns target string for use by the UI script under the Console menu's namespace
string function GetTarget(string suffix = "") global
    if suffix
        return "_global.Console." + suffix
    else
        return "_global.Console"
    endIf
endFunction

; Returns target string for use by the UI script under the namespace for the current Console instance
string function GetInstanceTarget(string suffix = "") global
    if suffix
        return GetTarget("ConsoleInstance." + suffix)
    else
        return GetTarget("ConsoleInstance")
    endIf
endFunction

;; ~ Show/Hide/Toggle ~

function HideAll() global
    HideHeader()
    HideBody()
    HideTextInput()
    HideBackground()
endFunction
function ShowAll() global
    ShowHeader()
    ShowBody()
    ShowTextInput()
    ShowBackground()
endFunction
function SetAllVisible(bool value)
    SetHeaderVisible(value)
    SetBodyVisible(value)
    SetTextInputVisible(value)
    SetBackgroundVisible(value)
endFunction
function ToggleAll() global
    ToggleHeader()
    ToggleBody()
    ToggleTextInput()
    ToggleBackground()
endFunction

;; ~ Get/Set/Clear Text ~

function ClearAllText() global
    ClearHeaderText()
    ClearBodyText()
    ClearTextInputText()
endFunction

;; ~ Text Size ~

function SetTextSize(int pointSize) global
    UI.InvokeInt(GetMenuName(), GetTarget("SetTextSize"), pointSize)
endFunction

;; ~ Text Color ~

function SetTextColor(string color) global
    SetHeaderTextColor(color)
    SetBodyTextColor(color)
    SetTextInputTextColor(color)
endFunction

;; ~ Opacity ~

function SetOpacity(int opacity) global
    SetHeaderOpacity(opacity)
    SetBodyOpacity(opacity)
    SetTextInputOpacity(opacity)
endFunction

;; ~ Background Color ~

function SetBackgroundColor(string color, bool enableBackground = true) global
    SetHeaderBackgroundColor(color, enableBackground)
    SetBodyBackgroundColor(color,enableBackground)
    SetTextInputBackgroundColor(color,enableBackground )
endFunction
function ShowBackgrounds() global
    ShowHeaderBorder()
    ShowBodyBorder()
    ShowTextInputBorder()
endFunction
function HideBackgrounds() global
    HideHeaderBorder()
    HideBodyBorder()
    HideTextInputBorder()
endFunction

;; ~ Border Color ~

function SetBorderColor(string color, bool enableBorder = true) global
    SetHeaderBorderColor(color, enableBorder)
    SetBodyBorderColor(color, enableBorder)
    SetTextInputBorderColor(color, enableBorder)
endFunction
function ShowBorders() global
    ShowHeaderBorder()
    ShowBodyBorder()
    ShowTextInputBorder()
endFunction
function HideBorders() global
    HideHeaderBorder()
    HideBodyBorder()
    HideTextInputBorder()
endFunction

;; ~ Adjust Size and Position ~

; TODO

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Current Selection aka "Header" TextInput Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ~ Target Helpers ~

; Returns target string for use by the UI script for interacting with the CurrentSelection TextInput
string function GetHeaderTarget(string suffix = "") global
    if suffix
        return GetInstanceTarget("CurrentSelection." + suffix)
    else
        return GetInstanceTarget("CurrentSelection")
    endIf
endFunction

;; ~ Show/Hide/Toggle ~

function ShowHeader() global
    return UI.SetBool(GetMenuName(), GetHeaderTarget("_visible"), true)
endFunction
function HideHeader() global
    return UI.SetBool(GetMenuName(), GetHeaderTarget("_visible"), false)
endFunction
bool function IsHeaderVisible() global
    return UI.GetBool(GetMenuName(), GetHeaderTarget("_visible"))
endFunction
function SetHeaderVisible(bool value) global
    UI.SetBool(GetMenuName(), GetHeaderTarget("_visible"), value)
endFunction
function ToggleHeader() global
    UI.SetBool(GetMenuName(), GetHeaderTarget("_visible"), ! IsHeaderVisible())
endFunction

;; ~ Get/Set/Clear Text ~

string function GetHeaderText() global
    return UI.GetString(GetMenuName(), GetHeaderTarget("text"))
endFunction
function SetHeaderText(string value) global
    UI.SetString(GetMenuName(), GetHeaderTarget("text"), value)
endFunction
function ClearHeaderText() global
    SetHeaderText("")
endFunction

;; ~ Text Size ~

; *Requires ConsoleHelper's custom console.swf (built-in to the mod package)*
function SetHeaderTextSize(int pointSize) global
    UI.InvokeInt(GetMenuName(), GetTarget("SetCurrentSelectionTextSize"), pointSize)
endFunction

;; ~ Text Color ~

function SetHeaderTextColor(string color) global
    UI.SetString(GetMenuName(), GetHeaderTarget("textColor"), GetColor(color))
endFunction
int function GetHeaderTextColorInt() global
    return UI.GetInt(GetMenuName(), GetHeaderTarget("textColor"))
endFunction

;; ~ Opacity ~

function SetHeaderOpacity(int opacity) global
    UI.SetFloat(GetMenuName(), GetHeaderTarget("_alpha"), opacity)
endFunction
int function GetHeaderOpacity() global
    return UI.GetInt(GetMenuName(), GetHeaderTarget("_alpha"))
endFunction

;; ~ Background ~

function ShowHeaderBackground() global
    UI.SetBool(GetMenuName(), GetHeaderTarget("background"), true)
endFunction
function HideHeaderBackground() global
    UI.SetBool(GetMenuName(), GetHeaderTarget("background"), false)
endFunction
bool function IsHeaderBackgroundVisible() global
    return UI.GetBool(GetMenuName(), GetHeaderTarget("background"))
endFunction
function SetHeaderBackgroundVisible(bool value) global
    UI.SetBool(GetMenuName(), GetHeaderTarget("background"), value)
endFunction
function ToggleHeaderBackground() global
    SetHeaderBackgroundVisible(! IsHeaderVisible())
endFunction

;; ~ Background Color ~

function SetHeaderBackgroundColor(string color, bool enableBackground = true) global
    if enableBackground
        ShowHeaderBackground()
    endIf
    UI.SetString(GetMenuName(), GetHeaderTarget("backgroundColor"), GetColor(color))
endFunction
int function GetHeaderBackgroundColorInt() global
    return UI.GetInt(GetMenuName(), GetHeaderTarget("backgroundColor"))
endFunction

;; ~ Border ~

function ShowHeaderBorder() global
    UI.SetBool(GetMenuName(), GetHeaderTarget("border"), true)
endFunction
function HideHeaderBorder() global
    UI.SetBool(GetMenuName(), GetHeaderTarget("border"), false)
endFunction
bool function IsHeaderBorderVisible() global
    return UI.GetBool(GetMenuName(), GetHeaderTarget("border"))
endFunction
function SetHeaderBorderVisible(bool value) global
    UI.SetBool(GetMenuName(), GetHeaderTarget("border"), value)
endFunction
function ToggleHeaderBorder() global
    SetHeaderBorderVisible(! IsHeaderVisible())
endFunction

;; ~ Border Color ~

function SetHeaderBorderColor(string color, bool enableBorder = true) global
    if enableBorder
        ShowHeaderBorder()
    endIf
    UI.SetString(GetMenuName(), GetHeaderTarget("borderColor"), GetColor(color))
    ; UI.SetBool("Console", GetInstanceTarget("CurrentSelection.border"), true)
    ; UI.SetString("Console", GetInstanceTarget("CurrentSelection.borderColor"), GetColor(color))
endFunction
int function GetHeaderBorderColorInt() global
    return UI.GetInt(GetMenuName(), GetHeaderTarget("borderColor"))
endFunction

;; ~ Adjust Size and Position ~

int function GetHeaderWidth() global
    return UI.GetInt(GetMenuName(), GetHeaderTarget("_width"))
endFunction
function SetHeaderWidth(int width) global
    UI.SetFloat(GetMenuName(), GetHeaderTarget("_width"), width)
endFunction
int function GetHeaderHeight() global
    return UI.GetInt(GetMenuName(), GetHeaderTarget("_height"))
endFunction
function SetHeaderHeight(int height) global
    UI.SetFloat(GetMenuName(), GetHeaderTarget("_height"), height)
endFunction
int function GetHeaderPositionX() global
    return UI.GetInt(GetMenuName(), GetHeaderTarget("_x"))
endFunction
function SetHeaderPositionX(int x) global
    UI.SetFloat(GetMenuName(), GetHeaderTarget("_x"), x)
endFunction
int function GetHeaderPositionY() global
    return UI.GetInt(GetMenuName(), GetHeaderTarget("_y"))
endFunction
function SetHeaderPositionY(int y) global
    UI.SetFloat(GetMenuName(), GetHeaderTarget("_y"), y)
endFunction
function CenterHeader() global
    int screenWidth = GetScreenWidth()
    int currentWidth = GetHeaderWidth()
    int emptySpaceOnSides = screenWidth - currentWidth
    SetHeaderPositionX(emptySpaceOnSides / 2)
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Command History aka "Body" TextInput Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ~ Target Helpers ~

; Returns target string for use by the UI script for interacting with the CommandHistory TextInput
string function GetBodyTarget(string suffix = "") global
    if suffix
        return GetInstanceTarget("CommandHistory." + suffix)
    else
        return GetInstanceTarget("CommandHistory")
    endIf
endFunction

;; ~ Show/Hide/Toggle ~

function ShowBody() global
    return UI.SetBool(GetMenuName(), GetBodyTarget("_visible"), true)
endFunction
function HideBody() global
    return UI.SetBool(GetMenuName(), GetBodyTarget("_visible"), false)
endFunction
bool function IsBodyVisible() global
    return UI.GetBool(GetMenuName(), GetBodyTarget("_visible"))
endFunction
function SetBodyVisible(bool value) global
    UI.SetBool(GetMenuName(), GetBodyTarget("_visible"), value)
endFunction
function ToggleBody() global
    UI.SetBool(GetMenuName(), GetBodyTarget("_visible"), ! IsBodyVisible())
endFunction

;; ~ Get/Set/Clear Text ~

string function GetBodyText() global
    return UI.GetString(GetMenuName(), GetBodyTarget("text"))
endFunction
function SetBodyText(string value) global
    UI.SetString(GetMenuName(), GetBodyTarget("text"), value)
endFunction
function ClearBodyText() global
    SetBodyText("")
endFunction

;; ~ Text Size ~

; *Requires ConsoleHelper's custom console.swf (built-in to the mod package)*
function SetBodyTextSize(int pointSize) global
    UI.InvokeInt(GetMenuName(), GetTarget("SetCurrentSelectionTextSize"), pointSize)
endFunction

;; ~ Text Color ~

function SetBodyTextColor(string color) global
    UI.SetString(GetMenuName(), GetBodyTarget("textColor"), GetColor(color))
endFunction
int function GetBodyTextColorInt() global
    return UI.GetInt(GetMenuName(), GetBodyTarget("textColor"))
endFunction

;; ~ Opacity ~

function SetBodyOpacity(int opacity) global
    UI.SetFloat(GetMenuName(), GetBodyTarget("_alpha"), opacity)
endFunction
int function GetBodyOpacity() global
    return UI.GetInt(GetMenuName(), GetBodyTarget("_alpha"))
endFunction

;; ~ Background ~

function ShowBodyBackground() global
    UI.SetBool(GetMenuName(), GetBodyTarget("background"), true)
endFunction
function HideBodyBackground() global
    UI.SetBool(GetMenuName(), GetBodyTarget("background"), false)
endFunction
bool function IsBodyBackgroundVisible() global
    return UI.GetBool(GetMenuName(), GetBodyTarget("background"))
endFunction
function SetBodyBackgroundVisible(bool value) global
    UI.SetBool(GetMenuName(), GetBodyTarget("background"), value)
endFunction
function ToggleBodyBackground() global
    SetBodyBackgroundVisible(! IsBodyVisible())
endFunction

;; ~ Background Color ~

function SetBodyBackgroundColor(string color, bool enableBackground = true) global
    if enableBackground
        ShowBodyBackground()
    endIf
    UI.SetString(GetMenuName(), GetBodyTarget("backgroundColor"), GetColor(color))
endFunction
int function GetBodyBackgroundColorInt() global
    return UI.GetInt(GetMenuName(), GetBodyTarget("backgroundColor"))
endFunction

;; ~ Border ~

function ShowBodyBorder() global
    UI.SetBool(GetMenuName(), GetBodyTarget("border"), true)
endFunction
function HideBodyBorder() global
    UI.SetBool(GetMenuName(), GetBodyTarget("border"), false)
endFunction
bool function IsBodyBorderVisible() global
    return UI.GetBool(GetMenuName(), GetBodyTarget("border"))
endFunction
function SetBodyBorderVisible(bool value) global
    UI.SetBool(GetMenuName(), GetBodyTarget("border"), value)
endFunction
function ToggleBodyBorder() global
    SetBodyBorderVisible(! IsBodyVisible())
endFunction

;; ~ Border Color ~

function SetBodyBorderColor(string color, bool enableBorder = true) global
    if enableBorder
        ShowBodyBorder()
    endIf
    UI.SetString(GetMenuName(), GetBodyTarget("borderColor"), GetColor(color))
        ;     UI.SetBool("Console", ConsoleHelper.GetInstanceTarget("CommandHistory.border"), true)
        ; UI.SetString("Console", ConsoleHelper.GetInstanceTarget("CommandHistory.borderColor"), ConsoleHelper.GetColor("red"))
endFunction
int function GetBodyBorderColorInt() global
    return UI.GetInt(GetMenuName(), GetBodyTarget("borderColor"))
endFunction

;; ~ Adjust Size and Position ~

int function GetBodyWidth() global
    return UI.GetInt(GetMenuName(), GetBodyTarget("_width"))
endFunction
function SetBodyWidth(int width) global
    UI.SetFloat(GetMenuName(), GetBodyTarget("_width"), width)
endFunction
int function GetBodyHeight() global
    return UI.GetInt(GetMenuName(), GetBodyTarget("_height"))
endFunction
function SetBodyHeight(int height) global
    UI.SetFloat(GetMenuName(), GetBodyTarget("_height"), height)
endFunction
int function GetBodyPositionX() global
    return UI.GetInt(GetMenuName(), GetBodyTarget("_x"))
endFunction
function SetBodyPositionX(int x) global
    UI.SetFloat(GetMenuName(), GetBodyTarget("_x"), x)
endFunction
int function GetBodyPositionY() global
    return UI.GetInt(GetMenuName(), GetBodyTarget("_y"))
endFunction
function SetBodyPositionY(int y) global
    UI.SetFloat(GetMenuName(), GetBodyTarget("_y"), y)
endFunction
function CenterBody() global
    int screenWidth = GetScreenWidth()
    int currentWidth = GetBodyWidth()
    int emptySpaceOnSides = screenWidth - currentWidth
    SetBodyPositionX(emptySpaceOnSides / 2)
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Command Entry aka "Text Input" TextInput Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ~ Target Helpers ~

; Returns target string for use by the UI script for interacting with the CommandEntry TextInput
string function GetTextInputTarget(string suffix = "") global
    if suffix
        return GetInstanceTarget("CommandEntry." + suffix)
    else
        return GetInstanceTarget("CommandEntry")
    endIf
endFunction

;; ~ Show/Hide/Toggle ~

function ShowTextInput() global
    return UI.SetBool(GetMenuName(), GetTextInputTarget("_visible"), true)
endFunction
function HideTextInput() global
    return UI.SetBool(GetMenuName(), GetTextInputTarget("_visible"), false)
endFunction
bool function IsTextInputVisible() global
    return UI.GetBool(GetMenuName(), GetTextInputTarget("_visible"))
endFunction
function SetTextInputVisible(bool value) global
    UI.SetBool(GetMenuName(), GetTextInputTarget("_visible"), value)
endFunction
function ToggleTextInput() global
    UI.SetBool(GetMenuName(), GetTextInputTarget("_visible"), ! IsTextInputVisible())
endFunction

;; ~ Get/Set/Clear Text ~

string function GetTextInputText() global
    return UI.GetString(GetMenuName(), GetTextInputTarget("text"))
endFunction
function SetTextInputText(string value) global
    if IsConsoleHelperConsoleInstalled()
        UI.InvokeString(GetMenuName(), GetInstanceTarget("SetCommandEntryText"), value)
    else
        UI.SetString(GetMenuName(), GetTextInputTarget("text"), value)
    endIf
endFunction
function ClearTextInputText() global
    SetTextInputText("")
endFunction
string function GetAndClearInputText() global
    string text = GetTextInputText()
    SetTextInputText("")
    return text
endFunction

;; ~ Text Size ~

; *Requires ConsoleHelper's custom console.swf (built-in to the mod package)*
function SetTextInputTextSize(int pointSize) global
    UI.InvokeInt(GetMenuName(), GetTarget("SetCurrentSelectionTextSize"), pointSize)
endFunction

;; ~ Text Color ~

function SetTextInputTextColor(string color) global
    UI.SetString(GetMenuName(), GetTextInputTarget("textColor"), GetColor(color))
endFunction
int function GetTextInputTextColorInt() global
    return UI.GetInt(GetMenuName(), GetTextInputTarget("textColor"))
endFunction

;; ~ Opacity ~

function SetTextInputOpacity(int opacity) global
    UI.SetFloat(GetMenuName(), GetTextInputTarget("_alpha"), opacity)
endFunction
int function GetTextInputOpacity() global
    return UI.GetInt(GetMenuName(), GetTextInputTarget("_alpha"))
endFunction

;; ~ Background ~

function ShowTextInputBackground() global
    UI.SetBool(GetMenuName(), GetTextInputTarget("background"), true)
endFunction
function HideTextInputBackground() global
    UI.SetBool(GetMenuName(), GetTextInputTarget("background"), false)
endFunction
bool function IsTextInputBackgroundVisible() global
    return UI.GetBool(GetMenuName(), GetTextInputTarget("background"))
endFunction
function SetTextInputBackgroundVisible(bool value) global
    UI.SetBool(GetMenuName(), GetTextInputTarget("background"), value)
endFunction
function ToggleTextInputBackground() global
    SetTextInputBackgroundVisible(! IsTextInputVisible())
endFunction

;; ~ Background Color ~

function SetTextInputBackgroundColor(string color, bool enableBackground = true) global
    if enableBackground
        ShowTextInputBackground()
    endIf
    UI.SetString(GetMenuName(), GetTextInputTarget("backgroundColor"), GetColor(color))
endFunction
int function GetTextInputBackgroundColorInt() global
    return UI.GetInt(GetMenuName(), GetTextInputTarget("backgroundColor"))
endFunction

;; ~ Border ~

function ShowTextInputBorder() global
    UI.SetBool(GetMenuName(), GetTextInputTarget("border"), true)
endFunction
function HideTextInputBorder() global
    UI.SetBool(GetMenuName(), GetTextInputTarget("border"), false)
endFunction
bool function IsTextInputBorderVisible() global
    return UI.GetBool(GetMenuName(), GetTextInputTarget("border"))
endFunction
function SetTextInputBorderVisible(bool value) global
    UI.SetBool(GetMenuName(), GetTextInputTarget("border"), value)
endFunction
function ToggleTextInputBorder() global
    SetTextInputBorderVisible(! IsTextInputVisible())
endFunction

;; ~ Border Color ~

function SetTextInputBorderColor(string color, bool enableBorder = true) global
    if enableBorder
        ShowTextInputBorder()
    endIf
    UI.SetString(GetMenuName(), GetTextInputTarget("borderColor"), GetColor(color))
    ;  UI.SetBool("Console", ConsoleHelper.GetInstanceTarget("CommandEntry.border"), true)
    ;     UI.SetString("Console", ConsoleHelper.GetInstanceTarget("CommandEntry.borderColor"), ConsoleHelper.GetColor("red"))
endFunction
int function GetTextInputBorderColorInt() global
    return UI.GetInt(GetMenuName(), GetTextInputTarget("borderColor"))
endFunction

;; ~ Adjust Size and Position ~

int function GetTextInputWidth() global
    return UI.GetInt(GetMenuName(), GetTextInputTarget("_width"))
endFunction
function SetTextInputWidth(int width) global
    UI.SetFloat(GetMenuName(), GetTextInputTarget("_width"), width)
endFunction
int function GetTextInputHeight() global
    return UI.GetInt(GetMenuName(), GetTextInputTarget("_height"))
endFunction
function SetTextInputHeight(int height) global
    UI.SetFloat(GetMenuName(), GetTextInputTarget("_height"), height)
endFunction
int function GetTextInputPositionX() global
    return UI.GetInt(GetMenuName(), GetTextInputTarget("_x"))
endFunction
function SetTextInputPositionX(int x) global
    UI.SetFloat(GetMenuName(), GetTextInputTarget("_x"), x)
endFunction
int function GetTextInputPositionY() global
    return UI.GetInt(GetMenuName(), GetTextInputTarget("_y"))
endFunction
function SetTextInputPositionY(int y) global
    UI.SetFloat(GetMenuName(), GetTextInputTarget("_y"), y)
endFunction
function CenterTextInput() global
    int screenWidth = GetScreenWidth()
    int currentWidth = GetTextInputWidth()
    int emptySpaceOnSides = screenWidth - currentWidth
    SetTextInputPositionX(emptySpaceOnSides / 2)
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Background Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; [[ Target Helpers ]]

; Returns target string for use by the UI script for interacting with the Background object
string function GetBackgroundTarget(string suffix = "") global
    if suffix
        return GetInstanceTarget("Background." + suffix)
    else
        return GetInstanceTarget("Background")
    endIf
endFunction

;; ~ Show/Hide/Toggle ~

function ShowBackground() global
    return UI.SetBool(GetMenuName(), GetBackgroundTarget("_visible"), true)
endFunction
function HideBackground() global
    return UI.SetBool(GetMenuName(), GetBackgroundTarget("_visible"), false)
endFunction
bool function IsBackgroundVisible() global
    return UI.GetBool(GetMenuName(), GetBackgroundTarget("_visible"))
endFunction
bool function SetBackgroundVisible(bool value) global
    UI.SetBool(GetMenuName(), GetBackgroundTarget("_visible"), value)
endFunction
function ToggleBackground() global
    UI.SetBool(GetMenuName(), GetBackgroundTarget("_visible"), ! IsBackgroundVisible())
endFunction

;; ~ Adjust Size and Position ~

int function GetBackgroundWidth() global
    return UI.GetInt(GetMenuName(), GetBackgroundTarget("_width"))
endFunction
function SetBackgroundWidth(int width) global
    UI.SetFloat(GetMenuName(), GetBackgroundTarget("_width"), width)
endFunction
int function GetBackgroundHeight() global
    return UI.GetInt(GetMenuName(), GetBackgroundTarget("_height"))
endFunction
function SetBackgroundHeight(int height) global
    UI.SetFloat(GetMenuName(), GetBackgroundTarget("_height"), height)
endFunction
int function GetBackgroundPositionX() global
    return UI.GetInt(GetMenuName(), GetBackgroundTarget("_x"))
endFunction
function SetBackgroundPositionX(int x) global
    UI.SetFloat(GetMenuName(), GetBackgroundTarget("_x"), x)
endFunction
int function GetBackgroundPositionY() global
    return UI.GetInt(GetMenuName(), GetBackgroundTarget("_y"))
endFunction
function SetBackgroundPositionY(int y) global
    UI.SetFloat(GetMenuName(), GetBackgroundTarget("_y"), y)
endFunction
function CenterBackground() global
    int screenWidth = GetScreenWidth()
    int currentWidth = GetBackgroundWidth()
    int emptySpaceOnSides = screenWidth - currentWidth
    SetBackgroundPositionX(emptySpaceOnSides / 2)
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Commands History Array
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Returns target string for use by the UI script for interacting with the Commands array which stores the history of run commands
string function GetCommandHistoryTarget(string suffix = "") global
    if suffix
        return GetInstanceTarget("Commands." + suffix)
    else
        return GetInstanceTarget("Commands")
    endIf
endFunction

string[] function GetCommandHistory() global
    int historyLength = GetCommandHistoryLength()
    if historyLength > 0
        int index = 0
        string[] commands = Utility.CreateStringArray(historyLength)
        while index < historyLength
            commands[index] = GetCommandHistoryItem(index)
            index += 1
        endWhile
        return commands
    endIf
endFunction

string function GetCommandHistoryItem(int index) global
    return UI.GetString(GetMenuName(), GetCommandHistoryTarget(index))
endFunction

int function GetCommandHistoryLength() global
    return UI.GetInt(GetMenuName(), GetCommandHistoryTarget("length"))
endFunction

function ClearCommandHistory() global
    return UI.InvokeInt(GetMenuName(), GetCommandHistoryTarget("splice"), 0)
endFunction

function AddToCommandHistory(string command) global
    return UI.InvokeString(GetMenuName(), GetCommandHistoryTarget("push"), command)
endFunction

function RemoveOldestCommandHistoryItem() global
    return UI.Invoke(GetMenuName(), GetCommandHistoryTarget("shift"))
endFunction

function RemoveMostRecentCommandHistoryItem() global
    int spliceStart = GetCommandHistoryLength() - 1; pop() not working for me
    return UI.InvokeInt(GetMenuName(), GetCommandHistoryTarget("splice"), spliceStart)
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ... organize me ...
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

function CenterConsole() global
    int screenWidth = GetScreenWidth()
    int currentWidth = GetCurrentWidth()
    int emptySpaceOnSides = screenWidth - currentWidth
    SetPositionX(emptySpaceOnSides / 2)
endFunction

bool function IsOpen() global
    return UI.GetBool(GetMenuName(), GetInstanceTarget("Shown"))
endFunction

bool function IsMinimized() global
    return GetPositionY() == (GetOriginalHeight() - GetCommandHistoryPositionY())
endFunction

; Opens the Skyrim ~ console menu
function Open(bool force = false) global
    if force || ! IsOpen() || IsMinimized()
        if IsMinimized()
            Restore()
        else
            TapConsoleToggleKey()
        endIf
    endIf
endFunction

; Closes the Skyrim ~ console menu
function Close(bool force = false) global
    if force || IsOpen() || ! IsMinimized()
        if IsMinimized()
            Restore()
        endIf
        TapConsoleToggleKey()
    endIf
endFunction

function TapConsoleToggleKey() global
    Input.TapKey(GetConsoleToggleKeyCode())
endFunction

int function GetConsoleToggleKeyCode() global
    return Input.GetMappedKey(GetMenuName())
endFunction

function Hide(bool force = false) global
    if force || IsOpen()
        UI.Invoke(GetMenuName(), GetTarget("Hide"))
    endIf
endFunction

function Minimize(bool force = false) global
    if force || IsOpen()
        UI.Invoke(GetMenuName(), GetTarget("Minimize"))
    endIf
endFunction

function Restore(bool force = true) global
    if force || IsMinimized()
        SetPositionY(GetOriginalHeight())
    endIf
endFunction


function SetPositionY(int height) global
    UI.SetFloat(GetMenuName(), GetInstanceTarget("_parent._y"), height)
endFunction


function SetPositionX(int height) global
    UI.SetFloat(GetMenuName(), GetInstanceTarget("_parent._x"), height)
endFunction


int function GetPositionY() global
    return UI.GetInt(GetMenuName(), GetInstanceTarget("_parent._y"))
endFunction


int function GetPositionX() global
    return UI.GetInt(GetMenuName(), GetInstanceTarget("_parent._x"))
endFunction


function SetWidth(int pixels) global
    UI.SetFloat(GetMenuName(), GetInstanceTarget("_width"), pixels)
endFunction


function SetHeight(int pixels) global
    UI.SetFloat(GetMenuName(), GetInstanceTarget("_height"), pixels)
endFunction


function Scale(int percentage) global
    float multiplier = percentage / 100.0
    SetWidth((GetCurrentWidth() * multiplier) as int)
    SetHeight((GetCurrentHeight() * multiplier) as int)
endFunction


function ResetScale() global
    SetWidth(__consoleHelper__.GetInstance().InitialConsoleWidth)
    SetHeight(__consoleHelper__.GetInstance().InitialConsoleHeight)
endFunction


function ResetPosition() global
    SetPositionX(__consoleHelper__.GetInstance().InitialConsoleX)
    SetPositionY(__consoleHelper__.GetInstance().InitialConsoleY)
endFunction


; TODO provide this for each element including background too!


function DockTop() global
    ResetScaleAndPosition()
    Scale(84)
    SetPositionY(0)
    CenterConsole()
endFunction


function ResetScaleAndPosition() global
    ResetScale()
    ResetPosition()
endFunction


int function GetOriginalHeight() global
    return UI.GetInt(GetMenuName(), GetInstanceTarget("OriginalHeight"))
endFunction


int function GetOriginalWidth() global
    return UI.GetInt(GetMenuName(), GetInstanceTarget("OriginalWidth"))
endFunction


int function GetCurrentHeight() global
    return UI.GetInt(GetMenuName(), GetInstanceTarget("_height"))
endFunction


int function GetCurrentWidth() global
    return UI.GetInt(GetMenuName(), GetInstanceTarget("_width"))
endFunction


int function GetCommandHistoryPositionY() global
    return UI.GetInt(GetMenuName(), GetInstanceTarget("CommandHistory._y"))
endFunction


int function GetCommandHistoryPositionX() global
    return UI.GetInt(GetMenuName(), GetInstanceTarget("CommandHistory._x"))
endFunction

; Add text to the history
; Note: this is not automatically followed by a newline
;       for that, use AddHistoryLine() or Print()
function AddHistory(string text) global
    UI.InvokeString(GetMenuName(), GetTarget("AddHistory"), text)
endFunction

; Add text to the history followed by a newline
function AddHistoryLine(string text) global
    AddHistory(text + "\n")
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom Console Commands
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; *Requires ConsoleHelper's custom console.swf (built-in to the mod package)*
;
; This will send an SKSE ModEvent to the caller using the callbackFn provided
; whenever the [Enter] or [Return] key is pressed, sending along the text of
; the command that is intended to be run.
;
; This will automatically clear the text input and add the command to the
; command history.
;
; Automatically disables handling of [Enter] and [Return] key by the console.swf
; via DisableNativeEnterReturnKeyHandling()
;
; Use UnregisterForCustomCommands() to stop listening for custom commands.
; Once the last listener has unregistered, the console.swf built-in command handling
; is re-enabled via EnableNativeEnterReturnKeyHandling()
;
; Note: when this is in-use, no console commands will be executed.
; You can process the commands however you wish.
; Use ExecuteCommand() if you'd like to run the command using the native command execution.
;
; It *sort of* works with the vanilla console.swf but it will print out an error for every custom command you run
; and it will run commands, you cannot keep it from running commands for you.
function RegisterForCustomCommands(string eventName) global
    __consoleHelper__.GetInstance().RegisterForCustomCommands(eventName)
endFunction

; *Requires ConsoleHelper's custom console.swf (built-in to the mod package)*
;
; See RegisterForCustomCommands() for documentation.
function UnregisterForCustomCommands(string eventName) global
    __consoleHelper__.GetInstance().UnregisterForCustomCommands(eventName)
endFunction

; *Requires ConsoleHelper's custom console.swf (built-in to the mod package)*
;
; Disables the native console's handling of the Enter and Return keys
function DisableNativeEnterReturnKeyHandling() global
    if IsConsoleHelperConsoleInstalled()
        UI.SetBool(GetMenuName(), GetInstanceTarget("HandleEnterReturnKeys"), false)
    else
        __consoleHelper__.LogCustomSwfRequiredError("DisableNativeEnterReturnKeyHandling")
    endIf
endFunction

; *Requires ConsoleHelper's custom console.swf (built-in to the mod package)*
;
; Enables the native console's handling of the Enter and Return keys
function EnableNativeEnterReturnKeyHandling() global
    if IsConsoleHelperConsoleInstalled()
        UI.SetBool(GetMenuName(), GetInstanceTarget("HandleEnterReturnKeys"), true)
    else
        __consoleHelper__.LogCustomSwfRequiredError("EnableNativeEnterReturnKeyHandling")
    endIf
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Friendly Color Helper Function (supports HTML color names)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Returns color in Flash compatible string hex format: "0xff00ff"
; Supports a variety of different inputs:
; - "0xff00ff"
; - "#ff00ff"
; - "Light Gray"
; - "Red"
; - Any of the 140 color names supported by HTML/Web browsers
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