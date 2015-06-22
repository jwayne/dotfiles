#!/bin/bash
############################
# install.sh
# This script does all the install steps.
############################

#-----
# Handle args

dir=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# Defaults
setup_zsh=true  #if false, we use bash
setup_git=

while test $# -gt 0; do
    case "$1" in
        -h|--help)
            echo "$package - install environment"
            echo " "
            echo "$package [options] [arguments]"
            echo " "
            echo "options:"
            echo "-h, --help                show brief help"
            echo "--bash OR --zsh"
            echo "--git"
            exit 0
            ;;
        --bash)
            setup_zsh=
            shift
            ;;
        --zsh)
            setup_zsh=true            
            shift
            ;;
        --git)
            setup_git=true            
            shift
            ;;
    esac
done
        
#-----
# zsh or bash?

if [ "$setup_zsh" = true ]; then
    echo "================================================================================"
    echo "setting up zsh"
    echo "--------------------------------------------------------------------------------"
    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo "installing oh-my-zsh"
        sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    else
        echo "oh-my-zsh already installed"
        if [ "$SHELL" != "/bin/zsh" ]; then
            echo "chsh -s /bin/zsh"
            chsh -s /bin/zsh
            set SHELL=/bin/zsh
        else
            echo "default shell is already zsh, nothing to do"
        fi
    fi
else
    echo "================================================================================"
    echo "setting up bash"
    echo "--------------------------------------------------------------------------------"
    if [ "$SHELL" != "/bin/bash" ]; then
        echo "chsh -s /bin/bash"
        chsh -s /bin/bash
        set SHELL=/bin/bash
    else
        echo "default shell is already bash, nothing to do"
    fi
fi
echo -e "done\n"

#-----
# dotfiles

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


#-----
# git

if [[ "$setup_git" = true ]]; then
    echo "================================================================================"
    echo "setting up git"
    echo "--------------------------------------------------------------------------------"
    git config --global user.name "Josh Chen"
    git config --global user.email "jwcstar@gmail.com"
    echo -e "done\n"
fi

#-----
# manual installs

echo "================================================================================"
echo "manual installs"
echo "--------------------------------------------------------------------------------"
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    echo "OS: linux-gnu"
    echo "Nothing to do"
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "OS: OS X"
    echo "Install manually: ShiftIt"
else
    echo "OS: unknown"
    echo "Nothing to do"
fi
echo
