#!/bin/bash

echo RECURSE=all                                        >  autogen.mk
echo SUBDIRS=                                           >> autogen.mk

export PKG_CONFIG_PATH=/usr/local/share/pkgconfig:$PKG_CONFIG_PATH

BUILD_STEP=
if [ "x$1" != "x" ]; then
    BUILD_STEP="$1"
    shift
fi

for DIR in protocol libs/common clients/gtk server streaming-agent
do
    echo Entering $DIR
    (cd $DIR && ./autogen.sh ${1+"$@"} && ([ -z "$BUILD_STEP" ] || $BUILD_STEP))
    echo "AUTOGEN+=$DIR"                            >> autogen.mk
done
