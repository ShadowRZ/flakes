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
          pyflakes
          pytest
          jedi-language-server
          pynvim
          sphinx
          sphinx_rtd_theme
          pygments
        ]);
    in with pkgs; [
      python3-env
      pipenv # Pipenv
    ];
}
