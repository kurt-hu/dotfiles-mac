# dotfiles-mac

macOS dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Prerequisites

```bash
brew install stow
```

## Packages

| Package | Contents |
|---------|----------|
| `zsh` | `.zshrc` — Oh My Zsh config, aliases, plugin setup |
| `nvim` | `.config/nvim/` — Neovim config (Kickstart-based, Lazy.nvim) |
| `karabiner` | `.config/karabiner/` — Karabiner-Elements key remapping |
| `starship` | `.config/starship.toml` — Starship prompt theme |
| `git` | `.config/git/ignore` — Global gitignore |

## Setup

Clone into your home directory and stow each package:

```bash
cd ~
git clone <repo-url> dotfiles-mac
cd dotfiles-mac
stow zsh
stow nvim
stow karabiner
stow starship
stow git
```

Or stow everything at once:

```bash
cd ~/dotfiles-mac
stow */
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
