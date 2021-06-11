# Yvan Vivid - General System

{ pkgs, ... }: {
  # Sound
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    media-session.enable = true;
  };

  # Bluetooth
  hardware.bluetooth.enable = true;

  # Power / thermal
  services = {
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

  # Networking
  networking = {
    networkmanager.enable = true;
    useDHCP = false;
    hosts = {
      "127.0.0.1"   = [ "localhost.localdomain" "localhost" ];
      "192.168.0.1" = [ "router" ];
    };
  };

  # Fonts
  fonts = {
    fontDir.enable = true;
    enableGhostscriptFonts = true;
    fontconfig.enable = true;
  };
}
