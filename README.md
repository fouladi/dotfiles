# dotfiles

Personal configuration files managed with [GNU Stow](https://www.gnu.org/software/stow/).

Each top-level directory is a **stow package** that mirrors the target
home-directory layout. Installing a package creates symlinks from `~/`
into this repo.

## Quick start

```sh
# Clone the repo into your home directory
git clone <repo-url> ~/dotfiles
cd ~/dotfiles

# Install a single package
stow <package>

# Install ALL packages at once
stow */

# Uninstall (remove symlinks) for a package
stow -D <package>

# Preview what stow would do (dry-run)
stow -n -v <package>
```

> **Note:** Stow will refuse to overwrite existing files. Back up or
> remove conflicting dotfiles in `~/` before running `stow`.

## Packages

| Package | Description | Install |
|---------|-------------|---------|
| [ghostty](#ghostty) | Ghostty terminal emulator config | `stow ghostty` |
| [git](#git) | Git configuration & commit template | `stow git` |
| [nvim](#nvim) | Neovim configuration (lazy.nvim) | `stow nvim` |
| [ripgrep](#ripgrep) | ripgrep configuration | `stow ripgrep` |
| [screenlayout](#screenlayout) | xrandr display layout scripts | `stow screenlayout` |
| [wezterm](#wezterm) | WezTerm terminal emulator config | `stow wezterm` |
| [yazi](#yazi) | Yazi terminal file manager config | `stow yazi` |
| [zsh](#zsh) | Zsh shell, aliases & Starship prompt | `stow zsh` |

---

### ghostty

Ghostty is a GPU-accelerated terminal emulator that pushes modern
features.

- URL: <https://ghostty.org>
- Symlinks: `~/.config/ghostty/config`, `~/.config/ghostty/themes/`

```sh
stow ghostty
```

---

### git

Git identity, aliases, delta pager, difftastic diff-tool, and merge-tool
configuration.

- URL: <https://git-scm.com>
- Symlinks: `~/.gitconfig`, `~/.gitmessage`

```sh
stow git
```

This package also expects two companion identity files (not
tracked here):

- `~/.gitconfig-work` — work email/signing key
- `~/.gitconfig-personal` — personal email/signing key

---

### nvim

Neovim configuration using
[lazy.nvim](https://github.com/folke/lazy.nvim) as the plugin manager.

- URL: <https://neovim.io>
- Symlinks: `~/.config/nvim/`

```sh
stow nvim
```

#### Dependencies

- `ctags` — generates tag files for source code navigation
- `tree-sitter-cli` — required by some Treesitter grammars (e.g. LaTeX):
  `sudo npm -g install tree-sitter-cli`
- `lazygit` — TUI for git, also used via the nvim lazygit plugin
- Plugin inspiration: <https://github.com/rockerBOO/awesome-neovim>

---

### ripgrep

ripgrep is a line-oriented regex search tool.

- URL: <https://github.com/BurntSushi/ripgrep>
- Symlinks: `~/.ripgreprc`

```sh
stow ripgrep
```

Install ripgrep via your package manager or from source:

```sh
# From source (requires Rust toolchain)
cargo install ripgrep
```

---

### screenlayout

xrandr helper scripts for monitor layouts.

- Symlinks: `~/.screenlayout/`

```sh
stow screenlayout
```

#### Autostart on LXQt

1. Main Menu > Preferences > LXQt Settings > Session Settings > Autostart
2. Click **Add** and point to:

```sh
~/.screenlayout/farr_single.sh
```

#### Ubuntu/Lubuntu keyboard shortcut

Update the terminal shortcut (`Ctrl+Alt+T`) to point at your preferred
emulator:

- **Ubuntu 20.04+:** Settings > Keyboard Shortcuts > Custom Shortcuts
- **Lubuntu/LXQt:** Preferences > LXQt Settings > Shortcut Keys

---

### wezterm

WezTerm is a GPU-accelerated, cross-platform terminal emulator.

- URL: <https://wezfurlong.org/wezterm/>
- Symlinks: `~/.config/wezterm/wezterm.lua`

```sh
stow wezterm
```

---

### yazi

Yazi is a blazing-fast terminal file manager written in Rust.

- URL: <https://yazi-rs.github.io>
- Symlinks: `~/.config/yazi/{yazi,keymap,theme}.toml`

```sh
stow yazi
```

Install yazi:

```sh
cargo install --locked yazi-fm yazi-cli
```

---

### zsh

Zsh shell configuration including `.zshrc`, custom aliases, and a
Starship prompt config.

- Symlinks: `~/.zshrc`, `~/.alias.zsh`, `~/.config/starship.toml`

```sh
stow zsh
```

#### Terminal utilities

These tools are referenced in the zsh/alias configuration:

| Tool | Description | URL |
|------|-------------|-----|
| starship | Cross-shell prompt | <https://starship.rs/> |
| eza | Modern `ls` replacement | <https://eza.rocks/> |
| zoxide | Smarter `cd` | <https://github.com/ajeetdsouza/zoxide> |
| fzf | Fuzzy finder | <https://github.com/junegunn/fzf> |
| bat | `cat` with syntax highlighting | <https://github.com/sharkdp/bat> |
| ripgrep | Fast `grep` replacement | <https://github.com/BurntSushi/ripgrep> |
| tldr (tealdeer) | Simplified man pages | <https://github.com/tealdeer-rs/tealdeer> |
| git-delta | Syntax-highlighted diff pager | <https://github.com/dandavison/delta> |
| difftastic | Structural diff tool | <https://github.com/Wilfred/difftastic> |
| lnav | Log file viewer | <https://lnav.org> |
| csvlens | CSV viewer | <https://github.com/ys-l/csvlens> |
| entr | Run command on file change | <https://github.com/eradman/entr> |
| vivid | `LS_COLORS` generator | <https://github.com/sharkdp/vivid> |
| lazygit | Git TUI | <https://github.com/jesseduffield/lazygit> |

**fzf keybindings:**

| Key | Action |
|-----|--------|
| `Ctrl+R` | Paste selected command from history |
| `Alt+C` | `cd` into selected directory |
| `Ctrl+T` | Paste selected file/directory onto command line |

---

## How GNU Stow works

Stow operates from a **stow directory** (this repo) and symlinks
package contents into a **target directory** (default: parent of stow
dir, i.e. `~/`).

```
~/dotfiles/git/.gitconfig  -->  ~/.gitconfig (symlink)
~/dotfiles/nvim/.config/nvim/  -->  ~/.config/nvim/ (symlink)
```

The `.stow-local-ignore` file in this repo overrides Stow's built-in
ignore list to exclude git metadata and documentation files from being
symlinked.

## License

Personal use. Feel free to take inspiration.
