# get-quantower-keybd-btn-toggle-state

This repository provides an AutoHotkey v2 helper function `getQuantowerKeybdBtnToggleState()` that determines whether the **KEYBOARD** button in a [Quantower](https://www.quantower.com/) chart window is currently **Off** or **On**.

The function was originally written as a response to this AutoHotkey forum post:  
[Imagesearch shades of variation for a very small icon](https://www.autohotkey.com/boards/viewtopic.php?f=82&t=128626)

On first run, the script downloads small reference images (Off / On) for the [Quantower](https://www.quantower.com/) button from this GitHub repository and caches them in the user’s temporary folder. It then captures the Quantower chart window and performs an image search to detect the current toggle state.

Return values:

- `-2` – Quantower chart window could not be found  
- `-1` – Unknown state  
- `0`  – Button is Off  
- `1`  – Button is On  

---

![quantower-keybd-btn-state-0.png](https://raw.githubusercontent.com/SevenKeyboard/get-quantower-keybd-btn-toggle-state/main/docs/quantower-keybd-btn-state-0.png)
![quantower-keybd-btn-state-1.png](https://raw.githubusercontent.com/SevenKeyboard/get-quantower-keybd-btn-toggle-state/main/docs/quantower-keybd-btn-state-1.png)
