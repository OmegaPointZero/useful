directory(){
    stuff=`ls -t $1 | head `
    for thing in $stuff
    do
        typestr=`file $thing`
        IFS=': ' read -r -a array <<< "$typestr"
        type=${array[1]}
        if [ "$type" == "directory" ]; then
            echo -e "\e[34m$thing [$type]"
        elif [ "$type" == "CSV" ]; then
            echo -e "\e[36m$thing"
        elif [ "$type" == "Zip" ]; then
            echo -e "\e[31m$thing"
        else
            echo -e "\e[37m$thing"
        fi
    done
}

if [ -z "$1" ]
    then
        directory
else
    tgt=$1
    typ=`file $tgt`
    IFS=': ' read -r -a array <<< "$typ"
    type=${array[1]}
    if [ "$type" == "directory" ]; then
        directory
    elif [ "$type" == "CSV" ]; then
        stuff=`cat $tgt | head`
        IFS=' ' read -r -a array <<< "$stuff"
        for thing in $stuff
        do
            echo "$thing"
        done
    fi
fi
