scriptName __consoleHelper__ extends Quest
{[INTERNAL] Allows ConsoleHelper to store persistent data and perform operations on Console open/close}

; Stores the currently installed version of ConsoleHelper
float property CurrentlyInstalledVersion auto

event OnInit()
    ; Set the currently installed version of this mod on first-time mod initialization
    CurrentlyInstalledVersion = ConsoleHelper.GetCurrentVersion()
endEvent

; Helper to get an instance of __consoleHelper__ for use in the public ConsoleHelper interface
__consoleHelper__ function GetInstance() global
    return Game.GetFormFromFile(0x800, "ConsoleHelper.esp") as __consoleHelper__
endFunction

; Returns true if the currently console.swf used by the game is our customized version for ConsoleHelper
bool function GetIsConsoleHelperConsoleInstalled() global
    return GetInstance().IsConsoleHelperConsoleInstalled
endFunction

int __isConsoleHelperConsoleInstalled = -1 ; -1 means that we have not checked yet

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