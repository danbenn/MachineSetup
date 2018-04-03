export PYTHONPATH=$PATH:~/lucida-clinc:~/lucida-clinc/uservices
export CLINC_PATH=~/lucida-clinc
export LUCIDA_HOSTNAME=$(hostname).clinc.ai

export TERM=xterm-256color
export CLICOLOR=1

alias py="python"
alias zeus="ssh eric@zeus.clinc.ai"
alias pi="ssh clinc-user@raspberrypi"
alias pnc="ssh eric@pnc.clinc.ai"
alias launch-finie="CLINC_PATH=$CLINC_PATH LUCIDA_HOSTNAME=$LUCIDA_HOSTNAME docker-compose up"
alias build-launch-finie="make docker;docker-flush-all;launch-finie"
alias get-setup="git clone https://github.com/euriostigue/setup.git"
alias responses="grep -c "fields" $CLINC_PATH/clincapi/finie/fixtures/response_template_*.json"
alias bash_web="docker exec -it lucidaclinc_static-web-content_1 /bin/bash"
alias docker_postgres="docker run --name test-postgres -e POSTGRES_USER=eric -e POSTGRES_PASSWORD=clincdev -p 5432:5432 -d postgres:9.6.5"

color_prompt=yes
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[00;34m\]\u@\h - [\d \@] - [\w]\[\033[00m\]\n\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


function docker-flush-all(){
    dockerlist=$(docker ps -a -q )
    if [ "${dockerlist}" != "" ]; then
        for d in ${dockerlist}; do
            echo "***** ${d}"
            docker stop ${d} 2>&1 > /dev/null
            docker rm ${d} 2>&1 > /dev/null
        done
    fi
}

function docker-clean(){
    docker rmi $(docker images --quiet --filter "dangling=true")
}

function findstring(){
    grep -i -r --include="*.$1" $2 .
}

function findpy(){
    grep -i -r --include="*.py" $1 .
}

function delete_file_types(){
    sudo find . -name "*.$1" -type f -delete
}

function findfile(){
    find . -name $1
}

function check_uuids(){
    grep -h "id" $CLINC_PATH/clincapi/finie/fixtures/response_template_* | sort | uniq --count --repeated
}

function prod-certs(){
    docker run -it --rm -p 443:443 -p 80:80 --name letsencrypt \
        -v "/etc/letsencrypt:/etc/letsencrypt"  \
        -v "/var/lib/letsencrypt:/var/lib/letsencrypt" \
        quay.io/letsencrypt/letsencrypt:latest auth
}



# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin:$HOME/phhrb/bin:$HOME/ruby/bin"
