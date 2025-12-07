#Requires AutoHotkey v2.0.0+
#Include "%A_ScriptDir%"
#Include ".\lib\Gdip_All.ahk" ;  Tested with https://github.com/buliasz/AHKv2-Gdip/blob/8960b875c4f1064865b51c72978d61e6648c0343/Gdip_All.ahk
#Include ".\lib\ImagePut.ahk" ;  Tested with https://github.com/iseahound/ImagePut/blob/d37dd55dd83902f31f1f18502db08b2d49d2b498/ImagePut.ahk
getQuantowerKeybdBtnToggleState()    {
    static init:=false, bufNeedleOff, bufNeedleOn
        ,DPI_AWARENESS_CONTEXT_UNAWARE:=-1
    getWindowDpiAwarenessContextIgnoringInfoFlag(hWnd)    {
        areDpiAwarenessContextsEqual(dpiContextA, dpiContextB)    {
            return dllCall("User32.dll\AreDpiAwarenessContextsEqual", "Ptr",dpiContextA, "Ptr",dpiContextB)
        }
        getWindowDpiAwarenessContext(hWnd)    {
            return dllCall("User32.dll\GetWindowDpiAwarenessContext", "Ptr",hWnd, "Ptr")
        }
        if (dpiContextA:=getWindowDpiAwarenessContext(hWnd))    {
            loop 5    {
                dpiContextB:=-1*A_Index
                if (areDpiAwarenessContextsEqual(dpiContextA,dpiContextB))
                    return dpiContextB
            }
        }
        return false
    }
    if (!init)    {
        init:=true
        if (!fileExist(pathOff:=A_Temp "\quantower-keybd-btn-off.png"))
            download("https://raw.githubusercontent.com/SevenKeyboard/get-quantower-keybd-btn-toggle-state/main-ahkv2.0/quantower-keybd-btn-off.png", pathOff)
        if (!fileExist(pathOn:=A_Temp "\quantower-keybd-btn-on.png"))
            download("https://raw.githubusercontent.com/SevenKeyboard/get-quantower-keybd-btn-toggle-state/main-ahkv2.0/quantower-keybd-btn-on.png", pathOn)
        bufNeedleOff:=ImagePutBuffer(pathOff)
        bufNeedleOn:=ImagePutBuffer(pathOn)
    }
    prevTMM:=setTitleMatchMode("RegEx")
    hWnd:=winExist("ahk_class ^HwndWrapper\[Starter")
    setTitleMatchMode(prevTMM)
    /*
    Chart
    ahk_class HwndWrapper[Starter;;0868b63c-43fa-412f-9089-77cadc9056b2]
    ahk_exe Starter.exe
    */
    if (!hWnd) || (getWindowDpiAwarenessContextIgnoringInfoFlag(hWnd)!==DPI_AWARENESS_CONTEXT_UNAWARE)
        return -2
    winGetPos(&winX, &winY, &winW, &winH, hWnd)
    if (windowDpiScale:=dllCall("User32.dll\GetDpiForWindow", "Ptr",hwnd, "UInt")/A_ScreenDPI)
        winW:=round(winW*windowDpiScale), winH:=round(winH*windowDpiScale)
    ;------------------
    hbm:=CreateDIBSection(winW, winH), hdc:=CreateCompatibleDC(), obm:=SelectObject(hdc, hbm)
    PrintWindow(hwnd, hdc)
    pHaystack:=Gdip_CreateBitmapFromHBITMAP(hbm)
    SelectObject(hdc, obm), DeleteObject(hbm), DeleteDC(hdc)
    bufHaystack:=ImagePutBuffer(pHaystack)
    loop 1    {
        state:=-1
        variation:=5 ;  I thought a little variation wouldn't be necessary, but it is needed. I'm not sure why.
        if (xys:=bufHaystack.ImageSearchAll(bufNeedleOff,variation))    {
            if (xys.length)    {
                state:=0
                break
            }
        }
        if (xys:=bufHaystack.ImageSearchAll(bufNeedleOn,variation))    {
            if (xys.length)    {
                state:=1
                break
            }
        }
    }
    Gdip_DisposeImage(pHaystack)
    return state
}