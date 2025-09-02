rebuild:
    #!/bin/bash
    set -e
    pushd ~/dotfiles/nixos/
    nvim oatman-pc.nix
    alejandra . &>/dev/null
    git diff -U0 *.nix
    echo "NixOS Rebuilding..."
    sudo nixos-rebuild switch --flake . &>nixos-switch.log || (
    cat nixos-switch.log | grep --color error && false)
    gen=$(nixos-rebuild list-generations | grep current)
    git commit -am "$gen"
    popd

format:
    alejandra --quiet .

update:
    nix flake update
