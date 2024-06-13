{ pkgs, inputs, ... }:

{
  imports = [
    inputs.hyprland.nixosModules.default
  ./hardware-configuration.nix ./user.nix ];

  services.xserver.desktopManager.xterm.enable = false;

  environment.systemPackages = with pkgs; [
    vim
    git
    htop
  ];

  fonts.packages = with pkgs; [
    nerdfonts
  ];

  # TODO: Move to hyprland config
  programs.hyprland.enable = true;


  # Bootloader.
  boot = {
    loader = {
      grub.enable = true;
      grub.device = "/dev/sda";
      grub.useOSProber = true;
    };
  };

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Copenhagen";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_DK.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "da_DK.UTF-8";
    LC_IDENTIFICATION = "da_DK.UTF-8";
    LC_MEASUREMENT = "da_DK.UTF-8";
    LC_MONETARY = "da_DK.UTF-8";
    LC_NAME = "da_DK.UTF-8";
    LC_NUMERIC = "da_DK.UTF-8";
    LC_PAPER = "da_DK.UTF-8";
    LC_TELEPHONE = "da_DK.UTF-8";
    LC_TIME = "da_DK.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  programs.dconf.enable = true;

  xdg.portal = {
# TODO: This is depecated, so i need to do something about it 
# https://github.com/flatpak/xdg-desktop-portal/blob/1.18.1/doc/portals.conf.rst.in
    config.common.default = "*";
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "dk";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "dk-latin1";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Security 
  security = {
    # Extra security
    protectKernelImage = true;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  # Set environment variables
  environment.variables = {
    NIXOS_CONFIG = "$HOME/nixos/configuration.nix";
    NIXOS_CONFIG_DIR = "$HOME/nixos/";
    XDG_DATA_HOME = "$HOME/.local/share";
    PASSWORD_STORE_DIR = "$HOME/.local/share/password-store";
    GTK_RC_FILES = "$HOME/.local/share/gtk-1.0/gtkrc";
    GTK2_RC_FILES = "$HOME/.local/share/gtk-2.0/gtkrc";
    MOZ_ENABLE_WAYLAND = "1";
    EDITOR = "vim";
    DIRENV_LOG_FORMAT = "";
    ANKI_WAYLAND = "1";
    DISABLE_QT5_COMPAT = "0";
  };

  virtualisation = {
    podman = {
      defaultNetwork.settings.dns_enabled = true;
      dockerCompat = true;
      enable = true;
      extraPackages = with pkgs; [ zfs ];
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
