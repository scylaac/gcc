/* Definitions for LoongArch CPU properties.
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

#ifndef LOONGARCH_CPU_H
#define LOONGARCH_CPU_H

#include "loongarch-rtx-cost.h"

/* enum loongarch_cpu_type */
enum loongarch_cpu_type {
    CPU_NATIVE = 0,
    CPU_LOONGARCH64 = 1,
    CPU_GS464V = 2,
    N_CPU_TYPES = 3,
};

struct loongarch_isa_ext {
    int ext_dummy;
};

struct loongarch_cpu_config {
    int isa_int;
    int isa_float;
    struct loongarch_isa_ext ext;
};

/* Static CPU property tables */
extern const char* loongarch_cpu_strings[];

extern struct loongarch_cpu_config loongarch_cpu_default_config[];

extern int loongarch_cpu_issue_rate[];

extern int loongarch_cpu_multipass_dfa_lookahead[];

extern struct loongarch_rtx_cost_data loongarch_cpu_rtx_cost_data[];

#endif /* LOONGARCH_CPU_H */
