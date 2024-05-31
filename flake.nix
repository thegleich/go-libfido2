{
  inputs = {
    flake-utils = { url = "github:numtide/flake-utils"; };
    nixpkgs = { url = "github:NixOS/nixpkgs/nixos-unstable"; };
  };

  outputs = inputs@{ self, ... }:
    inputs.flake-utils.lib.eachDefaultSystem (system:
      let pkgs = inputs.nixpkgs.legacyPackages.${system};
      in {
        packages = {
          default = pkgs.buildGoModule {
            CGO_CFLAGS = "-I ${pkgs.libfido2.dev}/include -I ${pkgs.openssl.dev}/include";
            CGO_LDFLAGS = "-L ${pkgs.libfido2}/lib";

            pname = "age-plugin-fido2-hmac";
            src = ./.;
            vendorHash = "sha256-h4/tyq9oZt41IfRJmmsLHUpJiPJ7YuFu59ccM7jHsFo=";
            version = "0.2.3";
          };
        };
      });
}
