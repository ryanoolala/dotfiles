# Ubuntu-only stuff. Abort if not Ubuntu.
is_ubuntu || return 1

apt_keys=()
apt_source_files=()
apt_source_texts=()
apt_packages=()
deb_installed=()
deb_sources=()

installers_path="$DOTFILES/caches/installers"

# Ubuntu distro release name, eg. "xenial"
release_name=$(lsb_release -c | awk '{print $2}')

function add_ppa() {
  apt_source_texts+=($1)
  IFS=':/' eval 'local parts=($1)'
  apt_source_files+=("${parts[1]}-ubuntu-${parts[2]}-$release_name")
}

#############################
# WHAT DO WE NEED TO INSTALL?
#############################

# Misc.
apt_packages+=(
  awscli
  build-essential
  cmatrix
  cowsay
  curl
  git-core
  gnome-icon-theme
  thunar
  htop
  imagemagick
  jq
  nmap
  postgresql
  python-pip
  ranger
  silversearcher-ag
  telnet
  tree
  w3m-img
  zsh
)

apt_packages+=(vim)
is_ubuntu_desktop && apt_packages+=(vim-gnome)

# https://github.com/neovim/neovim/wiki/Installing-Neovim
add_ppa ppa:neovim-ppa/stable
apt_packages+=(neovim)

# https://launchpad.net/~stebbins/+archive/ubuntu/handbrake-releases
#add_ppa ppa:stebbins/handbrake-releases
#apt_packages+=(handbrake-cli)
#is_ubuntu_desktop && apt_packages+=(handbrake-gtk)

# https://github.com/rvm/ubuntu_rvm
add_ppa ppa:rael-gc/rvm
apt_packages+=(rvm)

# https://github.com/rbenv/ruby-build/wiki
apt_packages+=(
  autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev
  libncurses5-dev libffi-dev libgdbm3 libgdbm-dev software-properties-common  zlib1g-dev
)

# https://www.digitalocean.com/community/tutorials/how-to-install-and-configure-ansible-on-ubuntu-16-04
add_ppa ppa:ansible/ansible
apt_packages+=(ansible)

if is_ubuntu_desktop; then
  # http://www.omgubuntu.co.uk/2016/06/install-latest-arc-gtk-theme-ubuntu-16-04
  # apt_keys+=(http://download.opensuse.org/repositories/home:Horst3180/xUbuntu_16.04/Release.key)
  # apt_source_files+=(arc-theme)
  # apt_source_texts+=("deb http://download.opensuse.org/repositories/home:/Horst3180/xUbuntu_16.04/ /")
  # apt_packages+=(arc-theme)

 # add_ppa ppa:fossfreedom/arc-gtk-theme-daily
 # apt_packages+=(arc-theme)

  # https://github.com/tagplus5/vscode-ppa
  apt_keys+=(https://tagplus5.github.io/vscode-ppa/ubuntu/gpg.key)
  apt_source_files+=(vscode.list)
  apt_source_texts+=("deb https://tagplus5.github.io/vscode-ppa/ubuntu ./")
  apt_packages+=(code code-insiders)

  # https://www.ubuntuupdates.org/ppa/google_chrome
  apt_keys+=(https://dl-ssl.google.com/linux/linux_signing_key.pub)
  apt_source_files+=(google-chrome)
  apt_source_texts+=("deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main")
  apt_packages+=(google-chrome-stable)

  # https://www.spotify.com/us/download/linux/
  #apt_keys+=('--keyserver hkp://keyserver.ubuntu.com:80 --recv-keys BBEBDCB318AD50EC6865090613B00F1FD2C19886')
  #apt_source_files+=(spotify)
  #apt_source_texts+=("deb http://repository.spotify.com stable non-free")
  #apt_packages+=(spotify-client)

  # https://tecadmin.net/install-oracle-virtualbox-on-ubuntu/
  #apt_keys+=(https://www.virtualbox.org/download/oracle_vbox_2016.asc)
  #apt_source_files+=(virtualbox)
  #apt_source_texts+=("deb http://download.virtualbox.org/virtualbox/debian $release_name contrib")
  #apt_packages+=(virtualbox-5.1)


  # https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-16-04
  apt_keys+=(https://download.docker.com/linux/ubuntu/gpg)
  apt_source_files+=(docker)
  apt_source_texts+=("deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable")
  apt_packages+=(docker-ce)

  #http://tipsonubuntu.com/2017/05/30/install-sublime-text-3-ubuntu-16-04-official-way/
  apt_keys+=(https://download.sublimetext.com/sublimehq-pub.gpg)
  apt_source_files+=(sublime-text-3)
  apt_source_texts+=("deb https://download.sublimetext.com/ apt/stable/")
  apt_packages+=(sublime-text)

  #http://howtoubuntu.org/how-to-install-spotify-in-ubuntu
  #apt_keys+=('--keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410')
  #apt_source_files+=(spotify)
  #apt_source_texts+=("deb http://repository.spotify.com stable non-free")
  #apt_packages+=(spotify-client)

  #http://www.webupd8.org/2015/01/install-official-telegram-desktop-app.html
  add_ppa ppa:atareao/telegram
  apt_packages+=(telegram)

  # http://askubuntu.com/a/190674
  #add_ppa ppa:webupd8team/java
  #apt_packages+=(oracle-java8-installer)
 # function preinstall_oracle-java8-installer() {
 #   echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
 #   echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
 # }

  add_ppa ppa:nathan-renniewaldock/flux
  apt_packages+=(fluxgui)

#  add_ppa ppa:jtaylor/keepass
 # apt_packages+=(keepass2)
   add_ppa ppa:phoerious/keepassxc
   apt_packages+=(keepassxc)

   add_ppa ppa:plushuang-tw/uget-stable
   apt_packages+=(uget)


   add_ppa ppa:rael-gc/rvm
   apt_packages+=(rvm)

  # Misc
  apt_packages+=(adb fastboot)
  apt_packages+=(
    chromium-browser
    gnome-tweak-tool
    k4dirstat
    rofi
    openssh-server
    shutter
    vlc
    xclip
    zenmap
  )

  # Manage online accounts via "gnome-control-center" in launcher
  apt_packages+=(gnome-control-center gnome-online-accounts)

  # https://github.com/mitchellh/vagrant/issues/7411
  deb_installed+=(/usr/bin/vagrant)
  deb_sources+=(https://releases.hashicorp.com/vagrant/1.9.2/vagrant_1.9.2_x86_64.deb)
  # https://github.com/vagrant-libvirt/vagrant-libvirt/issues/575
  # apt_packages+=(vagrant)
  # function postinstall_vagrant() {
  #   sudo sed -i'' "s/Specification.all = nil/Specification.reset/" /usr/lib/ruby/vendor_ruby/vagrant/bundler.rb
  # }

  # https://launchpad.net/grub-customizer
  add_ppa ppa:danielrichter2007/grub-customizer
  apt_packages+=(grub-customizer)

  # https://support.gitkraken.com/how-to-install
 # deb_installed+=(/usr/bin/gitkraken)
 # deb_sources+=(https://release.gitkraken.com/linux/gitkraken-amd64.deb)

  # http://askubuntu.com/a/852727
  apt_packages+=(cabextract)
  deb_installed+=(/usr/share/fonts/truetype/msttcorefonts)
  deb_sources+=(deb_source_msttcorefonts)
  function deb_source_msttcorefonts() {
    echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | sudo debconf-set-selections
    echo http://ftp.debian.org/debian/pool/contrib/m/msttcorefonts/ttf-mscorefonts-installer_3.6_all.deb
  }

  # https://slack.com/downloads/instructions/linux
  deb_installed+=(/usr/bin/slack)
  deb_sources+=(https://downloads.slack-edge.com/linux_releases/slack-desktop-2.5.2-amd64.deb)

  # http://askubuntu.com/questions/854480/how-to-install-the-steam-client/854481#854481
  apt_packages+=(python-apt)
  deb_installed+=(/usr/bin/steam)
  deb_sources+=(deb_source_steam)
  function deb_source_steam() {
    local steam_root steam_file
    steam_root=http://repo.steampowered.com/steam/pool/steam/s/steam/
    steam_file="$(wget -q -O- "$steam_root?C=M;O=D" | sed -En '/steam-launcher/{s/.*href="([^"]+)".*/\1/;p;q;}')"
    echo "$steam_root$steam_file"
  }
fi

function other_stuff() {
  # Install Git Extras
  if [[ ! "$(type -P git-extras)" ]]; then
    e_header "Installing Git Extras"
    (
      cd $DOTFILES/vendor/git-extras &&
      sudo make install
    )
  fi
  # Install misc bins from zip file.
 # install_from_zip ngrok 'https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip'
 # install_from_zip terraform 'https://releases.hashicorp.com/terraform/0.9.2/terraform_0.9.2_linux_amd64.zip'
}

####################
# ACTUALLY DO THINGS
####################

# Add APT keys.
keys_cache=$DOTFILES/caches/init/apt_keys
IFS=$'\n' GLOBIGNORE='*' command eval 'setdiff_cur=($(<$keys_cache))'
setdiff_new=("${apt_keys[@]}"); setdiff; apt_keys=("${setdiff_out[@]}")
unset setdiff_new setdiff_cur setdiff_out

if (( ${#apt_keys[@]} > 0 )); then
  e_header "Adding APT keys (${#apt_keys[@]})"
  for key in "${apt_keys[@]}"; do
    e_arrow "$key"
    if [[ "$key" =~ -- ]]; then
      sudo apt-key adv $key
    else
      wget -qO- $key | sudo apt-key add -
    fi && \
    echo "$key" >> $keys_cache
  done
fi

# Add APT sources.
function __temp() { [[ ! -e /etc/apt/sources.list.d/$1.list ]]; }
source_i=($(array_filter_i apt_source_files __temp))

if (( ${#source_i[@]} > 0 )); then
  e_header "Adding APT sources (${#source_i[@]})"
  for i in "${source_i[@]}"; do
    source_file=${apt_source_files[i]}
    source_text=${apt_source_texts[i]}
    if [[ "$source_text" =~ ppa: ]]; then
      e_arrow "$source_text"
      sudo add-apt-repository -y $source_text
    else
      e_arrow "$source_file"
      sudo sh -c "echo '$source_text' > /etc/apt/sources.list.d/$source_file.list"
    fi
  done
fi

# Update APT.
e_header "Updating APT"
sudo apt-get -qq update

# Only do a dist-upgrade on initial install, otherwise do an upgrade.
e_header "Upgrading APT"
if is_dotfiles_bin; then
  sudo apt-get -qy upgrade
else
  sudo apt-get -qy dist-upgrade
fi

# Install APT packages.
installed_apt_packages="$(dpkg --get-selections | grep -v deinstall | awk 'BEGIN{FS="[\t:]"}{print $1}' | uniq)"
apt_packages=($(setdiff "${apt_packages[*]}" "$installed_apt_packages"))

if (( ${#apt_packages[@]} > 0 )); then
  e_header "Installing APT packages (${#apt_packages[@]})"
  for package in "${apt_packages[@]}"; do
    e_arrow "$package"
    [[ "$(type -t preinstall_$package)" == function ]] && preinstall_$package
    sudo apt-get -qq install "$package" && \
    [[ "$(type -t postinstall_$package)" == function ]] && postinstall_$package
  done
fi

# Install debs via dpkg
function __temp() { [[ ! -e "$1" ]]; }
deb_installed_i=($(array_filter_i deb_installed __temp))

if (( ${#deb_installed_i[@]} > 0 )); then
  mkdir -p "$installers_path"
  e_header "Installing debs (${#deb_installed_i[@]})"
  for i in "${deb_installed_i[@]}"; do
    e_arrow "${deb_installed[i]}"
    deb="${deb_sources[i]}"
    [[ "$(type -t "$deb")" == function ]] && deb="$($deb)"
    installer_file="$installers_path/$(echo "$deb" | sed 's#.*/##')"
    wget -O "$installer_file" "$deb"
    sudo dpkg -i "$installer_file"
  done
fi

# install bins from zip file
function install_from_zip() {
  local name=$1 url=$2 bins b zip tmp
  shift 2; bins=("$@"); [[ "${#bins[@]}" == 0 ]] && bins=($name)
  if [[ ! "$(which $name)" ]]; then
    mkdir -p "$installers_path"
    e_header "Installing $name"
    zip="$installers_path/$(echo "$url" | sed 's#.*/##')"
    wget -O "$zip" "$url"
    tmp=$(mktemp -d)
    unzip "$zip" -d "$tmp"
    for b in "${bins[@]}"; do
      sudo cp "$tmp/$b" "/usr/local/bin/$(basename $b)"
    done
    rm -rf $tmp
  fi
}

# Run anything else that may need to be run.
type -t other_stuff >/dev/null && other_stuff
