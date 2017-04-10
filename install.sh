#!/bin/bash
############################
# install.sh
# This script does all the install steps.
############################

#TODO: spacemacs from nikki93, tmux

dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

if [[ "$OSTYPE" == "darwin"* ]]; then
    is_mac=true
    is_linux=
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
    is_mac=
    is_linux=true
else
    is_mac=
    is_linux=
fi

#-----
# Handle args

# Defaults
arg_programs=
arg_shell=
arg_dotfiles=
arg_git=

print_help() {
    echo "--------------------------------------------------------------------------------"
    echo "$0 [options]"
    echo
    echo "This program sets up your environment for you."
    echo "You have to provide arguments for what you want it to set up."
    echo "By default, it will not install anything."
    echo
    echo "options:"
    echo "-h, --help                show brief help"
    echo "--all                     install all below options"
    echo "--programs                default: no install"
    echo "--shell zsh|bash          default: no install; if all then zsh"
    echo "--dotfiles                default: no install"
    echo "--git                     default: no install"
    exit 0
}

if [[ "$#" -eq 0 ]]; then
    print_help
fi

while test $# -gt 0; do
    case "$1" in
        -h|--help)
            print_help
            ;;

        --all)
            arg_shell="zsh"
            arg_programs=true
            arg_dotfiles=true
            arg_git=true
            shift
            ;;

        --programs)
            arg_programs=true
            shift
            ;;

        --shell)
            shift
            arg_shell="$1"
            if [ "$arg_shell" != "zsh" ] && [ "$arg_shell" != "bash" ]; then
                echo "Unknown --shell: $arg_shell"
                print_help
                exit 1
            fi
            shift
            ;;

        --dotfiles)
            arg_dotfiles=true
            shift
            ;;

        --git)
            arg_git=true            
            shift
            ;;

        *)
            echo "Unknown option or argument: $1"
            print_help
            exit 1
    esac
done

#-----
# program installs

if [ "$arg_programs" = true ]; then
    if [ $is_mac = true ]; then
        echo "================================================================================"
        echo "OS X program installs"
        echo "--------------------------------------------------------------------------------"

        echo "installing Homebrew"
        ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
        echo -e "done\n"

        echo "installing new vim"
        brew install vim
        echo -e "done\n"

        echo "installing tmux"
        brew install tmux
        echo -e "done\n"

        echo "Here\'s some other stuff you might need:"
        echo "IDEs: XCode, Android Studio, Eclipse"
        echo "SDKs: Java + Java SDK"
        echo "Other: ShiftIt"
        echo "Press enter to continue..."
        read -e
    elif [ $is_linux = true ]; then
        echo "================================================================================"
        echo "Linux program installs"
        echo "--------------------------------------------------------------------------------"

        sudo apt-get install vim
        sudo apt-get install tmux
        sudo apt-get install zsh
        sudo apt-get install xclip
    fi

    sudo pip install jupyter matplotlib ipdb numpy
fi       

#-----
# zsh or bash?

if [ ! -z "$arg_shell" ]; then
    echo "================================================================================"
    echo "setting up your shell"
    echo "--------------------------------------------------------------------------------"
    if [ "$arg_shell" == "zsh" ]; then
        if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
            echo "using zsh"
            echo
            if [ ! -d "$HOME/.oh-my-zsh" ]; then
                echo "installing oh-my-zsh"
                sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
                echo
            else
                echo "oh-my-zsh already installed"
                echo
                ZSH_PATH=`which zsh`
                if [ "$SHELL" != "$ZSH_PATH" ]; then
                    echo "chsh -s $ZSH_PATH"
                    chsh -s $ZSH_PATH
                    export SHELL=$ZSH_PATH
                else
                    echo "default shell is already zsh, nothing to do"
                    echo
                fi
            fi
            echo "cp $dir/dotfiles/.bashrc $HOME/.oh-my-zsh/custom/$USER.zsh"
            cp $dir/dotfiles/.bashrc $HOME/.oh-my-zsh/custom/$USER.zsh
        else
            echo "zsh not available, using bash instead"
            arg_shell="bash"
        fi
    fi
    if [ "$arg_shell" == "bash" ]; then
        echo "using bash"
        echo
        BASH_PATH=`which bash`
        if [ "$SHELL" != "$BASH_PATH" ]; then
            echo "chsh -s $BASH_PATH"
            chsh -s $BASH_PATH
            export SHELL=$BASH_PATH
        else
            echo "default shell is already bash, nothing to do"
            echo
        fi
    fi
    echo -e "done\n"
fi

#-----
# dotfiles

if [ "$arg_dotfiles" = true ]; then
    echo "================================================================================"
    echo "installing dotfiles"
    echo "--------------------------------------------------------------------------------"
    dir_dotfiles=$dir/dotfiles
    dir_dotfiles_old=$dir_dotfiles/old
    dotfiles="$(ls -A $dir_dotfiles)"
    if [ ! -d $dir_dotfiles_old ]; then
        echo "mkdir $dir_dotfiles_old"
        mkdir $dir_dotfiles_old
        echo 
    fi
    for file in $dotfiles; do
        if [ "$file" != "old" ]; then
            # If existing symlink
            if [ -h ~/$file ]; then
                echo "rm ~/$file"
                rm ~/$file
            # If existing regular file
            elif [ -e ~/$file ]; then
                echo "mv ~/$file $dir_dotfiles_old/"
                mv ~/$file $dir_dotfiles_old/
            fi
            # Now, make the symlink
            echo "ln -s $dir_dotfiles/$file ~/$file"
            ln -s $dir_dotfiles/$file ~/$file
            echo
        fi
    done
    echo -e "done\n"
fi

#-----
# git

if [ "$arg_git" = true ]; then
    echo "================================================================================"
    echo "setting up git"
    echo "--------------------------------------------------------------------------------"
    git config --global user.name "Josh Chen"
    git config --global user.email "jwayne@users.noreply.github.com"
    git config --global push.default simple
    echo -e "done\n"
fi
