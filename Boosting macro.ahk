;----------------made by syspalk & suggested by sqyx----------------
global textcol := "cred"
Gui, Font, s10 bold
Gui, Color,black
;----------------CREATING THE GUI----------------
i := 0
loop 7{
	i++
	iniRead,timer,data.ini,timers,timer%i%
	IniRead,toggle,data.ini,toggles,toggle%i%
	IniRead,key,data.ini,keys,key%i%
	if (toggle){
		toggle := "Checked"
	}
	Gui, Add, Checkbox, x15 yp+34 %textcol% %toggle% vtoggle%i%,Hotbar slot %i%
	Gui, Add,Edit,number xp+120 yp-5 w100 vtimer%i% ,%timer%
	Gui, Add,Edit,limit1 xp+120 yp w30 vkey%i% ,%key%
	toggle%i%timer := 0
}
Gui, Font, s11
Gui, Add,Text,y8 x145 cblue,Delays (ms)     Hotkeys
Gui, Add,Text,y240 x15 cwhite,START : F1     STOP : F2     PAUSE : F3
Gui, Show,,Boosting Macro
;----------------MACRO HOTKEYS----------------
F2::
savedata()
reload
return
F3::Pause
return
GuiClose:
savedata()
ExitApp
F1::
savedata()
;----------------HOTKEY TIMERS----------------
loop{
	sleep 5
	i := 0
	loop 7{
		i++
		GuiControlGet,toggle%i%
		GuiControlGet,timer%i%
		GuiControlGet,key%i%
		toggle := toggle%i%
		timer := timer%i%
		key := key%i%
		if (toggle && A_TickCount - toggle%i%timer > timer){
			toggle%i%timer := A_TickCount
			Send %key%
		}
	}
}
;----------------FUNCTION FOR SAVING THE SETTINGS----------------
savedata(){
	i := 0
	loop 7{
		i++
		GuiControlGet,toggle%i%
		GuiControlGet,timer%i%
		GuiControlGet,key%i%
		toggle := toggle%i%
		timer := timer%i%
		key := key%i%
		IniWrite,%toggle%,data.ini,toggles,toggle%i%
		IniWrite,%timer%,data.ini,timers,timer%i%
		IniWrite,%key%,data.ini,keys,key%i%
	}
}