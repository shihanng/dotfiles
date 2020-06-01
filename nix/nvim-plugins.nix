{ pkgs, fetchgit }:

let
  buildVimPlugin = pkgs.vimUtils.buildVimPluginFrom2Nix;
in
{

  "vim-nerdtree-syntax-highlight" = buildVimPlugin {
    pname = "vim-nerdtree-syntax-highlight";
    version = "2020-05-30";
    src = fetchgit {
      url = "https://github.com/tiagofumo/vim-nerdtree-syntax-highlight";
      rev = "c83898832738d40177ca6ccd7a69ef1db14e06b0";
      sha256 = "0mb5xqlqh0j5zjjbll5fy94rp2q48vgsw7jpf25mjwz8kss95p9i";
    };
    dependencies = [];
  };

  "vim-devicons" = buildVimPlugin {
    pname = "vim-devicons";
    version = "2020-05-30";
    src = fetchgit {
      url = "https://github.com/ryanoasis/vim-devicons";
      rev = "15b532ebd4455d9d099e9ccebab09915e0562754";
      sha256 = "0cfiwdaj43fx2gq7916i98iyn3ky79d359ylgpznczn88k37s1wi";
    };
    dependencies = [];
  };

  "fzf" = buildVimPlugin {
    pname = "fzf";
    version = "2020-05-30";
    src = fetchgit {
      url = "https://github.com/junegunn/fzf";
      rev = "f81feb1e69e5cb75797d50817752ddfe4933cd68";
      sha256 = "1ssv9sh0f1s8ad5jny4ps9pd8fsb29dfpcmwxmxviz1lnx5i6hni";
    };
    dependencies = [];
  };

  "gotests-vim" = buildVimPlugin {
    pname = "gotests-vim";
    version = "2020-05-30";
    src = fetchgit {
      url = "https://github.com/buoto/gotests-vim";
      rev = "e0ad687be26875153ecd43d16db3b93a637394e4";
      sha256 = "01w981v7rya9fnxwdhlka4vfzlnw87pxmfcqmvxh3p96lmi71xjm";
    };
    dependencies = [];
  };
  # more?
}
