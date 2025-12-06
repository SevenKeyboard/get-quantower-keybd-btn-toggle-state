#Requires AutoHotkey v2.0
#SingleInstance Force
#Include "%A_ScriptDir%"
#Include ".\lib\Gdip_All.ahk" ;  Tested with https://github.com/buliasz/AHKv2-Gdip/blob/8960b875c4f1064865b51c72978d61e6648c0343/Gdip_All.ahk
#Include ".\lib\getQuantowerKeybdBtnToggleState.ahk"

pToken:=Gdip_Startup(), onExit((*)=>Gdip_Shutdown(pToken))

F5::  {
    state := getQuantowerKeybdBtnToggleState()
    tooltip "state: " state
    /*
    -2      The window cannot be found.
    -1      Unknown
    0       Off
    1       On
    */
}