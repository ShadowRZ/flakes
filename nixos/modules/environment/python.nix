{ pkgs, ... }: {
  environment.systemPackages =
    # Python 3
    let
      python3-env = pkgs.python3.withPackages (ps:
        with ps; [
          ipython
          requests
          six
          future
          beautifulsoup4
          numpy
          flake8
          isort
          pytest
          jedi-language-server
          pynvim
          black
          sphinx
          sphinx_rtd_theme
          furo
          pygments
          jupyter
          jupyter_console
          jupyterlab
          qtconsole
        ]);
    in with pkgs; [
      python3-env
      pipenv # Pipenv
    ];
}
