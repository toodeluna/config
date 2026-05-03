export NH_FLAKE := justfile_directory()
export NH_OS_FLAKE := justfile_directory()
export NH_DARWIN_FLAKE := justfile_directory()

[linux]
build hostname=`hostname`:
    nh os build -H {{ hostname }} -o ./result -d always

[macos]
build hostname=`hostname`:
    nh darwin build -H {{ hostname }} -o ./result -d always

[linux]
switch hostname=`hostname`:
    nh os switch -H {{ hostname }} -d always

[macos]
switch hostname=`hostname`:
    nh darwin switch -H {{ hostname }} -d always

[linux]
boot hostname=`hostname`:
    nh os boot -H {{ hostname }} -d always

[linux]
deploy hostname:
    nh os switch -H {{ hostname }} --target-host {{ hostname }}

[working-directory("./nix/secrets")]
edit-secret name:
    agenix -e {{ name }}
