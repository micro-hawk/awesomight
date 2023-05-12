#!/bin/bash
#
## Installer Script

## Colors ----------------------------
Color_Off='\033[0m'
BBlack='\033[1;30m' BRed='\033[1;31m' BGreen='\033[1;32m' BYellow='\033[1;33m'
BBlue='\033[1;34m' BPurple='\033[1;35m' BCyan='\033[1;36m' BWhite='\033[1;37m'

## Notations ----------------------------
# [*] Installing
# [!] Failed Command
# [::] Reading Input

## Directories ----------------------------
DIR=$(pwd)
FONT_DIR="$HOME/.fonts"
ICON_DIR="$HOME/.icons"
THEME_DIR="$HOME/.themes"
ROFI_DIR="$HOME/.config/rofi"
PICOM_DIR="$HOME/.config/picom"

install_paru_bin() {
    if command -v paru &>/dev/null; then
        echo -e ${BRed}"[!] Removing Paru\n" ${Color_Off}
        sudo pacman -Rcns paru
        echo "paru has been removed successfully."
    else
        sudo pacman -S git --noconfirm --needed
    fi

    echo -e ${BBlue}"\n[*] Installing paru-bin..." ${Color_Off}
    mkdir -p $HOME/aur && rm -rf $HOME/aur/paru-bin
    git clone https://aur.archlinux.org/paru-bin.git $HOME/aur/paru-bin
    cd $HOME/aur/paru-bin/

    if makepkg -sci --noconfirm --needed; then
        echo -e ${BGreen}"[*] Successfully Installed.\n" ${Color_Off}
    else
        echo -e ${BRed}"[!] Failed to install.\n" ${Color_Off}
        exit 1
    fi
}

install_pklist() {
    echo -e ${BBlue}"\n[*] Installing Pkglist..." ${Color_Off}
    if paru -S $(cat $DIR/pkglist) --noconfirm --needed; then
        echo -e ${BGreen}"[*] Successfully Installed.\n" ${Color_Off}
    else
        echo -e ${BRed}"[!] Failed to install.\n" ${Color_Off}
        exit 1
    fi

}

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
    {
        mkdir -p "$ROFI_DIR"
        cp -rf $DIR/dotfiles/.config/rofi/* "$ROFI_DIR"
    }

    if [[ -f "$ROFI_DIR/config.rasi" ]]; then
        echo -e ${BGreen}"[*] Successfully Installed.\n" ${Color_Off}
        exit 0
    else
        echo -e ${BRed}"[!] Failed to install.\n" ${Color_Off}
        exit 1
    fi
}

install_zsh_plugins() {
    echo -e ${BBlue}"\n[*] Installing ZSH Plugins..." ${Color_Off}
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-autosuggestions \
        ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
}

install_vim_plugins() {
    echo -e ${BBlue}"\n[*] Installing Plugin Manager..." ${Color_Off}
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    echo -e ${BBlue}"\n[*] Installing Plugin for VIM..." ${Color_Off}
    if vim +PlugUpdate +qall; then
        echo -e ${BGreen}"[*] Successfully Installed.\n" ${Color_Off}
    else
        echo -e ${BRed}"[!] Failed to install vim plugins.\n" ${Color_Off}
    fi
}

install_picom() {
    if [[ -d "$PICOM_DIR" ]]; then
        echo -e ${BPurple}"[*] Creating a backup of your picom configs..." ${Color_Off}
        mv "$PICOM_DIR" "${PICOM_DIR}.${USER}"
    fi
    echo -e ${BYellow}"[!] Note - Picom Animation don't support blur effect.\n" ${Color_Off}
    read -e -p "[::] Enter type of picom config (Animation[A]/Blur[B]): " AB_PICOM
    case $AB_PICOM in
    [aA])
        echo -e ${BBlue}"\n[*] Installing Picom with Animation..." ${Color_Off}
        paru -Rcns picom-ibhagwan-git --noconfirm --needed
        paru -S picom-pijulius-git --noconfirm --needed
        {
            mkdir -p "$PICOM_DIR"
            cp -rf $DIR/picom/picom-animations.conf "$PICOM_DIR/picom.conf"
        }
        ;;
    [bB])
        echo -e ${BBlue}"\n[*] Installing Picom with Blur Effect..." ${Color_Off}
        paru -Rcns picom-pijulius-git --noconfirm --needed
        paru -S picom-ibhagwan-git --noconfirm --needed
        {
            mkdir -p "$PICOM_DIR"
            cp -rf $DIR/picom/picom-blur.conf "$PICOM_DIR/picom.conf"
        }
        ;;
    *)
        echo -e ${BRed}"[!] Failed to install.\n" ${Color_Off}
        exit 1
        ;;
    esac

}

# Main
# main() {
#     install_vim_plugins
# }

# main
