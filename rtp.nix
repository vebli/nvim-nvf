{pkgs, ...}:
pkgs.stdenv.mkDerivation {
  name = "Lua config files";
  src = ../.;
  buildInputs = [];
  phases = ["installPhase"];
  installPhase = ''
      mkdir -p $out
      cp -r $src/lua $out
      '';
}

