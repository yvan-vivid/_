# Yvan Vivid - Terminal Environment

{ pkgs, ... }: {
  programs = {
    tmux.enable = true;
    zsh.enable = true;
    less.enable = true;
    nix-ld.enable = true;
    git.enable = true;
    htop.enable = true;
    iotop.enable = true;
    usbtop.enable = true;
    iftop.enable = true;
    neovim.enable = true;
    direnv.enable = true;
  };
  
  environment.systemPackages = with pkgs; [
    # Base Utilities
    bat file lsd eza tree fd ripgrep silver-searcher findutils ncurses fzf

    # TUI Apps
    ncdu powertop

    # System
    lshw ctop lsof pciutils usbutils libva-utils udisks f2fs-tools

    # Tools
    zip unzip jq tmuxp entr graphviz gnupg mime-types ffmpeg sheldon

    # Networking
    curl wget rclone nmap openssh netcat netcat-gnu websocat

    # VS
    git-lfs
    gitAndTools.git-annex
    gitAndTools.git-annex-remote-rclone

    # Development
    binutils gnumake direnv bats niv
  ];
}
