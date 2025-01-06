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
