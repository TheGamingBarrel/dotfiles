{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/sda"; 

  # Set your time zone.
  time.timeZone = "Europe/London";

  # Enable power management and sensors
  tlp.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget vim bspwm sxhkd git texlive.combined.scheme-full zsh oh-my-zsh acpi rxvt_unicode rofi qutebrowser neofetch libinput zathura lm_sensors
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enables Networking via NetworkManager.
  networking.networkmanager.enable = true;
  networking.hostName = "doxepin"; # Define your hostname.

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable the X11 windowing system.
  
  services.xserver = {
    enable = true;
    layout = "us";
    displayManager.lightdm.enable = true;
    displayManager.lightdm.autoLogin.user = "barrel";
    desktopManager.default = "none";
    desktopManager.xterm.enable = false;
    xkbOptions = "ctrl:nocaps";
    libinput = {
      enable = true;
    };
  }; 
  
  services.xserver.windowManager = {
    bspwm.enable = true;
    default = "bspwm";
  };

   users.users.barrel = {
     isNormalUser = true;
     uid = 1000;
     home = "/home/barrel";
     shell = pkgs.zsh;
     extraGroups = [ "wheel" "networkmanager" ];
   };

  programs.zsh.interactiveShellInit = ''
  export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh
  plugins=(git)

  source $ZSH/oh-my-zsh.sh
'';

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?

}
