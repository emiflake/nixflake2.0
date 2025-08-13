{ config, inputs, system, pkgs, ... }:

{
  imports = [
    # Include the results of the hardware scan.
    ../hardware/desktop-7950x.nix
    ../modules/fonts.nix
  ];

  # Bootloader.
  # boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.configurationLimit = 5;

  networking.hostName = "nextflake";

  # networking.wireless.enable = true;
  services.pcscd.enable = true;

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 27504 5173 ];
    allowedUDPPortRanges = [
      {
        from = 27504;
        to = 27504;
      }
      {
        from = 5173;
        to = 5173;
      }
    ];
  };

  hardware.rasdaemon.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  # Graphics support
  hardware = {
    graphics.enable = true;
    # driSupport32Bit = true;
    graphics.enable32Bit = true;
  };

  hardware.nvidia = {
    # package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
    #   version = "555.42.02";
    #   sha256_64bit = "sha256-k7cI3ZDlKp4mT46jMkLaIrc2YUx1lh1wj/J4SVSHWyk=";
    #   sha256_aarch64 = "sha256-rtDxQjClJ+gyrCLvdZlT56YyHQ4sbaL+d5tL4L4VfkA=";
    #   openSha256 = "sha256-rtDxQjClJ+gyrCLvdZlT56YyHQ4sbaL+d5tL4L4VfkA=";
    #   settingsSha256 = "sha256-rtDxQjClJ+gyrCLvdZlT56YyHQ4sbaL+d5tL4L4VfkA=";
    #   persistencedSha256 = pkgs.lib.fakeSha256;
    # };
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  # boot.initrd.kernelModules = [ "nvidia" ];
  services.xserver.videoDrivers = [ "nvidia" ];
  boot.kernel.sysctl = { "fs.inotify.max_user_watches" = "1048576"; };
  # hardware.opengl.extraPackages = with pkgs; [
  #   amdvlk
  # ];
  # # For 32 bit applications 
  # hardware.opengl.extraPackages32 = with pkgs; [
  #   driversi686Linux.amdvlk
  # ];
  services.ollama = {
    enable = true;
    package = (import inputs.nixpkgs-master {
      inherit system;
      config.allowUnfree = true;
    }).ollama;
    acceleration = "cuda";
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

  services.xserver.enable = true;
  services.xserver.displayManager.startx.enable = true;

  services.xserver = {
    layout = "us";
    xkbVariant = "";
  };

  services.printing.enable = true;

  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  services.tailscale.enable = true;

  programs.zsh.enable = true;
  virtualisation.docker = {
    enable = true;
    # Set up resource limits
    daemon.settings = {
      experimental = true;
      default-address-pools = [{
        base = "172.30.0.0/16";
        size = 24;
      }];
    };
  };

  users.users.emi = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "emi";
    extraGroups = [ "networkmanager" "wheel" "docker" "tty" "dialout" ];
    packages = with pkgs; [ firefox ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  nix.trustedUsers = [ "root" "@wheel" ];
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" "ca-derivations" ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [ vim git wget curl pinentry-curses ];

  system.stateVersion = "23.11"; # Did you read the comment?

}
