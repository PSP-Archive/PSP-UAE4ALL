 /*
  * UAE - The Un*x Amiga Emulator
  *
  * MC68881 emulation
  * Support functions for IEEE compatible host CPUs.
  * These functions use a GCC extension (type punning through unions) and
  * should only be compiled with compilers that support this.
  *
  * Copyright 1999 Sam Jordan
  */

static __inline__ float to_single (uae_u32 value)
{
    union {
        float f;
        uae_u32 u;
    } val;

    val.u = value;
    return val.f;
}

static __inline__ uae_u32 from_single (float src)
{
    union {
        float f;
        uae_u32 u;
    } val;

    val.f = src;
    return val.u;
}

static __inline__ float to_double(uae_u32 wrd1, uae_u32 wrd2)
{
    union {
        float d;
        uae_u32 u[2];
    } val;

    val.u[0] = wrd1;
    val.u[1] = wrd2;
    return val.d;
}

static __inline__ void from_double(float src, uae_u32 * wrd1, uae_u32 * wrd2)
{
    union {
        float d;
        uae_u32 u[2];
    } val;

    val.d = src;
    *wrd1 = val.u[0];
    *wrd2 = val.u[1];
}

#define HAVE_from_double
#define HAVE_to_double
#define HAVE_from_single
#define HAVE_to_single

/* Get the rest of the conversion functions defined.  */
#include "fpp-unknown.h"
