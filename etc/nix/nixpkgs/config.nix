{ 
  allowUnfree = true;
  
  packageOverrides = pkgs: with pkgs; rec {
    bitwig = pkgs.callPackage ./bitwig-studio-3.nix {
      inherit (pkgs.gnome3) zenity;
      libxkbcommon = pkgs.libxkbcommon_7;
    };
    
    pidgin-with-plugins = pkgs.pidgin-with-plugins.override {
      plugins = with pkgs; [
        purple-facebook
        purple-hangouts
        purple-slack
        telegram-purple
      ];
    };

    yvan-local = pkgs.buildEnv {
      name = "yvan-local";
      extraOutputsToInstall = [ "man" ];
      paths = with pkgs; [
        # Audio / Video
        bitwig
        audacity
        cadence
        mediainfo
        gnome3.cheese
        fluidsynth
        soundfont-fluid

        # Visual
        gimp
        shotwell
        imagemagick

        # General Dev
        niv
        nix-diff
        texlive.combined.scheme-medium
        shellcheck
        languagetool
        nodejs
        html-tidy
        pandoc
        hexyl
        dfeet
        mediainfo

        # Apps
        firefox-devedition-bin
        zoom-us
        zotero
        youtube-dl
        font-manager
        tdesktop # telegram desktop
        beets

        # Shell Env
        starship
        fish
        nnn
        duff
        mime-types
      ];
    };
  };
}
