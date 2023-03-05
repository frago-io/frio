{ pkgs,isDarwin, ...}:
let python-packages = pyPacks: with pyPacks;
  let dashing = buildPythonPackage rec {
            pname = "dashing";
            version = "0.1.0";
            src = fetchPypi {
                inherit pname version;
                sha256 = "sha256-JRRgjg8pp3Xb0bERFWEhnOg9U8+kuqL+QQH6uE/Vbxs=";
            };
            doCheck = false;
            propagatedBuildInputs = [
                # Specify dependencies
                pkgs.python3Packages.blessed
                #pkgs.python3Packages.dashing
            ];
          };
          asitop = buildPythonPackage rec {
            pname = "asitop";
            version = "0.0.23";
            src = fetchPypi {
              inherit pname version;
              sha256 = "sha256-BNncgQRNAd6Pgur5D1xVQi3LSsijSAYIYvhsuiVyi9Q=";
            };
            doCheck = false;
            propagatedBuildInputs = [
                # Specify dependencies
                pkgs.python3Packages.psutil
                dashing
                #pkgs.python3Packages.dashing
              ];
            };
  in  
  (if isDarwin then[ 
    #just for darwin
    asitop
  ] else [
    #just for linux
  ]) ++ 
    # for both
  [
    #pandas
    #requests
    #asitop
    # other python packages you want
  ]; 
in pkgs.python3.withPackages python-packages
