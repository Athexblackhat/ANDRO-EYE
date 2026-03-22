#!/bin/bash

# ASCII Banner
display_banner() {
    clear
    echo -e "\e[1;92m"
    cat << "EOF"
 _______  __    _  ______   ______    _______    _______  __   __  _______ 
|   _   ||  |  | ||      | |    _ |  |       |  |       ||  | |  ||       |
|  |_|  ||   |_| ||  _    ||   | ||  |   _   |  |    ___||  |_|  ||    ___|
|       ||       || | |   ||   |_||_ |  | |  |  |   |___ |       ||   |___ 
|       ||  _    || |_|   ||    __  ||  |_|  |  |    ___||_     _||    ___|
|   _   || | |   ||       ||   |  | ||       |  |   |___   |   |  |   |___ 
|__| |__||_|  |__||______| |___|  |_||_______|  |_______|  |___|  |_______|
                  🔍 ANDRO-EYE - Android Security Tool 🔍    
EOF
    echo -e "\e[0m"
}

# Loading animation
loading_animation() {
    local message=$1
    local chars="⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏"
    
    echo -ne "\e[1;96m$message \e[0m"
    for i in {1..20}; do
        for char in $(echo $chars | grep -o .); do
            echo -ne "\e[1;93m$char\e[0m"
            sleep 0.05
            echo -ne "\b"
        done
    done
    echo -e "\e[1;92m Done! \e[0m"
}

# Progress bar animation
progress_bar() {
    local duration=$1
    local message=$2
    
    echo -ne "\e[1;96m$message \e[0m"
    for i in {1..50}; do
        echo -ne "\e[1;92m▓\e[0m"
        sleep $(echo "scale=2; $duration/50" | bc)
    done
    echo -e "\e[1;92m Complete! \e[0m"
}

# Pulse animation for important messages
pulse_message() {
    local message=$1
    local color=$2
    
    for i in {1..3}; do
        echo -ne "\e[${color}m$message\e[0m"
        sleep 0.3
        echo -ne "\r"
        for j in $(seq 1 ${#message}); do
            echo -n " "
        done
        echo -ne "\r"
        sleep 0.3
    done
    echo -e "\e[${color}m$message\e[0m"
}

# Matrix rain effect for fun
matrix_effect() {
    echo -e "\e[1;92m"
    for i in {1..20}; do
        for j in {1..40}; do
            if [ $((RANDOM % 5)) -eq 0 ]; then
                echo -n $((RANDOM % 2))
            else
                echo -n " "
            fi
        done
        echo
        sleep 0.05
    done
    echo -e "\e[0m"
}

# Display banner at start
display_banner
sleep 1

echo -e "\n\e[1;95m✨ Argument used: '\e[1;93m$1\e[1;95m'\e[0m\n"

if [ $(id -u) -ne 0 ]; then
    pulse_message "⚠️  THE INSTALLATION SCRIPT MUST BE RUN AS ROOT ⚠️" "1;91"
    exit 1
fi

help () {
    echo -e "\n\e[1;96m                                   "
    echo -e "            INSTALLATION OPTIONS             "
    echo -e "                                      \e[0m\n"
    echo -e "To install ANDRO-EYE use:-\n"
    echo -e "  \e[1;92m➜\e[0m \e[1;93msudo bash $0 install\e[0m"
    echo -e "  \e[1;92m➜\e[0m \e[1;93msudo bash $0 -i\e[0m"
    echo -e "  \e[1;92m➜\e[0m \e[1;93msudo bash $0 -install\e[0m\n"
}

opt_install () {
    loading_animation "🔍 Detecting distribution"
    
    distro=$(awk '/^ID_LIKE=/' /etc/*-release | awk -F'=' '{ print tolower($2) }')

    if [ "$distro" == "" ]; then
        distro=$(awk '/^ID=/' /etc/*-release | awk -F'=' '{ print tolower($2) }')
    fi

    echo -e "\n\e[1;96m📦 Detected distribution: \e[1;93m$distro\e[0m\n"

    ## DEBIAN INSTALLER ##
    debian_install () {
        progress_bar 2 "📥 Installing ADB"
        apt-get install adb -y > /dev/null 2>&1
        echo -e "\e[1;92m✓ ADB installed\e[0m"
        
        progress_bar 2 "📥 Installing Fastboot"
        apt-get install fastboot -y > /dev/null 2>&1
        echo -e "\e[1;92m✓ Fastboot installed\e[0m"
        
        progress_bar 2 "📥 Installing Ruby"
        apt-get install ruby-full -y > /dev/null 2>&1
        echo -e "\e[1;92m✓ Ruby installed\e[0m"
        
        loading_animation "⚙️  Setting up Metasploit"
        curl -s https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall
        chmod +x msfinstall && ./msfinstall > /dev/null 2>&1
    }

    ## ARCH INSTALLER ##
    arch_install () {
        progress_bar 2 "📥 Installing Android tools"
        pacman -S --noconfirm android-tools > /dev/null 2>&1
        echo -e "\e[1;92m✓ Android tools installed\e[0m"
        
        progress_bar 2 "📥 Installing Ruby"
        pacman -S --noconfirm ruby > /dev/null 2>&1
        echo -e "\e[1;92m✓ Ruby installed\e[0m"
        
        progress_bar 2 "📥 Installing Metasploit"
        pacman -S --noconfirm metasploit > /dev/null 2>&1
        echo -e "\e[1;92m✓ Metasploit installed\e[0m"
    }

    ## CENTOS INSTALLER ##
    centos_install () {
        progress_bar 2 "📥 Installing Android tools"
        yum install -y android-tools > /dev/null 2>&1
        echo -e "\e[1;92m✓ Android tools installed\e[0m"
        
        progress_bar 2 "📥 Installing Ruby"
        yum install -y ruby > /dev/null 2>&1
        echo -e "\e[1;92m✓ Ruby installed\e[0m"
        
        loading_animation "⚙️  Setting up Metasploit"
        curl -s https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall
        chmod +x msfinstall && ./msfinstall > /dev/null 2>&1
    }

    ## FEDORA INSTALLER ##
    fedora_install () {
        progress_bar 2 "📥 Installing Android tools"
        dnf install -y android-tools > /dev/null 2>&1
        echo -e "\e[1;92m✓ Android tools installed\e[0m"
        
        echo -e "\n\e[1;93m⚠️  PLEASE INSTALL THE METASPLOIT FRAMEWORK MANUALLY\e[0m\n"
    }

    case $distro in 
        "debian") debian_install;;
        "arch") arch_install;;
        "centos") centos_install;;
        "fedora") fedora_install;;
        *) echo -e "\e[1;91m❌ THE DISTRO $distro IS NOT IDENTIFIED PLEASE MANUALLY INSTALL 'ADB' & 'FASTBOOT' FOR YOUR DISTRO.\e[0m"; exit 1;;
    esac

    if [ $? == 0 ]; then
        matrix_effect
        display_banner
        
        loading_animation "🔧 Finalizing installation"
        
        chmod +x ANDRO-EYE.sh
        touch ~/.bash_aliases 2> /dev/null
        mkdir $PWD/.temp 2> /dev/null
        echo "alias ANDRO-EYE='cd $PWD && sudo bash ANDRO-EYE.sh'" >> ~/.bash_aliases
        source ~/.bash_aliases
        
        echo -e "\n\e[1;92m                                     "
        echo -e "      ✅ INSTALLATION COMPLETED SUCCESSFULLY   "
        echo -e "                                         \e[0m\n"
        echo -e "\e[1;96m📌 USAGE:\e[0m"
        echo -e "  \e[1;92m➜\e[0m \e[1;93msudo ./ANDRO-EYE.sh\e[0m"
        echo -e "  \e[1;92m➜\e[0m \e[1;93msudo ANDRO-EYE\e[0m (from anywhere in shell)\n\n"
    fi
}

if [[ ("$1" = "install" || "$1" = "-i" || "$1" = "-install") ]]; then
    opt_install
else
    help
fi