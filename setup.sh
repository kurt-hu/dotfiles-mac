#!/bin/bash
set -e

echo "==> Installing Homebrew packages..."
brew install stow fzf zoxide starship neovim ripgrep fd node lazygit tree-sitter tree-sitter-cli go

echo "==> Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  # Oh My Zsh overwrites .zshrc — remove its version so stow can link ours
  rm -f "$HOME/.zshrc"
else
  echo "    Already installed, skipping."
fi

ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

echo "==> Installing zsh plugins..."
[ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] || \
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
[ -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] || \
  git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
[ -d "$ZSH_CUSTOM/plugins/you-should-use" ] || \
  git clone https://github.com/MichaelAquilina/zsh-you-should-use.git "$ZSH_CUSTOM/plugins/you-should-use"

echo "==> Installing Rust..."
if ! command -v rustup &> /dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  source "$HOME/.cargo/env"
else
  echo "    Already installed, skipping."
fi

echo "==> Stowing dotfiles..."
cd "$(dirname "$0")"
for pkg in zsh nvim karabiner starship git; do
  echo "    Stowing $pkg..."
  stow --adopt "$pkg" 2>/dev/null || stow "$pkg"
done

echo "==> Done! Restart your shell or run: source ~/.zshrc"
