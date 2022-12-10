{ pkgs }: let
  inherit (pkgs) buildEnv;

  python-packages = py: with py; [
    mypy pynvim pylint pytest ipython cython jupyter 
    # poetry
  ];

  node-packages = pkgs: with pkgs.nodePackages; [
    pkgs.nodejs
    eslint
    typescript
    prettier
    prettier-plugin-toml
  ];
in { 
  allowUnfree = true;

  packageOverrides = pkgs: with pkgs; rec {
    bitwig = callPackage ./bitwig-studio-3.nix {
      inherit (gnome) zenity;
      libxkbcommon = libxkbcommon_7;
    };

    yvan-python-env = buildEnv {
      name = "yvan-python-env";
      paths = [
        ((python310.withPackages python-packages).override (args: { ignoreCollisions = true; }))
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
        # bitwig
        audacity
        cadence
        mediainfo
        gnome.cheese
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
        dfeet
        socat
        gita
        tree-sitter
        gcc
        luarocks
        rustup
        qmk

        texlab
        stylua
        
        # Writing Tools
        pdftk
        languagetool
        texlive.combined.scheme-medium
        
        # Shell Env
        neovim
        starship
        fish
        nnn
        duff
        joshuto
        broot
        traceroute
      ];
    };
    
    yvan-apps = buildEnv {
      name = "yvan-apps";
      paths = [
        zoom-us
        yt-dlp
        tdesktop # telegram desktop
        beets
        foot
        nyxt
        bottom
        signal-desktop
        sioyek
        chromium
      ];
    };

    yvan-local = buildEnv {
      name = "yvan-local";
      extraOutputsToInstall = [ "man" ];
      paths = with pkgs; [
        # Default dev environments
        yvan-python-env
        yvan-node-env

        yvan-production
        yvan-dev-tools
        yvan-apps

        # System
        lxappearance
        breeze-icons
        breeze-gtk
      ];
    };
  };
}
