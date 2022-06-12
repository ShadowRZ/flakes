pkgs: {
  layer = "bottom";
  position = "bottom";
  height = 25;
  modules-left = [ "custom/taskmaid" ];
  modules-right = [ "network" "cpu" "temperature" "memory" "battery" "clock" ];
  battery = { format = "BAT: {capacity}%"; };
  clock = {
    interval = 1;
    format = "{:%H:%M:%S}";
  };
  cpu = {
    interval = 1;
    format = "CPU: {usage}%";
  };
  temperature = {
    interval = 1;
    format = "TEMP: {temperatureC}°C";
  };
  memory = {
    interval = 1;
    format = "MEM: {percentage}%";
  };
  network = {
    format = "";
    format-wifi = "WLAN: {signalStrength}%";
    format-ethernet = "Ethernet";
    format-disconnected = "";
  };
  "custom/taskmaid" = {
    exec =
      let taskmaid = with pkgs; stdenv.mkDerivation {
        name = "taskmaid-client";
        src = ./taskmaid.c;

        dontUnpack = true;
        dontConfigure = true;
        dontInstall = true;

        buildPhase = ''
          $CC $src -O2 $(pkg-config --cflags --libs glib-2.0 gio-2.0 json-glib-1.0) -o $out
        '';

        buildInputs = [ glib json-glib ];
        nativeBuildInputs = [ pkg-config ];
      };
      in "${taskmaid}";
    max-length = 1500;
    return-type = "json";
  };
}
