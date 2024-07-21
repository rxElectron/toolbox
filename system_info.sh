#!/bin/bash

system_info.sh

show_system_info() {
    SYS_INFO=$(uname -a)
    show_message "System information:\n$SYS_INFO"
}
