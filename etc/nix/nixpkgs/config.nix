{ pkgs }: let
  inherit (pkgs) buildEnv;

  python-packages = py: with py; [
    mypy pynvim pylint pytest ipython cython jupyter poetry
    python-lsp-server
    pylsp-mypy
    python-lsp-black
  ];

  node-packages = pkgs: with pkgs.nodePackages; [
    pkgs.nodejs
    eslint
    typescript
    prettier
    prettier-plugin-toml

    # language servers
    bash-language-server
    diagnostic-languageserver
    dockerfile-language-server-nodejs
    svelte-language-server
    typescript-language-server
    vscode-css-languageserver-bin
    vscode-json-languageserver-bin
    vscode-html-languageserver-bin
    
    # vim-language-server
    yaml-language-server
  ];
in { 
  allowUnfree = true;

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/neovim-nightly-overlay/archive/master.tar.gz;
    }))
  ];

  packageOverrides = pkgs: with pkgs; rec {
    bitwig = callPackage ./bitwig-studio-3.nix {
      inherit (gnome3) zenity;
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
        gnome3.cheese
        fluidsynth
        soundfont-fluid
        lame
        
        # Visual
        gimp
        shotwell
        imagemagick
        inkscape
        blender
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

        gcc

        # Language Servers
        asls
        # cmake-language-server
        dhall-lsp-server
        erlang-ls
        haskell-language-server
        java-language-server
        rnix-lsp
        sumneko-lua-language-server
        terraform-ls
        texlab
        
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
      ];
    };
    
    yvan-apps = buildEnv {
      name = "yvan-apps";
      paths = [
        zoom-us
        zotero
        youtube-dl
        tdesktop # telegram desktop
        beets
        foot
        nyxt
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

        # System
        lxappearance
        breeze-icons
        breeze-gtk
      ];
    };
  };
}
