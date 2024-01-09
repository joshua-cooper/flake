{ config, pkgs, ... }:


{
  imports = [
    ./hardware-configuration.nix
    ../../modules/profiles/server.nix
  ];

  system.stateVersion = "23.05";

  system.autoUpgrade = {
    enable = true;
    flake = "github:joshua-cooper/flake#${config.networking.hostName}";
    flags = [
      "--print-build-logs"
      "--refresh"
    ];
    randomizedDelaySec = "1h";
    allowReboot = true;
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking.hostName = "forge";

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  environment.systemPackages = with pkgs; [
    neovim
    gitMinimal
    tmux
  ];

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
    };
  };

  services.gitolite = {
    enable = true;
    user = "git";
    group = "git";
    adminPubkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPYpsPNfmD0/+Bk1ZVigV+WZ+eSD8XMr8XG+k5wt8Urt josh@x13";
  };

  users.users.root.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPv05cZiRXRO3EqVE/C/obDLekCmwPlAWNK5t+Fdpgwi"
  ];
}
