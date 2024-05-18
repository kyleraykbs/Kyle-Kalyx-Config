git add -A
cd kalyx
git add -A
cd ..
cd kyler
git add -A
cd ..
cd kyvim
git add -A
cd ..
nix flake lock --update-input kalyx
nix flake lock --update-input kyler
nix flake lock --update-input kyvim
sudo nixos-rebuild $1 --flake ./#$HOSTNAME $2
