#!/bin/bash

current_date=`date +%Y-%m-%dT%T%:z`

red=`tput setaf 1`
green=`tput setaf 2`
cyan=`tput setaf 6`
normal=`tput setaf 7`
yellow=`tput setaf 3`

tput setaf 6; cat << "EOF"

  _______   _                          _______                   
 |__   __| | |                        |__   __|                  
    | | ___| |__   ___  _   _ _ __   __ _| | ___  __ _ _ __ ___  
    | |/ __| '_ \ / _ \| | | | '_ \ / _` | |/ _ \/ _` | '_ ` _ \ 
    | | (__| | | | (_) | |_| | |_) | (_| | |  __/ (_| | | | | | |
    |_|\___|_| |_|\___/ \__,_| .__/ \__,_|_|\___|\__,_|_| |_| |_|
                             | |                                 
                             |_|                                 
EOF
echo -e "\nWrite-up generator ${yellow}v0.1${cyan} by ${red}ChapeauR0uge${normal}"
echo -e "-------------------------------------------------------------------"

echo -e "Write UP directory to add on the server:"
tput setaf 6; read source_path; tput setaf 7
if ! [[ -d ${source_path} ]]
then
    echo "${red}error: ${source_path} not found"
    exit 1
fi

for entry in `ls ${source_path}`; do
    echo -e "${yellow} found: ${entry} ${normal}"
done

echo -e "Continue (press ${cyan}0${normal} for yes) ?"
tput setaf 6; read res; tput setaf 7

if ! [[ $res -eq 0 ]]; then
    echo -e "${red}Aborted"
    exit 1
fi
echo -e "${green}[+] '${source_path}' selected${normal}"
echo -e "Choose the event:"

declare -a event_choice

for entry in `ls ./content/posts`; do
    event_choice+=($entry)
done

i=0
for all in ${event_choice[@]}; do
    echo -e "${cyan}${i}${normal} - ${all}"
    ((i+=1)) 
done

tput setaf 6; read choice; tput setaf 7

if ! [[ -v "event_choice[${choice}]" ]]; then
    echo -e "${red}Error: event not found"
    exit 1
fi

choice=${event_choice[${choice}]}

echo -e "${green}[+] ${choice} event selected${normal}" 

echo -e "Challenge name (no special char just (only space allowed)): "

tput setaf 6; read chall_name; tput setaf 7

if [[ "$chall_name" =~ [^a-zA-Z0-9\ ] ]]; then
    echo -e "${red}Error: char forbidden${normal}"
    exit 1
fi

title=$(echo -e "${chall_name}" | tr '[a-z]' '[A-Z]')
file_name=$(echo -e "${chall_name}" | tr '[A-Z]' '[a-z]' | tr ' ' -)
if [[ -f "./content/posts/${choice}/${file_name}.md" ]]; then
    echo -e "${red}Error: ${file_name}.md already exist${normal}"
    exit 1
fi

echo -e "${green}[+] challenge_name : '${chall_name}' added${normal}"
echo -e "${green}[+] title : '${title}' generated${normal}"
echo -e "${green}[+] path_name : '${file_name}' generated${normal}"

category_list=(web reverse steganography blockchain pwn osint forensic cryptography misc)
echo -e "Choose the challenge category :"
i=0
for all in ${category_list[@]}; do
    echo -e "${cyan}${i}${normal} - ${all}"
    ((i+=1)) 
done

tput setaf 6; read category; tput setaf 7

if ! [[ -v "category_list[${category}]" ]]; then
    echo -e "Error: category not found"
    exit 1
fi

category=${category_list[${category}]}
echo -e "${green}[+] category : '${category}' selected${normal}"

echo -e "How many points for this challenge ?"
tput setaf 6; read points; tput setaf 7
if [[ "$points" =~ [^0-9] ]]; then
    echo -e "${red}Error: bad numbers${normal}"
    exit 1
fi
echo -e "${green}[+] points : '${points}' added${normal}"

echo -e "Author of this write-up ?"
tput setaf 6; read author; tput setaf 7
echo -e "${green}[+] author : '${author}' added${normal}"

config="---\ntitle: \"${title}\"\nchall_name: \"${file_name}\"\ncategory: \"${category}\"\ndescription: \"\"\ndate: ${current_date}\nweight: 20\ndraft: true\ninfo: \"\"\npoints: \"${points}\"\nauthor: \"${author}\"\n---\n"
echo -e "${yellow}${config}${normal}"

echo -e "Would you want create this write-up on the server ? (press ${cyan}0${normal} to confirm )"
tput setaf 6; read res; tput setaf 7

if ! [[ $res -eq 0 ]]; then
    echo -e "${red}Aborted"
    exit 1
fi

touch "./content/posts/${choice}/${file_name}.md"
echo -e $config > "./content/posts/${choice}/${file_name}.md"
echo -e "${green}[+] ./content/posts/${choice}/${file_name}.md created${normal}"
mkdir "./static/files/${choice}/${file_name}"
echo -e "${green}[+] ./static/files/${choice}/${file_name} created${normal}"
cp ${source_path}/* "./static/files/${choice}/${file_name}"
cat ./static/files/${choice}/${file_name}/*.md >> "./content/posts/${choice}/${file_name}.md"
rm ./static/files/${choice}/${file_name}/*.md
echo -e "${green} New write-up added on server"