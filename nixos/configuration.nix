# this is your system's configuration file.
# use this to configure your system environment (it replaces /etc/nixos/configuration.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # you can import other nixos modules here
  imports = [
    # if you want to use modules your own flake exports (from modules/nixos):
    # outputs.nixosmodules.example

    # or modules from other flakes (such as nixos-hardware):
    # inputs.hardware.nixosmodules.common-cpu-amd
    # inputs.hardware.nixosmodules.common-ssd

    # you can also split up your configuration and import pieces of it here:
    # ./users.nix

    # import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
  ];


  nixpkgs = {
    # you can add overlays here
    overlays = [
      # add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.additions
      outputs.overlays.modifications
      outputs.overlays.unstable-packages

      # you can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideattrs (oldattrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # configure your nixpkgs instance
    config = {
      # disable if you don't want unfree packages
      allowunfree = true;
    };
  };

  nix = let
    flakeinputs = lib.filterAttrs (_: lib.isType "flake") inputs;
  in {
    settings = {
      # enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # opinionated: disable global registry
      flake-registry = "";
      # workaround for https://github.com/nixos/nix/issues/9574
    };
    # opinionated: disable channels
    channel.enable = false;

    # opinionated: make flake registry and nix path match flake inputs

  };

  boot.kernelPackages = pkgs.linuxPackages_latest;

   networking.hostName = "nixos-btw"; # Define your hostname.
  # Pick only one of the below networking options.i
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
   networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
   time.timeZone = "America/Denver";

  users.users = {
    winter = {
      # if you do, you can skip setting a root password by passing '--no-root-passwd' to nixos-install.
      # be sure to change it (using passwd) after rebooting!
      isNormalUser = true;
      extraGroups = ["wheel"];
    };
  };



   programs.firefox.enable = true;

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
   environment.systemPackages = with pkgs; [
  	neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  	wget
	hyfetch
	fastfetch
	kitty
	wofi
	dunst
	phinger-cursors
	git
	github-cli
	home-manager
	wl-clipboard
	
   ];
services.displayManager.sddm.enable = true;
services.displayManager.sddm.wayland.enable = true; 
environment.sessionVariables =  {XCURSOR_THEME = "phinger-cursors-light";
XCURSOR_SIZE = "24";
};
programs.hyprland.enable = true;

   services.pipewire = {
     enable = true;
     pulse.enable = true;
   };
  # https://nixos.wiki/wiki/faq/when_do_i_update_stateversion
  system.stateVersion = "25.05";
    boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}
