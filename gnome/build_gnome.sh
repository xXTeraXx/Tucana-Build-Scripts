#!/bin/bash
set -e
ROOT="$(pwd)"
build() {
  echo "Building $1"
  bash -e $ROOT/$1

}
build "gcr"
build "gcr-4"
build "gsettings-desktop-schemas"
build "yelp-xsl"
build "gjs"
build "gnome-autoar"
build "gnome-desktop"
build "gnome-menus"
build "gnome-video-effects"
build "gnome-online-accounts"
build "libwnck"
build "libcloudproviders"
build "evolution-data-server"

# Desktop
build "dconf"
build "dconf-editor"
build "gnome-backgrounds"
build "gexiv2"
build "nautilus"
build "gnome-bluetooth"
build "gnome-keyring"
build "gnome-settings-daemon"
build "tecla"
build "gnome-control-center"
build "mutter"
build "gnome-shell"
build "gnome-shell-extensions"
build "gnome-session"
build "gnome-tweaks"
build "gnome-user-docs"
build "yelp"
build "loupe"
build "gdm"
build "gnome-software"
