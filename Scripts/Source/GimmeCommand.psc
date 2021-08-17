scriptName GimmeCommand extends ConsoleCommand

; gimme --help
; gimme --version
; gimme gold 100 -s / --silent
; gimme gold -n / --amount 100

event Config()
    Version = 1.0
    Command("gimme", "Gives the player stuff!", alias = "g")
    Subcommand("gold", "Gives the specified amount of gold to the player (default: 100)", alias = "g")
    Subcommand("lockpicks", "Gives the specified amount of lockpicks to the player (default: 100)", alias = "l")
    Flag("silent", "When provided, adds the item(s) without notification", alias = "s")
    OptionFloat("multiplier", "Will multiply the amount by this number", alias = "m", subcommand = "gold", default = 1.0)
endEvent

event OnCommand(string command, string subcommand, string[] arguments)
    if subcommand == "gold"
        GiveGold(arguments[0] as int)
    elseIf subcommand == "lockpicks"
        GiveLockpicks(arguments[0] as int)
    else
        Print("Command not found: " + subcommand)
    endIf
endEvent

function GiveGold(int amount)
    if amount == 0
        amount = 100
    endIf
    amount = amount * GetOptionFloat("multiplier") as int
    Game.GetPlayer().AddItem(Game.GetForm(0xf), amount, abSilent = GetFlag("silent"))
    Print("Gave player " + amount + " gold")
endFunction

function GiveLockpicks(int amount)
    if amount == 0
        amount = 100
    endIf
    Game.GetPlayer().AddItem(Game.GetForm(0xa), amount, abSilent = GetFlag("silent"))
    Print("Gave player " + amount + " lockpick(s)")
endFunction
