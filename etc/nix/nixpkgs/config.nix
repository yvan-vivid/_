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
      pylatexenc
    ];

  node-packages = pkgs:
    with pkgs.nodePackages; [
      pkgs.nodejs
      eslint
      typescript
      prettier
    ];

  tex-setup = pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-basic titlesec xetex collection-latexextra;
  };
in {
  allowUnfree = true;
  android_sdk.accept_license = true;
  packageOverrides = pkgs:
    with pkgs; rec {
      yvan-python-env = buildEnv {
        name = "yvan-python-env";
        paths = [
          ((python312.withPackages python-packages).override
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
          uv

          # LSP / Neovim support
          bash-language-server
          typescript-language-server
          svelte-language-server
          yaml-language-server
          lua-language-server
          marksman
          nixd
          prettierd
          ruff-lsp
          basedpyright
          harper
          # basedmypy

          # Formatters
          shfmt
          html-tidy
          alejandra
          stylua
          csslint
          ruff

          texlab

          # Writing Tools
          pdftk
          languagetool
          tex-setup
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
          ueberzugpp
          zoxide
          systemctl-tui
          aerc
          dysk

          # Shell
          oh-my-posh
          fish
          sesh

          # File Browsers
          yazi
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
          spacedrive

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

          # Games
          gzdoom
          higan
          zsnes

          # AI
          ollama
        ];
      };

      yvan-local = buildEnv {
        name = "yvan-local";
        paths = [
          # Default dev environments
          yvan-python-env
          yvan-node-env

          yvan-production
          yvan-dev-tools
          yvan-term-env
          yvan-apps

          # Android development
          # android-studio
        ];
      };
    };
}
