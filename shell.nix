# Virtual environment for HighestBidder Elixir/Phoenix development
#
#

{ pkgs ? import <nixpkgs> {} }:
#{ pkgs ? import (builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/nixpkgs-unstable.tar.gz") { } }:

pkgs.mkShell {
  name = "har-surgeon-env";
  buildInputs = with pkgs; [
    elixir_1_18
    inotify-tools
    git
    wget
    sysstat
    direnv
    nixpkgs-fmt
    gcc
    zip
    bat
    gh
    inetutils
    starship
    fish
  ];

  shellHook = ''
    #
    # Source ENVVARs
    source .env
    #
    mix Deps.get
    mix Tailwind.install
    #
    starship prompt
    echo "Run 'iex -S mix phx.server' to start the Phoenix server."
    echo -e "Then run ':observer.start()', if you want to start observer.\n"
    #
    fish
    #
    #
    exit
  '';
}
