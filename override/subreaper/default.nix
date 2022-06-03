pkgs: pkgs.runCommandCC "subreaper" {
  SOURCE_FILE = ./subreaper.c;
} ''
set -x
$CC $SOURCE_FILE -O3 -std=c99 -o $out
''
