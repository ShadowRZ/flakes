final: prev: rec {
  wayfireApplications-unwrapped = prev.wayfireApplications-unwrapped.extend
    (self: super: rec {
      wayfire = super.wayfire.overrideAttrs (old: rec {
        version = "1abd63179a5ed51d614989df7692dde3024aa866";
        src = final.fetchFromGitHub {
          owner = "lilydjwg";
          repo = "wayfire";
          rev = version;
          fetchSubmodules = true;
          sha256 = "sha256-lkHkScrsYq6RKAqkii9vdgpwAIh1SRzGs+MIaIQCfDc=";
        };
        buildInputs = old.buildInputs ++ (with final; [ pango xorg.xcbutilwm ]);
        mesonFlags = old.mesonFlags ++ [
          "-Duse_system_wlroots=enabled"
          "-Duse_system_wfconfig=enabled"
          "-Dtests=disabled"
        ];
      });
      # NOTE: Here we override based on the 0.15 version of wlroots,
      # so `prev` instead of `super`.
      wlroots = prev.wlroots.overrideAttrs (old: rec {
        version = "75d31509db8c28e8379fe9570118ef8c82284581";
        src = final.fetchFromGitLab {
          domain = "gitlab.freedesktop.org";
          owner = "wlroots";
          repo = "wlroots";
          rev = version;
          sha256 = "sha256-zZaona39DOZNL93A1KG3zAi8vDttJBirxacq24hWCn4=";
        };
      });
      wcm = super.wcm.overrideAttrs
        (old: { buildInputs = old.buildInputs ++ [ wlroots ]; });
    });
  wf-config = prev.wf-config.overrideAttrs (old: rec {
    version = "e42a3870fb194842a505ad5a9671be1aebda0b0b";
    src = final.fetchFromGitHub {
      owner = "WayfireWM";
      repo = "wf-config";
      rev = version;
      sha256 = "sha256-Ob8LVYKL1XiDc29JkmahEfOtkPKgpDGg7D3i9SMc0Vg=";
    };
  });
  wayfirePlugins = prev.wayfirePlugins // {
    wf-shell = prev.wayfirePlugins.wf-shell.overrideAttrs (old: {
      buildInputs = old.buildInputs
        ++ [ wayfireApplications-unwrapped.wlroots ];
    });
  };
}
