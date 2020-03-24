#!/bin/bash

FILE=${1};

if [ -f "${FILE}" ]; then
    FILENAME=$(basename ${FILE});
    SVGNAME=$(echo "${FILENAME%.*}.svg");

    if [ -f "${SVGNAME}" ]; then
        echo "SVG file already exist! ${SVGNAME}";
        exit 1;
    fi
    DIMENSIONS=$(identify -format '%w %h' ${FILE});
    WIDTH=$(echo ${DIMENSIONS}| awk '{print $1}');
    HEIGHT=$(echo ${DIMENSIONS}| awk '{print $2}');
    CONTENT=$(cat ${FILE} | base64 -w 0);

    cat > ${SVGNAME} << EOF
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
<svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" x="0px" y="0px" width="${WIDTH}px" height="${HEIGHT}px" viewBox="0 0 ${WIDTH} ${HEIGHT}" enable-background="new 0 0 ${WIDTH} ${HEIGHT}" xml:space="preserve">
    <image id="image0" width="${WIDTH}" height="${HEIGHT}" x="0" y="0" xlink:href="data:image/png;base64,${CONTENT}"/>
</svg>
EOF
else
    echo "File does not exist! ${FILE}";
    exit 1;
fi
