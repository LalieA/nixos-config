{ config, pkgs, lib, ...}:

{
    programs.zsh = {
        enable = true;
        shellAliases = {
            ll = "ls -l";
            update = "sudo nixos-rebuild switch";
        };

        autocd = true;
        dotDir = ".config/zsh";
        history.share = true;
        history.path = "${config.home.homeDirectory}/.zshistory";

        historySubstringSearch.enable = true;
        initExtra = ''
            # search history based on what's typed in the prompt
            autoload -U history-search-end
            zle -N history-beginning-search-backward-end history-search-end
            zle -N history-beginning-search-forward-end history-search-end
            bindkey "^[OA" history-beginning-search-backward-end
            bindkey "^[OB" history-beginning-search-forward-end

            # case insensitive tab completion
            zstyle ':completion:*' completer _complete _ignored _approximate
            zstyle ':completion:*' list-colors
            zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
            zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
            zstyle ':completion:*' menu select
            zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
            zstyle ':completion:*' verbose true
            _comp_options+=(globdots)
        '';

        plugins = [
            {
                name = "powerlevel10k";
                src = pkgs.zsh-powerlevel10k;
                file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
            }
            {
                name = "powerlevel10k-config";
                src = lib.cleanSource ./zsh-config;
                file = "pk10-lean.zsh";
            }
        ];
    };
}
