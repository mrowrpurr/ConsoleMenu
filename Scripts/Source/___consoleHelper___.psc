scriptName ___consoleHelper___ extends ReferenceAlias hidden
{[INTERNAL] Allows ConsoleHelper to register to OnPlayerLoadGame events, e.g. to perform mod upgrade operations}

event OnPlayerLoadGame()
    __consoleHelper__.GetInstance().ResetData()
endEvent