{ mkDerivation, base, containers, doctest, split, stdenv }:
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
}
