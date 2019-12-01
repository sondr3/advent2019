{ mkDerivation, base, split, stdenv }:
mkDerivation {
  pname = "christmas";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = false;
  isExecutable = true;
  executableHaskellDepends = [ base split ];
  description = "Haskell solutions for Christmas 2019";
  license = stdenv.lib.licenses.publicDomain;
}
