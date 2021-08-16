scriptName ___consoleHelper___ extends ReferenceAlias  
{[INTERNAL] Allows ConsoleHelper to register to OnPlayerLoadGame events, e.g. to perform mod upgrade operations}

event OnPlayerLoadGame()
    __consoleHelper__.GetInstance().ClearCache()
endEvent