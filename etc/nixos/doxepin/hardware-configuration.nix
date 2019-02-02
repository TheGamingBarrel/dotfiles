# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "uhci_hcd" "ehci_pci" "ahci" "usb_storage" "sd_mod" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/35da6f50-a776-4021-9fd4-0fed44e8e404";
      fsType = "xfs";
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/6265ff01-c8f5-4f83-9d93-95560d7a9f7f"; }
    ];

  nix.maxJobs = lib.mkDefault 2;
}
