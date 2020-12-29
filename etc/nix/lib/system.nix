# Yvan Vivid - General System

{ pkgs, ... }: {
  # Sound
  nixpkgs.config.pulseaudio = true;
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    extraConfig = ''
      # Automatically switch to newly connected devices.
      load-module module-switch-on-connect
    '';
    zeroconf.discovery.enable = true;

    # bluetooth support
    extraModules = [ pkgs.pulseaudio-modules-bt ];

    # bluetooth and other support
    package = pkgs.pulseaudioFull;
  };
  services.pipewire.enable = true;

  # Bluetooth
  hardware.bluetooth.enable = true;

  # Power / thermal
  services = {
    acpid.enable = true;
    thermald.enable = true;
    upower.enable = true;
  };

  # Other services
  services = {
    openssh.enable = true;
    printing.enable = true;
    irqbalance.enable = true;
  };

  # Security
  security = {
    sudo.enable = true;
    polkit.enable = true;
  };

  # Console setup
  console = {
    packages = [ pkgs.terminus_font ];
    font = "ter-i32b"; # HDPI
    keyMap = "us";
  };
}
