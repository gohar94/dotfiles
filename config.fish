# Lazy conda init: defer the slow `conda shell.fish hook` until first use.
set -l conda_bin (command -v conda)
if test -n "$conda_bin"
    function conda --inherit-variable conda_bin
        functions -e conda
        $conda_bin shell.fish hook | source
        conda $argv
    end
end

set -g fish_greeting ""
