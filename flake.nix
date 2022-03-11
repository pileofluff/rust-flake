{
  description = "Hello World in Rust";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }:
    let
      pname = "hello";
      version = "0.1.0";
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};

    in
    {
      # nix build
      packages.${system}.${pname} = pkgs.rustPlatform.buildRustPackage rec {
        inherit pname version;
        src = ./.;

        cargoLock = {
          lockFile = ./Cargo.lock;
        };
      };

      # nix develop
      devShells.${system}.${pname} = pkgs.mkShell {
        buildInputs = with pkgs; [
          cargo
          rust-analyzer
        ];
      };
    };
}
