# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use modules your own flake exports (from modules/home-manager):
    # outputs.homeManagerModules.example

    # Or modules exported from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModules.default
 ./hyprland.nix
    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      #outputs.overlays.additions
      #outputs.overlays.modifications
      #outputs.overlays.unstable-packages

      # You can also add overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };
  home.packages = with pkgs; [
	waybar
	btop
	hyprpaper
	zsh
	vesktop
	nerd-fonts.jetbrains-mono


  ];
   programs.zsh = {
    enable = true;
 initExtra = ''
 hyfetch'';

    oh-my-zsh = {
      enable = true;
      theme = "agnoster";
    
      plugins = [ "git" "z" "sudo" ];
    };
  };

programs.kitty = {
  enable = true;
  extraConfig = ''
    confirm_os_window_close 0
  '';
};

  home = {
    username = "winter";
    homeDirectory = "/home/winter";
  };
 
      home.file.".config/hypr/hyprpaper.conf".text = ''
splash_offset = 2.0

preload = /home/winter/Pictures/deltarune.png

wallpaper = eDP-1,/home/winter/Pictures/deltarune.png
'';

home.pointerCursor = {
    name = "phinger-cursors-light";
    package = pkgs.phinger-cursors;
    size = 24;
    gtk.enable = true;
  };
fonts.fontconfig.enable = true;

gtk = {
  enable = true;
  gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
};
  # Add stuff for your user as you see fit:
  programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.05";
}
