# Yvan Vivid - 'burning-pope' NixOS config

{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ./lib/file-systems.nix
  ];

  nixpkgs.config = {
    allowUnfree = true;
    pulseaudio = true;
  };
  xdg.portal.enable = true;

  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  # Boot related
  boot.kernelPackages = pkgs.linuxPackages_5_9;
  boot.loader = {
    systemd-boot = { enable = true; editor = false; };
    efi.canTouchEfiVariables = true;

    grub = {
      enable = true;
      efiSupport = true;
      useOSProber = true;
      device = "nodev";
    };

    # might change later - no rush
    timeout = 20;
  };
  boot.initrd.kernelModules = [ "i915" ];

  hardware = {
    brillo.enable = true;
    bluetooth.enable = true;
    # hardware.cpu.intel.updateMicrocode = true;

    opengl = {
      enable = true;
      driSupport = true;
      extraPackages = with pkgs; [
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
        intel-media-driver
      ];
    };

    pulseaudio = {
      enable = true;
      extraConfig = ''
        # Automatically switch to newly connected devices.
        load-module module-switch-on-connect
      '';
      zeroconf.discovery.enable = true;

      # bluetooth support
      extraModules = [ pkgs.pulseaudio-modules-bt ];

      # bluetooth and other support
      package = pkgs.pulseaudioFull;
    };
  };

  # Enable sound.
  sound.enable = true;

  networking = {
    networkmanager.enable = true;
    hostName = "burning-pope";
    hosts = {
      "127.0.0.1"    = [ "localhost.localdomain" "localhost" ];
      "127.0.1.1"    = [ "burning-pope" ];
      "192.168.0.1"  = [ "router" ];
      "192.168.0.87" = [ "wittie-box.localdomain" "wittie-box" ];
    };

    useDHCP = false;
    interfaces = {
      "wlp59s0" = {
        useDHCP = true;
      };
    };
  };

  console = {
    packages = [ pkgs.terminus_font ];
    font = "ter-i32b"; # HDPI
    keyMap = "us";
  };

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
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
      # TODO: Consider bumping this
      dpi = 0;
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    # shell environment
    tmuxp ncurses
    bat ncdu ripgrep htop jq nox file htop findutils lsd ranger tree
    unzip usbutils entr iotop lshw pciutils zip ctop bat fd ripgrep ag
    fzf exa lsof bats direnv
    neovim vim

    # network
    curl wget rclone nmap openssh netcat netcat-gnu websocat

    # versioning
    git git-lfs
    gitAndTools.git-annex
    gitAndTools.git-annex-remote-rclone

    # dev env
    python39
    nodejs
    binutils gnumake cmake

    # media
    jack2 qjackctl cadence
    ffmpeg
    mpv imv zathura pandoc graphviz

    # security
    gnupg

    # apps
    alacritty kitty pavucontrol gparted

    # system
    wineWowPackages.stable
    qemu libva-full libva-utils libnotify mime-types niv
  ];

  programs = {
    sway = {
      enable = true;
      extraPackages = with pkgs; [
        swaybg swaylock swayidle
        mako wofi i3status-rust xwayland
        kanshi wev wob slurp grim wl-clipboard
        redshift
      ];
    };
    tmux.enable = true;
    zsh.enable = true;
    less.enable = true;
  };

  services = {
    flatpak.enable = true;
    openssh.enable = true;
    acpid.enable = true;
    pipewire.enable = true;
    hardware.bolt.enable = true;
    printing.enable = true;
    thermald.enable = true;
    upower.enable = true;
    irqbalance.enable = true;
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
          "wheel" "network" "networkmanager" # system
          "docker" "vboxusers" # virtualisation
          "fuse" "sway"
        ];
        useDefaultShell = true;
      };
    };
  };
  nix.trustedUsers = [ "root" "hexxiiiz" ];

  security = {
    sudo.enable = true;
    polkit.enable = true;
    pam.loginLimits = [
      { domain = "@audio"; item = "memlock"; type = "-"; value = "800000"; }
      { domain = "@audio"; item = "rtprio"; type = "-"; value = "95"; }
    ];
  };

  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.03"; # Did you read the comment?
}
