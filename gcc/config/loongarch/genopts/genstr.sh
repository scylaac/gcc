#!/bin/sh
# A simple script that generates loongarch-str.h and loongarch.opt
# from genopt/loongarch-optstr.
#
# Copyright (C) 2021 Free Software Foundation, Inc.
#
# This file is part of GCC.
#
# GCC is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free
# Software Foundation; either version 3, or (at your option) any later
# version.
#
# GCC is distributed in the hope that it will be useful, but WITHOUT
# ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
# or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
# License for more details.
#
# You should have received a copy of the GNU General Public License
# along with GCC; see the file COPYING3.  If not see
# <http://www.gnu.org/licenses/>.

cd "$(dirname "$0")"

# Generate a header containing definitions from the string table.
gen_defines() {
    cat <<EOF
/* Generated automatically by "genstr" from "loongarch-strings".
   Copyright (C) 2021 Free Software Foundation, Inc.
   Contributed by Loongson Ltd.

This file is part of GCC.

GCC is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 3, or (at your option)
any later version.

GCC is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with GCC; see the file COPYING3.  If not see
<http://www.gnu.org/licenses/>.  */

#ifndef LOONGARCH_STR_H
#define LOONGARCH_STR_H
EOF

    sed -e '/^$/n' -e 's@#.*$@@' -e '/^$/d' \
	-e 's@^\([^ \t]\+\)[ \t]*\([^ \t]*\)@#define \1 "\2"@' \
	loongarch-strings

    echo
    echo "#endif /* LOONGARCH_STR_H */"
}


# Substitute all "@@<KEY>@@" to "<VALUE>" in loongarch.opt.in
# according to the key-value pairs defined in loongarch-strings.

gen_options() {

    sed -e '/^$/n' -e 's@#.*$@@' -e '/^$/d' \
	-e 's@^\([^ \t]\+\)[ \t]*\([^ \t]*\)@\1="\2"@' \
	loongarch-strings | { \

	# read the definitions
	while read -r line; do
	    eval "$line"
	done

	# make the substitutions
	sed -e 's@"@\\"@g' -e 's/@@\([^@]\+\)@@/${\1}/g' loongarch.opt.in | \
	    while read -r line; do
		eval "echo \"$line\""
	    done
    }
}

main() {
    case "$1" in
	header) gen_defines;;
	opt) gen_options;;
	*) echo "Unknown Command: \"$1\". Available: header, opt"; exit 1;;
    esac
}

main "$@"
