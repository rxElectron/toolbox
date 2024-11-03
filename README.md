# Toolbox 📦

## Overview
Toolbox is a versatile toolset that provides various functionalities including measuring line lengths, taking screenshots, displaying system information, and more. This project is designed to be easily extensible and supports multiple operating systems including Linux (Ubuntu, Arch Linux, Kali Linux), macOS, and Windows 10/11.

## Features
- 📏 Measure Line Length
- 📸 Screenshot from Area
- 🖼️ Full Screenshot
- 🎨 Select Pixel Color
- 🕒 Show Date and Time
- 💻 Display System Information
- 💾 Calculate Disk Usage
- ⚙️ Settings

## Installation
### Linux (Ubuntu, Arch Linux, Kali Linux)
1. **Clone the repository**:
    ```sh
    git clone https://github.com/rxElectron/toolbox.git
    cd toolbox
    ```

2. **Install dependencies**:
    - **Ubuntu**:
      ```sh
      sudo apt update
      sudo apt install -y xdotool x11-utils bc imagemagick zenity gromit-mpx
      ```
    - **Arch Linux**:
      ```sh
      sudo pacman -Syu
      sudo pacman -S --needed xdotool xorg-xwininfo bc imagemagick zenity gromit-mpx
      ```
    - **Kali Linux**:
      ```sh
      sudo apt update
      sudo apt install -y xdotool x11-utils bc imagemagick zenity gromit-mpx
      ```

3. **Make all the scripts executable**:
    ```sh
    chmod +x *.sh
    ```

4. **Run the main script**:
    ```sh
    ./main.sh
    ```

### macOS
1. **Install Homebrew** (if not already installed):
    ```sh
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    ```

2. **Install dependencies**:
    ```sh
    brew install imagemagick
    ```

3. **Clone the repository**:
    ```sh
    git clone https://github.com/rxElectron/toolbox.git
    cd toolbox
    ```

4. **Make all the scripts executable**:
    ```sh
    chmod +x *.sh
    ```

5. **Run the main script**:
    ```sh
    ./main.sh
    ```

### Windows 10/11
1. **Install Git Bash**:
    Download and install [Git Bash](https://gitforwindows.org/).

2. **Install dependencies**:
    - **ImageMagick**:
      Download and install [ImageMagick](https://imagemagick.org/script/download.php#windows).
    - **Windows Subsystem for Linux (WSL)** (if not already installed):
      - **Enable WSL**:
        ```powershell
        wsl --install
        ```
      - **Install a Linux distribution** (e.g., Ubuntu) from the Microsoft Store.

3. **Open Git Bash** and **clone the repository**:
    ```sh
    git clone https://github.com/rxElectron/toolbox.git
    cd toolbox
    ```

4. **Make all the scripts executable**:
    ```sh
    chmod +x *.sh
    ```

5. **Run the main script**:
    ```sh
    ./main.sh
    ```

## Usage
Simply run the `main.sh` script to open the main menu and choose the desired functionality.

## File Structure
The project is divided into multiple script files for better organization and maintenance:
- `main.sh`: The main script that provides the menu and manages user interactions.
- `functions.sh`: Contains common utility functions used by other scripts.
- `measure_length.sh`: Script for measuring line length.
- `screenshot_area.sh`: Script for taking a screenshot of a selected area.
- `full_screenshot.sh`: Script for taking a full screenshot.
- `select_color.sh`: Script for selecting and displaying pixel color.
- `show_date_time.sh`: Script for displaying the current date and time.
- `system_info.sh`: Script for displaying system information.
- `disk_usage.sh`: Script for calculating disk usage.
- `settings.sh`: Script for managing application settings.

## Compatibility
Toolbox supports the following operating systems:
- Ubuntu
- Arch Linux
- Kali Linux
- macOS
- Windows 10 and 11

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contributing
Contributions are welcome! Please open an issue or submit a pull request for any improvements or suggestions.

## Acknowledgements
Icons made by [Freepik](https://www.freepik.com) from [Flaticon](https://www.flaticon.com).
