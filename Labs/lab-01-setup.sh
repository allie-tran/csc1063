#!/bin/bash

echo "Setting up terminal practice environment in ~/csc1063..."

# Create the main directory for the practice tasks
mkdir -p ~/csc1063
cd ~/csc1063


# Task 2: Create files in ~/csc1063/Downloads directory
echo "Creating files in ~/csc1063/Downloads directory..."
mkdir -p Downloads
echo "Directory 'Downloads' created in ~/csc1063."

# Task 3: Create Documents and Backup directories
echo "Ensuring ~/csc1063/Documents and ~/csc1063/Backup directories exist..."
mkdir -p Documents Backup
touch Documents/meeting_notes.txt
echo "File 'meeting_notes.txt' created in ~/csc1063/Documents."

# Task 4: Create temp directory and files
echo "Creating temp directory and temporary files..."
mkdir -p temp
touch temp/file1.tmp temp/file2.tmp temp/file3.tmp
touch temp/file4.log temp/file5.txt temp/file6.log
echo "Files created in ~/csc1063/temp."

echo "Terminal practice environment set up successfully in ~/csc1063!"
