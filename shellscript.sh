#!/usr/bin/sh

yes y | sudo pacman -S --needed git base-devel

#ohmyzsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

#starshipt prompt
sh -c "$(curl -fsSL https://starship.rs/install.sh)"

#auto-completion
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

#syntax-highlighting
sudo git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone https://github.com/HarshalRathore/My-i3wm-config.git
cd My-i3wm-config

config_path=$(pwd)
cp -R .config ~/
chmod -R +x ~/.config/i3/scripts
cp .gtkrc-2.0 ~/
cp -R .fonts ~/
cp .bashrc ~/
cp .zshrc ~/
cp -R .local ~/

mv harshal/.robbyrussell.zsh-theme harshal/robbyrussell.zsh-theme
cp harshal/.robbyrussell.zsh-theme ~/.oh-my-zsh/themes/robbyrussell.zsh-theme

wget https://raw.githubusercontent.com/endeavouros-team/EndeavourOS-packages-lists/master/i3
sudo pacman -S --needed - < i3

echo "Do you want to write EndevourOS repository to pacman.conf and pacman.d[y/n]"
if [[ $(cat /etc/*-release | awk -F '=' '{if(NR==2)print $2 }') != "EndeavourOS" && $1 == "y" ]]; then
sudo echo "
[endeavouros]
SigLevel = PackageRequired
Include = /etc/pacman.d/endeavouros-mirrorlist" >> /etc/pacman.conf
sudo cp -R pacman.d /etc/
fi

echo "Trying to install yay-AUR helper from EndevourOS"
yes y | sudo pacman -S --needed yay
if [[ -f "/usr/bin/yay" ]]; then
echo "Yet-Another-Yourt sucessfully Installed"
else
echo "Failed to Installed yay with with EndevourOS repository"
echo "Beginning to install yay from source"
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
fi

yes y | sudo pacman -S --needed - < pacman_pkgs

cd $config_path
#pwd=$(pwd)
#while read pkg
#do
#    git clone https://aur.archlinux.org/$pkg.git
#    cd $pkg && makepkg -si && cd $pwd
#done < aur_pkgs
yay -S --needed - < aur_pkgs

yes y | sudo pacman -Syyu
chsh -s $(which zsh)
