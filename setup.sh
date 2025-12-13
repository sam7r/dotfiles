#!/bin/bash

git clone https://github.com/sam7r/dotfiles.git
# TODO: mv configs to all the right places!

install_packages() {
	sudo pacman -Syu --noconfirm base-devel
	sudo pacman -S --noconfirm \
		eza \
		fd \
		fzf \
		lazygit \
		make \
		neovim \
		packer \
		ripgrep \
		starship \
		thefuck \
		tree \
		tree-sitter-cli \
		zoxide \
		xclip

	sudo pacman -S --noconfirm go nvm terraform pyenv python-argcomplete
	sudo pacman -S --noconfirm ttf-firacode-nerd ttf-victor-mono-nerd
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
}

if [[ $(uname) == "Linux" ]]; then
	echo "installing linux deps..."
	if grep -q "ID=steamos" /etc/os-release && grep -q "VARIANT_ID=steamdeck" /etc/os-release; then
		echo "running on steam deck, setting up distrobox..."
		sudo pacman-key --init
		sudo pacman-key --populate archlinux holosudo
		distrobox create -n devbox -i archlinux
		distrobox enter devbox -- bash -c "$(declare -f install_packages); install_packages"
		distrobox enter devbox -- bash -c "$(declare -f install_omzshplugins); install_omzshplugins"
	else
		install_packages
		install_omzshplugins
	fi
fi
