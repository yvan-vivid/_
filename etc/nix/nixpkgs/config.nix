let
  python-packages = py: with py; [
    mypy pynvim pylint pytest ipython
    python-language-server
    pyls-mypy pyls-black
  ];

  node-packages = pkgs: with pkgs.nodePackages; [
    pkgs.nodejs
    eslint
    typescript

    # language servers
    typescript-language-server
    svelte-language-server
    vscode-css-languageserver-bin
    vscode-html-languageserver-bin
    bash-language-server
    dockerfile-language-server-nodejs
    vscode-json-languageserver-bin
    vim-language-server
    yaml-language-server
  ];
in { 
  allowUnfree = true;
  
  packageOverrides = pkgs: with pkgs; rec {
    bitwig = pkgs.callPackage ./bitwig-studio-3.nix {
      inherit (pkgs.gnome3) zenity;
      libxkbcommon = pkgs.libxkbcommon_7;
    };

    yvan-local = pkgs.buildEnv {
      name = "yvan-local";
      extraOutputsToInstall = [ "man" ];
      paths = with pkgs; [
        # Default Python
        (python38.withPackages python-packages)

        # Audio / Video
        bitwig
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

        # Writing Tools
        pdftk
        languagetool
        texlive.combined.scheme-medium

        # General Dev
        niv
        shellcheck
        html-tidy
        pandoc
        hexyl
        dfeet

        # Apps
        zoom-us
        zotero
        youtube-dl
        tdesktop # telegram desktop
        beets
        foot
        lxappearance
        breeze-icons
        breeze-gtk

        # Shell Env
        starship
        fish
        nnn
        duff
        mime-types
        xdg_utils
      ] ++ (node-packages pkgs);
    };
  };
}
