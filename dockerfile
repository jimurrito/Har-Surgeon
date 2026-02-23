FROM docker.io/nixos/nix

ENV NIX_CONFIG="experimental-features = nix-command flakes"
RUN nix-channel --update
RUN nix profile add nixpkgs#elixir_1_18 nixpkgs#inotify-tools nixpkgs#gnused

RUN mkdir /db

ADD ./ /app/
WORKDIR /app

ENV MIX_ENV=prod

RUN mix deps.get 
RUN mix compile
RUN mix assets.setup
RUN mix assets.deploy
RUN mix phx.digest
RUN mix phx.gen.release
RUN mix release

EXPOSE 4000

CMD ["bash", "start.bash"]
