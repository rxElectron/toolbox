#!/bin/bash

select_pixel_color() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        notify-send "Move the mouse to the desired pixel and press any key."
        sleep 0.1
        COLOR=$(xwd -root | convert xwd:- -crop 1x1+$(xdotool getmouselocation --shell | grep X= | cut -d= -f2)+$(xdotool getmouselocation --shell | grep Y= | cut -d= -f2) txt:- | grep -oP '#\w+')
        zenity --info --text="The selected pixel color is $COLOR."
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        osascript -e 'display dialog "Feature not supported on macOS." buttons {"OK"} default button "OK"'
    elif [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
        powershell -command "Add-Type -AssemblyName System.Windows.Forms; 
            $form = New-Object Windows.Forms.Form; 
            $form.Text = 'Select Pixel Color';
            $form.Size = New-Object Drawing.Size(400,200); 
            $form.StartPosition = 'CenterScreen'; 
            $label = New-Object Windows.Forms.Label; 
            $label.Text = 'Feature not supported on Windows.'; 
            $label.AutoSize = $true; 
            $label.Location = New-Object Drawing.Point(10,20); 
            $form.Controls.Add($label); 
            $okButton = New-Object Windows.Forms.Button; 
            $okButton.Text = 'OK'; 
            $okButton.Location = New-Object Drawing.Point(150,100); 
            $okButton.Add_Click({ $form.Close() }); 
            $form.Controls.Add($okButton); 
            $form.ShowDialog()"
    fi
}
