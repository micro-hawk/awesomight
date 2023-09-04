#!/bin/bash

# Colors
Color_Off='\033[0m'
BBlack='\033[1;30m'
BRed='\033[1;31m'
BGreen='\033[1;32m'
BYellow='\033[1;33m'
BBlue='\033[1;34m'
BPurple='\033[1;35m'
BCyan='\033[1;36m'
BWhite='\033[1;37m'

# Logo
function print_logo() {
    echo -e "${BPurple}"
    cat << "EOF"
░█▀▀█ █░░░█ █▀▀ █▀▀ █▀▀█ █▀▄▀█ ░▀░ █▀▀▀ █░░█ ▀▀█▀▀
▒█▄▄█ █▄█▄█ █▀▀ ▀▀█ █░░█ █░▀░█ ▀█▀ █░▀█ █▀▀█ ░░█░░
▒█░▒█ ░▀░▀░ ▀▀▀ ▀▀▀ ▀▀▀▀ ▀░░░▀ ▀▀▀ ▀▀▀▀ ▀░░▀ ░░▀░░
EOF
    echo -e "${Color_Off}"
}

# Check internet connection
function check_internet() {
    echo -e "${BCyan}[*] Checking internet connection..."
    ping -c 1 google.com >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        echo -e "${BGreen}Internet connection is available.${Color_Off}"
    else
        echo -e "${BRed}[!] Internet connection is not available. Please check your network connection."
        exit 1
    fi
}

# Check package manager
function check_package_manager() {
    echo -e "${BCyan}[*] Checking package manager..."
    if ! command -v pacman &>/dev/null; then
        echo -e "${BRed}[!] This script is only compatible with the pacman package manager. Exiting..."
        exit 1
    fi
}

# Install paru-bin
function install_paru_bin() {
    if command -v paru &>/dev/null; then
        echo -e "${BRed}[!] Removing Paru${Color_Off}"
        sudo pacman -Rcns paru
        echo "paru has been removed successfully."
    else
        sudo pacman -S git --noconfirm --needed
    fi

    echo -e "${BBlue}\n[*] Installing paru-bin...${Color_Off}"
    local aur_dir="$HOME/aur/paru-bin"
    mkdir -p "$aur_dir"
    rm -rf "$aur_dir"
    git clone https://aur.archlinux.org/paru-bin.git "$aur_dir"
    cd "$aur_dir"

    if makepkg -sci --noconfirm --needed; then
        echo -e "${BGreen}[*] Successfully Installed.${Color_Off}"
    else
        echo -e "${BRed}[!] Failed to install.${Color_Off}"
        exit 1
    fi
}

# Install packages from pkglist file
function install_packages_from_pkglist() {
    echo -e "${BBlue}\n[*] Installing packages from Pkglist...${Color_Off}"
    local pkglist_file="$DIR/pkglist"
    if paru -S --noconfirm --needed - <"$pkglist_file"; then
        echo -e "${BGreen}[*] Successfully Installed.${Color_Off}"
    else
        echo -e "${BRed}[!] Failed to install.${Color_Off}"
        exit 1
    fi
}

# Install Fonts
function install_fonts() {
    echo -e "${BBlue}\n[*] Installing fonts...${Color_Off}"
    local font_dir="$HOME/.fonts"
    mkdir -p "$font_dir"
    cp -rf "$DIR/fonts"/* "$font_dir"
    echo -e "${BYellow}[*] Updating font cache...\n${Color_Off}"
    fc-cache
}

# Install Icons
function install_icons() {
    echo -e "${BBlue}\n[*] Installing icons...${Color_Off}"
    local icon_dir="$HOME/.icons"
    mkdir -p "$icon_dir"
    cp -rf "$DIR/icons"/* "$icon_dir"
    echo -e "${BGreen}[*] Successfully Installed.${Color_Off}"
}

# Install GTK Themes
function install_gtk_themes() {
    echo -e "${BBlue}\n[*] Installing themes...${Color_Off}"
    local theme_dir="$HOME/.themes"
    mkdir -p "$theme_dir"
    cp -rf "$DIR/gtk-themes"/* "$theme_dir"
    echo -e "${BGreen}[*] Successfully Installed.${Color_Off}"
}

# Install Rofi Themes
function install_rofi_themes() {
    local rofi_dir="$HOME/.config/rofi"
    if ! command -v rofi &>/dev/null; then
        echo -e "${BRed}Rofi is not installed. Installing Rofi...${Color_Off}"
        sudo pacman -S rofi --noconfirm --needed
    fi

    if [[ -d "$rofi_dir" ]]; then
        echo -e "${BPurple}[*] Creating a backup of your rofi configs...${Color_Off}"
        mv "$rofi_dir" "${rofi_dir}.${USER}"
    fi

    echo -e "${BBlue}[*] Installing rofi configs...${Color_Off}"
    mkdir -p "$rofi_dir"
    cp -rf "$DIR/dotfiles/.config/rofi"/* "$rofi_dir"

    if [[ -f "$rofi_dir/config.rasi" ]]; then
        echo -e "${BGreen}[*] Successfully Installed.${Color_Off}"
    else
        echo -e "${BRed}[!] Failed to install.${Color_Off}"
        exit 1
    fi
}


# Backup old config files
function backup_configs() {
    echo -e "${BPurple}[*] Backing up existing files...${Color_Off}"
    local config_backup_dir="$HOME/config-backup"
    mkdir -p "$config_backup_dir"
    mv -iv ~/.config/alacritty "$config_backup_dir/alacritty.old"
    mv -iv ~/.config/awesome "$config_backup_dir/awesome.old"
    mv -iv ~/.config/cava "$config_backup_dir/cava.old"
    mv -iv ~/.config/htop "$config_backup_dir/htop.old"
    mv -iv ~/.config/kitty "$config_backup_dir/kitty.old"
    mv -iv ~/.config/neofetch "$config_backup_dir/neofetch.old"
    mv -iv ~/.config/ranger "$config_backup_dir/ranger.old"
    mv -iv ~/.config/Thunar "$config_backup_dir/Thunar.old"
    mv -iv ~/.bashrc "$config_backup_dir/bashrc.old"
    mv -iv ~/.vimrc "$config_backup_dir/vimrc.old"
    mv -iv ~/.zshrc "$config_backup_dir/zshrc.old"
    mv -iv ~/.zsh-aliases "$config_backup_dir/zsh-aliases.old"
    echo -e "${BGreen}[*] Backup completed.${Color_Off}"
}

# Setup symlinks for configuration files
function setup_symlinks() {
    echo -e "${BBlue}[*] Setting up symlinks...${Color_Off}"
    local config_dir="$HOME/dotfiles/.config"
    ln -sfnv "$config_dir/alacritty/" ~/.config/
    ln -sfnv "$config_dir/awesome/" ~/.config/
    ln -sfnv "$config_dir/cava/" ~/.config/
    ln -sfnv "$config_dir/htop/" ~/.config/
    ln -sfnv "$config_dir/kitty" ~/.config/
    ln -sfnv "$config_dir/neofetch" ~/.config/
    ln -sfnv "$config_dir/ranger/" ~/.config/
    ln -sfnv "$config_dir/Thunar/" ~/.config/
    ln -sfnv "$HOME/dotfiles/.bashrc" ~/
    ln -sfnv "$HOME/dotfiles/.vimrc" ~/
    ln -sfnv "$HOME/dotfiles/.zshrc" ~/
    ln -sfnv "$HOME/dotfiles/.zsh-aliases/" ~/
    echo -e "${BGreen}[*] Symlinks setup completed.${Color_Off}"
}

# Install ZSH with Powerlevel10k and Plugins
function install_zsh_with_powerlevel10k_and_plugins() {
    echo -e "${BBlue}\n[*] Installing ZSH with Powerlevel10k and Plugins...${Color_Off}"

    # Check if Git is installed
    if ! command -v git &>/dev/null; then
        echo -e "${BRed}Git is not installed. Installing Git...${Color_Off}"
        sudo pacman -S git --noconfirm --needed
    fi

    # Check if Zsh is installed
    if ! command -v zsh &>/dev/null; then
        echo -e "${BRed}Zsh is not installed. Installing Zsh...${Color_Off}"
        sudo pacman -S zsh --noconfirm --needed
    fi

    # Install ZSH with Powerlevel10k
    zsh
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    git clone https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k"

    # Install ZSH Plugins
    echo -e "${BBlue}\n[*] Installing ZSH Plugins...${Color_Off}"
    local zsh_custom_dir="${ZSH_CUSTOM:-~/.oh-my-zsh/custom}"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$zsh_custom_dir/plugins/zsh-syntax-highlighting"
    git clone https://github.com/zsh-users/zsh-autosuggestions "$zsh_custom_dir/plugins/zsh-autosuggestions"

    echo -e "${BGreen}[*] ZSH with Powerlevel10k and Plugins installation completed.${Color_Off}"
}




# Install VIM Plugins
function install_vim_plugins() {
    echo -e "${BBlue}\n[*] Installing Plugin Manager...${Color_Off}"
    local vim_autoload_dir="$HOME/.vim/autoload"
    curl -fLo "$vim_autoload_dir/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    echo -e "${BBlue}\n[*] Installing Plugins for VIM...${Color_Off}"
    if vim +PlugUpdate +qall; then
        echo -e "${BGreen}[*] Successfully Installed.${Color_Off}"
    else
        echo -e "${BRed}[!] Failed to install vim plugins.${Color_Off}"
    fi
}

# Install PICOM Compositor
function install_picom() {
    local picom_dir="$HOME/.config/picom"
    if [[ -d "$picom_dir" ]]; then
        echo -e "${BPurple}[*] Creating a backup of your picom configs...${Color_Off}"
        mv "$picom_dir" "${picom_dir}.${USER}"
    fi
    echo -e "${BYellow}[!] Note - Picom Animation doesn't support the blur effect.${Color_Off}"
    read -e -p "[::] Enter type of picom config (Animation[A]/Blur[B]): " ab_picom
    case $ab_picom in
    [aA])
        echo -e "${BBlue}\n[*] Installing Picom with Animation...${Color_Off}"
        paru -Rcns picom-ibhagwan-git
        paru -S picom-pijulius-git --noconfirm --needed
        {
            mkdir -p "$picom_dir"
            cp -rf "$DIR/picom/picom-animations.conf" "$picom_dir/picom.conf"
        }
        ;;
    [bB])
        echo -e "${BBlue}\n[*] Installing Picom with Blur Effect...${Color_Off}"
        paru -Rcns picom-pijulius-git
        paru -S picom-ibhagwan-git --noconfirm --needed
        {
            mkdir -p "$picom_dir"
            cp -rf "$DIR/picom/picom-blur.conf" "$picom_dir/picom.conf"
        }
        ;;
    *)
        echo -e "${BRed}[!] Failed to install.${Color_Off}"
        exit 1
        ;;
    esac
}

# Main function
function main() {
    print_logo
    check_internet
    check_package_manager
    install_paru_bin
    install_packages_from_pkglist
    install_fonts
    install_icons
    install_gtk_themes
    install_rofi_themes
    backup_configs
    setup_symlinks
    install_zsh_with_powerlevel10k_and_plugins
    install_vim_plugins
    install_picom
    echo -e "${BGreen}=== Successfully Installed ===${Color_Off}"
}

# Check if the script was invoked with the --all or -a flag
if [[ "$1" = "--all" || "$1" = "-a" ]]; then
    main
    exit 0
fi

# Show the menu TUI if no flag is provided
echo -e "${BWhite}Select an option:${Color_Off}"
echo -e "${BBlue}  (0) Setup everything (recommended) ${Color_Off}"
echo -e "${BBlue}  (1) Install paru-bin ${Color_Off}"
echo -e "${BBlue}  (2) Install packages ${Color_Off}"
echo -e "${BBlue}  (3) Install Fonts ${Color_Off}"
echo -e "${BBlue}  (4) Install Icons & Themes ${Color_Off}"
echo -e "${BBlue}  (5) Install Rofi Themes ${Color_Off}"
echo -e "${BBlue}  (6) Backup current config ${Color_Off}"
echo -e "${BBlue}  (7) Setup symlinks ${Color_Off}"
echo -e "${BBlue}  (8) Setup Picom Compositor ${Color_Off}"
echo -e "${BBlue}  (9) Install Powerlevel10k & ZSH-Plugins ${Color_Off}"
echo -e "${BBlue}  (10) Install vim plugins ${Color_Off}"
echo -e "${BRed}  (*) Anything else to exit ${Color_Off}"

echo -en "${BGreen} ==> ${Color_Off}"

read -r option

case $option in
    "0") main ;;
    "1") install_paru_bin ;;
    "2") install_packages_from_pkglist ;;
    "3") install_fonts ;;
    "4") install_icons ;;
    "5") install_rofi_themes ;;
    "6") backup_configs ;;
    "7") setup_symlinks ;;
    "8") install_picom ;;
    "9") install_zsh_with_powerlevel10k_and_plugins ;;
    "10") install_vim_plugins ;;
    *)
        echo -e "${BRed}Invalid option entered, Bye!${Color_Off}"
        exit 0
        ;;
esac

exit 0
