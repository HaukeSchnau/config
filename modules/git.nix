{pkgs, ...}: {
  programs.git = {
    enable = true;
    userName = "Hauke Schnau";
    userEmail = "hauke@schnau.dev";

    delta = {
      enable = true;
      options = {
        side-by-side = true;
      };
    };

    lfs.enable = true;

    ignores = ["**/.DS_STORE"];

    extraConfig = {
      column = {
        ui = "auto";
      };
      github = {
        user = "HaukeSchnau";
      };
      init = {
        defaultBranch = "main";
      };
      pull = {
        rebase = true;
      };
      push = {
        autoSetupRemote = true;
        default = "simple";
      };
      branch = {
        sort = "-committerdate";
      };
      tag = {
        sort = "version:refname";
      };
      diff = {
        algorithm = "histogram";
        colorMoved = "plain";
        mnemonicPrefix = true;
        renames = true;
      };
      help = {
        autocorrect = "prompt";
      };
      commit = {
        verbose = true;
      };
      rerere = {
        enabled = true;
        autoupdate = true;
      };
      core = {
        editor = "nvim";
        fileMode = false;
        ignorecase = false;
        attributesfile = "~/.gitattributes";
        autocrlf = "input";
      };
      rebase = {
        autoSquash = true;
        autoStash = true;
        updateRefs = true;
      };
      merge = {
        conflictstyle = "zdiff3";
      };
      "merge \"mergiraf\"" = {
        name = "mergiraf";
        driver = "mergiraf merge --git %O %A %B -s %S -x %X -y %Y -p %P -l %L";
      };
    };
  };

  programs = {
    lazygit.enable = true;
    gh.enable = true;
    gh-dash.enable = true;
  };

  home.packages = with pkgs; [
    git-interactive-rebase-tool
    git-absorb
    # git-branchless
    git-quick-stats
    mergiraf
    glab
  ];
}
