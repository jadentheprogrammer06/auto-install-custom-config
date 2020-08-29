#!/bin/bash
#
# I designed this program (Originally) for Ubuntu/AMD64 and personal usage.
#
# You can make a fork and modify this code to suit your needs or make a separate script for your linux distro.

### EXAMPLE CODE (for quick one-line program installs.)
#install_category=0
# Installation steps for programs are put into categories using If loops.
# Art Programs go here.
#printf "\n\nCategory: category"
#PROGRAM="by each option in category"; INSTALL_STEPS='echo'; prompt_category=1; PromptInstall
#if [[ $install_category == 1 ]]
#then
#    PROGRAM="program"; INSTALL_STEPS='sudo apt install program'; PromptInstall
#    PROGRAM="program"; INSTALL_STEPS='sudo snap install program'; PromptInstall
#fi
#install_category=0
###
### EXAMPLE CODE (for multiple-line-commands installs.)
# Programs that require more complicated installation instructions will have their commands in a custom function that will be passed into our prompt.
# $multiplecommands should be set to 1 and #commands_function should be set to your function containing proper installation instructions.
#
# ProgramCommands() {
# wget https://this-is-the-location-of-our-package/package.deb -P ~/Downloads/
# sudo dpkg -i ~/Downloads/package.deb
# }
# PROGRAM="Third party software"; multiplecommands=1; commands_function=ProgramCommands; PromptInstall
#
###



PromptInstall() {
RunPrompt=1
while [[ $RunPrompt == 1 ]]
do
printf "\nWould you like to install $PROGRAM? \n>>>"; read yesorno
    if [[ $yesorno == "" ]]; then
        printf "\nThat is not an option. [y]yes or [n]no."
    elif [[ $yesorno == "y"* ]]; then
        printf "\nAttempting to install $PROGRAM...\n"
        [[ $multiplecommands != 1 ]] && $INSTALL_STEPS || $commands_function
        [[ $prompt_category == 1 ]] && install_category=1 && RunPrompt=0 || install_category=0
        prompt_category=0; multiplecommands=0; INSTALL_STEPS='echo'; # need to reset to 0 so it doesn't glitch out.
    elif [[ $yesorno == "n"* ]]; then
        prompt_category=0; multiplecommands=0; INSTALL_STEPS='echo';
        printf "\nNot installing $PROGRAM\n" && RunPrompt=0
    fi
done
}


Main() {
install_category=0
prompt_category=0
# Installation steps for programs are put into categories using If loops.
# where $PROGRAM is actually a category.

# Recommended/Useful-Miscellaneous Programs go here. (Brave-browser, Chromium, VLC media player, Syncthing, GIMP, Alacarte, Virtualbox, Wireshark)
printf "\n\nCategory: Recommended / Useful Software"
PROGRAM="by each option in Recommended/Useful Software"; prompt_category=1; PromptInstall
if [[ $install_category == 1 ]]
then
    PROGRAM="VLC (FOSS Video/Music/DVD Player)"; INSTALL_STEPS='sudo snap install vlc'; PromptInstall
    PROGRAM="GIMP (FOSS Image Editor)"; INSTALL_STEPS='sudo apt install gimp'; PromptInstall
    BraveCommands() {
    sudo apt install apt-transport-https curl
    curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
    echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    sudo apt update
    sudo apt install brave-browser    
    }
    PROGRAM="Brave (Web Browser, Chromium-based with better privacy/security.)"; multiplecommands=1; commands_function=BraveCommands; PromptInstall
    ChromiumCommands() {
    echo 'deb http://download.opensuse.org/repositories/home:/ungoogled_chromium/Ubuntu_Focal/ /' | sudo tee /etc/apt/sources.list.d/home-ungoogled_chromium.list > /dev/null
    curl -s 'https://download.opensuse.org/repositories/home:/ungoogled_chromium/Ubuntu_Focal/Release.key' | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home-ungoogled_chromium.gpg > /dev/null
    sudo apt-get update
    sudo apt-get install -y ungoogled-chromium
    }
    PROGRAM="Ungoogled Chromium (Web Browser, Google Chrome fork.)"; multiplecommands=1; commands_function=ChromiumCommands; PromptInstall
    SyncthingCommands() {
    sudo apt-get install apt-transport-https
    curl -s https://syncthing.net/release-key.txt | sudo apt-key add -
    echo "deb https://apt.syncthing.net/ syncthing stable" | sudo tee /etc/apt/sources.list.d/syncthing.list
    sudo apt-get update
    sudo apt-get install syncthing && SYNCTHING_IS_INSTALLED=1 && break
    }
    AnkiCommands() {
    wget https://github.com/ankitects/anki/releases/download/2.1.30/anki-2.1.30-linux-amd64.tar.bz2 -P ~/Downloads/
    sudo tar xjf ~/Downloads/anki-2.1.30-linux-amd64.tar.bz2
    cd anki-2.1.30-linux-amd64
    sudo make install
    }
    PROGRAM="Anki (Flash Cards. Flexible & Efficient Studying.)"; multiplecommands=1; commands_function=AnkiCommands; PromptInstall
    PROGRAM="Syncthing (Can be used to Sync your files across all devices. Respects your privacy and decisions.)"; multiplecommands=1; commands_function=SyncthingCommands; PromptInstall
    PROGRAM="Alacarte (Used to create custom applications-menu icons for programs and games which do not have any by default.)"; INSTALL_STEPS='sudo apt install alacarte'; PromptInstall
    VirtualboxCommands() {
    wget https://download.virtualbox.org/virtualbox/6.1.12/virtualbox-6.1_6.1.12-139181_Ubuntu_eoan_amd64.deb -P ~/Downloads/ && sudo dpkg -i ~/Downloads/virtualbox-6.1_6.1.12-139181_Ubuntu_eoan_amd64.deb
    }
    PROGRAM="VirtualBox (OS Virtualization Software. Supports Linux, Windows, etc.)"; multiplecommands=1; commands_function=VirtualboxCommands; PromptInstall
    PROGRAM="Wireshark (Network packet scanning utility.)"; INSTALL_STEPS='sudo apt install wireshark'; PromptInstall
    PROGRAM="BalenaEtcher (Flash ISO files to an external drive.)"; INSTALL_STEPS='wget https://github.com/balena-io/etcher/releases/download/v1.5.102/balena-etcher-electron-1.5.102-linux-x64.zip -P ~/Downloads/'; PromptInstall
    PROGRAM="GTKHash (Useful graphical utility for hash/checksum checking.)"; INSTALL_STEPS='sudo snap install gtkhash'; PromptInstall
    PROGRAM="Okular (Useful PDF-viewer utility.)"; INSTALL_STEPS='sudo apt install okular'; PromptInstall
fi
install_category=0

# Art Programs go here. (GIMP, Krita, Blender)
printf "\n\nCategory: Art"
PROGRAM="by each option in Art"; prompt_category=1; PromptInstall
if [[ $install_category == 1 ]]
then
    PROGRAM="GIMP (FOSS Image Editor)"; INSTALL_STEPS='sudo apt install gimp'; PromptInstall
    PROGRAM="Krita / Image Editor"; INSTALL_STEPS='sudo snap install krita'; PromptInstall
    PROGRAM="Blender (3D Models Software)"; INSTALL_STEPS='sudo snap install blender'; PromptInstall
fi
install_category=0

# Video-Editing Programs go here. (OBS, Kdenlive, Audacity)
printf "\n\nCategory: Video-Editing/Recording"
PROGRAM="by each option in Video-Editing/Recording"; prompt_category=1; PromptInstall
if [[ $install_category == 1 ]]
then
    OBSCommands() {
    sudo apt install ffmpeg
    sudo add-apt-repository ppa:obsproject/obs-studio
    sudo apt update
    sudo apt install obs-studio
    }
    PROGRAM="OBS (FOSS Video-Recording/Streaming)"; multiplecommands=1; commands_function=OBSCommands; PromptInstall
    PROGRAM="Audacity (Mic/Audio-Recording)"; INSTALL_STEPS='sudo snap install audacity'; PromptInstall
    PROGRAM="Kdenlive (Video-Editing)"; INSTALL_STEPS='sudo snap install kdenlive'; PromptInstall
    
fi
install_category=0

# Gaming Programs go here. (Retroarch, PCSX2, Citra, Dolphin, Minecraft Java & Bedrock, Minetest)
printf "\n\nCategory: Gaming"
PROGRAM="by each option in PC Gaming"; prompt_category=1; PromptInstall
if [[ $install_category == 1 ]]
then
    PROGRAM="Retroarch (Retro/Handheld Console Emulation)"; INSTALL_STEPS='sudo snap install retroarch'; PromptInstall
    SteamCommands() {
    wget https://cdn.cloudflare.steamstatic.com/client/installer/steam.deb -P ~/Downloads/ && sudo dpkg -i ~/Downloads/steam.deb
    }
    PROGRAM="Steam (PC/Linux Games Store & Launcher) (*May be considered Proprietory software.)"; multiplecommands=1; commands_function=SteamCommands; PromptInstall
    DolphinCommands() {
    sudo apt-add-repository ppa:dolphin-emu/ppa
    sudo apt update
    sudo apt install dolphin-emu
    }
    PROGRAM="Dolphin (GCN/Wii Emulation)"; multiplecommands=1; commands_function=DolphinCommands; PromptInstall
    CitraCommands() {
    printf "\nFlatpak will be required to install this program\n"
    sudo apt install flatpak
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install https://flatpak.citra-emu.org/citra-nightly.flatpakref
    }
    PROGRAM="Citra (3DS Emulation)"; multiplecommands=1; commands_function=CitraCommands;PromptInstall
    PCSX2Commands() {
    printf "\nPCSX2 has to compile from source. May take a while. Do something productive as you wait.\n"
    sudo snap install cmake
        sudo apt remove gcc-9 g++-9
        sudo apt install cmake g++-10-multilib \
	        libwxgtk3.0-gtk3-dev:i386 libgtk-3-dev:i386 \
	        libaio-dev:i386 libasound2-dev:i386 liblzma-dev:i386 \
	        libsdl2-dev:i386 libsoundtouch-dev:i386 \
	        libxml2-dev:i386 libpcap0.8-dev:i386

        sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-10 10
        sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-10 10
        sudo update-alternatives --install /usr/bin/cc  cc  /usr/bin/gcc 30
        sudo update-alternatives --install /usr/bin/c++ c++ /usr/bin/g++ 30
	cd ~
        git clone https://github.com/PCSX2/pcsx2.git
        cd ~/pcsx2
	mkdir build
	cd build

        cmake -DCMAKE_TOOLCHAIN_FILE=cmake/linux-compiler-i386-multilib.cmake -DCMAKE_BUILD_TYPE=Release \
	        -DBUILD_REPLAY_LOADERS=TRUE -DCMAKE_BUILD_PO=FALSE -DGTK3_API=TRUE ..
	        
        make -j10
        make install
        cd ../bin
    }
    PROGRAM="PCSX2 (PS2 Emulation)"; multiplecommands=1; commands_function=PCSX2Commands; PromptInstall
    MCBedrockCommands() {
        sudo dpkg --add-architecture i386
        sudo apt-get update
        sudo apt install curl libc6-i386 libx11-6:i386 libxext6:i386 libegl1-mesa:i386 zlib1g:i386 libstdc++6:i386 libgl1-mesa-dri:i386 libasound2:i386 libpulse0:i386
        curl -L https://github.com/ChristopherHX/linux-packaging-scripts/releases/download/appimage/Minecraft_Bedrock_Launcher-x86_64.0.0.510.AppImage --output MC.AppImage
        chmod +x MC.AppImage
        sudo mv MC.AppImage /usr/local/bin/MC-bedrock.AppImage/
        . ~/.bashrc
        printf "\nMinecraft Bedrock Edition is installed in ~/usr/local/bin PATH directory. To run the launcher use MC-bedrock.AppImage in terminal. Will have to manually add program to applications menu using Alacarte."
    }
    PROGRAM="Minecraft (Bedrock Edition, Unofficial Android -> Linux Port)"; multiplecommands=1; commands_function=MCBedrockCommands; PromptInstall
    MCJavaCommands() {
    sudo apt install default-jre #Need to install java runtime environment dependency.
    sudo apt-get install aptitude
    sudo aptitude install openjdk-8-jre #This is useful for older MC versions <1.12.
    sudo apt-get --fix-missing
    sudo apt-get install -f
    wget https://launcher.mojang.com/download/Minecraft.deb -P ~/Downloads/ && sudo dpkg -i ~/Downloads/Minecraft.deb
    printf "\nMinecraft was automatically installed from the official .deb package located in your ~/Downloads folder. The game itself should be available from your application menu."
    }
    PROGRAM="Minecraft (Java Edition, Original PC Version)"; multiplecommands=1; commands_function=MCJavaCommands; PromptInstall
    PROGRAM="Minetest (FOSS Minecraft Clone)"; INSTALL_STEPS='sudo snap install minetest'; PromptInstall
    PROGRAM="Ltris (FOSS Tetris Clone)"; INSTALL_STEPS="sudo apt install ltris"; PromptInstall
fi
install_category=0

# Programming / Developer programs go here. (Placeholder for later.)
printf "\n\nCategory: Programming"
PROGRAM="by each option in Programming software"; prompt_category=1; PromptInstall
if [[ $install_category == 1 ]]
then
    TerminalCustomizationCommands() {
    DOTFILES_REPO="https://github.com/jadentheprogrammer06/dotfiles"
    echo "Installing Xdo & Devour; Can use with aliases to force terminal to swallow/hide when launching programs."
    echo "This is useful with creating program aliases and menu shortcuts."
    sudo apt-get install xdo
    git clone https://github.com/salman-abedin/devour.git
    sudo mv devour/devour /usr/local/bin
    sudo rm devour -r
    echo "Installing terminator. Similar to default GNOME terminal but offers much more customization."
    sudo apt-get install terminator
    echo "Installing fonts-powerline"
    sudo apt-get install fonts-powerline
    echo "Installing dotfiles from the provided repository."
    sudo rm ~/.bashrc
    git clone $DOTFILES_REPO
    sudo cp -R dotfiles/files/.bashrc dotfiles/files/.bash_aliases dotfiles/files/.vimrc dotfiles/files/.nanorc dotfiles/files/.config/ /home/user/ 
    sudo rm dotfiles -r
    . ~/.bashrc
    }
    PROGRAM="Terminal-Emulator Customizations"; multiplecommands=1; commands_function=TerminalCustomizationCommands; PromptInstall
    PROGRAM="Atom IDE"; INSTALL_STEPS="sudo snap install atom --classic"; PromptInstall
    PROGRAM="PyCharm IDE"; INSTALL_STEPS="sudo snap install pycharm-community --classic"; PromptInstall
fi
install_category=0

}

Main
