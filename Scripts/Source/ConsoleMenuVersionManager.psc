scriptName ConsoleMenuVersionManager extends ReferenceAlias hidden
{[INTERNAL] Allows ConsoleMenu to register to OnPlayerLoadGame events, e.g. to perform mod upgrade operations}

event OnPlayerLoadGame()
    ConsoleMenuPrivateAPI.GetInstance().ResetData()
endEvent