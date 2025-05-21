{ pkgs, version ? "latest", ... }: {
	
    packages = [
      pkgs.gnused
      pkgs.unzip
      pkgs.wget
      pkgs.php83
      pkgs.php83Packages.composer
      pkgs.yarn
    ];

    bootstrap = ''
			mkdir "$out"
      wget https://github.com/laravel/vue-starter-kit/archive/refs/heads/main.zip
      unzip main.zip
      ls -l
      mv vue-starter-kit-main/{.*,*} "$out"/
      rm -rf vue-starter-kit-main
			mkdir -p "$out"/.idx
  		cp ${./dev.nix} "$out"/.idx/dev.nix
      cd "$out"/
      [ ! -f ".env" ] && cp .env.example .env
      [ -f "package-lock.json" ] && rm package-lock.json
      composer install
      yarn install
    '';
}