source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
source /usr/share/fzf-tab/fzf-tab.zsh

export FZF_DEFAULT_OPTS="--height=95% --layout=reverse --border --bind 'ctrl-y:toggle+down'"
export RUNEWIDTH_EASTASIAN=0
# --preview='
# if file --mime-type {} | grep -qF image/; then
#     kitty icat --clear --transfer-mode=memory --stdin=no --place=${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}@0x0 {} | sed \$d 
# else
#     bat --color=always {}
# fi
# ' 
PREVIEW=~/tools/fzf/.fzf_preview.sh

export FZF_CTRL_T_OPTS="
  --preview '$PREVIEW {}'
  --bind 'ctrl-s:reload(find . -type f)'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'
"

export FZF_CTRL_R_OPTS='
  --preview "
  CMD=$(echo {} | choose 1 ) 
  tldr $CMD "
  --bind "ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort"
  --color header:italic
  --header "Press CTRL-Y to copy command into clipboard"
'

export FZF_ALT_C_OPTS="
  --preview '$PREVIEW {}'
  --bind 'ctrl-s:reload(find . -type d)'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'
"

source ~/tools/fzf/.fzf-tab_conf.zsh
