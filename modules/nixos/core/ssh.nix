{ constants, ... }:
let
  trustedkeys = with constants.sshKeys; [
    crona.root
    crona.luna
    excalibur.luna
  ];
in
{
  users.users.profile.openssh.authorizedKeys.keys = trustedkeys;
  users.users.root.openssh.authorizedKeys.keys = trustedkeys;
}
