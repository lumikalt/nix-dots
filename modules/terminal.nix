{ ... }: {
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;

    settings = {
      scrollback_lines = 4000;
      placement_strategy = "center";

      allow_remote-control = "yes";
      enable_audio_bell = "no";
      visual_bell_duration = "0.3";

      disable_ligatures = "cursor";

      window_margin = "10.0";
    }; 
  };
}
