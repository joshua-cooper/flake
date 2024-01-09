{ lib, modulesPath, ... }:

{
  imports = [
    (modulesPath + "/profiles/qemu-guest.nix")
  ];

  boot = {
    initrd = {
      availableKernelModules = [ "xhci_pci" "virtio_pci" "virtio_scsi" "usbhid" "sr_mod" ];
      kernelModules = [ ];
    };
    kernelModules = [ ];
    extraModulePackages = [ ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/bdfe5a72-fd44-4acd-9b7c-54bfd3637928";
      fsType = "ext4";
    };

    "/boot" = {
      device = "/dev/disk/by-uuid/C5EC-F89D";
      fsType = "vfat";
    };
  };

  swapDevices = [ ];

  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp1s0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
