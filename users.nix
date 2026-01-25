{ lib, ... }:
let
  users = [ "lumi" ];
in
{
  imports = map (
    name: { pkgs, ... }@args: (import ./users/${name}.nix (args // { inherit name; }))
  ) users;

  users.users = lib.genAttrs users (name: {
    description = name;
    isNormalUser = true;
    home = "/home/${name}";
  });
}
