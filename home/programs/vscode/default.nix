{ config, pkgs, lib, ... }:
let
    cfg = config.programs.vscode;

    userSettingsPath = "${config.home.homeDirectory}/.config/Code/User";
    configFilePath = "${userSettingsPath}/settings.json";
    # tasksFilePath = "${userSettingsPath}/tasks.json";
    # keybindingsFilePath = "${userSettingsPath}/keybindings.json";
    # snippetsPath = "${userSettingsPath}/snippets";

    pathsToMakeWritable = lib.flatten [
        (lib.optional (cfg.userSettings != { }) configFilePath)
        # (lib.optional (cfg.userTasks != { }) tasksFilePath)
        # (lib.optional (cfg.keybindings != { }) keybindingsFilePath)
        # (lib.optional (cfg.globalSnippets != { })
        # "${snippetsPath}/global.code-snippets")
        # (lib.mapAttrsToList (language: _: "${snippetsPath}/${language}.json")
        # cfg.languageSnippets)
    ]; in
{
    imports = [
        ../mutable.nix
    ];

    programs.vscode = {
        enable = true;
        userSettings = builtins.fromJSON (builtins.readFile ./settings.json);
        extensions = with pkgs.vscode-extensions; [
            # aaron-bond.better-comments
            bbenoist.nix
            esbenp.prettier-vscode
            # fabiospampinato.vscode-diff
            jebbs.plantuml
            llvm-vs-code-extensions.vscode-clangd
            mikestead.dotenv
            # mkhl.shfmt
            ms-azuretools.vscode-docker
            ms-python.isort
            # ms-python.pylint
            ms-python.python
            ms-toolsai.jupyter-keymap
            # ms-toolsai.jupyter-renderer
            ms-toolsai.jupyter
            # ms-vscode.cpptools-extension-pack
            # pinage404.nix-extension-pack
            # platformio.platformio-ide
            rust-lang.rust-analyzer
            shd101wyy.markdown-preview-enhanced
            timonwong.shellcheck
            # vadimcn.codelldb
            # VisualStudioExptTeam.vscodeintellicode
            # vscode-icon-teams.vscode-icons
            # vscode.shellcheck
            yzhang.markdown-all-in-one
        ];
    };

    home.file = lib.genAttrs pathsToMakeWritable (_: {
        force = true;
        mutable = true;
    });
}
