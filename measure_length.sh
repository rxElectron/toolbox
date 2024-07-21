#!/bin/bash

measure_line_length() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if command_exists gromit-mpx; then
            gromit-mpx &
            GROMIT_PID=$!
        fi

        DPI=$(xdpyinfo | grep resolution | awk '{print $2}' | cut -d 'x' -f 1)

        if $SHOW_HINTS; then
            zenity --info --text="Please select a line on your screen by clicking and dragging the mouse. Press OK to start."
            zenity --info --text="Move the mouse to the starting point and click the left mouse button."
        fi

        sleep 0.1
        xdotool selectwindow
        START_COORDS=$(xdotool getmouselocation --shell | grep -E 'X|Y' | awk -F '=' '{print $2}')
        START_X=$(echo $START_COORDS | awk '{print $1}')
        START_Y=$(echo $START_COORDS | awk '{print $2}')

        if $SHOW_HINTS; then
            zenity --info --text="Starting point recorded at ($START_X, $START_Y). Move the mouse to the ending point and click the left mouse button."
        fi

        sleep 0.1
        xdotool selectwindow
        END_COORDS=$(xdotool getmouselocation --shell | grep -E 'X|Y' | awk -F '=' '{print $2}')
        END_X=$(echo $END_COORDS | awk '{print $1}')
        END_Y=$(echo $END_COORDS | awk '{print $2}')

        DELTA_X=$(($END_X - $START_X))
        DELTA_Y=$(($END_Y - $START_Y))
        LINE_LENGTH_PIXELS=$(echo "sqrt(($DELTA_X^2) + ($DELTA_Y^2))" | bc -l)

        if [[ -z "$LINE_LENGTH_PIXELS" || "$LINE_LENGTH_PIXELS" == "0" ]]; then
            show_error "No line was selected or the length is zero. Please try again."
            return
        fi

        LINE_LENGTH_INCH=$(echo "scale=2; $LINE_LENGTH_PIXELS / $DPI" | bc)
        LINE_LENGTH_CM=$(echo "scale=2; $LINE_LENGTH_INCH * 2.54" | bc)
        SCREEN_RESOLUTION=$(xrandr | grep '*' | awk '{print $1}')
        SCREEN_WIDTH=$(echo $SCREEN_RESOLUTION | cut -d 'x' -f 1)
        LINE_LENGTH_PERCENT=$(echo "scale=2; ($LINE_LENGTH_PIXELS / $SCREEN_WIDTH) * 100" | bc)

        zenity --info --title="Line Length Results" --text="Line Length:
        - Pixels: $LINE_LENGTH_PIXELS px
        - Inches: $LINE_LENGTH_INCH in
        - Centimeters: $LINE_LENGTH_CM cm
        - Percentage of screen width: $LINE_LENGTH_PERCENT %"

        if $SHOW_HINTS; then
            zenity --info --text="Thank you for using the line length measurement tool. Press OK to exit."
        fi

        if [ -n "$GROMIT_PID" ]; then
            kill $GROMIT_PID
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        osascript -e 'display dialog "Feature not supported on macOS." buttons {"OK"} default button "OK"'
    elif [[ "$OSTYPE" == "cygwin" ]] || [[ "$OSTYPE" == "msys" ]] || [[ "$OSTYPE" == "win32" ]]; then
        powershell -command "Add-Type -AssemblyName System.Windows.Forms; 
            $form = New-Object Windows.Forms.Form; 
            $form.Text = 'Measure Line Length';
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
