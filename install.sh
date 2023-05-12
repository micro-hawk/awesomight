#!/bin/bash
#
## Installer Script

## Colors ----------------------------
Color_Off='\033[0m'
BBlack='\033[1;30m' BRed='\033[1;31m'    BGreen='\033[1;32m' BYellow='\033[1;33m'
BBlue='\033[1;34m'  BPurple='\033[1;35m' BCyan='\033[1;36m'  BWhite='\033[1;37m'

## Directories ----------------------------
DIR=`pwd`
FONT_DIR="$HOME/.fonts"
ICON_DIR="$HOME/.icons"
THEME_DIR="$HOME/.themes"
ROFI_DIR="$HOME/.config/rofi"

# Installing Fonts
install_fonts() {
	echo -e ${BBlue}"\n[*] Installing fonts..." ${Color_Off}
	if [[ -d "$FONT_DIR" ]]; then
		cp -rf $DIR/fonts/* "$FONT_DIR"
	else
		mkdir -p "$FONT_DIR"
		cp -rf $DIR/fonts/* "$FONT_DIR"
	fi
	echo -e ${BYellow}"[*] Updating font cache...\n" ${Color_Off}
	fc-cache
}

# Installing Icons
install_icons() {
	echo -e ${BBlue}"\n[*] Installing icons..." ${Color_Off}
	if [[ ! -d "$ICON_DIR" ]]; then
		mkdir -p "$ICON_DIR"
    fi
    cp -rf $DIR/icons/* "$ICON_DIR"
    echo -e ${BGreen}"[*] Successfully Installed.\n" ${Color_Off}
}

# Installing GTK Themes
install_themes() {
	echo -e ${BBlue}"\n[*] Installing themes..." ${Color_Off}
	if [[ ! -d "$THEME_DIR" ]]; then
		mkdir -p "$THEME_DIR"
    fi
    cp -rf $DIR/gtk-themes/* "$THEME_DIR"
    echo -e ${BGreen}"[*] Successfully Installed.\n" ${Color_Off}
}

# Install Rofi Themes
install_rofi_themes() {
	if [[ -d "$ROFI_DIR" ]]; then
		echo -e ${BPurple}"[*] Creating a backup of your rofi configs..." ${Color_Off}
		mv "$ROFI_DIR" "${ROFI_DIR}.${USER}"
	fi
	echo -e ${BBlue}"[*] Installing rofi configs..." ${Color_Off}
	{ mkdir -p "$ROFI_DIR"; cp -rf $DIR/dotfiles/.config/rofi/* "$ROFI_DIR"; }

	if [[ -f "$ROFI_DIR/config.rasi" ]]; then
		echo -e ${BGreen}"[*] Successfully Installed.\n" ${Color_Off}
		exit 0
	else
		echo -e ${BRed}"[!] Failed to install.\n" ${Color_Off}
		exit 1
	fi
}

# Main
main() {
    # install_themes
}

main
