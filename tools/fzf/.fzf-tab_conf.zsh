#!/bin/zsh
export PREVIEW="$HOME/tools/fzf/.fzf_preview.sh"

# local extract="
# # trim input
# local in=\${\${\"\$(<{f})\"%\$'\0'*}#*\$'\0'}
# # get ctxt for current completion
# local -A ctxt=(\"\${(@ps:\2:)CTXT}\")
# # real path
# local realpath=\${ctxt[IPREFIX]}\${ctxt[hpre]}\$in
# realpath=\${(Qe)~realpath}
# "

# switch group using `,` and `.`
# zstyle ':fzf-tab:*' extra-opts --preview=$extract'$PREVIEW $realpath'

# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd -l  --color=always $realpath'
# zstyle ':fzf-tab:complete:lsd:*' fzf-preview '~/.fzf_preview.sh $realpath'
zstyle ':fzf-tab:complete:*:*' fzf-preview '$PREVIEW $realpath'
# zstyle ':fzf-tab:complete:ls:*' fzf-preview 'lsd -l  --color=always $realpath'
zstyle ':fzf-tab:complete:*:*' fzf-pad 4
