#!/bin/bash
# Author:
#	MeowIce <furrythecat@Meowmail.ml>
#
# About this scriptset:
#	A scriptset to configure and install applications for Ubuntu and its derivatives.
# Notes:
# 	This script is freeware. You can redistribute it and/or mofity it the terms of the GLP v3.
# 	This script came WITHOUT ANY WARRANTY !
#	You should have received a copy of the GNU General Public License along with this script. If not
# see <https://www.gnu.org/licenses/gpl-3.0.txt>
#	If you found a bug, please open an issue :)


#Info
Ver='1.0'
Auth='MeowIce'
# Color mapping ( DO NOT TOUCH )
UWhi='\e[4;37m'
BRed='\e[1;31m'
BGre='\e[1;32m'
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
BWhi='\e[1;37m'
Yel='\e[0;33m'
BYel='\e[1;33m'
Whi='\e[0;37m'
#Begin checks
clear
printf "
---------------------------------------------------------\n
|		${BGre}Welcome $(whoami)${NC}. Please wait while
| 	     we are checking your system requirements !\n
---------------------------------------------------------\n"
sleep 3
#I blocked Ctrl - C as if user press it, left over files will not be removed.
#COMMENT IF YOU WANT TO ALLOW CTRL - C.
trap '' SIGINT
#Temp folder
mkdir .postinsttmp
#Check system
printf "${Yel}[Info] Checking system...${NC}\n"
echo -ne "\033]0;Terminal | Checking system...\007"
printf "${Yel}[Info] Checking which OS you are running...${NC}\n"
OS_NAME="Linux"
if [[ $(uname) != "$OS_NAME" ]]; then
	printf "${BRed}[Error] You don't appear to be using $OS_NAME. Quitting${NC}\n"
	exit 02
else
	printf "${GREEN}[OK] Current OS is${GREEN} "$(uname)
	printf "\n"
	fi
#Now check distro
if [[ $(which lsb_release &>/dev/null; echo $?) != 0 ]]; then
	printf "${BRed}[Error] Unable to check which distro you're running. Quitting.${NC}\n"
	exit 03
else
	if lsb_release -ds | grep -qE '(Ubuntu)'; then
	printf "${GREEN}[Info] You are using Ubuntu...OK${NC}\n"
elif lsb_release -ds | grep -qE '(Mint|elementary|Pop|Lubuntu|Kubuntu|Xubuntu|Zorin|Feren)'; then
	printf "${Yel}[Caution] You are running another distro which is Ubuntu-based.${NC}\n"
elif lsb_release -ds | grep -q 'Debian'; then
	printf "${Yel}[Caution] You are using Debian. This is not recommended.${NC}\n"
else
	printf "${BRed}[Error] You are using a distro which is not compatible with this script. Quitting${NC}\n"
	exit 04
	fi
fi
#Check user privileges
printf "${Yel}[Info] Now checking current user...\n"
if [[ $EUID != 0 ]]; then
	if [[ $(groups $USER | grep -q 'sudo'; echo $?) != 0 ]]; then
		printf "${BRed}[Error] This user account does not have sudo privileges. Login as a user with sudo provileges to continue.\n"
		exit 05
	else
	printf "${GREEN}[Info] Current user has sudo privileges\n"
	fi
fi
if [ "$(whoami)" = "root" ]; then
	printf "${BRed}[Caution] You've logged in as root. This is not recommended btw.${NC}\n"
	while true; do
    read -p "[!] Do you want to continue as root ? (Yes/no) =>" yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
else
	printf "${GREEN}User not logged in as root...OK\n"
	fi
printf "${Yel}[Info] Now checking for installed packages...\n"
if [ $(wget&> .postinsttmp/chk.log | grep "command not found") ]; then
	printf "${BRed}This script requires this package installed to continue: ${NC}${BWhi}wget${NC}\n"
	while true; do
    read -p "Do you want to install this package ? (Yes/no) =>" yn
    case $yn in
        [Yy]* ) sudo apt install wget -y && break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
else
	printf "${GREEN}Package ${NC}${BWhi}wget${NC}${GREEN} installed...OK${NC}\n"
fi
if [ $(curl&> .postinsttmp/chk.log | grep "command not found") ]; then
	printf "${BRed}This script requires this package installed to continue: ${NC}${BWhi}curl${NC}\n"
	while true; do
    read -p "Do you want to install this package ? (Yes/no) =>" yn
    case $yn in
        [Yy]* ) sudo apt install curl -y && break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
else
	printf "${GREEN}Package ${NC}${BWhi}curl${NC}${GREEN} installed...OK${NC}\n"
fi
#Check is done
printf "${BGre}###### Check complete. Opening menu... ######\n"
sleep 5
while true
do
#Loóp the script
clear
printf "${RED}Ubuntu${NC} ${GREEN}Post-Installation Script\n"
echo "Version: ${Ver}"
echo "Written by ${Auth}."
printf "${BGRe}###### What do you want to do ? ######${NC}\n"
echo -ne "\033]0;Terminal | Prompt\007"
echo "-> 1. Update my system"
echo "-> 2. Configure my system"
echo "-> 3. Cleanup my system"
echo "-> 4. Optimize my system"
echo "-> 5. Install media codecs, fonts & additional applications"
echo "-> 6. Quit"
echo "[#] Your choice: "
read OPT
if [ "$OPT" == "1" ]; then
	clear
	printf "${GREEN}You've selected option 1 which is ${BWhi}System Update.${NC}\n"
	echo -ne "\033]0;Terminal | Performing system update\007"
	echo "The process will start after 3 seconds."
	sleep 3
	echo "Performing system update..."            
		if [[ $(sudo apt update 2> .postinsttmp/upd.log | grep "up to date") ]]; then
			printf "${GREEN}[OK]Your system is already up-to-date. No need to update.${NC}\n"
		else
			while true; do
    			read -p "[!] Updates found. Upgrade them? (Yes/no) =>" yn
				case $yn in
        			[Yy]* ) break;;
        			[Nn]* ) exit 01;;
        			* ) echo "Please answer yes or no.";;
    			esac
			done
			sudo apt upgrade -y
			printf "${GREEN}[OK] System Update is now done. Returning to main menu...${NC}\n"
		fi
	sleep 3
	#System configurating and troubleshooting module
	elif [ "$OPT" == "2" ]; then
	clear
	printf "${GREEN}You've selected option 2 which is ${BWhi}Configure my system.${NC}\n"
	echo "Please select an option"
	echo "--> 1. Disable nouveau driver to install nVIDIA."
	echo "--> 2. Disable App Crash Report."
	echo "--> 3. Hide snap directory in home folder."
	echo "--> 4. Fix 'Install RELEASE' showing in Launcher/Dock."
	echo "--> 5. Fix nVIDIA driver libgtk-x11-2.0.so.0 error."
	echo "--> 6. Go back"
	echo "[#] Your choice:"
	read OPT_CFG
	if [ "$OPT_CFG" == "1" ]; then
		clear
		echo -ne "\033]0;Terminal | Blacklist nouveau\007"
   		sudo bash -c "echo blacklist nouveau > /etc/modprobe.d/blacklist-nvidia-nouveau.conf"
		sudo bash -c "echo options nouveau modeset=0 >> /etc/modprobe.d/blacklist-nvidia-nouveau.conf"
		sudo update-initramfs -u&> .postinsttmp/nvidia.log
		sleep 3
		printf "${GREEN}Blacklisted nouveau driver. Now returning to main menu...\n"
	elif [ "$OPT_CFG" == "2" ]; then
		clear
		echo -ne "\033]0;Terminal | Disable App Crash Report\007"
		echo -ne "\033]0;Terminal | Disabling App Crash Report...\007"
		if [[ $(cat '/etc/default/apport' | grep -q 'enabled=0'; echo $?) != 0 ]]; then
			printf "${Yel}Disabling App Crash Report...${NC}\n"
			sudo sed --in-place s/enabled=1/enabled=0/g /etc/default/apport&> .postinsttmp/dacr.log
			printf "${GREEN}Disabled App Crash Report. Returning to main menu...\n"
			sleep 3
		else
			printf "${GREEN}App Crash Report is already disabled. Returning to main menu...\n"
			sleep 3
		fi
	elif [ "$OPT_CFG" == "3" ]; then
		clear
		echo -ne "\033]0;Terminal | Hiding 'snap' folder...\007"
		printf "${Yel}Hiding 'snap' folder in user home...${NC}\n"
		echo snap >> ~/.hidden&> .postinsttmp/hsnp.log
		printf "${GREEN}Hidden 'snap' folder in user home. Returning to main menu...\n"
		sleep 3
	elif [ "$OPT_CFG" == "4" ]; then
		clear
		echo -ne "\033]0;Terminal | Fixing Ubiquity\007"
		printf "${Yel}Fixing 'Install RELEASE' bug...${NC}\n"
		sudo apt-get remove ubiquity&> .postinsttmp/firb.log
		printf "${GREEN}Fixed 'Install RELEASE' bug. Returning to main menu...\n"
		sleep 3
	elif [ "$OPT_CFG" == "5" ]; then
		clear
		printf "${Yel}Fixing nVIDIA GTK...${NC}\n"
		echo -ne "\033]0;Terminal | Fixing nVIDIA GTK...\007"
		sudo apt install --reinstall libgtk2.0-0 -y&> .postinsttmp/nvfix.log
		printf "${GREEN}Fixed nVIDIA GTK error. Returning to main menu...\n"
		sleep 3
	elif [ "$OPT_CFG" == "6" ]; then
		sleep 0
	else
		echo "[X] Invalid option. Returning to main menu.... Returning to main menu..."
		sleep 3
	fi
#System Cleanup module
elif [ "$OPT" == "3" ]; then
	clear
	printf "${GREEN}You've selected option 3 which is ${BWhi}Cleanup the system.${NC}\n"
	echo -ne "\033]0;Terminal | Cleanup...\007"
	printf "${Yel}Cleaning up...${NC}\n"
	sudo apt auto-remove -y&> .postinsttmp/aptcl.log
	sudo apt clean&> .postinsttmp/aptcl.log
	printf "${GREEN}Cleaned up APT cache and unused packages.${NC}\n"
	while true; do
    	read -p "[!]Delete bash history (executed commands in terminal) ? (Yes/no) =>" yn
			case $yn in
        		[Yy]* ) rm -rf /home/$USER/.bash_history;;
        		[Nn]* ) break;;
        		* ) echo "Please answer yes or no.";;
    	esac
	done
	printf "${GREEN}Finished cleaning up. Returning to main menu...${NC}\n"
	sleep 3
#Optimization module
elif [ "$OPT" == "4" ]; then
	clear
	echo -ne "\033]0;Terminal | Optimize\007"
	printf "${GREEN}You've selected option 3 which is ${BWhi}Optimize my system.${NC}\n"
	prinf "${UWhi}List of tasks to do:${NC}\n"
	echo "1. Preload application"
	echo "2. Optimize swap" 
	echo "3. Install zram"
	echo "4. Install TLP"
	echo "5. Change CPU to High Performance mode."
	while true; do
    	read -p "Do you want to install preload ? (Yes/no) =>" yn
    	case $yn in
        [Yy]* ) 
			printf "${Yel}Installing preload. Please wait...${NC}\n"
			sudo apt install preload -y&> .postinsttmp/prld.log
			sudo systemctl start preload.service&> .postinsttmp/prld.log
			sudo systemctl enable preload.service&> .postinsttmp/prld.log
			printf "${GREEN}Installed preload.${NC}\n"
			break
			;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    	esac
	done
	while true; do
    	read -p "Do you want to optimize swap ? (Yes/no) =>" yn
    	case $yn in
        [Yy]* ) 
			echo "Current swappiness: "$(cat /proc/sys/vm/swappiness)
			sudo sysctl vm.swappiness=10&> .postinsttmp/swp.log
			sudo echo "vm.swappiness=10" >> /etc/sysctl.conf&> .postinsttmp/swp.log
			printf "${GREEN}Optimized swap.${NC}\n"
			echo "Optimized swappiness: 10"
			break
			;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    	esac
	done
	while true; do
    	read -p "Do you want to install zram ? (Yes/no) =>" yn
    	case $yn in
        [Yy]* ) 
			printf "${Yel}Installing zram. Please wait...${NC}\n"
			sudo apt install zram-config -y&> .postinsttmp/zram.log
			printf "${GREEN}Installed zram.${NC}\n"
			break
			;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    	esac
	done
	while true; do
    	read -p "Do you want to install TLP ? (Yes/no) =>" yn
    	case $yn in
        [Yy]* ) 
			sudo apt install tlp tlp-rdw -y&> .postinsttmp/tlp.log
			sudo tlp start&> .postinsttmp/tlp.log
			printf "${GREEN}Installed TLP.${NC}\n"
			break
			;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    	esac
	done
	while true; do
    	read -p "Do you want to change CPU to High Performance mode ? (Yes/no) =>" yn
    	case $yn in
        [Yy]* ) 
			echo 'GOVERNOR="performance"' | sudo tee /etc/default/cpufrequtils
			printf "${GREEN}Changed CPU to HP mode.${NC}\n"
			break
			;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    	esac
	done
	printf "${GREEN}Done optimization.${NC}\n"
#App installation modules
elif [ "$OPT" == "5" ]; then
	clear
	printf "${GREEN}You've selected option 3 which is ${BWhi}Install additional applications.${NC}\n"
	printf "${UWhi}Please select an option:${NC}\n"
	echo "--> 1. Install multimedia codecs."
	echo "--> 2. Install Microsoft Core Fonts."
	echo "--> 3. Install Emoji One."
	echo "--> 4. Install Font Manager application."
	echo "--> 5. Install Additional applications."
	echo "--> 6. Go back"
	echo "[#] Your option:"
	read OPT_AD
	if [ "$OPT_AD" == "1" ]; then
		clear
		printf "${Yel}Installing media codecs. Please wait...${NC}\n"
		sudo add-apt-repository multiverse -y&> .postinsttmp/mc.log
		sudo apt update&> .postinsttmp/mc.log
		sudo apt install ubuntu-restricted-extras -y&> .postinsttmp/mc.log
		printf "${GREEN}Installed media codecs.${NC}\n"
		sleep 3
	elif [ "$OPT_AD" == "2" ]; then
		clear
		echo -ne "\033]0;Terminal | Installing Microsoft Core fonts...\007"
		printf "${Yel}Installing Microsoft Core fonts. Please wait...${NC}\n"
		sudo add-apt-repository multiverse -y&> .postinsttmp/msf.log
		sudo apt update&> .postinsttmp/msf.log
		sudo apt install ttf-mscorefonts-installer -y&> .postinsttmp/msf.log
		printf "${GREEN}Installed Microsoft Core fonts.${NC}\n"
		sleep 3
	elif [ "$OPT_AD" == "3" ]; then
		clear
		echo -ne "\033]0;Terminal | Installing Emoji One fonts...\007"
		printf "${Yel}Installing Emoji One fonts. Please wait...${NC}\n"
		sudo apt-get install fonts-emojione -y&> .postinsttmp/emjf.log
		printf "${GREEN}Installed Emoji One fonts.${NC}\n"
		sleep 3
	elif [ "$OPT_AD" == "4" ]; then
		clear
		echo -ne "\033]0;Terminal | Installing Font Manager...\007"
		printf "${Yel}Installing Font Manager. Please wait...${NC}\n"
		sudo apt install font-manager -y&> .postinsttmp/fma.log
		printf "${GREEN}Installed Font Manager.${NC}\n"
		sleep 3
	elif [ "$OPT_AD" == "5" ]; then
		clear
		printf "${UWhi}Choose an app to install:${NC}\n"
		printf "${BGre}######### Web Browsers${NC}\n"
		echo "1. Google Chrome"
		echo "2. Mozilla Firefox"
		echo "3. Opera"
		printf "${BGre}######### SSH/SFTP/FTP${NC}\n"
		echo "4. OpenSSH server"
		echo "5. Filezilla"
		echo "6. gFTP"
		echo "7. qBittorren"
		printf "${BGre}######### Archive Manager${NC}\n"
		echo "8. Unzip"
		echo "9. Unrar"
		printf "${BGre}######### Media Player${NC}\n"
		echo "10. VLC Media Player"
		echo "11. mpv"
		printf "${BGre}######### Clipboard Manager${NC}\n"
		echo "12. Copyq"
		echo "13. Go back"
		echo "Your option:"
		read OPT_APP
		if [ "$OPT_APP" == "1" ]; then
			while true; do
			clear
			printf "${Yel}Installing Google Chrome. Please wait...${NC}\n"
			echo -ne "\033]0;Terminal | Installing Google Chrome...\007"
			wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb&> .postinsttmp/ggchrm.log &&
			sudo dpkg -i google-chrome-stable_current_amd64.deb&> ../.postinsttmp/ggchrm.log &&
			printf "${GREEN}Installed Google Chrome. Returning to main menu...${NC}\n"
			sleep 3
			break
			done
		elif [ "$OPT_APP" == "2" ]; then
			while true; do
			clear
			if [ $(firefox --version | grep "Mozilla Firefox" ) ]; then
				printf "${GREEN}Firefox is already installed. Returning to main menu...${NC}\n"
				sleep 3
			else
				echo "Select source to install Mozilla Firefox:"
				echo "1. From apt (Ubuntu repo)(recommended)."
				echo "2. From Mozilla repo."
				echo "3. Go back"
				read OPT_FF
				if [ "$OPT_FF" == "1" ]; then
					clear
					printf "${Yel}Installing Mozilla Firefox from APT. Please wait...${NC}\n"
					echo -ne "\033]0;Terminal | Installing Mozilla Firefox...\007"
					sudo apt install firefox -y&> .postinsttmp/ffinst.log
					printf "${GREEN}Installed Firefox from APT. Returning to main menu...${NC}\n"
					sleep 3
					break
				elif [ "$OPT_FF" == "2" ]; then
					clear
					printf "${Yel}Installing Mozilla Firefox from Mozilla repo. Please wait...${NC}\n"
					echo -ne "\033]0;Terminal | Installing Mozilla Firefox...\007"
					curl -L -o firefox.tar.bz2 https://download-installer.cdn.mozilla.net/pub/firefox/releases/101.0.1/linux-x86_64/en-US/firefox-101.0.1.tar.bz2
					tar -xf firefox.tar.bz2&> .postinsttmp/ffinstmr.log
					sudo mv firefox /opt
					sudo ln -s /opt/firefox/firefox /usr/bin/firefox&> .postinsttmp/ffinstmr.log
					echo -e "[Desktop Entry]\nEncoding=UTF-8\nName=Firefox\nComment=Firefox\nExec=/opt/firefox/firefox %u\nTerminal=false\nIcon=/opt/firefox/browser/chrome/icons/default/default128.png\nStartupWMClass=Firefox\nType=Application\nCategories=Network;WebBrowser;\nMimeType=text/html;text/xml;application/xhtml+xml;application/xml;application/vnd.mozilla.xul+xml;application/rss+xml;application/rdf+xml;x-scheme-handler/http;x-scheme-handler/https;\nStartupNotify=true\n" | sudo tee -a /usr/share/applications/firefox.desktop
&> ../.postinsttmp/ffinstmr.log
					printf "${GREEN}Installed Firefox from Mozilla repo. Returning to main menu...${NC}\n"
					sleep 3
				elif [ "$OPT_FF" == "3" ]; then
					break
				else
					echo "[X] Invalid option. Returning to main menu..."
				fi
			fi
			done
		elif [ "$OPT_APP" == "3" ]; then
			while true; do
			clear
			echo -ne "\033]0;Terminal | Installing Opera...\007"
			printf "${Yel}Installing Opera. Please wait...${NC}\n"
			wget https://download3.operacdn.com/pub/opera/desktop/88.0.4412.27/linux/opera-stable_88.0.4412.27_amd64.deb&> .postinsttmp/oprinst.log
			sudo dpkg -i opera-stable_88.0.4412.27_amd64.deb&> .postinsttmp/oprinst.log
			printf "${GREEN}Installed Opera. Returning to main menu...${NC}\n"
			sleep 3
			break
			done
		elif [ "$OPT_APP" == "4" ]; then
			while true; do
			clear
			echo -ne "\033]0;Terminal | Installing OpenSSH...\007"
			printf "${Yel}Installing OpenSSH. Please wait...${NC}\n"
			sudo apt install openssh-server -y&> .postinsttmp/ossh.log
			if [ $(ufw | grep "command not found") ]; then
			while true; do
    			read -p "[!] Install ufw ? (Yes/no) =>" yn
				case $yn in
        			[Yy]* ) break;;
        			[Nn]* ) exit 01;;
        			* ) echo "Please answer yes or no.";;
    			esac
			done
			sudo apt install ufw -y&> .postinsttmp/ufw.log
			sudo ufw allow ssh&> .postinsttmp/ufw.log
			printf "${GREEN}Installed OpenSSH without ufw allowed. Returning to main menu...${NC}\n"
			sleep 3
			break
			else
				printf "${GREEN}Installed OpenSSH with ufw allowed. Returning to main menu...${NC}\n"
				sleep 3
				break
			fi
			done
		elif [ "$OPT_APP" == "5" ]; then
			while true; do
			clear
			echo -ne "\033]0;Terminal | Installing Filezilla...\007"
			printf "${Yel}Installing Filezilla. Please wait...${NC}\n"
			sudo apt install filezilla -y&> .postinsttmp/fz.log
			printf "${GREEN}Installed Filezilla. Returning to main menu...${NC}\n"
			sleep 3
			break
			done
		elif [ "$OPT_APP" == "6" ]; then
			while true; do
			clear
			echo -ne "\033]0;Terminal | Installing gFTP...\007"
			printf "${Yel}Installing gFTP. Please wait...${NC}\n"
			sudo apt install gftp -y&> .postinsttmp/gftp.log
			printf "${GREEN}Installed gFTP. Returning to main menu...${NC}\n"
			sleep 3
			break
			done
		elif [ "$OPT_APP" == "7" ]; then
			while true; do
			clear
			echo -ne "\033]0;Terminal | Installing qBittorrent...\007"
			printf "${Yel}Installing qBittorrent. Please wait...${NC}\n"
			sudo apt install qbittorrent -y&> .postinsttmp/qb.log
			printf "${GREEN}Installed qBittorrent. Returning to main menu...${NC}\n"
			sleep 3
			break
			done
		elif [ "$OPT_APP" == "8" ]; then
			while true; do
			clear
			echo -ne "\033]0;Terminal | Installing unzip...\007"
			printf "${Yel}Installing unzip. Please wait...${NC}\n"
			sudo apt install unzip -y&> .postinsttmp/uz.log
			printf "${GREEN}Installed unzip. Returning to main menu...${NC}\n"
			sleep 3
			break
			done
		elif [ "$OPT_APP" == "9" ]; then
			while true; do
			clear
			echo -ne "\033]0;Terminal | Installing unrar...\007"
			printf "${Yel}Installing unrar. Please wait...${NC}\n"
			sudo apt install unrar -y&> .postinsttmp/ur.log
			printf "${GREEN}Installed unrar. Returning to main menu...${NC}\n"
			sleep 3
			break
			done
		elif [ "$OPT_APP" == "10" ]; then
			while true; do
			clear
			echo -ne "\033]0;Terminal | Installing VLC...\007"
			printf "${Yel}Installing VLC. Please wait...${NC}\n"
			sudo apt install vlc&> .postinsttmp/vlc.log
			printf "${GREEN}Installed VLC.${NC}\n"
			sleep 3
			break
			done
		elif [ "$OPT_APP" == "11" ]; then
			while true; do
			clear
			echo -ne "\033]0;Terminal | Installing mpv...\007"
			printf "${Yel}Installing mpv. Please wait...${NC}\n"
			sudo apt install mpv -y&> .postinsttmp/mpv.log
			printf "${GREEN}Installed mpv.${NC}\n"
			sleep 3
			break
			done
		elif [ "$OPT_APP" == "12" ]; then
			while true; do
			clear
			echo -ne "\033]0;Terminal | Installing Copyq...\007"
			printf "${Yel}Installing Copyq. Please wait...${NC}\n"
			sudo apt install copyq -y&> .postinsttmp/cpq.log
			printf "${GREEN}Installed Copyq.${NC}\n"
			sleep 3
			break
			done
		elif [ "$OPT_APP" == "13" ]; then
			sleep 0
		else
			echo "[X] Invalid option. Returning to main menu..."
			sleep 2
		fi
	elif [ "$OPT_AD" == "6" ]; then
		sleep 0
	else
		echo "[X] Invalid option. Returning to main menu..."
		sleep 2
	fi
elif [ "$OPT" == "6" ]; then
	clear
	printf "${RED}You've selected option 6 which is ${BWhi}Quit the script${NC}.\nNow quitting.\nCleaning up before quitting...\n"
	echo -ne "\033]0;Cleaning up before quitting.\007"
	rm -rf .postinsttmp/
	sleep 3
	printf "
	---------------------------------------------------------\n
	|		${BGre}Script made by ${Auth}${NC}			|\n
	|		${BWhi}Github:${NC} github.com/${Auth}		|\n
	|		${BWhi}Discord:${NC} ${Auth}#8543			|\n
	---------------------------------------------------------\n"
	break
else
	echo "[X] Invalid option."
	sleep 2
fi
done

