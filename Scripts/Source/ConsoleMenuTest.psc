scriptName ConsoleMenuTest extends SkyUnitTest hidden
{Base script for all ConsoleMenu tests}

function BeforeAll()
    ConsoleMenu.Open(force = true)
    Utility.WaitMenuMode(0.2)
endFunction

function AfterAll()
    ConsoleMenu.Close(force = true)
endFunction

function BeforeEach()
    ConsoleMenu.ClearAllText()
endFunction
