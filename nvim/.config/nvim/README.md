# Configuration Pure Nvim using only lua

make a symbolic link in directory:

```sh
cd ~/.config
ln -s nvim ~/repo/dotfiles/config_nvim
```

# lsp-config

You have to install `npm` before you go on with installaton of "Language-
Server". To do that:

## installs NVM (Node Version Manager)

```sh
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
```

* After that continue in a new Shell:

* download and install Node.js

```sh
nvm install 20
```

* verifies the right Node.js version is in the environment

```sh
node -v # should print `v20.12.2`
```

* verifies the right NPM version is in the environment

```sh
npm -v # should print `10.5.0`
```

## Installing tree-sitter-cli

Additionally you are goint to install 'tree-sitter-cli': (needed at
least by LaTeX)

```sh
cargo install tree-sitter-cli

# alternatively:

npm install tree-sitter-cli
```

* After that run in nvim: `TSUpdate latex`

## TODOs

* Some use of `vimscript` is due to backward compatibilities and can be
  move to `lua` in future.
