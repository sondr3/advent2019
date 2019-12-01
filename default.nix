{ mkDerivation, base, stdenv }:
mkDerivation {
  pname = "advent2019";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base ];
  description = "Haskell solutions for Advent of Code 2019";
  license = stdenv.lib.licenses.publicDomain;
}
