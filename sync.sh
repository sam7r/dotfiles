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

# Check if rsync is available
if ! command -v rsync &>/dev/null; then
	print_error "rsync is not installed or not in PATH. Please install rsync first."
	exit 1
fi
print_status "rsync is available"

# Function to sync directories using rsync
sync_dir() {
	local source="$1"
	local dest="$2"
	local desc="$3"
	local dry_run_flag=""

	# Check for dry run mode
	if [ "$DRY_RUN" = "true" ]; then
		dry_run_flag="--dry-run"
		print_status "[DRY RUN] Would sync $desc..."
	else
		print_status "Syncing $desc..."
	fi

	# Create destination directory if it doesn't exist
	mkdir -p "$(dirname "$dest")"

	# Use rsync with archive mode, verbose output, and optional dry run
	if rsync -av --delete $dry_run_flag "$source" "$dest"; then
		if [ "$DRY_RUN" != "true" ]; then
			print_status "$desc synced successfully"
		fi
	else
		print_error "Failed to sync $desc"
		return 1
	fi
}

# Function to sync configs to local .config
sync_to() {
	print_status "Syncing configs to local .config directory..."

	# Create .config directory if it doesn't exist
	mkdir -p "$HOME/.config"

	# Common configs for both Mac and Linux
	if [ -d "nvim" ]; then
		sync_dir "nvim/" "$HOME/.config/nvim/" "nvim config"
	fi

	if [ -d "yazi" ]; then
		sync_dir "yazi/" "$HOME/.config/yazi/" "yazi config"
	fi

	if [ -f "starship/starship.toml" ]; then
		print_status "Syncing starship config..."
		cp starship/starship.toml "$HOME/.config/"
	fi

	if [ -d "wezterm" ]; then
		sync_dir "wezterm/" "$HOME/.config/wezterm/" "wezterm config"
	fi

	if [ -d "atuin" ]; then
		sync_dir "atuin/" "$HOME/.config/atuin/" "atuin config"
	fi

	if [ -f ".zshrc" ]; then
		print_status "Syncing .zshrc..."
		cp .zshrc "$HOME/"
	fi

	if [ -d "taskwarrior" ]; then
		print_status "Syncing taskwarrior..."
		cp .taskrc "$HOME/"
		mkdir -p "$HOME/.task"
		# syncing individual dirs to avoid issues with data
		sync_dir "taskwarrior/hooks/" "$HOME/.task/hooks/" "taskwarrior hooks"
		sync_dir "taskwarrior/themes/" "$HOME/.task/themes/" "taskwarrior themes"
	fi

	if [ -d "timewarrior" ]; then
		print_status "Syncing timewarrior..."
		mkdir -p "$HOME/.timewarrior"
		cp timewarrior/timewarrior.cfg "$HOME/.timewarrior/"
		# syncing individual dir to avoid issues with data
		sync_dir "timewarrior/extensions/" "$HOME/.timewarrior/extensions/" "timewarrior extensions"
	fi

	# Mac-specific configs
	if [ "$OS_TYPE" = "mac" ]; then
		print_status "Syncing Mac-specific configs..."

		if [ -d "sketchybar" ]; then
			sync_dir "sketchybar/" "$HOME/.config/sketchybar/" "sketchybar config"
		fi

		if [ -f ".aerospace.toml" ]; then
			print_status "Syncing aerospace config..."
			cp .aerospace.toml "$HOME/"
		fi

		if [ -f "lazygit/config.yml" ]; then
			print_status "Syncing lazygit config..."
			mkdir -p "$HOME/Library/Application Support/lazygit"
			cp lazygit/config.yml "$HOME/Library/Application Support/lazygit/"
		fi
	fi

	# Linux-specific configs
	if [ "$OS_TYPE" = "linux" ]; then
		print_status "Syncing Linux-specific configs..."

		if [ -d "i3" ]; then
			sync_dir "i3/" "$HOME/.config/i3/" "i3 config"
		fi

		if [ -d "polybar" ]; then
			sync_dir "polybar/" "$HOME/.config/polybar/" "polybar config"
		fi

		if [ -d "rofi" ]; then
			sync_dir "rofi/" "$HOME/.config/rofi/" "rofi config"
		fi

		if [ -f "lazygit/config.yml" ]; then
			print_status "Syncing lazygit config..."
			mkdir -p "$HOME/.config/lazygit"
			cp lazygit/config.yml "$HOME/.config/lazygit/"
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
		sync_dir "$HOME/.config/nvim/" "nvim/" "nvim config from .config"
	fi

	if [ -d "$HOME/.config/yazi" ]; then
		sync_dir "$HOME/.config/yazi/" "yazi/" "yazi config from .config"
	fi

	if [ -f "$HOME/.config/starship.toml" ]; then
		print_status "Syncing starship config from .config..."
		mkdir -p starship
		cp "$HOME/.config/starship.toml" starship/
	fi

	if [ -d "$HOME/.config/wezterm" ]; then
		sync_dir "$HOME/.config/wezterm/" "wezterm/" "wezterm config from .config"
	fi

	if [ -d "$HOME/.config/atuin" ]; then
		sync_dir "$HOME/.config/atuin/" "atuin/" "atuin config from .config"
	fi

	if [ -f "$HOME/.zshrc" ]; then
		print_status "Syncing .zshrc from home..."
		cp "$HOME/.zshrc" .
	fi

	if [ -f "$HOME/.taskrc" ]; then
		print_status "Syncing .taskrc from home..."
		mkdir -p taskwarrior
		cp "$HOME/.taskrc" .
		cp -r "$HOME/.task/hooks" taskwarrior/
		cp -r "$HOME/.task/themes" taskwarrior/
	fi

	if [ -d "$HOME/.timewarrior" ]; then
		print_status "Syncing .timewarrior from home..."
		mkdir -p timewarrior
		cp "$HOME/.timewarrior/timewarrior.cfg" timewarrior/
		cp -r "$HOME/.timewarrior/extensions" timewarrior/
	fi

	# Mac-specific configs
	if [ "$OS_TYPE" = "mac" ]; then
		print_status "Syncing Mac-specific configs from .config..."

		if [ -d "$HOME/.config/sketchybar" ]; then
			sync_dir "$HOME/.config/sketchybar/" "sketchybar/" "sketchybar config from .config"
		fi

		if [ -f "$HOME/.aerospace.toml" ]; then
			print_status "Syncing aerospace config from home..."
			cp "$HOME/.aerospace.toml" .
		fi

		if [ -f "$HOME/Library/Application Support/lazygit/config.yml" ]; then
			print_status "Syncing lazygit config from home..."
			mkdir -p lazygit
			cp "$HOME/Library/Application Support/lazygit/config.yml" lazygit/
		fi
	fi

	# Linux-specific configs
	if [ "$OS_TYPE" = "linux" ]; then
		print_status "Syncing Linux-specific configs from .config..."

		if [ -d "$HOME/.config/i3" ]; then
			sync_dir "$HOME/.config/i3/" "i3/" "i3 config from .config"
		fi

		if [ -d "$HOME/.config/polybar" ]; then
			sync_dir "$HOME/.config/polybar/" "polybar/" "polybar config from .config"
		fi

		if [ -d "$HOME/.config/rofi" ]; then
			sync_dir "$HOME/.config/rofi/" "rofi/" "rofi config from .config"
		fi

		if [ -f "$HOME/.config/lazygit/config.yml" ]; then
			print_status "Syncing lazygit config from .config..."
			mkdir -p lazygit
			cp "$HOME/.config/lazygit/config.yml" lazygit/
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
	echo "Usage: $0 [--to-local|-t|--from-local|-f] [--dry-run|-n]"
	echo ""
	echo "Options:"
	echo "  --to-local, -t    Sync configs from dotfiles to local .config directory"
	echo "  --from-local, -f  Sync configs from local .config directory to dotfiles"
	echo "  --dry-run, -n     Show what would be synced without actually doing it (use with --to-local or --from-local)"
	echo ""
	echo "This script automatically detects Mac or Linux and syncs the appropriate configs."
	echo "Uses rsync for efficient directory syncing and cp for single files."
	echo ""
	echo "Examples:"
	echo "  $0 --to-local          # Sync to local .config"
	echo "  $0 --from-local        # Sync from local .config"
	echo "  $0 --to-local --dry-run # Preview sync to local .config"
}

# Set dry run flag
DRY_RUN="false"
SYNC_DIRECTION=""

# Parse arguments
while [[ $# -gt 0 ]]; do
	case $1 in
	--to-local | -t)
		SYNC_DIRECTION="to"
		shift
		;;
	--from-local | -f)
		SYNC_DIRECTION="from"
		shift
		;;
	--dry-run | -n)
		DRY_RUN="true"
		shift
		;;
	*)
		show_usage
		exit 1
		;;
	esac
done

# Check if sync direction was specified
if [ -z "$SYNC_DIRECTION" ]; then
	echo "Error: Must specify --to-local or --from-local"
	echo ""
	show_usage
	exit 1
fi

# Execute the appropriate sync function
if [ "$DRY_RUN" = "true" ]; then
	print_status "DRY RUN MODE: Showing what would be synced without making changes"
fi

case "$SYNC_DIRECTION" in
to)
	sync_to
	;;
from)
	sync_from
	;;
esac
