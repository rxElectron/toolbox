#!/bin/bash

screenshot_from_area() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        FILE=$(zenity --file-selection --save --confirm-overwrite --title="Save Screenshot As")
        if [ -z "$FILE" ]; then
            show_error "No file selected."
            return
        fi
        
        notify-send "Select the area to capture."
        sleep 0.1
        import "$FILE"
        show_message "Screenshot saved as $FILE"
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        FILE=$(osascript -e 'tell application "System Events" to set the filepath to (choose file name with prompt "Save Screenshot As:")')
        if [ -z "$FILE" ]; then
            show_error "No file selected."
            return
        fi

        osascript -e "do shell script \"screencapture -i $FILE\""
        show_message "Screenshot saved as $FILE"
    elif [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
        FILE=$(powershell -command "
        Add-Type -AssemblyName System.Windows.Forms
        $SaveFileDialog = New-Object System.Windows.Forms.SaveFileDialog
        $SaveFileDialog.Filter = 'PNG Image|*.png|All Files|*.*'
        $SaveFileDialog.Title = 'Save Screenshot As'
        $SaveFileDialog.ShowDialog() | Out-Null
        $SaveFileDialog.FileName
        ")
        if [ -z "$FILE" ]; then
            show_error "No file selected."
            return
        fi

        powershell -command "Add-Type -AssemblyName System.Drawing; 
            [Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms') | Out-Null; 
            $bounds = [System.Windows.Forms.Screen]::PrimaryScreen.Bounds; 
            $bmp = New-Object System.Drawing.Bitmap $bounds.Width, $bounds.Height; 
            $graphics = [System.Drawing.Graphics]::FromImage($bmp); 
            $graphics.CopyFromScreen($bounds.Location, [System.Drawing.Point]::Empty, $bounds.Size); 
            $bmp.Save('$FILE'); 
            $graphics.Dispose(); 
            $bmp.Dispose()"
        show_message "Screenshot saved as $FILE"
    fi
}
