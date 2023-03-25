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
  };
  
  environment.systemPackages = with pkgs; [
    # Base Utilities
    bat file lsd exa tree fd ripgrep silver-searcher findutils ncurses fzf

    # Editor
    vim

    # TUI Apps
    ranger ncdu

    # System
    lshw ctop lsof pciutils usbutils libva-utils

    # Tools
    zip unzip jq tmuxp entr graphviz gnupg mime-types ffmpeg

    # Networking
    curl wget rclone nmap openssh netcat netcat-gnu websocat

    # VS
    git-lfs
    gitAndTools.git-annex
    gitAndTools.git-annex-remote-rclone

    # Development
    python nodejs
    binutils gnumake direnv
    bats niv
  ];
}
