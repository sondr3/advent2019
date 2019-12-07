{ nixpkgs ? import <nixpkgs> { }, compiler ? "default", doBenchmark ? false }:

let

  inherit (nixpkgs) pkgs;

  f = { mkDerivation, base, containers, doctest, split, stdenv }:
    mkDerivation {
      pname = "advent2019";
      version = "0.1.0.0";
      src = ./.;
      isLibrary = false;
      isExecutable = true;
      executableHaskellDepends = [ base containers split ];
      testHaskellDepends = [ base doctest ];
      description = "Haskell solutions for Advent of Code 2019";
      license = stdenv.lib.licenses.publicDomain;
      maintainers = with stdenv.lib.maintainers; [ sondr3 ];
    };

  haskellPackages = if compiler == "default" then
    pkgs.haskellPackages
  else
    pkgs.haskell.packages.${compiler};

  variant = if doBenchmark then pkgs.haskell.lib.doBenchmark else pkgs.lib.id;

  drv = variant (haskellPackages.callPackage f { });

in if pkgs.lib.inNixShell then drv.env else drv
