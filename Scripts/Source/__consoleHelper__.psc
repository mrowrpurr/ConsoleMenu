scriptName __consoleHelper__ extends Quest
{[INTERNAL] Allows ConsoleHelper to store persistent data and perform operations on Console open/close}

; Stores the currently installed version of ConsoleHelper
float property CurrentlyInstalledVersion auto

; Adds to the Papyrus logs with the prefix [ConsoleHelper]
function Log(string text) global
    Debug.Trace("[ConsoleHelper] " + text)
endFunction

function LogCustomSwfRequiredError(string functionName) global
    Log(functionName + " could not be called. Requires ConsoleHelper's custom console.swf which is not currently installed. Note: it should be build-in to the primary distributed ConsoleHelper mod.")
endFunction

event OnInit()
    ; Set the currently installed version of this mod on first-time mod initialization
    CurrentlyInstalledVersion = ConsoleHelper.GetConsoleHelperVersion()
    ResetInstallationChecksCache()
endEvent

; Helper to get an instance of __consoleHelper__ for use in the public ConsoleHelper interface
__consoleHelper__ function GetInstance() global
    return Game.GetFormFromFile(0x800, "ConsoleHelper.esp") as __consoleHelper__
endFunction

; Returns true if the currently console.swf used by the game is our customized version for ConsoleHelper
bool function GetIsConsoleHelperConsoleInstalled() global
    return GetInstance().IsConsoleHelperConsoleInstalled
endFunction

; Reset the caches of whether various things are installed
; Reset on original mod installation and then on player load game events
function ResetInstallationChecksCache()
    __isConsoleHelperConsoleInstalled = -1
    __isConsoleUtilInstalled = -1
endFunction

; Cache of whether the ConsoleHelper custom console.swf is installed
int property __isConsoleHelperConsoleInstalled auto

; Cache of whether ConsoleUtil is installed
; Provides PrintMessage and ExecuteCommand (in case our custom console is not available)
; Check via ConsoleUtil.GetVersion()
int property __isConsoleUtilInstalled auto

; Property which is true if the currently console.swf used by the game is our customized version for ConsoleHelper
bool property IsConsoleHelperConsoleInstalled
    bool function get()
        if __isConsoleHelperConsoleInstalled == -1
            bool isInstalled = ConsoleHelper.GetBool("IsConsoleHelperConsole")
            if isInstalled
                __isConsoleHelperConsoleInstalled = 1
            else
                __isConsoleHelperConsoleInstalled = 0
            endIf
        endIf
        return __isConsoleHelperConsoleInstalled == 1
    endFunction
endProperty

; Property which is true if ConsoleUtil is installed
bool property IsConsoleUtilInstalled
    bool function get()
        if __isConsoleUtilInstalled == -1
            int consoleUtilVersion = ConsoleUtil.GetVersion()
            if consoleUtilVersion == 0
                __isConsoleUtilInstalled = 0
            else
                __isConsoleUtilInstalled = 1
            endIf
        endIf
        return __isConsoleUtilInstalled == 1
    endFunction
endProperty
