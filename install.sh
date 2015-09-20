for f in .??*
do
    [ "$f" = ".git" ] && continue

    ln -snfv `pwd`/"$f" "$HOME"/"$f"
done

curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh

