# dotfiles

Personal configuration files for a fresh machine setup.

## Contents

| File    | Symlinked to | Description                        |
| ------- | ------------ | --------------------------------- |
| `vimrc` | `~/.vimrc`   | Vim configuration (C dev–oriented) |
| `vim/after/syntax/c.vim` | `~/.vim/after/syntax/c.vim` | Extra C highlighting (function names) |

## Install

```bash
git clone git@github.com:b1tank/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

`install.sh` symlinks each file into `$HOME`, backing up any existing real file
to `<file>.bak` once, and creates `~/.vim/undodir` for Vim's persistent undo.

## Notes

- Secrets (keys, tokens, `.netrc`) are git-ignored and must never be committed.
- Add new configs by dropping the file here and adding a `link` line in `install.sh`.
