{ ... }: let
  usbFsOps = [
    "rw"
    "noauto"
    "user"
    "nosuid"
    "nodev"
    "noexec"
    "nofail"
    "noatime"
  ];
in {
  fileSystems."/mnt/pred" = {
    device = "/dev/disk/by-uuid/93d1105f-f05a-4791-b57b-61c401d5faf2";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/80C8-9AF0";
    fsType = "vfat";
  };

  fileSystems."/mnt/oak" = {
    device = "/dev/disk/by-uuid/f185035f-a3b7-42f1-b738-9fec78729748";
    fsType = "btrfs";
    options = usbFsOps;
  };

  fileSystems."/mnt/finger" = {
    device = "/dev/disk/by-uuid/ed8988f8-f396-49e7-a6bb-5f6a058e5901";
    fsType = "f2fs";
    options = usbFsOps;
  };
}
