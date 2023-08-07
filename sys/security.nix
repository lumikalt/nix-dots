{ ... }: {
  security.rtkit.enable = true;
  security.polkit.enable = true;
  # Can still call doas as sudo
  security.sudo.enable = false;

  # Configure doas
  security.doas = {
    enable = true;
    extraRules = [{
      users = [ "lumi" ];
      keepEnv = true;
      persist = true;  
    }];
  };

  security.pam.services.swaylock.text = ''
    # PAM configuration file for the swaylock screen locker. By default, it includes
    # the 'login' configuration file (see /etc/pam.d/login)
    auth include login
  '';
}