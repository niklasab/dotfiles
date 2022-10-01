# general
# TODO: Disable Ctrl-Q and S if possible too (avoid hang)
set -o ignoreeof # disable closing terminal on ctrl-d

# fzf
export FZF_DEFAULT_COMMAND="rg --files --hidden"
if [ -f $HOME/.config/nvim/autoload/plugged/fzf/shell/key-bindings.bash ]; then
    source $HOME/.config/nvim/autoload/plugged/fzf/shell/key-bindings.bash
    source $HOME/.config/nvim/autoload/plugged/fzf/shell/completion.bash
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
gitrbi() {
    git rebase -i HEAD~10
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
alias externalip="wget http://ipinfo.io/ip -qO -"
# xargs trim the white space
alias internalip="hostname -I | xargs"
alias vim="nvim"
alias vimdiff='nvim -d'
alias editbootstrap="vim $HOME/.config/yadm/bootstrap"
alias editi3="vim $HOME/.config/i3/config"
alias editalacritty="vim $HOME/.config/alacritty/alacritty.yml"
alias editvim="vim $HOME/.config/nvim/init.vim"
alias grep="grep --color"
alias lsmodified="ls -lahtr"
alias tree="tree -F --dirsfirst --noreport -C | sed -e 's/[├──└│]/ /g'"

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
    # https://stackoverflow.com/questions/11532157/remove-duplicate-lines-without-sorting
    cat $1 | awk '!/./ || !seen[$0]++'
    # Or this?
    # cat $1 | awk '!seen[$0]++'
}

trynvchad()
{
    sudo docker run -w /root -it --rm alpine:edge sh -uelic '
    apk add git nodejs neovim ripgrep alpine-sdk --update
    git clone https://github.com/NvChad/NvChad ~/.config/nvim
    nvim -c "autocmd User PackerComplete quitall" -c "PackerSync"
    nvim
    '
}

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

function canon_m50_webcam()
{
    # Stream from Canon m50
    # https://www.crackedthecode.co/how-to-use-your-dslr-as-a-webcam-in-linux/
    sudo modprobe v4l2loopback
    gphoto2 --stdout --capture-movie | ffmpeg -i - -vcodec rawvideo -pix_fmt yuv420p -threads 0 -f v4l2 /dev/video0
}

function mp4_to_mov()
{
    local inputvid="$1"
    local outputvid="$2"

    if ! [[ -f "$inputvid" ]]; then
        echo "Input video doesn't exist"
        echo "mp4_to_mov <input.mp4> <output.mov>"
        return 1
    fi

    if [[ -f "$outputvid" ]]; then
        echo "Output video already exists"
        echo "mp4_to_mov <input.mp4> <output.mov>"
        return 1
    fi

    if [[ -z "$outputvid" ]]; then
        echo "Must supply output video name"
        echo "mp4_to_mov <input.mp4> <output.mov>"
        return 1
    fi

    ffmpeg -i "$inputvid" -vcodec mjpeg -q:v 2 -acodec pcm_s16be -q:a 0 -f mov "$outputvid";
}

function all_mp4_to_mov()
{
    for file in *.MP4 *.mp4; do
        [ -f "$file" ] || break
        local filename="${file%.*}"
        if [ -f "$filename.mov" ]; then
            echo ".mov exist already"
        else
            mp4_to_mov $file "$filename.mov"
        fi
    done
}

function mov_to_mp4()
{
    local inputvid="$1"
    local outputvid="$2"

    if ! [[ -f "$inputvid" ]]; then
        echo "Input video doesn't exist"
        echo "mov_to_mp4 <input.mov> <output.mp4>"
        return 1
    fi

    if [[ -f "$outputvid" ]]; then
        echo "Output video already exists"
        echo "mov_to_mp4 <input.mov> <output.mp4>"
        return 1
    fi

    if [[ -z "$outputvid" ]]; then
        echo "Must supply output video name"
        echo "mov_to_mp4 <input.mov> <output.mp4>"
        return 1
    fi

    ffmpeg -i "$inputvid" -vcodec h264 -acodec aac "$outputvid"
}

function load_nvm()
{
    # This is slow, so don't load this automatically
    # Must run load_nvm before using nvm (e.g. nvm use 16.0)
    if [ -d $HOME/.nvm ]; then
        export NVM_DIR="$HOME/.nvm"
        echo "Load nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
        [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    fi
}

# Include host-specific aliases
if [ -f $HOME/.host_aliases ]; then
    source $HOME/.host_aliases
fi
