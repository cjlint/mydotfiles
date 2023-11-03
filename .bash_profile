export PATH=$PATH:~/bin
export PATH=$PATH:~/go/bin
export GPG_TTY=$(tty)
eval $(gdircolors -b)
export BASH_SILENCE_DEPRECATION_WARNING=1
export HISTFILESIZE=1000000
export HISTSIZE=1000000

# https://gist.github.com/justintv/168835?permalink_comment_id=3643177#gistcomment-3643177
function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working tree clean" ]] && echo "*"
}
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/(\1$(parse_git_dirty))/"
}
export PS1='\u@\h \[\e[38;5;211m\]\W\[\e[\033[38;5;48m\] $(parse_git_branch)\[\e[\033[00m\] \$ '

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

alias ls='gls --color=auto --group-directories-first'
alias gc='git checkout'
# __git_complete comes from git-completion.bash, allows bash completion to work with
# the specified alias. So cool
__git_complete gc _git_checkout
alias gb='git branch'
__git_complete gb _git_branch
alias findport='sudo lsof -n -i | grep LISTEN'

function pvim {
  if [ -n "$*" ]; then
    git ls-files | fzf --print0 -q "$*" | xargs -0 -o nvim
  else
    git ls-files | fzf --print0 | xargs -0 -o nvim
  fi
}

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/cjlinton/google-cloud-sdk/path.bash.inc' ]; then . '/Users/cjlinton/google-cloud-sdk/path.bash.inc'; fi
export CLOUDSDK_PYTHON=/usr/local/bin/python3

# The next line enables shell command completion for gcloud.
if [ -f '/Users/cjlinton/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/cjlinton/google-cloud-sdk/completion.bash.inc'; fi
