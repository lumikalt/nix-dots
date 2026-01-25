{ lib, ... }:
let
  users = [ "lumi" ];
in
{
  imports = map (name: import ./users/${name}.nix { inherit name; }) users;

  users.users = lib.genAttrs users (name: {
    description = name;
    isNormalUser = true;
    home = "/home/${name}";
  });
}
