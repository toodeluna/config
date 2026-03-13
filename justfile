export NH_FLAKE := justfile_directory()
export NH_OS_FLAKE := justfile_directory()
export NH_DARWIN_FLAKE := justfile_directory()

[linux]
build hostname=`hostname`:
    nh os build . -H {{ hostname }} -o ./result

[linux]
switch hostname=`hostname`:
    nh os switch . -H {{ hostname }}

[macos]
build hostname=`hostname`:
    nh darwin build . -H {{ hostname }} -o ./result

[macos]
switch hostname=`hostname`:
    nh darwin switch . -H {{ hostname }}
