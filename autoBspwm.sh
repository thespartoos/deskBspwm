#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

function ctrl_c(){
  echo -e "\n${redColour}[!] Saliendo...${endColour}\n"
  tput cnorm; exit 1 
}


# VARIABLES GLOBALES

declare -r username=$(echo "$USER")
declare -r homepath=$(echo "$HOME")
declare -r local="$(pwd)"

# CTRL + C
trap ctrl_c INT

function helpPanel(){
  echo -e "\n${yellowColour}[+]${endColour}${grayColour} Uso:${endColour}"
  echo -e "\n${yellowColour}[*]${endColour}${grayColour} Example: $0 ${endColour}${purpleColour}-t${endColour}${blueColour} deep${endColour}"
  echo -e "\n\t${yellowColour}[+]${endColour}${blueColour} AutoBspwm${endColour}${grayColour} will do: ${endColour}\n"
  echo -e "\t\t${grayColour}- apt update, apt upgrade y apt install bspwm${endColour}"
  echo -e "\t\t${grayColour}- bspwm github dependencies, building, installation${endColour}"
  echo -e "\t\t${grayColour}- apt install picom -y and config bspwmrc y sxhkdrc${endColour}"
  echo -e "\t\t${grayColour}- install polybar and picom${endColour}"
  echo -e "\t\t${grayColour}- apt install kitty conf, install google_chrome and last firefox${endColour}"
  echo -e "\t\t${grayColour}- apt install HackNerdFonts, Iosevka Nerd Font Complete${endColour}"
  echo -e "\t\t${grayColour}- apt install rofi -y && conf theme and apt install feh ${endColour}"
  echo -e "\t\t${grayColour}- config polybar and dunst${endColour}"
  echo -e "\t\t${grayColour}- powerlevel10k && bat and lsd${endColour}"
  echo -e "\t\t${grayColour}- set and edit .zshrc${endColour}"
  echo -e "\t\t${grayColour}- install sudo plugin && install nvim and edit nvchad${endColour}"
  echo -e "\t\t${grayColour}- install fzf-lovely and ranger${endColour}"
  echo -e "\n\t${purpleColour}t)${endColour} ${grayColour} Select your theme${endColour}${purpleColour} (${endColour}${blueColour}deep, forest, red, tokyo${endColour}${purpleColour})${endColour}"
    echo -e "\n\t${purpleColour}c)${endColour} ${grayColour} change your theme${endColour}${purpleColour} (${endColour}${blueColour}deep, forest, red, tokyo${endColour}${purpleColour})${endColour}"
  echo -e "\n\t${purpleColour}h)${endColour} ${grayColour} helpPanel${endColour}${purpleColour} (${endColour}${blueColour}-h, --help${endColour}${purpleColour})${endColour}"
  
}

function module() {

  theme="$1"
  clear

  test -d themes/$theme
  
  if [ "$(echo $?)" -eq 1 ]; then
    echo -e "${redColour}[!]${endColour}${grayColour} The theme you chose doesn't exist${endColour}"
    exit 0
  fi

  echo -e "\n${yellowColour}[*]${endColour}${grayColour} Realizando una actualizacion al sistema${endColour}"
  echo -e "\n${redColour}[!]${endColour}${grayColour} A continuacion se utilizara ${endColour}${yellowColour}sudo${endColour}${grayColour} para poder iniciar la installation${endColour}\n"
  sleep 2; sudo apt update -y &>/dev/null && sudo apt upgrade -y &>/dev/null && sudo apt install bspwm -y &>/dev/null
  tput civis
  if [ "$(echo $?)" -eq 0 ]; then
    echo -e "\n${greenColour}[+] System was successfully installed${endColour}"
  else
    echo -e "eres un gringo"
  fi

  echo -e "\n${greenColour}[+]${endColour}${grayColour} La actualización del sistema ha sido completada"
  echo -e "\n${yellowColour}[*]${endColour}${grayColour} Instalalling dependencies${endColour}"
  sudo apt-get install -y libxcb-xinerama0-dev libu2f-udev libxcb-icccm4-dev libxcb-randr0-dev libxcb-util0-dev libxcb-ewmh-dev libxcb-keysyms1-dev libxcb-shape0-dev &>/dev/null
  
  if [ "$(echo $?)" -eq 0 ]; then
    echo -e "\n${greenColour}[+] Dependencies was successfully installed${endColour}"
  else
    echo -e "eres un gringo"
  fi

  sudo apt install git make cava gcc net-tools -y &>/dev/null
  echo -e "\n${yellowColour}[*]${endColour}${grayColour} Clonando e instalando bspwm & sxhkd${endColour}"
  git clone https://github.com/baskerville/bspwm.git &>/dev/null
  git clone https://github.com/baskerville/sxhkd.git &>/dev/null
  cd bspwm && make &>/dev/null && sudo make install &>/dev/null
  cd ../sxhkd && make &>/dev/null && sudo make install &>/dev/null
  cd ../themes/$theme/dotfiles
  cp -r bspwm ~/.config/ 2>/dev/null && cp -r sxhkd ~/.config/ 2>/dev/null
  chmod u+x ~/.config/bspwm/bspwmrc
  cd ../../../
  if [ "$(echo $?)" -eq 0 ]; then
    echo -e "\n${greenColour}[+] Bspwm and sxhkd installation was successfully completed${endColour}"
  else
    echo -e "eres un gringo"
  fi

  echo -e "\n${yellowColour}[*]${endColour}${grayColour} Configurating ${endColour}${blueColour}bspwm${endColour}${purpleColour} &&${endColour}${blueColour} sxhkd${endColour}${grayColour} files${endColour}"
  rm -rf ~/.config/bspwm/ &>/dev/null
  cp -r themes/$theme/dotfiles/bspwm/ ~/.config/
  chmod +x ~/.config/bspwm/bspwmrc
  rm -rf ~/.config/sxhkd/ &>/dev/null
  cp -r themes/$theme/dotfiles/sxhkd/ ~/.config/

  sed "s/home\/thespartoos/home\/$username/g" ~/.config/bspwm/bspwmrc > ~/.config/bspwm/bspwmrc2
  rm -f ~/.config/bspwm/bspwmrc && mv ~/.config/bspwm/bspwmrc2 ~/.config/bspwm/bspwmrc

  chmod +x -R ~/.config/bspwm/
  
  if [ "$(echo $?)" -eq 0 ]; then
    echo -e "\n${greenColour}[+] Bspwm and sxhkd config was successfully completed${endColour}"
  else
    echo -e "eres un gringo"
  fi

  sleep 2; clear
  echo -e "\n${yellowColour}[*]${endColour}${grayColour} Installing picom and applaying the settings${endColour}"
  sudo apt install libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl-dev libegl-dev libpcre2-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev meson -y &>/dev/null
  sudo apt-get install libpcre3-dev -y &>/dev/null
  sudo apt install cmake -y &>/dev/null

  git clone https://github.com/ibhagwan/picom.git &>/dev/null
  cd picom/
  git submodule update --init --recursive 2>/dev/null
  meson --buildtype=release . build 2>/dev/null
  ninja -C build &>/dev/null 2>/dev/null
  sudo ninja -C build install &>/dev/null
      
  if [ "$(echo $?)" -eq 0 ]; then
    echo -e "\n${greenColour}[+] Picom was successfully installed${endColour}"
  else
    echo -e "eres un gringo"
  fi
  
  echo -e "\n${yellowColour}[*]${endColour}${grayColour} Configurating picom${endColour}"

  cd ..; rm -rf ~/.config/picom &>/dev/null && cp -r themes/$theme/dotfiles/picom ~/.config/
  
  if [ "$(echo $?)" -eq 0 ]; then
    echo -e "\n${greenColour}[+] Picom was successfully configurated${endColour}"
  else
    echo -e "eres un gringo"
  fi

  echo -e "\n${yellowColour}[*] Installing Polybar${endColour}"
  sudo apt install libcairo2-dev python3-sphinx libuv1-dev xcb-proto python3-xcbgen -y &>/dev/null
  git clone --recursive https://github.com/polybar/polybar
  cd polybar
  mkdir build 2>/dev/null; cd build
  cmake ..
  make -j$(nproc)
  sudo make install
  cd ../../
  
  if [ "$(echo $?)" -eq 0 ]; then
    echo -e "\n${greenColour}[+] Polybar was successfully installed${endColour}"
  else
    echo -e "eres un gringo"
  fi
  
  sudo apt install kitty -y &>/dev/null

  if [ "$(echo $?)" -eq 0 ]; then
    echo -e "\n${greenColour}[+] Kitty was successfully installed${endColour}"
  else
    echo -e "eres un gringo"
  fi

  sleep 2; clear
  echo -e "${yellowColour}[*]${endColour}${grayColour} Configurating${endColour}${blueColour} Kitty${endColour}"
  
  rm -rf ~/.config/kitty 2>/dev/null && cp -r themes/$theme/dotfiles/kitty/ ~/.config/

  if [ "$(echo $?)" -eq 0 ]; then
    echo -e "\n${greenColour}[+] Kitty Configuration was successfully applied${endColour}"
  else
    echo -e "eres un gringo"
  fi
  
  echo -e "\n${yellowColour}[*]${endColour}${grayColour} Installing${endColour}${blueColour} Google Chrome${endColour}"
  wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb &>/dev/null
  echo -e "\n${redColour}[!]${endColour}${grayColour} A continuacion se utilizara ${endColour}${yellowColour}sudo${endColour}${grayColour} para poder iniciar la installation${endColour}\n"
  sudo dpkg -i google-chrome-stable_current_amd64.deb &>/dev/null
  rm -rf google-chrome-stable_current_amd64.deb 2>/dev/null
  tput civis
  if [ "$(echo $?)" -eq 0 ]; then
    echo -e "${greenColour}[+]${endColour} ${blueColour}Google Chrome${endColour}${greenColour} was successfully installed${endColour}"
  else
    echo -e "eres un gringo"
  fi

  echo -e "\n${yellowColour}[*]${endColour}${grayColour} Installing Latest version of ${endColour}${blueColour}Firefox${endColour}"
  wget -O ~/FirefoxSetup.tar.bz2 "https://download.mozilla.org/?product=firefox-latest&os=linux64" &>/dev/null
  sudo tar xjf ~/FirefoxSetup.tar.bz2 -C /opt/ &>/dev/null
  
  if [ "$(echo $?)" -eq 0 ]; then
    echo -e "\n${greenColour}[+]${endColour}${blueColour} Firefox${endColour}${grayColour} was successfully installed${endColour}"
  else
    echo -e "eres un gringo"
  fi
  
  echo -e "\n${yellowColour}[*]${endColour}${grayColour} Installing ${endColour}${blueColour}Hack Nerd Fonts${endColour}${purpleColour} &&${endColour}${blueColour} Iosevka Font ${endColour}"
  respuesta="$(ls -l /usr/local/share/fonts/ | grep "Hack.zip" | awk 'NF{print $NF}')"
  if [ "$respuesta" != "Hack.zip" ]; then
    sudo wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/Hack.zip &>/dev/null
    sudo mv Hack.zip /usr/local/share/fonts/
    cd /usr/local/share/fonts && sudo unzip /usr/local/share/fonts/Hack.zip &>/dev/null
    cd $local
    sudo wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.2.2/Iosevka.zip &>/dev/null
    sudo mv Iosevka.zip /usr/local/share/fonts/
    cd /usr/local/share/fonts && sudo unzip -o Iosevka.zip &>/dev/null
  fi

  if [ "$(echo $?)" -eq 0 ]; then
    echo -e "\n${greenColour}[+]${endColour}${blueColour} Hack Nerd Fonts ${endColour}${purpleColour}&&${endColour}${blueColour} Iosevka${endColour}${greenColour} was successfully installed${endColour}"
  else
    echo -e "eres un gringo"
  fi

  sleep 2; clear

  echo -e "\n${yellowColour}[+]${endColour}${grayColour} Installing ${endColour}${blueColour}rofi${endColour}${grayColour} and configurating${endColour}"

  sudo apt install rofi -y &>/dev/null
  rm -rf ~/.config/rofi/ && cp -r $local/themes/$theme/dotfiles/rofi ~/.config/
  chmod +x -R ~/.config/rofi 2>/dev/null
  echo -e "\n${greenColour}[+]${endColour} ${blueColour}Rofi${endColour}${grayColour} was successfully installed and configurated${endColour}"

  echo -e "\n${yellowColour}[*]${endColour}${grayColour} Installing ${endColour}${blueColour} feh${endColour}${grayColour} and configurating${endColour}"
  sudo apt install feh -y &>/dev/null
  mkdir -p "$homepath/Escritorio/$username/Images"
  cp $local/themes/$theme/dotfiles/bg.png "$homepath/Escritorio/$username/Images"
  
  if [ "$(echo $?)" -eq 0 ]; then
    echo -e "\n${greenColour}[+]${endColour}${blueColour} feh${endColour}${greenColour} was successfully installed${endColour}"
  else
    echo -e "eres un gringo"
  fi

  echo -e "\n${yellowColour}[*]${endColour}${grayColour} Configurating${endColour}${blueColour} Polybar${endColour}"
  rm -rf ~/.config/polybar 2>/dev/null && cp -r $local/themes/$theme/dotfiles/polybar ~/.config/
  chmod +x -R ~/.config/polybar
  rm -rf ~/.config/bin 2>/dev/null
  cp -r $local/themes/$theme/dotfiles/bin ~/.config/ 2>/dev/null
  chmod +x -R ~/.config/bin
  
  if [ "$(echo $?)" -eq 0 ]; then
    echo -e "\n${greenColour}[+]${endColour}${blueColour} Polybar${endColour}${greenColour} was successfully configurated${endColour}"
  else
    echo -e "eres un gringo"
  fi

  echo -e "\n${yellowColour}[*]${endColour}${grayColour} Installing${endColour}${blueColour} Dunst${endColour}${grayColour} and configurating"

  sudo apt install dunst -y &>/dev/null

  rm -rf ~/.config/dunst && cp -r $local/themes/$theme/dotfiles/dunst ~/.config/dunst

  if [ "$(echo $?)" -eq 0 ]; then
    echo -e "\n${greenColour}[+]${endColour}${blueColour} Dunst${endColour}${greenColour} was successfully installed and configurated${endColour}"
  else
    echo -e "eres un gringo"
  fi
  rm -rf googl* 2>/dev/null
  sleep 2; clear

  declare -r homerealpath="$(cat /etc/passwd | grep "1000" --color=auto | awk '{print $6}' FS=':')"
  declare -r usereal="$(cat /etc/passwd | grep "1000" --color=auto | awk '{print $1}' FS=':')"
  
  
  tput civis
  echo -e "\n${yellowColour}[*]${endColour}${grayColour} Instalar ${endColour}${blueColour}zsh${endColour}${grayColour} para poder continuar${endColour}"
  sudo apt install zsh cava -y &>/dev/null
  sudo apt install net-tools -y &>/dev/null
  sed -i "s/thespartoos/$username/" ~/.config/bspwm/bspwmrc 2>/dev/null

  if [ "$(echo $?)" -eq 0 ]; then
    echo -e "\n${greenColour}[+]${endColour}${blueColour} zsh${endColour}${greenColour} was successfully installed and configurated${endColour}"
  else
    echo -e "eres un gringo"
  fi

  echo -e "\n${yellowColour}[+]${endColour}${grayColour} Installing${endColour} ${blueColour}powerlevel10k${endColour}"
  cp -r $local/themes/$theme/dotfiles/powerlevel10k ~/ 2>/dev/null
  cp $local/themes/$theme/dotfiles/.p10k.zsh ~/ 2>/dev/null
  sudo cp -r $local/themes/$theme/dotfiles/root/powerlevel10k /root/ 2>/dev/null
  sudo cp $local/themes/$theme/dotfiles/root/.p10k.zsh /root/ 2>/dev/null

  if [ "$(echo $?)" -eq 0 ]; then
    echo -e "\n${greenColour}[+]${endColour}${blueColour} powerlevel10k${endColour}${greenColour} was successfully installed and configurated${endColour}"
  else
    echo -e "eres un gringo"
  fi

  sleep 2; clear
  
  echo -e "\n${yellowColour}[*]${endColour}${grayColour} Installing${endColour}${blueColour} lsd${endColour} ${purpleColour}&&${endColour}${blueColour} bat${endColour}"
  sudo wget https://github.com/sharkdp/bat/releases/download/v0.22.1/bat_0.22.1_amd64.deb &>/dev/null
  sudo dpkg -i bat_0.22.1_amd64.deb &>/dev/null
  
  sudo wget https://github.com/Peltoche/lsd/releases/download/0.23.1/lsd-musl_0.23.1_amd64.deb &>/dev/null
  sudo dpkg -i lsd-musl_0.23.1_amd64.deb &>/dev/null
  
  sudo rm -rf bat_0.22.1_amd64.deb lsd-musl_0.23.1_amd64.deb 2>/dev/null
  
  if [ "$(echo $?)" -eq 0 ]; then
    echo -e "\n${greenColour}[+]${endColour}${blueColour} lsd${endColour}${purpleColour} &&${endColour}${blueColour} bat${endColour}${greenColour} was successfully installed and configurated${endColour}"
  else
    echo -e "eres un gringo"
  fi

  echo -e "\n${yellowColour}[*]${endColour}${grayColour} Configurating ${endColour}${blueColour}.zshrc ${endColour}${purpleColour}variables and functions${endColour}"
  sudo usermod -s /bin/zsh root 2>/dev/null
  rm -rf ~/.zshrc 2>/dev/null
  sed -i "s/\$username/$username/" $local/themes/$theme/dotfiles/zsh/.zshrc 2>/dev/null
  cp $local/themes/$theme/dotfiles/zsh/.zshrc ~/
  sudo ln -s -f $homerealpath/.zshrc /root/.zshrc 
  sudo apt install scrub zsh-syntax-highlighting zsh-autosuggestions -y &>/dev/null
  sudo mkdir /usr/share/zsh-sudo/ 2>/dev/null
  sudo cp $local/themes/$theme/dotfiles/zsh/sudo.plugin.zsh /usr/share/zsh-sudo 2>/dev/null
  sudo rm -rf /usr/local/share/zsh/site-functions/_bspc
  if [ "$(echo $?)" -eq 0 ]; then
    echo -e "\n${greenColour}[+]${endColour}${blueColour} .zshrc${endColour}${greenColour} was successfully configurated${endColour}"
  else
    echo -e "eres un gringo"
  fi
    
  tput cnorm
}

function changeTheme() {

  if [ "$(id -u)" -ne 0 ]; then
    echo -e "${yellowColour}[*]${endColour}${grayColour} Changing${endColour}${blueColour} theme${endColour}"; sleep 2
    rm -rf ~/.config/polybar 2>/dev/null
    cp -r themes/$theme/dotfiles/polybar ~/.config 2>/dev/null && chmod +x -R ~/.config/polybar 2>/dev/null
    rm -rf ~/.config/kitty 2>/dev/null
    cp -r themes/$theme/dotfiles/kitty ~/.config 2>/dev/null
    rm -rf ~/.config/bin 2>/dev/null
    cp -r themes/$theme/dotfiles/bin ~/.config 2>/dev/null && chmod +x -R ~/.config/bin 2>/dev/null
    rm -rf ~/.config/dunst 2>/dev/null
    kill $(ps -faux | grep -i "dunst" | awk 'NF{print $NF}' | grep "dunstrc" | tail -n 1) 2>/dev/null
    cp -r themes/$theme/dotfiles/dunst ~/.config 2>/dev/null
    rm -rf ~/.config/rofi 2>/dev/null
    cp -r themes/$theme/dotfiles/rofi ~/.config 2>/dev/null && chmod +x -R ~/.config/rofi 2>/dev/null
    rm ~/Escritorio/$username/Images/bg.png 2>/dev/null
    cp -r themes/$theme/dotfiles/bg.png ~/Escritorio/$username/Images/ 2>/dev/null
    echo -e "${greenColour}[+] The change was successfully did it"
  else
    echo -e "${redColour}[!]${endColour} ${grayColour}Debes ejecutarlo sin root${endColour}"
    exit 0
  fi
}



declare -i parameter_counter=0

while getopts "hm:t:c:" arg; do

  case $arg in
    t) theme=$OPTARG; let parameter_counter+=1;;
    c) theme=$OPTARG; let parameter_counter+=2;;
    h) helpPanel;
  esac  

done

if [ "$parameter_counter" -eq 1 ]; then
  module $theme
elif [ "$parameter_counter" -eq 2 ]; then
  changeTheme $theme
else
  helpPanel
fi
