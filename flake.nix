{
  description = "st is a simple terminal";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/23.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }: 
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in
    {
      packages.x86_64-linux.st = pkgs.stdenv.mkDerivation    {
        name = "st";
        src = ./.; 

        buildInputs = [ 
          pkgs.gcc 
          pkgs.pkg-config
          pkgs.ncurses
          pkgs.fontconfig
          pkgs.freetype
          pkgs.harfbuzz
          pkgs.xorg.libX11
          pkgs.xorg.libXft
          pkgs.victor-mono
        ];
        
        # Assuming you have a Makefile, otherwise specify buildPhase
        buildPhase = ''
          make -B
        '';

        installPhase = ''
          mkdir -p $out/bin
          cp -r st $out/bin
        '';
      };
      packages.x86_64-linux.default = self.packages.x86_64-linux.st;
    };
}

