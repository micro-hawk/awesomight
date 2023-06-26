<div align="center">

# 🌸**AWESOMIGHT**🌸

![GitHub Repo stars](https://img.shields.io/github/stars/micro-hawk/awesomight?style=for-the-badge&color=f7768e) ![GitHub last commit](https://img.shields.io/github/last-commit/micro-hawk/awesomight?style=for-the-badge&color=f7768e) ![GitHub repo size](https://img.shields.io/github/repo-size/micro-hawk/awesomight?style=for-the-badge&color=f7768e)


<br/>

![Screenshot of my desktop](/dotfiles/.config/awesome/themes/tokyo-night/tokyo-night/Screenshots/desktop.png)

![Screenshot of my desktop](/dotfiles/.config/awesome/themes/tokyo-night/tokyo-night/Screenshots/vimrc.png)

![Screenshot of my desktop](/dotfiles/.config/awesome/themes/tokyo-night/tokyo-night/Screenshots/workspace.png)

</div>


# Features

* Simple enough for beginner's but flexible enough for the power user.
* Extremely customizable, maybe more so than any other window manager.
* Configured in Lua.
* A documented API to configure and define the behavior of your window manager.

# Arch-Based Installation
```bash
sh setup.sh
```

Usage:  `./setup.sh`  **[OPTIONS...]**

```
-a, --all All          Install all the packages and configure
```

For example: install all themes

```sh
./setup.sh --all
```

> **NOTE** - While installing [Picom](https://github.com/yshui/picom), it will ask for blur effect or animations like Hyprland. 

### For [Blur Effect](/picom/picom-blur.conf): 
    paru -S picom-ibhagwan-git
### For [Animations](/picom/picom-animations.conf): 
    paru -S picom-pijulius-git
<br>

# Manual Installation

```bash
sudo pacman -S awesome dmenu rofi firefox kitty pasystray volumeicon
```

```bash
paru -S i3lock-fancy-git picom-ibhagwan-git thunar-extended
```
### Personalizing Tools

```bash
sudo pacman -S lxappearance nitrogen
```
### Install Fonts

```bash
paru -S terminus-font consolas-font ttf-firacode-nerd noto-fonts noto-fonts-cjk noto-fonts-emoji noto-fonts-extra
```

# My Keybindings

The MODKEY is set to the Super key (aka the Windows key).  I try to keep the
keybindings consistent with all of my window managers.

| Keybinding | Action |
| :--- | :--- |
| `MODKEY + RETURN` | opens terminal (Kitty is the terminal but can be easily changed) |
| `MODKEY + x` | opens run launcher (rofi (random) is the run launcher but can be easily changed) |
| `MODKEY + SHIFT + c` | closes window with focus |
| `MODKEY + SHIFT + r` | restarts awesome |
| `MODKEY + CTRL + q` | quits awesome |
| `MODKEY + 1-5` | switch focus to workspace (1-5) |
| `MODKEY + SHIFT + 1-5` | send focused window to workspace (1-5) |
| `MODKEY + m` | maximized focused window |
| `MODKEY + d` | minimize focused window  |
| `MODKEY + CTRL + d` | restore recent minimize window |
| `ALTKEY + SHIFT + LeftArrow` | Resize window to Left side  |
| `ALTKEY + SHIFT + RightArrow` | Resize window to Right side  |
| `MODKEY + j` | switches focus between windows in the stack, going down |
| `MODKEY + k` | switches focus between windows in the stack, going up |
| `MODKEY + h` | switches focus between windows in the stack, going left |
| `MODKEY + l` | switches focus between windows in the stack, going right |
| `MODKEY + SHIFT + j` | rotates the windows in the stack, going down|
| `MODKEY + SHIFT + k` | rotates the windows in the stack, going up |
| `MODKEY + SHIFT + h` | rotates the windows in the stack, going left|
| `MODKEY + SHIFT + l` | rotates the windows in the stack, going right |
| `MODKEY + period` | switch focus to next monitor |
| `MODKEY + comma` | switch focus to prev monitor |
| `MODKEY + SHIFT + w` | opens default web-browser |





## Getting Help With Awesome

#### IRC

You can join the `#awesome` channel on the [OFTC](http://www.oftc.net/) IRC network.

[IRC Webchat](https://webchat.oftc.net/?channels=awesome)

#### Stack Overflow
You can ask questions on [Stack Overflow](http://stackoverflow.com/questions/tagged/awesome-wm).

#### Reddit
There is an [awesome subreddit](https://www.reddit.com/r/awesomewm/) where you can share your work and ask questions.

## Reporting issues

Please report any issues you have with AwesomeWM on [our bugtracker](https://github.com/awesomeWM/awesome/issues).

## Contributing code

You can submit pull requests on the [github repository](https://github.com/awesomeWM/awesome).
Please read the [contributing guide](https://github.com/awesomeWM/awesome/blob/master/docs/02-contributing.md) for any coding, documentation or patch guidelines.

## Documentation

Online documentation is available [here](https://awesomewm.org/apidoc/).

## License
The content in this repository is licensed under the [MIT License](/LICENSE). You are free to use, modify, and distribute the resources and configurations as per the terms of the license.

## Disclaimer
⚠️ Please be aware that the software is maintained by a sole developer, which means there may be some bugs present. Please proceed with caution when using it.

    