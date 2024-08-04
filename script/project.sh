#!/bin/bash
# project.sh
# 
# This script provides a simple project navigation system using fzf for selection.
# It allows quick access to predefined project directories and opens them in Neovim.
#
# Usage: ./project.sh
#
# The script presents a list of project options using fzf. Upon selection, it 
# changes to the corresponding directory and opens Neovim in that location.
#
# Options:
# - .config/nvim: Opens Neovim configuration directory
# - test: Opens a test directory
# - code: Opens the main code directory
# - code/notes: Opens a notes subdirectory in the code folder
# - iaf: Opens the iaf project directory
# - gfg-mits: Opens the gfg-mits project directory
# - devi: Opens the devi project directory
# - exit: Exits the script
#
# If an invalid option is selected, the script displays an error message.



options=(
    ".config/nvim"
    "test"
    "code"
    "code/notes"
    "iaf"
    "gfg-mits"
    "devi"
    "exit"
)
 
# Display a list of options using fzf
selected_option=$(printf "%s\n" "${options[@]}" | fzf --prompt="Choose an option: ")

# Check the selected option and perform an action
case $selected_option in

"exit")
    exit
    ;;

"devi")
    cd ~/devi/ && nvim .
    ;;

"test")
    cd ~/test && nvim .
    ;;

"chatGPT")
    cd ~/test && nvim .
    ;;

"iaf")
    cd ~/iaf/ && nvim .
    ;;

"code")
    cd ~/code/ && nvim .
    ;;

"code/notes")
    cd ~/code/notes/ && nvim .
    ;;

".config/nvim")
    cd ~/.config/nvim && nvim .
    ;;

"gfg-mits")
    cd ~/gfg-mits/ && nvim .
    ;;

*)
    echo "No valid selection made."
    ;;
esac
