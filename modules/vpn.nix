{
  services.openvpn.servers.tecnico =
    let
      ovpn = ../assets/tecnico.ovpn;
    in
    {
      autoStart = false;
      config = ''
        config ${ovpn}
        auth-user-pass /run/secrets/vpn/tecnico/auth
      '';
    };
}
