#!/bin/bash

# File to store tasks
TODO_FILE=~/scripts/todo.txt

# Ensure the TODO file exists
touch $TODO_FILE

# Array of funny notes
FUNNY_NOTES=(
    "Remember: A task a day keeps the procrastination away!"
    "If you don’t like the task, just ‘wing it’ like a chicken!"
    "You can’t be late if you don’t show up! But let’s not test that theory."
    "Don’t worry if plan A doesn’t work, the alphabet has 25 more letters!"
    "Why did the scarecrow win an award? Because he was outstanding in his field!"
)

# Function to display the to-do list
display_tasks() {
    clear
    cat << "EOF"
______________________________________________
/\______________________________________________/`-.
<()>____________________________________________<    ##
\/______________________________________________\,-'
                                              88 88  
                                              "" 88  
                                                 88  
8b,dPPYba,   ,adPPYba, 8b,dPPYba,   ,adPPYba, 88 88  
88P'    "8a a8P_____88 88P'   `"8a a8"     "" 88 88  
88       d8 8PP""""""" 88       88 8b         88 88  
88b,   ,a8" "8b,   ,aa 88       88 "8a,   ,aa 88 88  
88`YbbdP"'   `"Ybbd8"' 88       88  `"Ybbd8"' 88 88  
88                                                   
88                                                   
EOF

    echo "==========================================="
    echo "              TO DO LIST               "
    echo "==========================================="
    echo ""

    if [ -s $TODO_FILE ]; then
        nl -w2 -s'. ' $TODO_FILE | sed 's/\[ \]/[ ]/g' | sed 's/\[x\]/[x]/g'
    else
        echo "No tasks found. Add some tasks!"
    fi

    echo ""
    echo "Options:"
    echo "1. Add Task"
    echo "2. Remove Task"
    echo "3. Complete Task"
    echo "4. Exit"
    echo ""
    echo "${FUNNY_NOTES[RANDOM % ${#FUNNY_NOTES[@]}]}"
    
    # Add signature here
    cat << "EOF"
__________       .__   __                 .___           
\____    /___.__.|  | |  | __           __| _/_______  __
  /     /<   |  ||  | |  |/ /  ______  / __ |/ __ \  \/ /
 /     /_ \___  ||  |_|    <  /_____/ / /_/ \  ___/\   / 
/_______ \/ ____||____/__|_ \         \____ |\___  >\_/  
        \/\/               \/              \/    \/       
EOF
}

# Function to add a task
add_task() {
    read -p "Enter the task description: " task
    echo "[ ] $task" >> $TODO_FILE
    echo "Task added! Don't forget to add some zest to it!"
}

# Function to remove a task
remove_task() {
    display_tasks
    read -p "Enter the task number to remove: " task_number
    sed -i "${task_number}d" $TODO_FILE
    echo "Task removed! Just like that, it's gone!"
}

# Function to complete a task
complete_task() {
    display_tasks
    read -p "Enter the task number to complete: " task_number
    sed -i "${task_number}s/\[ \]/[x]/" $TODO_FILE
    echo "Task marked as complete! You're on a roll!"
}

# Main loop
while true; do
    display_tasks
    read -p "Choose an option [1-4]: " option
    case $option in
        1) add_task ;;
        2) remove_task ;;
        3) complete_task ;;
        4) echo "Exiting... Have a pun-derful day!"; exit ;;
        *) echo "Invalid option. Please try again." ;;
    esac
done
