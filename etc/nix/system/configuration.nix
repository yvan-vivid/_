# Yvan Vivid - generic NixOS config
# dependent on a file `name.nix` which contains the name

{ config, pkgs, ... }: let
  name = import ./name.nix;
  machines = {
    "burning-pope" = ./machines/burning-pope.nix;
    "wittie-box" = ./machines/wittie-box.nix;
    "red-arrow" = ./machines/red-arrow.nix;
  };
  machine = machines.${name};
in {
  imports = [
    ./hardware-configuration.nix
    machine
  ];
}
