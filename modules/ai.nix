{
  home-manager.users.lumi = {
    services.ollama.enable = true;

    programs.claude-code = {
      enable = true;
    };
  };
}
