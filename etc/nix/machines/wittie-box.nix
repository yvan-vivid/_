# Yvan Vivid - 'wittie-box' NixOS config

{ config, pkgs, ... }: let
  nerdfontsUsed = [ 
    "DejaVuSansMono"
    "FiraCode"
    "OpenDyslexic"
  ];
in {
  imports = [
    ../hardware-configuration.nix
    ../lib/basis.nix
    ../lib/boot.nix
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

  # Kernel Version
  boot.kernelPackages = pkgs.linuxPackages_5_9;

  # OpenGL Settings
  hardware.opengl = {
    enable = true;
    driSupport = true;
    extraPackages = with pkgs; [
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
    ];
  };

  networking = {
    hostName = "wittie-box";
    hosts = {
      "127.0.1.1" = [ "wittie-box" ];
    };
    interfaces = {
      "wlp2s0" = { useDHCP = true; };
    };
  };

  fonts = {
    fonts = with pkgs; [
      helvetica-neue-lt-std
      ubuntu_font_family
      nerdfonts
    ];
    fontconfig = {
      defaultFonts = {
        sansSerif = ["Ubuntu"];
        monospace = ["DejaVuSansMono Nerd Font"];
      };
      # TODO: Consider bumping this
      dpi = 0;
    };
  };

  services.plex = {
    enable = true;
    openFirewall = true;
  };

  environment.systemPackages = with pkgs; [
    # system
    libva-full libnotify
  ];

  users = {
    defaultUserShell = pkgs.zsh;
    extraUsers = {
      yvan = {
        isNormalUser = true;
        createHome = true;
        uid = 1000;
        extraGroups = [
          "audio" "video" "input" "jackaudio" # media control
          "wheel" "network" "networkmanager" # system
          "docker" "vboxusers" # virtualisation
          "fuse" "sway"
        ];
        useDefaultShell = true;
      };
    };
  };
  nix.trustedUsers = [ "root" "yvan" ];

  # Virtualization / Containerization
  virtualisation = {
    docker.enable = true;
  };
}
