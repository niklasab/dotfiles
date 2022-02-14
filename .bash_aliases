# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND="rg --files --hidden"
if [ -f .config/nvim/autoload/plugged/fzf/shell/key-bindings.bash ]; then
    source .config/nvim/autoload/plugged/fzf/shell/key-bindings.bash
    source .config/nvim/autoload/plugged/fzf/shell/completion.bash
fi

# git
source /usr/share/bash-completion/completions/git
alias gst="git status -uno"
alias branch="git rev-parse --abbrev-ref HEAD"
alias branches="git branch --sort=committerdate"
alias gl="git log --pretty=oneline --abbrev-commit"
gitdate() {
    git log --after="$1 00:00" --before="$1 23:59"
}

# convert video to compressed mp4 and webm
convertvideo()
{
    if [ -Z $1 ]; then
        echo "convertvideo <video_file> <output_name>"
        return 0
    fi
    local vidfile=$1
    local outputname=$2
    ffmpeg -i $vidfile -vcodec libx264 -f mp4 -crf 28 -preset slow -an "${outputname}.mp4"
    ffmpeg -i $vidfile -f webm -vcodec libvpx-vp9 -vb 1024k -an "${outputname}.webm"
}

# unsorted
alias c="clear"
alias fn="find -name"
alias ls="ls --color=auto"
alias lsize="du -h --max-depth=1 | sort -h"
alias week="date +'%U'"
alias editba="vim $HOME/.bash_aliases"
alias srcba=". $HOME/.bash_aliases"
alias cdd="cd $HOME/documents/"
alias vimsession="vim -c \"cabbrev q <c-r>=(getcmdtype()==':' && getcmdpos()==1 ? 'close' : 'q')<CR>\""
alias cutvideo="losslesscut"
alias startgnome="startx ~/.xinitrc gnome"

# loop a command X times
#     loop_cmd <n times> "<command>" <time s> <args...>
#     e.g. loop_cmd 100 "echo 'hej'" <0.4s>
loop_cmd() {
    local times=$1
    local cmd=$2
    local sleeptime=$3

    if [ -z "$times" ] || [ -z "$cmd" ] || [ -z "$sleeptime" ]; then
        echo "Must supply times, cmd, sleeptime arguments"
        return 1
    fi

    for i in `seq 1 $times`; do
        echo "----$i/$times----";
        eval $cmd || break;
        sleep $sleeptime
    done
}

# print uniq lines from file
uniqlines()
{
    # Uniq lines except blank lines
    cat $1 | awk '!/./ || !seen[$0]++'
}

# include host-specific aliases
if [ -f ~/.host_aliases ]; then
    . ~/.host_aliases
fi

alias externalip="wget http://ipinfo.io/ip -qO - | xargs"
# xargs trim the white space
alias internalip="hostname -I | xargs"

trynvchad()
{
    sudo docker run -w /root -it --rm alpine:edge sh -uelic '
    apk add git nodejs neovim ripgrep alpine-sdk --update
    git clone https://github.com/NvChad/NvChad ~/.config/nvim
    nvim -c "autocmd User PackerComplete quitall" -c "PackerSync"
    nvim
    '
}

alias vim="nvim"
alias vimdiff='nvim -d'

new_bashscript()
{
    local scriptname=$1
    if [ -z "$scriptname" ];
    then
        echo "Must supply script name"
        return 1
    fi
    if [ -f "$scriptname" ];
    then
        echo "$scriptname already exists"
        return 1
    fi
    echo '#!/bin/bash' > $scriptname && chmod u+x $scriptname
    vim $scriptname
}

alias editbootstrap="vim $HOME/.config/yadm/bootstrap"
function dumphex()
{
    local filename="$1"
    xxd "$filename" > "$filename.hex"
}

function restorehex()
{
    local filename="$1"
    xxd -r "$filename" > "$filename.restored"
}

# Bash aliases not shared to public
source $HOME/.bash_aliases_private
