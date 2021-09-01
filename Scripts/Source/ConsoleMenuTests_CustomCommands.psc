scriptName ConsoleMenuTests_CustomCommands extends ConsoleMenuTest
{Tests for the custom console command support in ConsoleMenu}

function Tests()
    Test("Custom console commands disabled").Fn(CustomConsoleCommands_Disabled_Test())
    Test("Custom console commands enabled").Fn(CustomConsoleCommands_Enabled_Test())
endFunction

function CustomConsoleCommands_Disabled_Test()
    ConsoleMenu.SetTextInputText("foo bar baz")
    Input.TapKey(28) ; Enter
    Utility.WaitMenuMode(0.1)

    string expectedOutput = "Script command \"foo\" not found."
    ExpectString(ConsoleMenu.GetBodyText()).To(ContainText(expectedOutput))
    ExpectString(ConsoleMenu.GetTextInputText()).To(BeEmpty())
endFunction

function CustomConsoleCommands_Enabled_Test()
    ConsoleMenu.RegisterForCustomCommands("MyCustomCommand")
    RegisterForModEvent("MyCustomCommand", "OnMyCustomCommand")

    ConsoleMenu.SetTextInputText("foo bar baz")
    Input.TapKey(28) ; Enter
    ConsoleMenu.Print("We pushed the button...")

    string expectedOutput = "Hi, you tried to run: foo bar baz"
    string unexpectedOutput = "Script command \"foo\" not found."
    ExpectString(ConsoleMenu.GetBodyText()).Not().To(ContainText(unexpectedOutput))
    ExpectString(ConsoleMenu.GetTextInputText()).To(BeEmpty())
    ExpectString(ConsoleMenu.GetBodyText()).To(ContainText(expectedOutput))

    ConsoleMenu.UnregisterForCustomCommands("MyCustomCommand")
    UnregisterForModEvent("MyCustomCommand")
endFunction

event OnMyCustomCommand(string eventName, string command, float _, Form sender)
    ConsoleMenu.Print("Hi, you tried to run: " + command)
endEvent
