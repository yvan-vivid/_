# Yvan Vivid
# This little library parses external volume records out of a json file and
# generates mounts for nixos to put into fstab

let
  optionsSets = {
    usb = [
      "rw" "noauto" "user"
      "nosuid" "nodev" "noexec" "nofail" "noatime"
    ];
  };

  expandMount = { name, fsType, uuid, optionSet ? "usb" }: {
    inherit name fsType uuid;
    mountPoint = "/mnt/${name}";
    device = "/dev/disk/by-uuid/${uuid}";
    options = optionsSets."${optionSet}";
  };

  mountToFsAttr = { mountPoint, device, fsType, options, ... }: {
    name = mountPoint;
    value = { inherit device fsType options; };
  };

  createFileSystems = mounts: builtins.listToAttrs (map mountToFsAttr mounts);

  loadMounts = with builtins; path:
    if pathExists path
    then map expandMount (fromJSON (readFile path))
    else [];

in { inherit createFileSystems loadMounts; }
