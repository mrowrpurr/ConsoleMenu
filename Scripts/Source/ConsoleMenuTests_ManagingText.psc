scriptName ConsoleMenuTests_ManagingText extends ConsoleMenuTest
{Tests for setting, getting, and clearing text inputs}

function Tests()
    Test("Get and Set Header Text").Fn(GetSetHeaderTextTest())
    Test("Get and Set Body Text").Fn(GetSetBodyTextTest())
    Test("Get and Set TextInput Text").Fn(GetSetTextInputTextTest())
endFunction

function GetSetHeaderTextTest()
    ExpectString(ConsoleMenu.GetHeaderText()).To(BeEmpty())

    ConsoleMenu.SetHeaderText("Hello, Header!")

    ExpectString(ConsoleMenu.GetHeaderText()).To(EqualString("Hello, Header!"))
endFunction

function GetSetBodyTextTest()
    ExpectString(ConsoleMenu.GetBodyText()).To(BeEmpty())

    ConsoleMenu.SetBodyText("Hello, Body!")

    ExpectString(ConsoleMenu.GetBodyText()).To(EqualString("Hello, Body!"))
endFunction

function GetSetTextInputTextTest()
    ExpectString(ConsoleMenu.GetTextInputText()).To(BeEmpty())

    ConsoleMenu.SetTextInputText("Hello, TextInput!")

    ExpectString(ConsoleMenu.GetTextInputText()).To(EqualString("Hello, TextInput!"))
endFunction
