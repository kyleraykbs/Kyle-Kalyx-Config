git add -A
cd kalyx
git add -A
cd ..
cd kyler
git add -A
cd ..
nix flake lock --update-input kalyx
nix flake lock --update-input kyler
sudo nixos-rebuild $1 $2 --flake ./#comet
