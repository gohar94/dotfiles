# Lazy conda init: defer the slow `conda shell.fish hook` until first use.
set -l conda_bin (command -v conda)
if test -z "$conda_bin"
    for dir in $HOME/miniconda $HOME/miniconda3 $HOME/anaconda $HOME/anaconda3 $HOME/opt/miniconda3 $HOME/opt/anaconda3 /opt/homebrew/Caskroom/miniconda/base /opt/miniconda3 /opt/anaconda3
        if test -x $dir/bin/conda
            set conda_bin $dir/bin/conda
            set -gx PATH $dir/bin $PATH
            break
        end
    end
end
if test -n "$conda_bin"
    function conda --inherit-variable conda_bin
        functions -e conda
        $conda_bin shell.fish hook | source
        conda $argv
    end
end

set -g fish_greeting ""
