# dotfiles-mac

macOS dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Quick setup

```bash
cd ~
git clone <repo-url> dotfiles-mac
cd dotfiles-mac
./setup.sh
```

This installs all dependencies (brew packages, Oh My Zsh, zsh plugins) and stows everything.

## Dependencies

Installed automatically by `setup.sh`:

- **Brew packages:** stow, fzf, zoxide, starship, neovim, ripgrep, fd, node, lazygit, tree-sitter, tree-sitter-cli, go
- **Rust** via rustup (rustc, cargo, rustfmt)
- **Oh My Zsh** with plugins: zsh-autosuggestions, zsh-syntax-highlighting, you-should-use

## Packages

| Package | Contents |
|---------|----------|
| `zsh` | `.zshrc` — Oh My Zsh config, aliases, plugin setup |
| `nvim` | `.config/nvim/` — Neovim config (Kickstart-based, Lazy.nvim) |
| `karabiner` | `.config/karabiner/` — Karabiner-Elements key remapping |
| `starship` | `.config/starship.toml` — Starship prompt theme |
| `git` | `.config/git/ignore` — Global gitignore |

## Manual setup

If you prefer to do it step by step:

```bash
brew install stow fzf zoxide starship neovim ripgrep fd node lazygit tree-sitter tree-sitter-cli
cd ~/dotfiles-mac
stow zsh nvim karabiner starship git
```

## Removing symlinks

```bash
cd ~/dotfiles-mac
stow -D <package>
```

## Adding new dotfiles

1. Create a package directory (e.g. `tmux/`)
2. Mirror the home directory structure inside it:
   ```
   tmux/
   └── .tmux.conf
   ```
   For `.config/` files:
   ```
   alacritty/
   └── .config/
       └── alacritty/
           └── alacritty.toml
   ```
3. Run `stow <package>` to create the symlinks
