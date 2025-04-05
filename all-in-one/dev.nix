# To learn more about how to use Nix to configure your environment
# see: https://developers.google.com/idx/guides/customize-idx-env
{ pkgs, ... }: {
  # Which nixpkgs channel to use.
  channel = "stable-24.05"; # or "unstable"
  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.go
    #pkgs.python311
    #pkgs.python311Packages.pip
    pkgs.nodejs_20
    pkgs.nodePackages.nodemon
    (pkgs.python311.withPackages(ps: with ps; [
      pip
      ipykernel
      astropy
      scipy
      numpy
      pandas
      ipython
      matplotlib
    ]))
    pkgs.virtualenv
    pkgs.jupyter
    pkgs.zip
  ];
  # Sets environment variables in the workspace
  env = {};
  services.docker.enable = true;
  idx = {
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
    extensions = [
      # "vscodevim.vim"
      "ms-python.debugpy"
      "ms-python.python"
      "ms-toolsai.jupyter"
      "ms-toolsai.jupyter-keymap"
      "ms-toolsai.jupyter-renderers"
      "ms-toolsai.vscode-jupyter-cell-tags"
      "ms-toolsai.vscode-jupyter-slideshow"
      "mechatroner.rainbow-csv"
      "anwar.papyrus-pdf"
      "DEVSENSE.composer-php-vscode"
      "DEVSENSE.intelli-php-vscode"
      "DEVSENSE.phptools-vscode"
      "DEVSENSE.profiler-php-vscode"
      "janisdd.vscode-edit-csv"
      "ms-azuretools.vscode-docker"
      "moshfeu.diff-merge"
      "YuTengjing.vscode-archive"
    ];
    # Enable previews
    previews = {
      enable = true;
      previews = {
        # web = {
        #   # Example: run "npm run dev" with PORT set to IDX's defined port for previews,
        #   # and show it in IDX's web preview panel
        #   command = ["npm" "run" "dev"];
        #   manager = "web";
        #   env = {
        #     # Environment variables to set for your server
        #     PORT = "$PORT";
        #   };
        # };
      };
    };
    # Workspace lifecycle hooks
    workspace = {
      # Runs when a workspace is first created
      onCreate = {
        # Example: install JS dependencies from NPM
        # npm-install = "npm install";
        # Open editors for the following files by default, if they exist:
        copy-jl-config = "mv -f .jupyter ../";
        create-venv= "python3 -m venv .venv --system-site-packages; python3 -c 'import pandas, os; print(os.path.normpath(os.path.join(pandas.__file__,\"../..\")))' >> `ls -d .venv/lib/*/site-packages`/addpath.pth";
        add-jl-kernel= "python -m ipykernel install --name Python3.11 --display-name 'Python 3.11' --user; source .venv/bin/activate; python -m ipykernel install --name Python3.11.venv --display-name 'Python 3.11 (.venv)' --user";
        default.openFiles = [ "README.md" ];
      };
      # Runs when the workspace is (re)started
      onStart = {
        # Example: start a background task to watch and re-build backend code
        # watch-backend = "npm run watch-backend";
        run-jupyter = "jupyter-lab --no-browser";
      };
    };
  };
}
