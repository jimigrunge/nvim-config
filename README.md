# JimiGrunge dotfile configuration

## Fonts

On Linux and MacOS you can use getnf to install patched nerd fonts.

* https://github.com/ronniedroid/getnf

DejaVuSans Mono has been added in the `fonts` directory for convenience because its the one I like the most.

## Tmux

Install tmux plugin manager

```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

Then copy/symlink tmux.comf to `~/.tmux.conf`.

On first run of tmux you will need to run the plugin installer. `prefix + I`
