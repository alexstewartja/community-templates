# To learn more about how to use Nix to configure your environment
# see: https://developers.google.com/idx/guides/customize-idx-env
{pkgs}: {
  # Which nixpkgs channel to use.
  channel = "stable-24.11"; # or "unstable"
  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.php84
    pkgs.php84Packages.composer
    pkgs.php84Extensions.redis
    pkgs.nodejs_20
    pkgs.yarn
  ];
  # Sets environment variables in the workspace
  env = {};
  services.mysql = {
    enable = true;
    package = pkgs.mariadb_114;
  };
  services.redis = {
    enable = true;
    port = 6379;
  };
  idx = {
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
    extensions = [
      "laravel.vscode-laravel"
      "onecentlin.laravel5-snippets"
      "onecentlin.laravel-blade"
    ];
    workspace = {
      # Runs when a workspace is first created with this `dev.nix` file
      onCreate = {
        composer-install = "composer install";
        yarn-install = "yarn install";
        # Open editors for the following files by default, if they exist:
        default.openFiles = [ "README.md" "resources/views/app.blade.php" ];
      };
      onStart = {
        composer-install = "composer install";
        yarn-install = "yarn install";
      };
    };
    # Enable previews and customize configuration
    previews = {
      enable = true;
      previews = {
        web = {
          command = ["php" "artisan" "serve" "--port" "$PORT" "--host" "0.0.0.0"];
          manager = "web";
        };
        dev = {
          command = ["yarn" "run" "dev"]
        }
      };
    };
  };
}
