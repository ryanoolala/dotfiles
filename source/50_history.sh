# History settings

if [ -n "$BASH_VERSION" ]; then
  # Allow use to re-edit a faild history substitution.
  shopt -s histreedit
  # History expansions will be verified before execution.
  shopt -s histverify
elif [ -n %ZSH_VERSION ]; then
  setopt hist_verify
fi
# Entries beginning with space aren't added into history, and duplicate
# entries will be erased (leaving the most recent entry).
export HISTCONTROL="ignorespace:erasedups"
# Give history timestamps.
export HISTTIMEFORMAT="[%F %T] "
# Lots o' history.
export HISTSIZE=10000
export HISTFILESIZE=10000

# Easily re-execute the last history command.
alias r="fc -s"
