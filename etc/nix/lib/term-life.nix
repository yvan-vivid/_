# Yvan Vivid - Terminal Environment

{ ... }: {
  programs = {
    tmux.enable = true;
    zsh.enable = true;
    less.enable = true;
  };
  
  environment.systemPackages = with pkgs; [
    # Base Utilities
    bat file lsd exa tree fd ripgrep ag findutils ncurses fzf

    # Editor
    neovim vim

    # TUI Apps
    ranger ncdu

    # System
    htop lshw ctop iotop lsof pciutils usbutils libva-utils

    # Tools
    zip unzip jq tmuxp entr pandoc graphviz gnupg mime-types ffmpeg

    # Networking
    curl wget rclone nmap openssh netcat netcat-gnu websocat

    # VS
    git git-lfs
    gitAndTools.git-annex
    gitAndTools.git-annex-remote-rclone

    # Development
    python39 nodejs
    binutils gnumake direnv
    bats niv
  ];
}
