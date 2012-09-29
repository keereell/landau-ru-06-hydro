#!/bin/bash
cd ./html
ls *.html | while read file;
    do iconv -f UTF-8 -t UTF-8//ignore "$file" > ./tmp.html; # Fix broken utf8
    sed -i "s/<\/body><\/html>//g" ./tmp.html; # Add metrica JS at the bottom every html
    cat ../yametricka.txt >> ./tmp.html;
    echo "</body></html>" >> ./tmp.html
    mv -v ./tmp.html "$file";
done;
