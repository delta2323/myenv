# LANG
export LANG=ja_JP.UTF-8
case ${UID} in
0)
    LANG=C
    ;;
esac

# for golang
export GOROOT=$HOME/go
export GOPATH=$HOME/dev/go
PATH=$GOPATH/bin:$GOROOT/bin:$PATH
