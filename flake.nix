{
  description = "Blowfish Tools";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs =
    inputs@{ nixpkgs, flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        # systems for which you want to build the `perSystem` attributes
        "x86_64-linux"
        # ...
      ];
      perSystem =
        {
          config,
          self',
          inputs',
          pkgs,
          system,
          ...
        }:
        let
          lib = nixpkgs.lib;
        in
        {
          # Equivalent to  inputs'.nixpkgs.legacyPackages.hello;
          packages = {
            default = pkgs.hello;
            blowfish-tools = pkgs.buildNpmPackage rec {
              pname = "blowfish-tools";
              version = "1.9.0";

              src = pkgs.fetchFromGitHub {
                owner = "nunocoracao";
                repo = pname;
                rev = "v${version}";
                hash = "sha256-KNNY2tws4KfsyDQ2gsuasOFamxF3YQY4zeqHffUgj3o=";
              };

              npmDepsHash = "sha256-PvddV/HuPgHUpja2nR59bIUKllPVtKDoy8kM9JYL98M=";
              npmBuildScript = "start";

              # The prepack script runs the build script, which we'd rather do in the build phase.
              # npmPackFlags = [ "--ignore-scripts" ];

              # NODE_OPTIONS = "--openssl-legacy-provider";

              meta = {
                description = "CLI to initialize a Blowfish project";
                homepage = "https://github.com/nunocoracao/blowfish-tools";
                license = lib.licenses.mit;
                maintainers = with lib.maintainers; [ arunoruto ];
              };
            };
          };

          devShells.default = pkgs.mkShell {
            buildInputs = [
              config.packages.default
              config.packages.blowfish-tools
            ];

            shellHook = ''
              exec $SHELL
            '';
          };
        };
      flake = {
        # Put your original flake attributes here.
      };
    };
}
