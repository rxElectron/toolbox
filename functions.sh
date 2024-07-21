#!/bin/bash

# Function to display a message box
show_message() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        zenity --info --text="$1" --width=300 --height=200 --window-icon=info
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        osascript -e "display dialog \"$1\" buttons {\"OK\"} default button \"OK\""
    elif [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
        powershell -command "[System.Windows.MessageBox]::Show('$1', 'Information')"
    fi
}

# Function to display an error message
show_error() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        zenity --error --text="$1" --width=300 --height=200 --window-icon=error
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        osascript -e "display dialog \"$1\" buttons {\"OK\"} default button \"OK\" with icon stop"
    elif [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
        powershell -command "[System.Windows.MessageBox]::Show('$1', 'Error', 'OK', 'Error')"
    fi
}

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}
