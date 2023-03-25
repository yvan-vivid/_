# Yvan Vivid - 'red-arrow' NixOS config

{ config, pkgs, ... }:
let
  nerdfontsUsed = [
    "DejaVuSansMono"
    "FantasqueSansMono"
    "FiraCode"
    "Iosevka"
    "OpenDyslexic"
  ];
in
{
  imports = [
    ../lib/basis.nix
    ../lib/file-systems.nix
    ../lib/system.nix
    ../lib/term-life.nix
    ../lib/sway-de.nix
  ];

  # Overrides
  nixpkgs.config.packageOverrides = pkgs: {
    vaapiIntel = pkgs.vaapiIntel.override { enableHybridCodec = true; };
    nerdfonts = pkgs.nerdfonts.override { fonts = nerdfontsUsed; };
  };

  # Boot specifics
  boot.loader = {
    systemd-boot.enable = true;
    efi = {
      canTouchEfiVariables = true;
      efiSystemMountPoint = "/boot/efi";
    };
  };

  console.font = "ter-i32b"; # HDPI
  
  boot.kernelPackages = pkgs.linuxPackages_6_0;
  hardware.cpu.intel.updateMicrocode = true;

  # Graphics
  hardware.opengl = {
    enable = true;
    driSupport = true;
    extraPackages = with pkgs; [
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      intel-media-driver
    ];
  };

  networking = {
    hostName = "red-arrow";
  };

  fonts = {
    fonts = with pkgs; [
      nerdfonts
      helvetica-neue-lt-std
      ubuntu_font_family
    ];
    fontconfig = {
      defaultFonts = {
        sansSerif = [ "Ubuntu" ];
        monospace = [ "DejaVuSansMono Nerd Font" ];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    # system
    libva
    libnotify
  ];

  # Logind tweaks
  services.logind = {
    extraConfig =
      ''HandlePowerKey=suspend
        HandleLidSwitchExternalPower=ignore
      '';
  };

  services = {
    lorri.enable = true;
  };

  users = {
    defaultUserShell = pkgs.zsh;
    extraUsers = {
      hexxiiiz = {
        isNormalUser = true;
        createHome = true;
        uid = 1000;
        extraGroups = [
          "audio"
          "video"
          "input"
          "jackaudio" # media control
          "wheel"
          "network"
          "networkmanager"
          "nordvpn" # system
          "docker"
          "fuse"
          "sway"
        ];
        useDefaultShell = true;
      };
    };
  };
  nix.trustedUsers = [ "root" "hexxiiiz" ];

  # Virtualization / Containerization
  virtualisation = {
    docker.enable = true;
  };
}
