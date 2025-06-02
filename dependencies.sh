#!/bin/bash
# Salir en caso de error
set -e
echo "🛠️ Instalando paquetes con pacman..."
sudo pacman -Syu --needed \
  kitty hyprland wofi \
  git base-devel \
  lazygit fzf \
  waypaper \
  wl-clipboard cliphist \
  hyprland-qtutils \
  nautilus \
  brightnessctl \
  nvim \
  cpio cmake meson gcc \
  ark thunar-archive-plugin \
  nwg-look \
  waybar \
  swaync \
  pamixer \
  hyprlock \
  wlogout \
  sddm \
  udisks2 udiskie \
  xdg-desktop-portal xdg-desktop-portal-hyprland xdg-desktop-portal-gtk \
  pipewire pipewire-pulse pipewire-jack wireplumber \
  tlp tlp-rdw

echo "⚙️ Habilitando e iniciando SDDM..."
sudo systemctl enable sddm.service --force
sudo systemctl start sddm.service

echo "📦 Instalando yay (si no está instalado)..."
if ! command -v yay &> /dev/null; then
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
  cd ..
  rm -rf yay
fi

echo "🎉 Instalando paquetes desde AUR con yay..."
yay -S --noconfirm \
  pyprland \
  python-pywalfox \
  python-pywal16 \
  hyprpolkitagent \
  nautilus-admin-gtk4 \
  actions-for-nautilus-git \
  nautilus-open-any-terminal \
  ttf-jetbrains-mono-nerd \
  power-profiles-daemon \
  visual-studio-code-bin \
  galculator \
  hypridle \
  hyprshot \
  rofi rsync \
  swww-git \
  obsidian \
  auto-cpufreq \
  zellij-git \
  ttf-cascadia-code \
  dotnet-sdk-8.0-bin \
  intel-undervolt \
  youtube-music-bin

echo "🔧 Configurando Nautilus..."
sudo glib-compile-schemas /usr/share/glib-2.0/schemas/
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal kitty

echo "🎵 Habilitando servicios PipeWire..."
systemctl --user enable pipewire.service pipewire-pulse.service wireplumber.service
systemctl --user start pipewire.service pipewire-pulse.service wireplumber.service

echo "🌀 Instalando Oh My Fish..."
git clone https://github.com/oh-my-fish/oh-my-fish.git
cd oh-my-fish
bin/install --offline
omf install eclm
cd ..
rm -rf oh-my-fish

echo "🔁 Reiniciando servicios de portal xdg..."
systemctl --user restart xdg-desktop-portal xdg-desktop-portal-hyprland

echo "⚙️ Configurando intel-undervolt..."
sudo tee /etc/intel-undervolt.conf > /dev/null <<EOF
enable=yes
CPU: -90
GPU: -90
CPU Cache: -90
System Agent: -90
Analog I/O: -90
EOF

# Habilitar e iniciar intel-undervolt y tlp
sudo systemctl enable intel-undervolt.service --now
sudo systemctl enable tlp.service --now

echo "✅ Todo listo. El sistema ha sido configurado correctamente."
