switch host:
    #!/usr/bin/env bash
    set -e
    alejandra . &>/dev/null
    git diff -U0
    echo "NixOS Rebuilding..."
    sudo nixos-rebuild switch --flake .#{{host}} &>nixos-switch.log || (
    cat nixos-switch.log | grep --color error && false)
    gen=$(nixos-rebuild list-generations | grep 'True$' | awk '{print $1}')
    git commit -am "$gen"

format:
    alejandra --quiet .

update:
    nix flake update
