#!/bin/bash
#
# Build scripts for the Android edition of the Open Surge Engine
# Copyright 2024-present Alexandre Martins <http://opensurge2d.org>
# License: GPL-3.0-or-later
#
# pull_opensurge.sh
# Pull opensurge
#
set -e

echo "Pulling opensurge..."

src_dir="$(realpath "$(dirname "$0")/../src/cpp/opensurge")"
git_pull="$(realpath "$(dirname "$0")/git_pull.sh")"

pushd build/parts/opensurge/src

if [[ ! -d "$src_dir" ]]; then

    # remote copy
    "$git_pull" \
        --repository https://github.com/alemart/opensurge.git \
        --commit afb76f66b31f60b55ab9d53ab2a25aaaa19631ea \
    ;

else

    # local copy
    #cp -v -r $src_dir/* . # unsuitable
    pushd "$src_dir"
    tar cf - --exclude=src/misc/android --exclude=.git . | ( popd && tar xvf - )
    popd

fi

popd
