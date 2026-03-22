#!/bin/bash
# Written in Bash
# "ONLY FOR EDUCATIONAL PURPOSE"

current_version=2.32

# Color codes
RED='\033[0;91m'
GREEN='\033[0;92m'
YELLOW='\033[0;93m'
BLUE='\033[0;94m'
PURPLE='\033[0;95m'
CYAN='\033[0;96m'
WHITE='\033[0;97m'
NC='\033[0m' # No Color
BOLD='\033[1m'
UNDERLINE='\033[4m'
BLINK='\033[5m'

# Animation functions
loading_animation() {
    local message=$1
    local chars="⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"
    
    echo -ne "${CYAN}${BOLD}$message ${NC}"
    for i in {1..20}; do
        for char in $(echo $chars | grep -o .); do
            echo -ne "${YELLOW}${BOLD}$char${NC}"
            sleep 0.05
            echo -ne "\b"
        done
    done
    echo -e "${GREEN}${BOLD} Done! ${NC}"
}

progress_bar() {
    local duration=$1
    local message=$2
    
    echo -ne "${BLUE}${BOLD}$message ${NC}"
    for i in {1..30}; do
        echo -ne "${GREEN}${BOLD}▓${NC}"
        sleep $(echo "scale=2; $duration/30" | bc 2>/dev/null || echo "0.05")
    done
    echo -e "${GREEN}${BOLD} Complete! ${NC}"
}

sparkle_effect() {
    echo -ne "${YELLOW}"
    for i in {1..20}; do
        echo -ne "✦"
        sleep 0.03
    done
    echo -e "${NC}"
}

typewriter_effect() {
    local text=$1
    local color=$2
    for ((i=0; i<${#text}; i++)); do
        echo -ne "${color}${BOLD}${text:$i:1}${NC}"
        sleep 0.03
    done
    echo
}

pulse_message() {
    local message=$1
    local color=$2
    
    for i in {1..3}; do
        echo -ne "${color}${BOLD}$message${NC}"
        sleep 0.3
        echo -ne "\r"
        for j in $(seq 1 ${#message}); do
            echo -n " "
        done
        echo -ne "\r"
        sleep 0.3
    done
    echo -e "${color}${BOLD}$message${NC}"
}

## CLEANER FUNCTION ##
clean_exit() {
    echo -e "\n${YELLOW}${BOLD}🧹 Performing cleanup...${NC}"
    progress_bar 2 "Cleaning temporary files"
    
    rm -rf "$PWD/.temp/"* &> /dev/null
    rm -rf "$PWD/1" &> /dev/null
    rm -rf "$PWD/2" &> /dev/null
    
    echo -e "${GREEN}${BOLD}✓ Cleanup completed${NC}"
    sparkle_effect
    echo -e "${PURPLE}${BOLD}👋 Exiting ANDRO-EYE. Thanks for using!${NC}"
    echo -e "${GREEN}${BOLD}DONE${NC}\n"
    exit
}

trap_ctrlc() {
    clear
    pulse_message "⚠️  Ctrl-C caught! Performing Clean Up..." "${RED}"
    clean_exit
}

trap "trap_ctrlc" 2

banner() {
    clear
    echo -e "${RED}${BOLD}"
    cat << "EOF"
    ╔═══════════════════════════════════════════════════════════════════╗
    ║  █████╗ ███╗   ██╗██████╗ ██████╗  ██████╗     ███████╗██╗   ██╗██╗  ║
    ║ ██╔══██╗████╗  ██║██╔══██╗██╔══██╗██╔═══██╗    ██╔════╝╚██╗ ██╔╝██║  ║
    ║ ███████║██╔██╗ ██║██║  ██║██████╔╝██║   ██║    █████╗   ╚████╔╝ ██║  ║
    ║ ██╔══██║██║╚██╗██║██║  ██║██╔══██╗██║   ██║    ██╔══╝    ╚██╔╝  ╚═╝  ║
    ║ ██║  ██║██║ ╚████║██████╔╝██║  ██║╚██████╔╝    ███████╗   ██║   ██╗  ║
    ║ ╚═╝  ╚═╝╚═╝  ╚═══╝╚═════╝ ╚═╝  ╚═╝ ╚═════╝     ╚══════╝   ╚═╝   ╚═╝  ║
    ║                                                               ║
    ║              🔧 ${GREEN}ANDRO-EYE${RED} - ${CYAN}Android Security Toolkit${RED}              ║
    ║                                                               ║
    ╚═══════════════════════════════════════════════════════════════════╝
EOF
    echo -e "${NC}"
    echo -e "${YELLOW}${BOLD}              DEVELOPED BY ${RED}${BOLD}A T H E X${NC}\n"
    sparkle_effect
}

option_list() {
    banner
    echo -e "\n\n${RED}${BOLD}${UNDERLINE}╔════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${RED}${BOLD}${UNDERLINE}║              CHOOSE THE OPTIONS GIVEN BELOW                    ║${NC}"
    echo -e "${RED}${BOLD}${UNDERLINE}╚════════════════════════════════════════════════════════════════╝${NC}\n"
    
    echo -e "${YELLOW}${BOLD}┌─────────────────────────────────────┬─────────────────────────────────────┐${NC}"
    echo -e "${YELLOW}${BOLD}│${NC} ${GREEN}1.${NC}  SHOW CONNECTED DEVICES            ${YELLOW}│${NC} ${GREEN}24.${NC} PUT A FILE IN DEVICE           ${YELLOW}│${NC}"
    echo -e "${YELLOW}${BOLD}│${NC} ${GREEN}2.${NC}  RESTART ADB SERVICE                ${YELLOW}│${NC} ${GREEN}25.${NC} ${RED}GO TO METASPLOIT SECTION${NC}     ${YELLOW}│${NC}"
    echo -e "${YELLOW}${BOLD}│${NC} ${GREEN}3.${NC}  REBOOT SYSTEM                       ${YELLOW}│${NC} ${GREEN}26.${NC} LAUNCH AN APPLICATION           ${YELLOW}│${NC}"
    echo -e "${YELLOW}${BOLD}│${NC} ${GREEN}4.${NC}  REBOOT TO RECOVERY MODE             ${YELLOW}│${NC} ${GREEN}27.${NC} CHECK IF PHONE ROOTED           ${YELLOW}│${NC}"
    echo -e "${YELLOW}${BOLD}│${NC} ${GREEN}5.${NC}  REBOOT TO FASTBOOT/BOOTLOADER      ${YELLOW}│${NC} ${GREEN}28.${NC} HANG THE PHONE                   ${YELLOW}│${NC}"
    echo -e "${YELLOW}${BOLD}│${NC} ${GREEN}6.${NC}  START INTERACTIVE SHELL            ${YELLOW}│${NC} ${GREEN}29.${NC} SEND SMS FROM PHONE              ${YELLOW}│${NC}"
    echo -e "${YELLOW}${BOLD}│${NC} ${GREEN}7.${NC}  DUMP SYSTEM INFORMATION            ${YELLOW}│${NC} ${GREEN}A.${NC}  ABOUT AUTHOR                    ${YELLOW}│${NC}"
    echo -e "${YELLOW}${BOLD}│${NC} ${GREEN}8.${NC}  DUMP CPU INFORMATION               ${YELLOW}│${NC} ${RED}EXIT${NC} or Ctrl+C to quit           ${YELLOW}│${NC}"
    echo -e "${YELLOW}${BOLD}│${NC} ${GREEN}9.${NC}  DUMP MEMORY INFORMATION            ${YELLOW}│${NC}                                     ${YELLOW}│${NC}"
    echo -e "${YELLOW}${BOLD}│${NC} ${GREEN}10.${NC} GET PHONE DETAILS                  ${YELLOW}│${NC}                                     ${YELLOW}│${NC}"
    echo -e "${YELLOW}${BOLD}│${NC} ${GREEN}11.${NC} CAPTURE BUG REPORT                 ${YELLOW}│${NC}                                     ${YELLOW}│${NC}"
    echo -e "${YELLOW}${BOLD}│${NC} ${GREEN}12.${NC} INSTALL AN APK                     ${YELLOW}│${NC}                                     ${YELLOW}│${NC}"
    echo -e "${YELLOW}${BOLD}│${NC} ${GREEN}13.${NC} UNINSTALL A PACKAGE                ${YELLOW}│${NC}                                     ${YELLOW}│${NC}"
    echo -e "${YELLOW}${BOLD}│${NC} ${GREEN}14.${NC} LIST ALL INSTALLED PACKAGES        ${YELLOW}│${NC}                                     ${YELLOW}│${NC}"
    echo -e "${YELLOW}${BOLD}│${NC} ${GREEN}15.${NC} SEE LIVE LOG OF DEVICE             ${YELLOW}│${NC}                                     ${YELLOW}│${NC}"
    echo -e "${YELLOW}${BOLD}│${NC} ${GREEN}16.${NC} ESTABLISH REMOTE CONNECTION        ${YELLOW}│${NC}                                     ${YELLOW}│${NC}"
    echo -e "${YELLOW}${BOLD}│${NC} ${GREEN}17.${NC} CAPTURE SCREENSHOT ANONYMOUSLY     ${YELLOW}│${NC}                                     ${YELLOW}│${NC}"
    echo -e "${YELLOW}${BOLD}│${NC} ${GREEN}18.${NC} RECORD SCREEN ANONYMOUSLY          ${YELLOW}│${NC}                                     ${YELLOW}│${NC}"
    echo -e "${YELLOW}${BOLD}│${NC} ${GREEN}19.${NC} COPY ALL CAMERA PHOTOS             ${YELLOW}│${NC}                                     ${YELLOW}│${NC}"
    echo -e "${YELLOW}${BOLD}│${NC} ${GREEN}20.${NC} COPY ALL DOWNLOADS                 ${YELLOW}│${NC}                                     ${YELLOW}│${NC}"
    echo -e "${YELLOW}${BOLD}│${NC} ${GREEN}21.${NC} COPY ALL WHATSAPP DATA             ${YELLOW}│${NC}                                     ${YELLOW}│${NC}"
    echo -e "${YELLOW}${BOLD}│${NC} ${GREEN}22.${NC} COPY ALL DEVICE STORAGE            ${YELLOW}│${NC}                                     ${YELLOW}│${NC}"
    echo -e "${YELLOW}${BOLD}│${NC} ${GREEN}23.${NC} COPY SPECIFIED FILE/FOLDER         ${YELLOW}│${NC}                                     ${YELLOW}│${NC}"
    echo -e "${YELLOW}${BOLD}└─────────────────────────────────────┴─────────────────────────────────────┘${NC}\n"
    
    echo -ne "${RED}${BOLD}${BLINK}⚡${NC} ${UNDERLINE}SELECT AN OPTION${NC} ${RED}${BOLD}➤${NC} ${WHITE}"
    read options
    echo -ne "${NC}"
}

# Check if running as root
if [ $(id -u) -ne 0 ]; then
    pulse_message "❌ THIS SCRIPT MUST BE RUN AS ROOT ❌" "${RED}"
    exit 1
fi

# Check if .temp directory exists
if [ ! -d "$PWD/.temp/" ]; then
    echo -e "${YELLOW}${BOLD}📁 Creating .temp directory...${NC}"
    mkdir -p "$PWD/.temp"
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}${BOLD}✓ Created successfully${NC}"
    fi
fi

# Check if modules directory exists
if [ ! -d "$PWD/modules" ]; then
    echo -e "${RED}${BOLD}❌ Modules directory not found!${NC}"
    echo -e "${YELLOW}Please make sure you're in the correct directory${NC}"
    exit 1
fi

## CALLING THE option list function once
revised=""
option_list

## THE LOOP STARTS FROM HERE
while [ 1 ]; do
    case $options in
        "1" ) echo -e; bash modules/opt1 2>/dev/null || echo -e "${RED}Module opt1 not found${NC}";;
        "2" ) echo -e; bash modules/opt2 2>/dev/null || echo -e "${RED}Module opt2 not found${NC}";;
        "3" ) echo -e; bash modules/opt3 2>/dev/null || echo -e "${RED}Module opt3 not found${NC}";;
        "4" ) echo -e; bash modules/opt4 2>/dev/null || echo -e "${RED}Module opt4 not found${NC}";;
        "5" ) echo -e; bash modules/opt5 2>/dev/null || echo -e "${RED}Module opt5 not found${NC}";;
        "6" ) echo -e; bash modules/opt6 2>/dev/null || echo -e "${RED}Module opt6 not found${NC}";;
        "7" ) echo -e; bash modules/opt7 2>/dev/null || echo -e "${RED}Module opt7 not found${NC}";;
        "8" ) echo -e; bash modules/opt8 2>/dev/null || echo -e "${RED}Module opt8 not found${NC}";;
        "9" ) echo -e; bash modules/opt9 2>/dev/null || echo -e "${RED}Module opt9 not found${NC}";;
        "10") echo -e; bash modules/opt10 2>/dev/null || echo -e "${RED}Module opt10 not found${NC}";;
        "11") echo -e; bash modules/opt11 2>/dev/null || echo -e "${RED}Module opt11 not found${NC}";;
        "12") echo -e; bash modules/opt12 2>/dev/null || echo -e "${RED}Module opt12 not found${NC}";;
        "13") echo -e; bash modules/opt13 2>/dev/null || echo -e "${RED}Module opt13 not found${NC}";;
        "14") echo -e; bash modules/opt14 2>/dev/null || echo -e "${RED}Module opt14 not found${NC}";;
        "15") echo -e; bash modules/opt15 2>/dev/null || echo -e "${RED}Module opt15 not found${NC}";;
        "16") echo -e; bash modules/opt16 2>/dev/null || echo -e "${RED}Module opt16 not found${NC}";;
        "17") echo -e; bash modules/opt17 2>/dev/null || echo -e "${RED}Module opt17 not found${NC}";;
        "18") echo -e; bash modules/opt18 2>/dev/null || echo -e "${RED}Module opt18 not found${NC}";;
        "19") echo -e; bash modules/opt19 2>/dev/null || echo -e "${RED}Module opt19 not found${NC}";;
        "20") echo -e; bash modules/opt20 2>/dev/null || echo -e "${RED}Module opt20 not found${NC}";;
        "21") echo -e; bash modules/opt21 2>/dev/null || echo -e "${RED}Module opt21 not found${NC}";;
        "22") echo -e; bash modules/opt22 2>/dev/null || echo -e "${RED}Module opt22 not found${NC}";;
        "23") echo -e; bash modules/opt23 2>/dev/null || echo -e "${RED}Module opt23 not found${NC}";;
        "24") echo -e; bash modules/opt24 2>/dev/null || echo -e "${RED}Module opt24 not found${NC}";;
        "25") 
            echo -e "${YELLOW}${BOLD}🔄 Switching to Metasploit section...${NC}"
            if [ -f "modules/function2.sh" ]; then
                bash modules/function2.sh
            else
                echo -e "${RED}${BOLD}❌ Metasploit module not found!${NC}"
            fi
            break;;
        "26") echo -e; bash modules/opt26 2>/dev/null || echo -e "${RED}Module opt26 not found${NC}";;
        "27") echo -e; bash modules/opt27 2>/dev/null || echo -e "${RED}Module opt27 not found${NC}";;
        "28") echo -e; bash modules/opt28 2>/dev/null || echo -e "${RED}Module opt28 not found${NC}";;
        "29") echo -e; bash modules/opt29 2>/dev/null || echo -e "${RED}Module opt29 not found${NC}";;
        "A" | "a" ) 
            if [ -f "modules/about" ]; then
                bash modules/about
            else
                echo -e "${PURPLE}${BOLD}╔════════════════════════════════════╗${NC}"
                echo -e "${PURPLE}${BOLD}║     ABOUT THE AUTHOR              ║${NC}"
                echo -e "${PURPLE}${BOLD}╚════════════════════════════════════╝${NC}"
                echo -e "${CYAN}${BOLD}Developer: ${YELLOW}A T H E X${NC}"
                echo -e "${CYAN}${BOLD}Tool: ${YELLOW}ANDRO-EYE${NC}"
                echo -e "${CYAN}${BOLD}Version: ${YELLOW}$current_version${NC}"
                echo -e "${CYAN}${BOLD}Purpose: ${YELLOW}Android Security Testing${NC}"
            fi
            ;;
        "exit" | "EXIT" | "quit" | "QUIT")
            clean_exit
            ;;
        *) 
            clear
            pulse_message "❌ INVALID OPTION! Please try again ❌" "${RED}"
            revised="\n${RED}${BOLD}✗ Please enter a valid option ✗${NC}\n"
            option_list
            ;;
    esac
    
    # After executing option, ask to continue or exit
    if [ "$options" != "25" ]; then
        echo -e "\n${YELLOW}${BOLD}════════════════════════════════════════${NC}"
        echo -ne "${GREEN}${BOLD}Press Enter to continue or 'q' to quit: ${NC}"
        read continue_choice
        if [ "$continue_choice" = "q" ] || [ "$continue_choice" = "Q" ]; then
            clean_exit
        fi
        clear
        option_list
    fi
done

#### END OF THIS SCRIPT ####