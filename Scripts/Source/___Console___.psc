scriptName ___Console___ extends ReferenceAlias hidden
{[INTERNAL] Allows Console to register to OnPlayerLoadGame events, e.g. to perform mod upgrade operations}

event OnPlayerLoadGame()
    __Console__.GetInstance().ResetData()
endEvent