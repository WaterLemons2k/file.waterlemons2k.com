#!/bin/sh
set -e
#http://nginx.org/en/docs/http/ngx_http_autoindex_module.html
#https://stackoverflow.com/questions/21395159
#https://serverfault.com/questions/354403
#https://bytefreaks.net/gnulinux/bash/how-to-execute-find-that-ignores-git-directories

echo HTML Index generator version 1.0.5
if [ -z "$1" ]; then #If $1 empty
    root=$PWD #Set the root directory as the current directory
else #Else $1 is not empty
    root=$PWD/$1 #Set the root directory as the current directory/$1
fi

echo The root directory is $root
cd $root #Go to the root directory

for cd in $(find -type d ! -path "*/\.*" | sed 's|^./||'); do

    if [ $cd != "." ]; then #If current directory not equal . (Not the root directory)
        echo Generating Index of /$cd/
        cd $cd
        echo -e "<html>\n<head><title>Index of /$cd/</title></head>\n<body>\n<h1>Index of /$cd/</h1><hr><pre><a href=\"../\">../</a>" > index.html
    else #Else is the root directory
        echo Generating Index of /
        echo -e "<html>\n<head><title>Index of /</title></head>\n<body>\n<h1>Index of /</h1><hr><pre>" > index.html
    fi

    for directory in $(ls -l | grep ^d | awk '{print $NF}'); do #Output all directories to index.html
        echo "<a href=\"$directory/\">$directory/</a>" >> index.html
    done

    for file in $(ls -l | grep ^- | grep -v index.html | awk '{print $NF}'); do #Output all files to index.html (Except index.html)
        echo "<a href=\"$file\">$file</a>" >> index.html
    done

    echo -e "</pre><hr></body>\n</html>" >> index.html
    cd $root #Back to the root directory
done

echo Done!
