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

* Configuration: `oh-my-zsh` - URL: https://ohmyz.sh/
* Theme: `Powerlevel10k` - URL: https://github.com/romkatv/powerlevel10k
* Replacement for ls: `eza` - URL: https://eza.rocks/
* Change directory smarter: `zoxide` - URL: https://github.com/ajeetdsouza/zoxide
* Fuzzy finder: `fzf` - URL: https://github.com/junegunn/fzf
    - `Ctrl+R` paste the selected command from history.
    - `Alt-C` cd into the selected directory.
    - `CTRL-T` paste the selected files and directories onto the command line.
* Replacement for cat: `bat` - URL: https://github.com/sharkdp/bat
* Replacement for find: `ripgrep` - URL: https://github.com/BurntSushi/ripgrep
* Simplified and community-driven man pages: `tldr` - URL: https://tldr.sh/
* A viewer for git and diff output with syntax highlighting and line
  numbers: `git-delta` - URL: https://github.com/dandavison/delta
* An advanced log file viewer for the small-scale: `lnav` - URL:
  https://lnav.org
* Run *COMMAND* when *FILE* changes `entr` - URL:
  https://github.com/eradman/entr

#### oh-my-zsh plugins

Nearly all *oh-my-zsh* plugins are installed atomatically. But these
plugins you have install manually, i.e. custom plugins:

1. Install zsh-autosuggestions

```sh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

2. Install zsh-syntax-highlighting - Currently not in .zshrc:plugins
   activated (duplicate see: zsh-fast-syntax-highlighting).

```sh
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

3. Install zsh-pyenv

```sh
 git clone https://github.com/mattberther/zsh-pyenv ~/.oh-my-zsh/custom/plugins/zsh-pyenv ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-pyenv
```

4. Install zsh-fast-syntax-highlighting

```sh
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/fast-syntax-highlighting
```

Change from the *default* theme to *forest* with command:

```sh
fast-theme forest
#
fast-theme -l # list all themes
```

5. Install zsh-autocomplete - Currently not in .zshrc:plugins activated.

```sh
git clone --depth 1 -- https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete
```

Enable plugins by adding them to .zshrc:

```
plugins=(zsh-autosuggestions zsh-syntax-highlighting fast-syntax-highlighting zsh-autocomplete zsh-pyenv)
```

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

# TODO

Currently `Powerlevel10k` is not actively supported. I may move to:

- `starship` - URL: https://starship.rs/
- `oh-my-posh` - URL: https://ohmyposh.dev/

Using `pass` to store all my passowrds:

Password Manager:
- `pass` - URL: https://www.passwordstore.org/
