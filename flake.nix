{
    description = "rstudio environment";
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/23.05";
        nixgl.url = "github:guibou/nixGL";
    };

    outputs = { self, nixpkgs, nixgl }:
    let
        system = "x86_64-linux";
        pkgs = import nixpkgs { inherit system; overlays = [ nixgl.overlay ]; };
        rstudio-rPackages = pkgs.rstudioWrapper.override{ 
            packages = with pkgs.rPackages; [ 
                corpus 
                dplyr
                DT 
                nsyllable 
                quanteda 
                readtext
                readxl
                rvest 
                stringr 
                tidyr 
                tidyverse 
                tm 
                xlsx 
                xtable 
                zoo
            ];
        };
    in
    {
        devShells.${system}.default = pkgs.mkShell {
            buildInputs = [ 
                rstudio-rPackages  
                pkgs.nixgl.nixGLIntel
            ];
        };
    };
}