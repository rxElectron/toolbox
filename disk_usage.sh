#!/bin/bash

calculate_disk_usage() {
    DISK_USAGE=$(df -h)
    show_message "Disk usage:\n$DISK_USAGE"
}
