#!/bin/bash

settings_menu() {
    SHOW_HINTS_TEXT="ON"
    if ! $SHOW_HINTS; then
        SHOW_HINTS_TEXT="OFF"
    fi

    choice=$(zenity --list --title="Settings" --text="Choose a setting to change:" --radiolist --column="Select" --column="Option" TRUE "Hints: $SHOW_HINTS_TEXT" FALSE "Back to Main Menu" --width=400 --height=200)
    
    case $choice in
        "Hints: ON")
            SHOW_HINTS=false
            show_message "Hints have been turned OFF."
            settings_menu
            ;;
        "Hints: OFF")
            SHOW_HINTS=true
            show_message "Hints have been turned ON."
            settings_menu
            ;;
        "Back to Main Menu")
            main_menu
            ;;
        *)
            show_error "Invalid selection."
            ;;
    esac
}
