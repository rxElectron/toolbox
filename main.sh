#!/bin/bash

source functions.sh
source measure_length.sh
source screenshot_area.sh
source full_screenshot.sh
source select_color.sh
source show_date_time.sh
source system_info.sh
source disk_usage.sh
source settings.sh

# Main menu
main_menu() {
    while true; do
        if [[ "$OSTYPE" == "linux-gnu"* ]]; then
            choice=$(zenity --list --title="Main Menu" --text="Choose an option:" --radiolist --column="Select" --column="Option" TRUE "Measure Line Length" FALSE "Screenshot from Area" FALSE "Full Screenshot" FALSE "Select Pixel Color" FALSE "Show Date and Time" FALSE "Display System Information" FALSE "Calculate Disk Usage" FALSE "Settings" FALSE "Exit" --width=400 --height=300 --window-icon=dialog-information --ok-label="Select" --cancel-label="Exit")
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            choice=$(osascript -e 'choose from list {"Measure Line Length", "Screenshot from Area", "Full Screenshot", "Select Pixel Color", "Show Date and Time", "Display System Information", "Calculate Disk Usage", "Settings", "Exit"} with prompt "Choose an option:" default items {"Measure Line Length"}')
        elif [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
            choice=$(powershell -command "
            Add-Type -AssemblyName System.Windows.Forms
            $form = New-Object Windows.Forms.Form
            $form.Text = 'Main Menu'
            $form.Size = New-Object Drawing.Size(400,300)
            $form.StartPosition = 'CenterScreen'

            $label = New-Object Windows.Forms.Label
            $label.Text = 'Choose an option:'
            $label.AutoSize = $true
            $label.Location = New-Object Drawing.Point(10,20)
            $form.Controls.Add($label)

            $listbox = New-Object Windows.Forms.ListBox
            $listbox.Items.AddRange(@('Measure Line Length','Screenshot from Area','Full Screenshot','Select Pixel Color','Show Date and Time','Display System Information','Calculate Disk Usage','Settings','Exit'))
            $listbox.Location = New-Object Drawing.Point(10,50)
            $listbox.Size = New-Object Drawing.Size(360,150)
            $listbox.SelectionMode = 'One'
            $form.Controls.Add($listbox)

            $okButton = New-Object Windows.Forms.Button
            $okButton.Text = 'Select'
            $okButton.Location = New-Object Drawing.Point(100,220)
            $okButton.Add_Click({
                $form.Tag = $listbox.SelectedItem
                $form.Close()
            })
            $form.Controls.Add($okButton)

            $cancelButton = New-Object Windows.Forms.Button
            $cancelButton.Text = 'Exit'
            $cancelButton.Location = New-Object Drawing.Point(200,220)
            $cancelButton.Add_Click({
                $form.Tag = 'Exit'
                $form.Close()
            })
            $form.Controls.Add($cancelButton)

            $form.ShowDialog() | Out-Null
            $form.Tag
            ")
        fi
        
        if [ $? -eq 1 ] || [ "$choice" == "Exit" ]; then
            exit 0
        fi

        case $choice in
            "Measure Line Length")
                measure_line_length
                ;;
            "Screenshot from Area")
                screenshot_from_area
                ;;
            "Full Screenshot")
                full_screenshot
                ;;
            "Select Pixel Color")
                select_pixel_color
                ;;
            "Show Date and Time")
                show_date_time
                ;;
            "Display System Information")
                display_system_info
                ;;
            "Calculate Disk Usage")
                calculate_disk_usage
                ;;
            "Settings")
                settings_menu
                ;;
            *)
                show_error "Invalid selection."
                ;;
        esac
    done
}

# Display the main menu
main_menu
