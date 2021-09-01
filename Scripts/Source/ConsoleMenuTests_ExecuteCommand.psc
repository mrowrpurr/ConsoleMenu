scriptName ConsoleMenuTests_ExecuteCommand extends ConsoleMenuTest
{Tests for ExecuteCommand}

function Tests()
    Example("Get the result from running command").Fn(GetResult_Test())
    Example("Don't get result from running command").Fn(DontGetResult_Test())
    Example("Print executed command to console").Fn(PrintCommandToConsole_Test())
    Example("Don't print executed command to console").Fn(DontPrintCommandToConsole_Test())
    Example("Add executed command to history").Fn(AddExecutedCommandToHistory_Test())
    Example("Don't add executed command to history").Fn(DontAddExecutedCommandToHistory_Test())

    Example("player.showinventory").Fn(Example_ShowInventory_Test())
endFunction

function GetResult_Test()
    ExpectString(ConsoleMenu.GetBodyText()).To(BeEmpty())

    string output = ConsoleMenu.ExecuteCommand("just some gibberish")

    string expectedOutput = "Script command \"just\" not found."
    ExpectString(output).To(ContainText(expectedOutput))
    ExpectString(ConsoleMenu.GetBodyText()).Not().To(BeEmpty())
    ExpectString(ConsoleMenu.GetBodyText()).To(ContainText(expectedOutput))
endFunction

function DontGetResult_Test()
    ExpectString(ConsoleMenu.GetBodyText()).To(BeEmpty())

    string output = ConsoleMenu.ExecuteCommand("just some gibberish", getResult = false)

    string expectedOutput = ""
    ExpectString(output).To(EqualString(expectedOutput))
    ExpectString(ConsoleMenu.GetBodyText()).Not().To(BeEmpty())
    ExpectString(ConsoleMenu.GetBodyText()).To(ContainText(expectedOutput))
endFunction

function PrintCommandToConsole_Test()
    ExpectString(ConsoleMenu.GetBodyText()).To(BeEmpty())

    string output = ConsoleMenu.ExecuteCommand("foo bar baz", printCommand = false)

    string expectedOutput = "Script command \"foo\" not found."
    ExpectString(output).To(ContainText(expectedOutput))
    ExpectString(output).Not().To(ContainText("bar baz"))
    ExpectString(ConsoleMenu.GetBodyText()).To(ContainText(expectedOutput))
    ExpectString(ConsoleMenu.GetBodyText()).Not().To(ContainText("bar baz"))
endFunction

function DontPrintCommandToConsole_Test()
    ExpectString(ConsoleMenu.GetBodyText()).To(BeEmpty())

    ConsoleMenu.ExecuteCommand("foo bar baz", printCommand = true)

    string expectedOutput = "Script command \"foo\" not found."
    ExpectString(ConsoleMenu.GetBodyText()).To(ContainText(expectedOutput))
    ExpectString(ConsoleMenu.GetBodyText()).To(ContainText("bar baz"))
endFunction

function AddExecutedCommandToHistory_Test()
    int beforeHistoryLength = ConsoleMenu.GetCommandHistoryLength()

    ConsoleMenu.ExecuteCommand("foo bar baz", addToHistory = true)

    int afterHistoryLength = ConsoleMenu.GetCommandHistoryLength()
    ExpectInt(afterHistoryLength).To(EqualInt(beforeHistoryLength + 1))
    string mostRecentCommand = ConsoleMenu.GetMostRecentCommandHistoryItem()
    ExpectString(mostRecentCommand).To(EqualString("foo bar baz"))
endFunction

function DontAddExecutedCommandToHistory_Test()
    int beforeHistoryLength = ConsoleMenu.GetCommandHistoryLength()

    ConsoleMenu.ExecuteCommand("foo bar baz", addToHistory = false)

    int afterHistoryLength = ConsoleMenu.GetCommandHistoryLength()
    ExpectInt(afterHistoryLength).To(EqualInt(beforeHistoryLength))
endFunction

function Example_ShowInventory_Test()
    Form goblet = Game.GetForm(0x98620) ; "Goblet"

    Actor player = Game.GetPlayer()
    player.RemoveItem(goblet, player.GetItemCount(goblet))

    string output = ConsoleMenu.ExecuteCommand("player.showinventory")
    ExpectString(output).Not().To(ContainText("98620"))

    player.AddItem(goblet)

    output = ConsoleMenu.ExecuteCommand("player.showinventory")
    ExpectString(output).To(ContainText("98620"))

    player.RemoveItem(goblet)

    output = ConsoleMenu.ExecuteCommand("player.showinventory")
    ExpectString(output).Not().To(ContainText("98620"))
endFunction
