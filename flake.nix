{
  description = "lumi";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    rust-overlay.url = "github:oxalica/rust-overlay";

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      hyprland-contrib,
      nur,
      nix-index-database,
      nix-vscode-extensions,
      rust-overlay,
      niri,
      nix-ld,
    }@inputs:
    let
      system = "x86_64-linux";
      wallpaper = ./assets/wallpapers/wallpaper.jpg;
      # wallpaper = ./assets/wallpapers/wallpaper.png;
      # wallpaper = ./assets/wallpapers/wallpaper.mp4;
      inherit (nixpkgs) lib;
    in
    {
      nixosConfigurations."wumi" = lib.nixosSystem {
        inherit system;

        specialArgs = { inherit inputs wallpaper; };

        modules = [
          nur.modules.nixos.default
          niri.nixosModules.niri
          nix-ld.nixosModules.nix-ld

          ./system.nix

          ./users.nix

          {
            time.timeZone = "Europe/Lisbon";
            # Fix for Windows time.
            time.hardwareClockInLocalTime = true;
            i18n.defaultLocale = "en_GB.UTF-8";
            console.keyMap = "pt-latin1";
          }

          (
            { pkgs, ... }:
            {
              nixpkgs.overlays = [
                rust-overlay.overlays.default
                niri.overlays.niri
              ];

              environment.systemPackages = with pkgs; [
                rust-bin.beta.latest.default
                gcc
                xwayland-satellite
                wl-clipboard
              ];


            }
          )

          home-manager.nixosModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = { inherit inputs wallpaper; };
              sharedModules = [ nur.modules.homeManager.default ];

              backupFileExtension = "backup";

              useUserPackages = true;

              users.lumi = {
                imports = [
                  nix-index-database.homeModules.default

                  ./hm.nix
                ];
              };
            };
          }
        ];
      };
    };

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://helix.cachix.org"
      "https://hyprland.cachix.org"
      "https://niri.cachix.org"
    ];

    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "niri.cachix.org-1:Wv0OmO7PsuocRKzfDoJ3mulSl7Z6oezYhGhR+3W2964="
    ];
  };
}
