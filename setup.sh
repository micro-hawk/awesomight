#!/bin/bash
#
## Archlinux based Installer script

## Colors ----------------------------
Color_Off='\033[0m'
BBlack='\033[1;30m' BRed='\033[1;31m' BGreen='\033[1;32m' BYellow='\033[1;33m'
BBlue='\033[1;34m' BPurple='\033[1;35m' BCyan='\033[1;36m' BWhite='\033[1;37m'

echo -e ${BPurple}"

░█▀▀█ █░░░█ █▀▀ █▀▀ █▀▀█ █▀▄▀█ ░▀░ █▀▀▀ █░░█ ▀▀█▀▀ 
▒█▄▄█ █▄█▄█ █▀▀ ▀▀█ █░░█ █░▀░█ ▀█▀ █░▀█ █▀▀█ ░░█░░ 
▒█░▒█ ░▀░▀░ ▀▀▀ ▀▀▀ ▀▀▀▀ ▀░░░▀ ▀▀▀ ▀▀▀▀ ▀░░▀ ░░▀░░

" ${Color_Off}

## Notations ----------------------------
# [*] Installing
# [!] Failed Command
# [::] Reading Input

pre_validation() {
    # Checking internet connection
    echo -e ${BCyan}"\n[*] Checking internet connection..."
    ping -c 1 google.com >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo -e ${BGreen} "Internet connection is available."
    else
        echo -e ${BRed}"[!] Internet connection is not available. Please check your network connection."
        exit 1
    fi

    # Checking package manager
    echo -e ${BCyan}"[*] Checking package manager..."
    if ! command -v pacman &>/dev/null; then
        echo -e ${BRed} "[!] This script is only compatible with the pacman package manager. Exiting..."
        exit 1
    fi
}

## Directories ----------------------------
DIR=$(pwd)
FONT_DIR="$HOME/.fonts"
ICON_DIR="$HOME/.icons"
THEME_DIR="$HOME/.themes"
ROFI_DIR="$HOME/.config/rofi"
PICOM_DIR="$HOME/.config/picom"

# Checking paru-bin
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

# Installing Arch packages
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

# Backingup Old Configs
backup_configs() {
    echo -e ${BPurple}"[*] Backing up existing files..." ${Color_Off}
    mv -iv ~/.config/alacritty ~/.config/alacritty.old
    mv -iv ~/.config/awesome ~/.config/awesome.old
    mv -iv ~/.config/cava ~/.config/cava.old
    mv -iv ~/.config/htop ~/.config/htop.old
    mv -iv ~/.config/kitty ~/.config/kitty.old
    mv -iv ~/.config/neofetch ~/.config/neofetch.old
    mv -iv ~/.config/ranger ~/.config/ranger.old
    mv -iv ~/.config/Thunar ~/.config/Thunar.old
    mv -iv ~/.bashrc ~/.bashrc.old
    mv -iv ~/.vimrc ~/.vimrc.old
    mv -iv ~/.zshrc ~/.zshrc.old
    mv -iv ~/.zsh-aliases ~/.zsh-aliases.old
}

# Linking configs
setup_symlinks() {
    echo -e ${BBlue}"[*] Setting up symlinks..."${Color_Off}
    ln -sfnv "$PWD/dotfiles/.config/alacritty/" ~/.config/
    ln -sfnv "$PWD/dotfiles/.config/awesome/" ~/.config/
    ln -sfnv "$PWD/dotfiles/.config/cava/" ~/.config/
    ln -sfnv "$PWD/dotfiles/.config/htop/" ~/.config/
    ln -sfnv "$PWD/dotfiles/.config/kitty" ~/.config/
    ln -sfnv "$PWD/dotfiles/.config/neofetch" ~/.config/
    ln -sfnv "$PWD/dotfiles/.config/ranger/" ~/.config/
    ln -sfnv "$PWD/dotfiles/.config/Thunar/" ~/.config/
    ln -sfnv "$PWD/dotfiles/.bashrc" ~/
    ln -sfnv "$PWD/dotfiles/.vimrc" ~/
    ln -sfnv "$PWD/dotfiles/.zshrc" ~/
    ln -sfnv "$PWD/dotfiles/.zsh-aliases/" ~/
}

# Installing Powerlevel10k ZSH
install_powerlevel10k() {
    echo -e ${BBlue}"\n[*] Installing ZSH with Powerlevel10k..." ${Color_Off}
    zsh
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
}

# Installing ZSH Plugins
install_zsh_plugins() {
    echo -e ${BBlue}"\n[*] Installing ZSH Plugins..." ${Color_Off}
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
        ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-autosuggestions \
        ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
}

# Installing VIM Plugins
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

# Installing PICOM Compositor
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

# Setup Awesomight
main() {
    pre_validation
    install_paru_bin
    echo -e ${BBlue}"[*] Setting up Awesomight..."${Color_Off}
    install_pklist
    install_fonts
    install_icons
    install_themes
    install_rofi_themes
    backup_configs
    setup_symlinks
    install_powerlevel10k
    install_zsh_plugins
    install_vim_plugins
    install_picom
    echo -e ${BGreen}"=== Successfully Installed ===" ${Color_Off}
}

if [ "$1" = "--all" -o "$1" = "-a" ]; then
    main
    exit 0
fi

# Menu TUI
echo -e ${BWhite}"Select an option:"${Color_Off}
echo -e ${BBlue}"  (0) Setup everything(recommended) "${Color_Off}
echo -e ${BBlue}"  (1) Install paru-bin "${Color_Off}
echo -e ${BBlue}"  (2) Install packages "${Color_Off}
echo -e ${BBlue}"  (3) Install Fonts "${Color_Off}
echo -e ${BBlue}"  (4) Install Icons & Themes "${Color_Off}
echo -e ${BBlue}"  (5) Install Rofi Themes "${Color_Off}
echo -e ${BBlue}"  (6) Backup current config "${Color_Off}
echo -e ${BBlue}"  (7) Setup symlinks "${Color_Off}
echo -e ${BBlue}"  (8) Setup Picom Compositor "${Color_Off}
echo -e ${BBlue}"  (9) Install Powerlevel10k & ZSH-Plugins "${Color_Off}
echo -e ${BBlue}"  (10) Install vim plugins "${Color_Off}
echo -e ${BRed}"  (*) Anything else to exit "${Color_Off}

echo -en ${BGreen}" ==> "${Color_Off}

read -r option

case $option in

"0")
    main
    ;;

"1")
    install_paru_bin
    ;;

"2")
    install_pklist
    ;;

"3")
    install_fonts
    ;;

"4")
    install_themes
    install_icons
    ;;

"5")
    install_rofi_themes
    ;;

"6")
    backup_configs
    ;;

"7")
    setup_symlinks
    ;;

"8")
    install_picom
    ;;

"9")
    install_powerlevel10k
    install_zsh_plugins
    ;;

"10")
    install_vim_plugins
    ;;

*)
    echo -e ${BRed}"Invalid option entered, Bye!"${Color_Off}
    exit 0
    ;;
esac

exit 0
