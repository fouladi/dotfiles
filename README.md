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
