{pkgs}: let
  inherit (pkgs) buildEnv;

  python-packages = py:
    with py; [
      mypy
      pynvim
      pylint
      pytest
      ipython
      cython
      jupyter
      black
      isort
      pyls-isort
      pylsp-mypy
      # python-lsp-black
      python-lsp-server
    ];

  node-packages = pkgs:
    with pkgs.nodePackages; [
      pkgs.nodejs
      eslint
      typescript
      prettier
      prettier-plugin-toml
    ];
in {
  allowUnfree = true;
  packageOverrides = pkgs:
    with pkgs; rec {
      yvan-python-env = buildEnv {
        name = "yvan-python-env";
        paths = [
          ((python311.withPackages python-packages).override
            (args: {ignoreCollisions = true;}))
          poetry
        ];
      };

      yvan-node-env = buildEnv {
        name = "yvan-node-env";
        paths = node-packages pkgs;
      };

      yvan-production = buildEnv {
        name = "yvan-production";
        paths = [
          # Audio
          audacity
          ardour
          mediainfo
          cheese
          fluidsynth
          soundfont-fluid
          lame
          zrythm

          # Visual
          gimp
          shotwell
          imagemagick
          inkscape
          blender
          darktable
          olive-editor
          obs-studio
        ];
      };

      yvan-dev-tools = buildEnv {
        name = "yvan-dev-tools";
        paths = [
          # General Dev
          niv
          shellcheck
          html-tidy
          pandoc
          hexyl
          socat
          gita
          tree-sitter
          gcc
          luarocks
          rustup
          qmk
          go
          shfmt
          nixd
          alejandra
          bash-language-server

          texlab
          stylua

          # Writing Tools
          pdftk
          languagetool
          texlive.combined.scheme-medium
        ];
      };

      yvan-term-env = buildEnv {
        name = "yvan-term-env";
        paths = [
          # Term Apps
          neovim
          helix
          traceroute
          btop
          bottom
          fx
          glow
          yazi
          ueberzugpp

          # Shell
          starship
          fish

          # File Browsers
          broot
          joshuto
          nnn
          eza

          # File Management
          rclone
          duff
        ];
      };

      yvan-apps = buildEnv {
        name = "yvan-apps";
        paths = [
          # Media
          beets
          sioyek
          yt-dlp
          sshfs-fuse

          # browsers
          firefox-bin
          chromium
          # nyxt

          # Alternative Terms
          foot

          # Comms
          signal-desktop
          discord
          tdesktop # telegram desktop
          zoom-us
          wireguard-tools
          # openvpn

          # Productivity
          obsidian
        ];
      };

      yvan-local = buildEnv {
        name = "yvan-local";
        paths = with pkgs; [
          # Default dev environments
          yvan-python-env
          yvan-node-env

          yvan-production
          yvan-dev-tools
          yvan-term-env
          yvan-apps

          # System
          lxappearance
          breeze-icons
          breeze-gtk
        ];
      };
    };
}
