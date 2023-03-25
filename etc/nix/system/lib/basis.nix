{ ... }: {
  # Nix command
  nix = {
    extraOptions = "experimental-features = flakes";
  };

  # Nix setup
  nixpkgs.config.allowUnfree = true;

  # Localization
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  # Config format version (not release version)
  system.stateVersion = "20.03";
}
