{ pkgs, version ? "latest", ... }: {
	
    packages = [
      pkgs.wget2
      pkgs.unzip
    ];

    bootstrap = ''
			mkdir "$out"
      wget2 https://github.com/laravel/vue-starter-kit/archive/refs/heads/main.zip
      unzip main.zip
      ls -l
      mv vue-starter-kit-main/{.*,*} "$out"/
      rm -rf vue-starter-kit-main
			mkdir -p "$out"/.idx
  		cp ${./dev.nix} "$out"/.idx/dev.nix
    '';
}