{
  description = "luwumi";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    stylix.url = "github:danth/stylix";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    hyprland,
    hyprland-contrib,
    nur,
    stylix,
    nix-vscode-extensions,
    ...
  } @ inputs: let
    inherit (self) outputs;
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
    inherit (nixpkgs) lib;
  in {
    nixosConfigurations."wumi" = lib.nixosSystem {
      inherit system;

      specialArgs = { inherit inputs outputs; };

      modules = [
        nur.hmModules.nur

        stylix.nixosModules.stylix
        ./modules/wallpaper.nix

        ./config.nix

        home-manager.nixosModules.home-manager
        {
          home-manager = {
            # useGlobalPkgs = true;
            useUserPackages = true;
            users.lumi = { ... }: {
              imports = [
                # hm modules
                hyprland.homeManagerModules.default

                ./home.nix
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
    ];

    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "helix.cachix.org-1:ejp9KQpR1FBI2onstMQ34yogDm4OgU2ru6lIwPvuCVs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };
}
