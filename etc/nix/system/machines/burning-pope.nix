# Yvan Vivid - 'burning-pope' NixOS config

{ config, pkgs, ... }: let
  nerdfontsUsed = [ 
    "Agave"
    "DejaVuSansMono"
    "FantasqueSansMono"
    "FiraCode"
    "Iosevka"
    "OpenDyslexic"
  ];

in {
  imports = [
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

  boot.kernelPackages = pkgs.linuxPackages_6_0;
  hardware.cpu.intel.updateMicrocode = true;
  # book.kernelParams = [ "i915.enable_fbc=1" ];

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
    hostName = "burning-pope";
    interfaces = { "wlp59s0" = { useDHCP = true; }; };
  };

  # Machine specific filesystems
  fileSystems."/mnt/pred" = {
    device = "/dev/disk/by-uuid/93d1105f-f05a-4791-b57b-61c401d5faf2";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/80C8-9AF0";
    fsType = "vfat";
  };

  fonts = {
    fonts = with pkgs; [
      corefonts
      nerdfonts
      google-fonts
      helvetica-neue-lt-std
      ubuntu_font_family
    ];
    fontconfig = {
      defaultFonts = {
        sansSerif = ["Ubuntu"];
        monospace = ["DejaVuSansMono Nerd Font"];
      };
    };
  };

  environment.systemPackages = with pkgs; [
    # system
    wineWowPackages.stable
    qemu libva libnotify
  ];

  # Thunderbolt
  services.hardware.bolt.enable = true;

  # Logind tweaks
  services.logind = {
    extraConfig =
      ''HandlePowerKey=suspend
        HandleLidSwitchExternalPower=ignore
      '';
  };
  
  console.font = "ter-i32b"; # HDPI

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
          "audio" "video" "input" "jackaudio" # media control
          "wheel" "network" "networkmanager" "nordvpn" # system
          "docker" "vboxusers" # virtualisation
          "fuse" "sway"
        ];
        useDefaultShell = true;
      };
    };
  };
  nix.trustedUsers = [ "root" "hexxiiiz" ];

  # Special limits for audio production
  security.pam.loginLimits = [
    { domain = "@audio"; item = "memlock"; type = "-"; value = "800000"; }
    { domain = "@audio"; item = "rtprio"; type = "-"; value = "95"; }
  ];

  # Virtualization / Containerization
  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };
}
