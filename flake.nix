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
    emacs-overlay.url = "github:nix-community/emacs-overlay";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    hyprland,
    nur,
    stylix,
    emacs-overlay,
    ...
  } @ inputs: let
    inherit (self) outputs;
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [ emacs-overlay.overlays.default ];
    };
    inherit (nixpkgs) lib;
  in {
    nixosConfigurations."wumi" = lib.nixosSystem {
      inherit system;

      specialArgs = { inherit inputs outputs; };

      modules = [
        nur.hmModules.nur

        hyprland.nixosModules.default
        { programs.hyprland.enable=true; }

        stylix.nixosModules.stylix
        ./sysModules

        ./config.nix

        home-manager.nixosModules.home-manager
        {
          home-manager = {
            # useGlobalPkgs = true;
            useUserPackages = true;
            users.lumi.imports = [ ./home.nix ];
          };
        }
      ];
    };
  };
}
