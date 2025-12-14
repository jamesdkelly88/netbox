{ pkgs ? import <nixpkgs> {config.allowUnfree = true;} }:pkgs.mkShell {
  packages = with pkgs; [
    go-task
    terraform
  ];

  shellHook = ''
    export $(cat .env | xargs)
  '';
}

