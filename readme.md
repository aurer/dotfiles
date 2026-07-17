# Dotfiles

## Installation

1. Clone this repo to a permanent location (see the note below — the repo must stay put)
2. In a terminal run `./install`
3. Run `source ~/.zshrc` or `exec $SHELL -l` to reload your configuration

## How it works

The `install` script symlinks each file in `src/` into the matching location under
your home directory (e.g. `src/.zshrc` → `~/.zshrc`, `src/.config/git/config` →
`~/.config/git/config`). Files are linked individually rather than whole directories,
so shared directories like `~/.config` keep the configs of other apps intact.

Because your home config points back into this repo, keep two things in mind:

* **Don't move or delete the repo** after installing, or the symlinks will dangle. If
  you relocate it, re-run `./install`.
* **New tracked files need a re-run** — after adding a file to `src/`, run `./install`
  again to link it.

Any pre-existing real file is backed up to `<name>.bak` before it is replaced, and
re-running `./install` is safe: correct symlinks are detected and left untouched.

## Extras

* Install `zsh-autosuggestions` and `zsh-syntax-highlighting` plugins. They should be picked up if installed into `/usr/local/share` or `/usr/share` directories.
