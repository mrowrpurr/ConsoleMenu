scriptName ConsoleTests_ShowHide extends Quest ; Lilac  
{Tests for showing and hiding the ~ console}

; function TestSuites()
;     describe("Show / Hide the Console", ShowAndHideTestGroup())
; endFunction

; function ShowAndHideTestGroup()
;     it("should be able to open the console", OpenConsoleTest())
;     it("should be able to close the console", CloseConsoleTest())
; endFunction

; function beforeEach()
;     if Console.IsOpen()
;         Console.Close()
;     endIf
; endFunction

; function OpenConsoleTest()
;     expectBool(Console.IsOpen(), to, beEqualTo, false)

;     Console.Open()
    
;     expectBool(Console.IsOpen(), to, beEqualTo, true)
; endFunction

; function CloseConsoleTest()
;     Console.Open()
;     expectBool(Console.IsOpen(), to, beEqualTo, true)

;     Console.Close()
    
;     expectBool(Console.IsOpen(), to, beEqualTo, false)
; endFunction
