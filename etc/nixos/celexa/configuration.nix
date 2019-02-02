# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
     [
      /etc/nixos/hardware-configuration.nix
    ];


  boot.initrd.luks.devices = [
    {
      name = "root";
      device = "/dev/sdc2";
      preLVM = true;
    }
];


  nixpkgs.config = {
    allowUnfree = true;
  };

  hardware.enableAllFirmware = true;


  nix.binaryCaches = [
    "https://cache.nixos.org"
  ];


  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  sound.enable = true;

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };

  services.mpd = {
    enable = true;
    user = "barrel";
    group = "users";
    musicDirectory = "/home/SSD/Music/";
    dataDir = "/home/barrel/.mpd";
    extraConfig = ''
        audio_output {
          type    "pulse"
          name    "Local MPD"
          server  "127.0.0.1"
        }
      '';
  };


  hardware.pulseaudio = {
    enable = true;
    daemon.config = {
      # Allow app volumes to be set independently of master
      flat-volumes = "no";
    };
    # Get a lightweight package by default. Need full to support BT audio.
    # package = pkgs.pulseaudioFull;
  };


  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_AU.UTF-8";
  };

#  fonts = {
#    enableFontDir = true;
#    enableGhostscriptFonts = true;
#    fonts = with pkgs; [
#      liberation_ttf
#      corefonts  # Micrsoft free fonts
#      font-awesome-5
#      noto-fonts
#      noto-fonts-cjk
#      noto-fonts-emoji
#      terminus_font # for hidpi screens, large fonts
#      ubuntu_font_family  # Ubuntu fonts
#    ];
#  };


  fonts.fonts = with pkgs; [
    iosevka
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code
    siji 
    fira-code-symbols
    source-code-pro
    source-sans-pro
    source-serif-pro
    mplus-outline-fonts
    dina-font
    proggyfonts
];

fonts.fontconfig = {
	defaultFonts = {
		monospace = [ "Source Code Pro" ];
		sansSerif = [ "Source Sans Pro" ];
		serif = [ "Source Serif Pro" ];
  };
};
 
  # Set your time zone.
  time.timeZone = "Europe/London";

  virtualisation.libvirtd.enable = true;
  boot.kernel.sysctl = { "net.ipv4.ip_forward" = 1; };
  
  environment.sessionVariables = {
   # XCURSOR_PATH = [
   #   "${config.system.path}/share/icons"
   #   "$HOME/.icons"
   #   "$HOME/.nix-profile/share/icons/"
   # ];
    GTK_DATA_PREFIX = [
      "${config.system.path}"
    ];
};

  # SEE .nixpkgs/config.nix for installed packages
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    gcc
    ufraw
    spotify
    font-manager
    exfat
    xcalib
    acpi
    thunderbird
    zip
    unzip
    unrar
    imagemagick
    gimp
    adapta-gtk-theme
    arc-theme
    xorg.xcursorthemes
    lxappearance
    darktable
    playerctl
    alacritty
    pkgs.gnome3.dconf
    ranger
    rxvt_unicode
    python3
    exfat-utils
    sxhkd
    bspwm
    fuse_exfat
    zsh
    oh-my-zsh
    pavucontrol
    vim
    qutebrowser
    oh-my-zsh
    youtube-dl
    tdesktop
    mpd
    mpv
    emacs
    wget 
    git 
    dunst
    rofi
    polybar
    gnupg
    zathura
    zathura
    chromium
    google-chrome
    firefox
    antigen
    maim
    libreoffice
    racket
    libinput
    xdotool
    xorg.xprop
    xorg.xwininfo
    steam
    kvm
    kicad
    tmux
    discord
    pass
    i3lock
    lm_sensors
    texlive.combined.scheme-full
  ];


  programs.bash.enableCompletion = true;

  hardware.pulseaudio.support32Bit = true;

  systemd.extraConfig = "DefaultLimitNOFILE=1048576";
  
  programs.zsh.interactiveShellInit = ''
  export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh/

  # Customize your oh-my-zsh options here
  ZSH_THEME="agnoster"
  plugins=(git)

  source $ZSH/oh-my-zsh.sh
'';

programs.zsh.promptInit = ""; # Clear this to avoid a conflict with oh-my-zsh

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    desktopManager.default = "none";
    displayManager.lightdm.enable = true;
    displayManager.lightdm.autoLogin.user = "barrel";
    synaptics.enable = false;
    libinput = {
      enable = true;
      };
    xkbOptions = "ctrl:nocaps";
};

services.xserver.windowManager = {
  bspwm.enable = true;
#  shxkd.enable = true;
  default = "bspwm";
};

programs.dconf.enable = true;

boot.kernelPackages = pkgs.linuxPackages_latest;

  users.users.barrel =
    { isNormalUser = true;
      home = "/home/barrel";
      shell = pkgs.zsh;
      description = "Will Anderson";
      extraGroups = [ "docker" "audio" "wheel" "networkmanager" "libvirtd" "qemu" "kvm" ];
  };

  environment.variables = {
    OH_MY_ZSH = [ "${pkgs.oh-my-zsh}/share/oh-my-zsh" ];
  };


  boot.kernelModules = [
    "kvm"
    "kvm_intel"
  ];
 

 nixpkgs.config.packageOverrides = pkgs: {
  polybar = pkgs.polybar.override {
    mpdSupport = true;
  };
};



  networking.hostName = "celexa";

  hardware.trackpoint.enable = true;

  virtualisation.docker.enable = true;

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  #
    system.stateVersion = "unstable"; # Did you read the comment?
}
