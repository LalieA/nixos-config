{ config, pkgs, home-manager, nix-vscode-extensions, ... }:

{
    programs.vscode = {
        enable = true;
        extensions = with pkgs.vscode-extensions; [
            # aaron-bond.better-comments
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
}
