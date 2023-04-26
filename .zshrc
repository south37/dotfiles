source ~/dotfiles/.shrc

# To use '^' without escape (To type "git diff HEAD^")
# Please see http://stackoverflow.com/questions/6091827/git-show-head-doesnt-seem-to-be-working-is-this-normal
setopt NO_EXTENDED_GLOB

# Use vim by default
export EDITOR=vim

# Need to set this to avoid using vim keybind in child process. (Due to EDITOR=vim)
# Please see http://web-salad.hateblo.jp/entry/2014/12/07/090000
bindkey -e

# ^D でshellから抜けない様にする
# 参考: http://www.ki.nu/~makoto/diary/2009/06/21/1.html
setopt IGNOREEOF

# Homebrew用
export PATH="/opt/homebrew/bin:$PATH"

# Bundler用
export BUNDLER_EDITOR=vim

# pkg-config用PATH
export PKG_CONFIG_PATH="/usr/local/lib/pkgconfig:/usr/lib/pkgconfig:/usr/X11/lib/pkgconfig"

# 3秒以上かかった処理は詳細表示
REPORTTIME=3

# for zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)
# zshの補完
fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
# Homebrewのコマンド補完を有効にする
fpath=(~/.zsh/functions/ $fpath)
# 自作した補完関数等は~/.zsh/functions/Completionに置く
fpath=(~/.zsh/functions/Completion(N-/) ${fpath})

# 補完機能
autoload -Uz compinit
compinit -u

# 先方予測機能
#autoload predict-on
#predict-on

# 保管候補を詰めて表示
setopt list_packed

# Command correction
setopt correct

# Command history
HISTFILE=~/.zsh_history
HISTSIZE=6000000
SAVEHIST=6000000
setopt hist_ignore_dups   # ignore duplication command history list
setopt share_history      # share command history data

# Search command history
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# Show git branch in prompt
# Ref. https://gist.github.com/otiai10/8034038
function branch-status-check {
    local prefix branchname suffix
    # Exclude because not in .git
    if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
        return
    fi
    branchname=`get-branch-name`
    # Exclude because there is no branch name
    if [[ -z $branchname ]]; then
        return
    fi
    prefix=`get-branch-status` # Only returns color
    suffix='%{'${reset_color}'%}'
    echo ${prefix}${branchname}${suffix}
}
function get-branch-name {
    # Ignore error when not in git directory.
    echo `git rev-parse --abbrev-ref HEAD 2> /dev/null`
}
function get-branch-status {
    local res color
    output=`git status -uno --short 2> /dev/null`
    if [ -z "$output" ]; then
        res=':' # status Clean
        color='%{'${fg[green]}'%}'
    elif [[ $output =~ "[\n]?\?\? " ]]; then
        res='?:' # Untracked
        color='%{'${fg[yellow]}'%}'
    elif [[ $output =~ "[\n]? M " ]]; then
        res='M:' # Modified
        color='%{'${fg[red]}'%}'
    else
        res='A:' # Added to commit
        color='%{'${fg[cyan]}'%}'
    fi
    # echo ${color}${res}'%{'${reset_color}'%}'
    echo ${color} # Only returns color
}

# Prompt
autoload -U colors; colors
PROMPT='%F{blue}[$(date "+%Y/%m/%d %H:%M:%S")]%f %~ ($(branch-status-check))'$'\n$ ' # gitのbranch名を表示
if (( ${+KUBE_FORK_TARGET_ENV} )); then
  PROMPT="[fork ${KUBE_FORK_TARGET_ENV}] ${PROMPT}"
fi
# setopt transient_rprompt
setopt prompt_subst # Eval prompt string for every line.

# beep sound
# cf. https://blog.vghaisas.com/zsh-beep-sound/
unsetopt BEEP

# Color
export CLICOLOR=1
export LSCOLORS=gxfxbxdxcxegedabagacad

# od
alias od='od -tx1z -Ax -v'

# alias
alias la='ls -a'
alias ll='ls -hl'
alias rm='rm -i'

# Util
pvim() { peco | xargs sh -c 'vim "$0" < /dev/tty' }
alias p='git ls-files | pvim'
pdo() { peco | while read LINE; do $@ $LINE; done }
alias c='find ./ -type d | pdo cd'
alias e='ghq list -p | pdo cd'

set -o noclobber

# Substite strings in all git-managed files
# Ref: http://pg-sugarless.hatenablog.jp/entry/20130409/1365510182
# Ref 2: http://stackoverflow.com/questions/4247068/sed-command-failing-on-mac-but-works-on-linux
function sedall()  { ag -l $1 $3 | xargs sed -Ei '' s/$1/$2/g }
# rename
function renameall() { git ls-files | grep $1 | while read LINE; do mv $LINE `echo $LINE | sed s/$1/$2/g`; done }

# Go
# http://qiita.com/methane/items/4905f40e4772afec3e60
export GOPATH=$HOME/.go
export GOROOT=/usr/local/go
export PATH="$GOPATH/bin:$PATH"

# Go mod
export GO111MODULE=on

# Find a PR that contains the specific commit.
function find-pr() {
  local parent=$2||'master'
  git log $1..$2 --merges --ancestry-path --reverse --oneline | head -n1
}

function find-pr-open() {
  local pr="$(find-pr $1 $2 | awk '{print substr($5, 2)}')"
  local r="$(git config --get remote.origin.url | sed 's/ssh:\/\/git@github\.com\///' | sed 's/\.git$//')"
  open "https://github.com/${r}/pull/${pr}"
}

alias altool='/Applications/Xcode.app/Contents/Applications/Application\ Loader.app/Contents/Frameworks/ITunesSoftwareService.framework/Support/altool'

# To avoid error message of vim
# cf. https://discourse.brew.sh/t/failed-to-set-locale-category-lc-numeric-to-en-ru/5092/13
export LC_ALL=en_US.UTF-8

# rbenv
export PATH="$HOME/.rbenv/shims:$PATH"

# poetry
export PATH="$HOME/.poetry/bin:$PATH"

# JDK
export JAVA_HOME="/opt/homebrew/opt/openjdk@17"
export PATH="$JAVA_HOME/bin:$PATH"
export PATH="/opt/homebrew/Cellar/gradle/7.3.1/bin:$PATH"
# export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"
# export PATH="$JAVA_HOME/bin:$PATH"

# webp
export PATH="$HOME/.webp/bin:$PATH"

# TiDB
# https://docs.pingcap.com/tidb/stable/quick-start-with-tidb
export PATH="/Users/minami/.tiup/bin:$PATH"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/minami/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/minami/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/minami/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/minami/google-cloud-sdk/completion.zsh.inc'; fi

# flutter
export PATH="$HOME/flutter/bin:$PATH"
export PATH="$HOME/Library/Android/sdk/cmdline-tools/latest/bin:$PATH"
