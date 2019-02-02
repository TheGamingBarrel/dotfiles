# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

let
  unstableTarball =
    fetchTarball
      https://github.com/NixOS/nixpkgs-channels/archive/nixos-unstable.tar.gz;
in
{

  imports =
    [ # Include the results of the hardware scan.
      /etc/nixos/hardware-configuration.nix
    ];

  nixpkgs.config = {
    packageOverrides = pkgs: {
      unstable = import unstableTarball {
        config = config.nixpkgs.config;
      };
    };
  };


  boot.initrd.luks.devices = [
    {
      name = "root";
      device = "/dev/sdb2";
      preLVM = true;
    }
];


  nixpkgs.config.allowUnfree = true;

  hardware.enableAllFirmware = true;

  security.chromiumSuidSandbox.enable = true;

  nix.binaryCaches = [
#    "hydra.mayflower.de:9knPU2SJ2xyI0KTJjtUKOGUVdR2/3cOB4VNDQThcfaY="
    "https://cache.nixos.org"
  ];


  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  sound.enable = true;

  


  services.mpd = {
    enable = true;
    user = "barrel";
    group = "users";
    musicDirectory = "/home/SSD/Music/";
    dataDir = "/home/barrel/.config/mpd/";
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

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    s3tcSupport = true;
  };
    


  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "us";
    defaultLocale = "en_AU.UTF-8";
  };

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
    GTK_DATA_PREFIX = [
      "${config.system.path}"
    ];
};

  # SEE .nixpkgs/config.nix for installed packages
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [

    # Development
    gcc
    ufraw
    ffmpeg
    libGL
    unstable.unity3d
    git 
    nmap
    iperf
    gnupg
    tlp
    racket
    python3

    # Music and Video

    mpv
    mpd
    playerctl

    # 3D Stuff
    blender

    # File Management
    unzip
    unrar
    zip
    ranger

    # Image Manipulation
    imagemagick
    gimp
    darktable

    font-manager
    # GTK Things
    adapta-gtk-theme
    arc-theme
    lxappearance
    pkgs.gnome3.dconf


    # X Stuff
    unstable.tdrop
    xdotool
    sxhkd 
    bspwm
    compton
    xcalib
    xorg.xprop
    xorg.xwininfo
    xorg.xcursorthemes
    dunst
    rofi
    polybar
    alacritty
    rxvt_unicode

    # Power Management

    acpi

    # File System Stuff

    exfat-utils
    fuse_exfat
    exfat

    # Shell Stuff
    zsh
    oh-my-zsh

    # Text Editing and Viewing
    (import ./vim.nix)
    emacs
    zathura
    libreoffice
    ibus
    youtube-dl
    wget 

    # Web Browsers
    unstable.qutebrowser
    chromium
    google-chrome
    firefox
    tor

    #Games
    unstable.steam


    # Social Medias
    unstable.discord
    tdesktop
    thunderbird
    keybase


    # Miscellaneous 
    pass
    filezilla
    libinput
    i3lock
    texlive.combined.scheme-full
    lm_sensors
    antigen
    maim
    pavucontrol

    # Virtualization
    kvm

    # Games
    minecraft

    
  ];


  programs.adb.enable = true;
#  programs.vim.defaultEditor = true;
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

  services.fprintd.enable = true;

  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplipWithPlugin ];

  services.avahi.enable = true;
  services.avahi.publish.enable = true;
  services.avahi.publish.userServices = true;

  services.printing.browsing = true;
  services.printing.listenAddresses = [ "*:631" ]; # Not 100% sure this is needed and you might want to restrict to the local network
  services.printing.defaultShared = true; # If you want

  networking.firewall.allowedUDPPorts = [ 631 8000 5001 ];
  networking.firewall.allowedTCPPorts = [ 631 8000 ];

  # Enable the X11 windowing system.
  services.xserver = {
    enable = true;
    layout = "us";
    displayManager.lightdm.enable = true;
    displayManager.lightdm.autoLogin.user = "barrel";
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

#boot.kernelPackages = with pkgs; linuxPackages_latest;

  users.users.barrel =
    { isNormalUser = true;
      home = "/home/barrel";
      shell = pkgs.zsh;
      description = "Will Anderson";
      extraGroups = [ "uucp" "adbusers" "docker" "audio" "wheel" "networkmanager" "libvirtd" "qemu" "kvm" ];
  };

  environment.variables = {
    OH_MY_ZSH = [ "${pkgs.oh-my-zsh}/share/oh-my-zsh" ];
  };


  boot.kernelModules = [
    "kvm"
    "acpi_call"
    "kvm_intel"
  ];
 
  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs.ibus-engines; [ hangul table table-others ];
  };


  networking.hostName = "celexa";

  hardware.trackpoint.enable = true;

  virtualisation.docker.enable = true;
  system.stateVersion = "18.03";

}
