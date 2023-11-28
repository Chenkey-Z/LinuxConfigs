# Setup fzf
# ---------
if [[ ! "$PATH" == */home/chenkeyz/git/fzf/bin* ]]; then
	PATH="${PATH:+${PATH}:}/home/chenkeyz/git/fzf/bin"
fi

# Auto-completion
# ---------------
source "/home/chenkeyz/git/fzf/shell/completion.bash"

# Key bindings
# ------------
source "/home/chenkeyz/git/fzf/shell/key-bindings.bash"
