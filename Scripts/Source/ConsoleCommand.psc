scriptName ConsoleCommand extends Quest
{Extend this to create your own console command.

Brief Instructions: ...}

float property Version auto

function Command(string command, string description = "", string alias = "", string defaultSubcommand = "")
endFunction

function Subcommand(string subcommand, string description = "", string alias = "")
endFunction

function Print(string text)
endFunction

function Flag(string name, string description = "", string alias = "", string subcommand = "")
endFunction

bool function GetFlag(string flag)
    return false
endFunction

function OptionString(string name, string description = "", string alias = "", string subcommand = "", string default = "")
endFunction

function OptionInt(string name, string description = "", string alias = "", string subcommand = "", int default = 0)
endFunction

function OptionFloat(string name, string description = "", string alias = "", string subcommand = "", float default = 0.0)
endFunction

string function GetOptionString(string name)
    return ""
endFunction

int function GetOptionInt(string name)
    return 0
endFunction

float function GetOptionFloat(string name)
    return 0.0
endFunction
