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
    nur.url = "github:nix-community/NUR";
    stylix.url = "github:danth/stylix";
    nix-doom-emacs.url = "github:nix-community/nix-doom-emacs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    hyprland,
    nur,
    stylix,
    nix-doom-emacs,
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

        hyprland.nixosModules.default
        { programs.hyprland.enable = true; }
        ./modules/hyprland.nix

        stylix.nixosModules.stylix
        ./modules/wallpaper.nix

        ./config.nix

        home-manager.nixosModules.home-manager
        {
          home-manager = {
            # useGlobalPkgs = true;
            useUserPackages = true;
            users.lumi = {...}: {
	      imports = [
	        nix-doom-emacs.hmModule
	        ./home.nix
	      ];
	    };
          };
        }
      ];
    };
  };
}
