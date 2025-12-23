#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Detect OS
OS=$(uname -s)
case "$OS" in
    Darwin*)
        OS_TYPE="mac"
        ;;
    Linux*)
        OS_TYPE="linux"
        ;;
    *)
        print_error "Unsupported OS: $OS"
        exit 1
        ;;
esac

print_status "Detected OS: $OS_TYPE"

# Function to sync configs to local .config
sync_to() {
    print_status "Syncing configs to local .config directory..."
    
    # Create .config directory if it doesn't exist
    mkdir -p "$HOME/.config"
    
    # Common configs for both Mac and Linux
    if [ -d "nvim" ]; then
        print_status "Syncing nvim config..."
        rm -rf "$HOME/.config/nvim"
        cp -r nvim "$HOME/.config/"
    fi
    
    if [ -d "yazi" ]; then
        print_status "Syncing yazi config..."
        rm -rf "$HOME/.config/yazi"
        cp -r yazi "$HOME/.config/"
    fi
    
    if [ -f "starship/starship.toml" ]; then
        print_status "Syncing starship config..."
        mkdir -p "$HOME/.config/starship"
        cp starship/starship.toml "$HOME/.config/starship/"
    fi
    
    if [ -f "wezterm/wezterm.lua" ]; then
        print_status "Syncing wezterm config..."
        mkdir -p "$HOME/.config/wezterm"
        cp wezterm/wezterm.lua "$HOME/.config/"
    fi
    
    if [ -d "atuin" ]; then
        print_status "Syncing atuin config..."
        rm -rf "$HOME/.config/atuin"
        cp -r atuin "$HOME/.config/"
    fi
    
    if [ -f ".zshrc" ]; then
        print_status "Syncing .zshrc..."
        cp .zshrc "$HOME/"
    fi
    
    # Mac-specific configs
    if [ "$OS_TYPE" = "mac" ]; then
        print_status "Syncing Mac-specific configs..."
        
        if [ -d "sketchybar" ]; then
            print_status "Syncing sketchybar config..."
            rm -rf "$HOME/.config/sketchybar"
            cp -r sketchybar "$HOME/.config/"
        fi
        
        if [ -f ".aerospace.toml" ]; then
            print_status "Syncing aerospace config..."
            cp .aerospace.toml "$HOME/.config/"
        fi
    fi
    
    # Linux-specific configs
    if [ "$OS_TYPE" = "linux" ]; then
        print_status "Syncing Linux-specific configs..."
        
        if [ -d "i3" ]; then
            print_status "Syncing i3 config..."
            mkdir -p "$HOME/.config/i3"
            cp i3/config "$HOME/.config/i3/"
        fi
        
        if [ -d "polybar" ]; then
            print_status "Syncing polybar config..."
            rm -rf "$HOME/.config/polybar"
            cp -r polybar "$HOME/.config/"
        fi
        
        if [ -d "rofi" ]; then
            print_status "Syncing rofi config..."
            mkdir -p "$HOME/.config/rofi"
            cp rofi/config.rasi "$HOME/.config/rofi/"
        fi
        
        if [ -f "picom/picom.conf" ]; then
            print_status "Syncing picom config..."
            mkdir -p "$HOME/.config/picom"
            cp picom/picom.conf "$HOME/.config/picom/"
        fi
        
        if [ -d "gtk-x" ]; then
            print_status "Syncing GTK config..."
            mkdir -p "$HOME/.config/gtk-3.0"
            cp gtk-x/settings.ini "$HOME/.config/gtk-3.0/"
        fi
    fi
    
    print_status "Sync to local .config completed!"
}

# Function to sync configs from local .config
sync_from() {
    print_status "Syncing configs from local .config directory..."
    
    # Common configs for both Mac and Linux
    if [ -d "$HOME/.config/nvim" ]; then
        print_status "Syncing nvim config from .config..."
        rm -rf nvim
        cp -r "$HOME/.config/nvim" .
    fi
    
    if [ -d "$HOME/.config/yazi" ]; then
        print_status "Syncing yazi config from .config..."
        rm -rf yazi
        cp -r "$HOME/.config/yazi" .
    fi
    
    if [ -f "$HOME/.config/starship/starship.toml" ]; then
        print_status "Syncing starship config from .config..."
        mkdir -p starship
        cp "$HOME/.config/starship/starship.toml" starship/
    fi
    
    if [ -f "$HOME/.config/wezterm/wezterm.lua" ]; then
        print_status "Syncing wezterm config from .config..."
        mkdir -p wezterm
        cp "$HOME/.config/wezterm/wezterm.lua" wezterm/
    fi
    
    if [ -d "$HOME/.config/atuin" ]; then
        print_status "Syncing atuin config from .config..."
        rm -rf atuin
        cp -r "$HOME/.config/atuin" .
    fi
    
    if [ -f "$HOME/.zshrc" ]; then
        print_status "Syncing .zshrc from home..."
        cp "$HOME/.zshrc" .
    fi
    
    # Mac-specific configs
    if [ "$OS_TYPE" = "mac" ]; then
        print_status "Syncing Mac-specific configs from .config..."
        
        if [ -d "$HOME/.config/sketchybar" ]; then
            print_status "Syncing sketchybar config from .config..."
            rm -rf sketchybar
            cp -r "$HOME/.config/sketchybar" .
        fi
        
        if [ -f "$HOME/.config/aerospace.toml" ]; then
            print_status "Syncing aerospace config from .config..."
            cp "$HOME/.config/aerospace.toml" .
        fi
    fi
    
    # Linux-specific configs
    if [ "$OS_TYPE" = "linux" ]; then
        print_status "Syncing Linux-specific configs from .config..."
        
        if [ -d "$HOME/.config/i3" ]; then
            print_status "Syncing i3 config from .config..."
            mkdir -p i3
            cp "$HOME/.config/i3/config" i3/
        fi
        
        if [ -d "$HOME/.config/polybar" ]; then
            print_status "Syncing polybar config from .config..."
            rm -rf polybar
            cp -r "$HOME/.config/polybar" .
        fi
        
        if [ -d "$HOME/.config/rofi" ]; then
            print_status "Syncing rofi config from .config..."
            mkdir -p rofi
            cp "$HOME/.config/rofi/config.rasi" rofi/
        fi
        
        if [ -f "$HOME/.config/picom/picom.conf" ]; then
            print_status "Syncing picom config from .config..."
            mkdir -p picom
            cp "$HOME/.config/picom/picom.conf" picom/
        fi
        
        if [ -f "$HOME/.config/gtk-3.0/settings.ini" ]; then
            print_status "Syncing GTK config from .config..."
            mkdir -p gtk-x
            cp "$HOME/.config/gtk-3.0/settings.ini" gtk-x/
        fi
    fi
    
    print_status "Sync from local .config completed!"
}

# Function to show usage
show_usage() {
    echo "Usage: $0 [--to-local|-t|--from-local|-f]"
    echo ""
    echo "Options:"
    echo "  --to-local, -t    Sync configs from dotfiles to local .config directory"
    echo "  --from-local, -f  Sync configs from local .config directory to dotfiles"
    echo ""
    echo "This script automatically detects Mac or Linux and syncs the appropriate configs."
}

# Main script logic
case "$1" in
    --to-local|-t)
        sync_to
        ;;
    --from-local|-f)
        sync_from
        ;;
    *)
        show_usage
        exit 1
        ;;
esac