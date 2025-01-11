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

## wezterm - WezTerm - Wez's Terminal Emulator

* URL: https://wezfurlong.org/wezterm/index.html
* Run: `stow wezterm`

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

### Some Dependencies in zshrc

* Configuration: `oh-my-zsh` - URL: https://ohmyz.sh/
* Theme: `Powerlevel10k` - URL: https://github.com/romkatv/powerlevel10k
* Replacement for ls: `eza` - URL: https://eza.rocks/
* Change directory smarter: `zoxide` - URL: https://github.com/ajeetdsouza/zoxide
* Fuzzy finder: `fzf` - URL: https://github.com/junegunn/fzf
* Replacement for cat: `bat` - URL: https://github.com/sharkdp/bat

#### oh-my-zsh plugins

Nearly all *oh-my-zsh* plugins are installed atomatically. But these
plugins you have install manually, i.e. custom plugins:

1. Install zsh-autosuggestions

```sh
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

2. Install zsh-syntax-highlighting

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

5. Install zsh-autocomplete

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

- Theme: `starship` - URL: https://starship.rs/

Using `pass` to store all my passowrds:

- Password Manager: `pass` - URL: https://www.passwordstore.org/
