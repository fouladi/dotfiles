# dotfiles

To install every configuration to your current environment use
`GNU Stow`! For each application Change to the current directory in
*dotfiles* and Run the command, see below. To install all
configurations:

* Run: `stow all`
* URL: https://www.gnu.org/software/stow/

## nvim - neovim: Vim-based text editor

* URL: https://neovim.io
* Run: `stow nvim`

### Some Dependencies in nvim

* `ctags`: generates an index (or tag) file of language objects found in
  source files for programming languages.
* Pick Plugins: https://github.com/rockerBOO/awesome-neovim
* You may need for some languages, e.g. LaTeX: `sudo npm -g install tree-sitter-cli`

## Terminal Emulators

My two alternatives:

### wezterm - WezTerm - Wez's Terminal Emulator

* URL: https://wezfurlong.org/wezterm/index.html
* Run: `stow wezterm`

### ghostty - Ghostty - terminal emulator pushing modern features

* URL: https://ghostty.org
* Run: `stow ghostty`

### Change Ubuntu's 20.04 Keyboard Shortcuts

Open `Settings > Keyboard Shortcuts > Custom Shortcust` and click on the
item: `Control+Alt+T`

### Change Lubuntu's default terminal

Open `Preferences > LXQT Settings > Shortcut Keys` and double click on
the item that has the shortcut you wish to change: `Control+Alt+T`

## Screenlayout

* Run: `stow screenlayout`

### Adding `xrandr` command in startup script

#### Use the 'autostart' feature of LXQt.

* From the Main Menu
    + `Preferences` -> `LXQT Settings`
    + select `Session Settings` -> `Autostart`
    + scroll down to and high-light `LXQT Autostart`
    + click the Add button and add the action that you want.

```sh
~/.screenlayout/farr_single.sh
```

## git configuration

It makes symbolic links for *git* configuration files.

* Run: `stow git`

## zsh configuration

It makes symbolic links for *zsh* configuration files.

* Run: `stow zsh`

### Some Dependencies and Terminal Utilities

* Add `starship` prompt for `Zsh` - URL: https://starship.rs/
* Replacement for ls: `eza` - URL: https://eza.rocks/
* Change directory smarter: `zoxide` - URL: https://github.com/ajeetdsouza/zoxide
* Fuzzy finder: `fzf` - URL: https://github.com/junegunn/fzf
    - `Ctrl+R` paste the selected command from history.
    - `Alt-C` cd into the selected directory.
    - `CTRL-T` paste the selected files and directories onto the command line.
* Replacement for cat: `bat` - URL: https://github.com/sharkdp/bat
* Replacement for find: `ripgrep` - URL: https://github.com/BurntSushi/ripgrep
* Simplified and community-driven man pages: `tldr` - URL: https://github.com/tealdeer-rs/tealdeer
* A viewer for git and diff output with syntax highlighting and line
  numbers: `git-delta` - URL: https://github.com/dandavison/delta
* An advanced log file viewer for the small-scale: `lnav` - URL: https://lnav.org
* Run *COMMAND* when *FILE* changes `entr` - URL: https://github.com/eradman/entr
* A generator for the `LS_COLORS` environment variable: `vivid` - URL: https://github.com/sharkdp/vivid
* Add `Lazygit`, it used in `nvim` too through a plugin - URL: https://github.com/jesseduffield/lazygit

## Yazi configuration

It is a terminal file manager written in Rust, based on async I/O.

* Run: `stow yazi`
* URL: https://yazi-rs.github.io

To install `yazi`

```sh
rustup update
# Now you can install Yazi from crates.io:
cargo install --locked yazi-fm yazi-cli
```

## ripgrep

ripgrep is a line-oriented search tool that recursively searches the
current directory for a regex pattern.

* Run: `stow ripgrep`
* URL: https://github.com/BurntSushi/ripgrep

To install `ripgrep`

```sh
rustup update
cargo install ripgrep
```
