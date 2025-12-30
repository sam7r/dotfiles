#!/bin/bash

echo "syncing configs to local"
./sync.sh --to-local

install_packages_linux() {
	sudo pacman -S --noconfirm \
		atuin \
		eza \
		carapace \
		direnv \
		fd \
		fzf \
		github-cli \
		lazygit \
		make \
		neovim \
		obsidian \
		packer \
		ripgrep \
		starship \
		task \
		timew \
		thefuck \
		tree \
		tree-sitter-cli \
		vivid \
		xclip \
		zoxide

	sudo pacman -S --noconfirm go nvm tfenv pyenv python-argcomplete
	sudo pacman -S --noconfirm ttf-firacode-nerd ttf-victor-mono-nerd figlet
}

install_packages_mac() {
	if ! command -v brew &>/dev/null; then
		echo "Installing Homebrew..."
		/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi

	brew install \
		atuin \
		eza \
		carapace \
		fd \
		fzf \
		gh \
		lazygit \
		make \
		neovim \
		obsidian \
		ripgrep \
		starship \
		task \
		timewarrior \
		thefuck \
		tree \
		tree-sitter \
		zoxide

	brew install go nvm tfenv pyenv
	brew install --cask font-fira-code-nerd font-victor-mono-nerd
}

install_omzshplugins() {
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	# autoupdate plugin
	git clone https://github.com/TamCore/autoupdate-oh-my-zsh-plugins ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/autoupdate
	# nvm plugin
	git clone https://github.com/lukechilds/zsh-nvm ~/.oh-my-zsh/custom/plugins/zsh-nvm
	# zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
	# zsh-syntax-highlighting
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
	# evalcache
	git clone https://github.com/mroth/evalcache ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/evalcache
	# timewarrior
	git clone https://github.com/svenXY/timewarrior ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/timewarrior
}

if [[ $(uname) == "Linux" ]]; then
	echo "installing linux deps..."
	if grep -q "ID=steamos" /etc/os-release && grep -q "VARIANT_ID=steamdeck" /etc/os-release; then
		echo "running on steam deck, setting up distrobox..."
		sudo pacman-key --init
		sudo pacman-key --populate archlinux holosudo
		sudo pacman -Syu --noconfirm base-devel
		distrobox create -n devbox -i archlinux
		distrobox enter devbox -- bash -c "$(declare -f install_packages_linux); install_packages_linux"
		distrobox enter devbox -- bash -c "$(declare -f install_omzshplugins); install_omzshplugins"
	else
		install_packages_linux
		install_omzshplugins
	fi
elif [[ $(uname) == "Darwin" ]]; then
	echo "installing mac deps..."
	install_packages_mac
	install_omzshplugins
fi
