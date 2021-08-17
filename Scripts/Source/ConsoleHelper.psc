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
    InvokeInstanceString("ExecuteCommand", command)
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

function ScrollUp() global
    if IsConsoleHelperConsoleInstalled()
        InvokeInstance("ScrollUp")
    else
        ; var _loc2_ = this.CommandHistory.bottomScroll - this.CommandHistory.scroll;
        ;   var _loc3_ = this.CommandHistory.scroll - _loc2_;
        ;   this.CommandHistory.scroll = _loc3_ <= 0 ? 0 : _loc3_;
    endIf
endFunction

function ScrollDown() global
    if IsConsoleHelperConsoleInstalled()
        InvokeInstance("ScrollDown")
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
;; ~ Get/Set Text ~
;; ~ Text Size ~
;; ~ Text Color ~
;; ~ Text Opacity ~
;; ~ Background Color ~
;; ~ Background Opacity ~
;; ~ Border Color ~
;; ~ Border Opacity ~
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

;; ~ Get/Set Text ~

;; ~ Text Size ~

;; ~ Text Color ~

;; ~ Text Opacity ~

;; ~ Background Color ~

;; ~ Background Opacity ~

;; ~ Border Color ~

;; ~ Border Opacity ~

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
    return SetBool(GetHeaderTarget("_visible"), true)
endFunction
function HideHeader() global
    return SetBool(GetHeaderTarget("_visible"), false)
endFunction
bool function IsHeaderVisible() global
    return GetBool(GetHeaderTarget("_visible"))
endFunction
bool function SetHeaderVisible(bool value) global
    SetBool(GetHeaderTarget("_visible"), value)
endFunction
function ToggleHeader() global
    SetBool(GetHeaderTarget("_visible"), ! IsHeaderVisible())
endFunction

;; ~ Get/Set Text ~

string function GetHeaderText() global
    return GetString(GetHeaderTarget("text"))
endFunction
function SetHeaderText(string value) global
    SetString(GetHeaderTarget("text"), value)
endFunction

;; ~ Text Size ~

;; ~ Text Color ~

;; ~ Text Opacity ~

;; ~ Background Color ~

;; ~ Background Opacity ~

;; ~ Border Color ~

;; ~ Border Opacity ~

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
    return SetBool(GetBodyTarget("_visible"), true)
endFunction
function HideBody() global
    return SetBool(GetBodyTarget("_visible"), false)
endFunction
bool function IsBodyVisible() global
    return GetBool(GetBodyTarget("_visible"))
endFunction
bool function SetBodyVisible(bool value) global
    SetBool(GetBodyTarget("_visible"), value)
endFunction
function ToggleBody() global
    SetBool(GetBodyTarget("_visible"), ! IsBodyVisible())
endFunction

;; ~ Get/Set Text ~

;; ~ Text Size ~

;; ~ Text Color ~

;; ~ Text Opacity ~

;; ~ Background Color ~

;; ~ Background Opacity ~

;; ~ Border Color ~

;; ~ Border Opacity ~

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
    return SetBool(GetTextInputTarget("_visible"), true)
endFunction
function HideTextInput() global
    return SetBool(GetTextInputTarget("_visible"), false)
endFunction
bool function IsTextInputVisible() global
    return GetBool(GetTextInputTarget("_visible"))
endFunction
bool function SetTextInputVisible(bool value) global
    SetBool(GetTextInputTarget("_visible"), value)
endFunction
function ToggleTextInput() global
    SetBool(GetTextInputTarget("_visible"), ! IsTextInputVisible())
endFunction

;; ~ Get/Set Text ~

;; ~ Text Size ~

;; ~ Text Color ~

;; ~ Text Opacity ~

;; ~ Background Color ~

;; ~ Background Opacity ~

;; ~ Border Color ~

;; ~ Border Opacity ~

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
    return SetBool(GetBackgroundTarget("_visible"), true)
endFunction
function HideBackground() global
    return SetBool(GetBackgroundTarget("_visible"), false)
endFunction
bool function IsBackgroundVisible() global
    return GetBool(GetBackgroundTarget("_visible"))
endFunction
bool function SetBackgroundVisible(bool value) global
    SetBool(GetBackgroundTarget("_visible"), value)
endFunction
function ToggleBackground() global
    SetBool(GetBackgroundTarget("_visible"), ! IsBackgroundVisible())
endFunction






;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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

; DOC
string function GetAndClearCommandEntryText() global
    string text = GetCommandEntryText()
    SetCommandEntryText("")
    return text
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

; Alias for GetAndClearCommandEntryText
string function GetAndClearInputText() global
    return GetAndClearCommandEntryText()
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
function SetTextColor(string color) global
    SetCurrentSelectionTextColor(color)
    SetCommandHistoryTextColor(color)
    SetCommandEntryTextColor(color)
endFunction

; DOC
function SetBackgroundColor(string color) global
    SetCurrentSelectionBackgroundColor(color)
    SetCommandHistoryBackgroundColor(color)
    SetCommandEntryBackgroundColor(color)
endFunction

; DOC
function UnsetBackgroundColor() global
    UnsetCurrentSelectionBackgroundColor()
    UnsetCommandHistoryBackgroundColor()
    UnsetCommandEntryBackgroundColor()
endFunction

; DOC
function SetBorderColor(string color) global
    SetCurrentSelectionBorderColor(color)
    SetCommandHistoryBorderColor(color)
    SetCommandEntryBorderColor(color)
endFunction

; DOC
function UnsetBorderColor() global
    UnsetCurrentSelectionBorderColor()
    UnsetCommandHistoryBorderColor()
    UnsetCommandEntryBorderColor()
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
    return GetPositionY() == (GetOriginalHeight() - GetCommandHistoryPositionY())
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
        SetPositionY(GetOriginalHeight())
    endIf
endFunction

; DOC
function SetPositionY(int height) global
    SetInstanceInt("_parent._y", height)
endFunction

; DOC
function SetPositionX(int height) global
    SetInstanceInt("_parent._x", height)
endFunction

; DOC
int function GetPositionY() global
    return GetInstanceInt("_parent._y")
endFunction

; DOC
int function GetPositionX() global
    return GetInstanceInt("_parent._x")
endFunction

; DOC
function SetWidth(int pixels) global
    SetInstanceInt("_width", pixels)
endFunction

; DOC
function SetHeight(int pixels) global
    SetInstanceInt("_height", pixels)
endFunction

; DOC
function Scale(int percentage) global
    float multiplier = percentage / 100.0
    SetWidth((GetCurrentWidth() * multiplier) as int)
    SetHeight((GetCurrentHeight() * multiplier) as int)
endFunction

; DOC
function ResetScale() global
    SetWidth(__consoleHelper__.GetInstance().InitialConsoleWidth)
    SetHeight(__consoleHelper__.GetInstance().InitialConsoleHeight)
endFunction

; DOC
function ResetPosition() global
    SetPositionX(__consoleHelper__.GetInstance().InitialConsoleX)
    SetPositionY(__consoleHelper__.GetInstance().InitialConsoleY)
endFunction

; DOC
function Center() global
    int screenWidth = __consoleHelper__.GetInstance().InitialConsoleWidth
    int currentWidth = GetCurrentWidth()
    int emptySpaceOnSides = screenWidth - currentWidth
    SetPositionX(emptySpaceOnSides / 2)
endFunction

; DOC
function DockTop() global
    ResetScaleAndPosition()
    Scale(84)
    SetPositionY(0)
    Center()
endFunction

; DOC
function ResetScaleAndPosition() global
    ResetScale()
    ResetPosition()
endFunction

; DOC
function SetCurrentSelectionBackgroundColor(string color) global
    SetInstanceBool("CurrentSelection.background", true)
    SetInstanceString("CurrentSelection.backgroundColor", GetColor(color))
endFunction

; DOC
function UnsetCurrentSelectionBackgroundColor() global
    SetInstanceBool("CurrentSelection.background", false)
endFunction

; DOC
function SetCurrentSelectionBorderColor(string color) global
    SetInstanceBool("CurrentSelection.border", true)
    SetInstanceString("CurrentSelection.borderColor", GetColor(color))
endFunction

; DOC
function UnsetCurrentSelectionBorderColor() global
    SetInstanceBool("CurrentSelection.border", false)
endFunction

; DOC
function SetCommandHistoryBackgroundColor(string color) global
    SetInstanceBool("CommandHistory.background", true)
    SetInstanceString("CommandHistory.backgroundColor", GetColor(color))
endFunction

; DOC
function UnsetCommandHistoryBackgroundColor() global
    SetInstanceBool("CommandHistory.background", false)
endFunction

; DOC
function SetCommandHistoryBorderColor(string color) global
    SetInstanceBool("CommandHistory.border", true)
    SetInstanceString("CommandHistory.borderColor", GetColor(color))
endFunction

; DOC
function UnsetCommandHistoryBorderColor() global
    SetInstanceBool("CommandHistory.border", false)
endFunction

; DOC
function SetCommandEntryBackgroundColor(string color) global
    SetInstanceBool("CommandEntry.background", true)
    SetInstanceString("CommandEntry.backgroundColor", GetColor(color))
endFunction

; DOC
function UnsetCommandEntryBackgroundColor() global
    SetInstanceBool("CommandEntry.background", false)
endFunction

; DOC
function SetCommandEntryBorderColor(string color) global
    SetInstanceBool("CommandEntry.border", true)
    SetInstanceString("CommandEntry.borderColor", GetColor(color))
endFunction

; DOC
function UnsetCommandEntryBorderColor() global
    SetInstanceBool("CommandEntry.border", false)
endFunction

; DOC
int function GetOriginalHeight() global
    return GetInstanceInt("OriginalHeight")
endFunction

; DOC
int function GetOriginalWidth() global
    return GetInstanceInt("OriginalWidth")
endFunction

; DOC
int function GetCurrentHeight() global
    return GetInstanceInt("_height")
endFunction

; DOC
int function GetCurrentWidth() global
    return GetInstanceInt("_width")
endFunction

; DOC
int function GetCommandHistoryPositionY() global
    return GetInstanceInt("CommandHistory._y")
endFunction

; DOC
int function GetCommandHistoryPositionX() global
    return GetInstanceInt("CommandHistory._x")
endFunction

; Add text to the history
; Note: this is not automatically followed by a newline
;       for that, use AddHistoryLine() or Print()
function AddHistory(string text) global
    InvokeString("AddHistory", text)
endFunction

; Add text to the history followed by a newline
function AddHistoryLine(string text) global
    AddHistory(text + "\n")
endFunction

; DOC
function SetTextSize(int pointSize) global
    InvokeInt("SetTextSize", pointSize)
endFunction

; *Requires ConsoleHelper's custom console.swf (built-in to the mod package)*
;
; DOC
function SetCurrentSelectionTextSize(int pointSize) global
    InvokeInt("SetCurrentSelectionTextSize", pointSize)
endFunction

; *Requires ConsoleHelper's custom console.swf (built-in to the mod package)*
;
; DOC
function SetCommandHistoryTextSize(int pointSize) global
    InvokeInt("SetCommandHistoryTextSize", pointSize)
endFunction

; *Requires ConsoleHelper's custom console.swf (built-in to the mod package)*
;
; DOC
function SetCommandEntryTextSize(int pointSize) global
    InvokeInt("SetCommandEntryTextSize", pointSize)
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
function RegisterForCustomCommands(string eventName) global
    if IsConsoleHelperConsoleInstalled()
        __consoleHelper__.GetInstance().RegisterForCustomCommands(eventName)
    else
        ; TODO TRACE MESSAGE
    endIf
endFunction

; *Requires ConsoleHelper's custom console.swf (built-in to the mod package)*
;
; See RegisterForCustomCommands() for documentation.
function UnregisterForCustomCommands(string eventName) global
    if IsConsoleHelperConsoleInstalled()
        __consoleHelper__.GetInstance().UnregisterForCustomCommands(eventName)
    else
        ;; TODO TRACE MESSAGE
    endIf
endFunction

; *Requires ConsoleHelper's custom console.swf (built-in to the mod package)*
;
; Disables the native console's handling of the Enter and Return keys
function DisableNativeEnterReturnKeyHandling() global
    if IsConsoleHelperConsoleInstalled()
        SetInstanceBool("HandleEnterReturnKeys", false)
    else
        __consoleHelper__.LogCustomSwfRequiredError("DisableNativeEnterReturnKeyHandling")
    endIf
endFunction

; *Requires ConsoleHelper's custom console.swf (built-in to the mod package)*
;
; Enables the native console's handling of the Enter and Return keys
function EnableNativeEnterReturnKeyHandling() global
    if IsConsoleHelperConsoleInstalled()
        SetInstanceBool("HandleEnterReturnKeys", true)
    else
        __consoleHelper__.LogCustomSwfRequiredError("EnableNativeEnterReturnKeyHandling")
    endIf
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Console Function Invocation Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Console Instance Function Invocation Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Invoke an ActionScript function on the Console
function Invoke(string functionName) global
    UI.Invoke(GetMenuName(), GetTarget(functionName))
endFunction

; DOC
function InvokeString(string functionName, string value) global
    UI.InvokeString(GetMenuName(), GetTarget(functionName), value)
endFunction

; DOC
function InvokeInt(string functionName, int value) global
    UI.Invokeint(GetMenuName(), GetTarget(functionName), value)
endFunction

; Invoke an ActionScript function on the current Console instance
function InvokeInstance(string functionName) global
    UI.Invoke(GetMenuName(), GetInstanceTarget(functionName))
endFunction

; DOC
function InvokeInstanceString(string functionName, string value) global
    UI.InvokeString(GetMenuName(), GetInstanceTarget(functionName), value)
endFunction

; DOC
function InvokeInstanceInt(string functionName, int value) global
    UI.InvokeInt(GetMenuName(), GetInstanceTarget(functionName), value)
endFunction

; DOC
function InvokeInstanceIntArray(string functionName, int[] values) global
    UI.InvokeIntA(GetMenuName(), GetInstanceTarget(functionName), values)
endFunction

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Console Getter Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Console Instance Getter Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Console Setter Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Console Instance Setter Functions
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


; DOC
string function GetString(string target) global
    return UI.GetString(GetMenuName(), GetTarget(target))
endFunction

; DOC
function SetString(string target, string value) global
    UI.SetString(GetMenuName(), GetTarget(target), value)
endFunction

; DOC
string function GetInstanceString(string target) global
    return UI.GetString(GetMenuName(), GetInstanceTarget(target))
endFunction

; DOC
function SetInstanceString(string target, string value) global
    UI.SetString(GetMenuName(), GetInstanceTarget(target), value)
endFunction

; DOC
bool function GetBool(string target) global
    return UI.GetBool(GetMenuName(), GetTarget(target))
endFunction

; DOC
function SetBool(string target, bool value) global
    UI.SetBool(GetMenuName(), GetTarget(target), value)
endFunction

; DOC
bool function GetInstanceBool(string target) global
    return UI.GetBool(GetMenuName(), GetInstanceTarget(target))
endFunction

; DOC
function SetInstanceBool(string target, bool value) global
    UI.SetBool(GetMenuName(), GetInstanceTarget(target), value)
endFunction

; DOC
int function GetInt(string target) global
    return UI.GetInt(GetMenuName(), GetTarget(target))
endFunction

; DOC
function SetInt(string target, int value) global
    UI.SetInt(GetMenuName(), GetTarget(target), value)
endFunction

; DOC
int function GetInstanceInt(string target) global
    return UI.GetInt(GetMenuName(), GetInstanceTarget(target))
endFunction

; DOC
function SetInstanceInt(string target, int value) global
    UI.SetInt(GetMenuName(), GetInstanceTarget(target), value)
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