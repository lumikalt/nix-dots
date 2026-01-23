{ pkgs, ... }:
{
  programs.thunar = {
    enable = true;

    plugins = with pkgs; [
      thunar-volman
      thunar-vcs-plugin
      thunar-archive-plugin
      thunar-media-tags-plugin
    ];
  };
}
