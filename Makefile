# Astrolog (Version 5.41E) File: Makefile (Unix version)
#
# IMPORTANT NOTICE: The graphics database and chart display routines
# used in this program are Copyright (C) 1991-1996 by Walter D. Pullen
# (Astara@msn.com, http://www.magitech.com/~cruiser1/astrolog.htm).
# Permission is granted to freely use and distribute these routines
# provided one doesn't sell, restrict, or profit from them in any way.
# Modification is allowed provided these notices remain with any
# altered or edited versions of the program.
#
# First created 11/21/1991.
#
# This Makefile is included only for convenience. One could easily compile
# Astrolog on a Unix system by hand with the command:
# % cc -c -O *.c; cc -o astrolog *.o -lm -lX11
# Generally, all that needs to be done to compile once astrolog.h has been
# edited, is compile each source file, and link them together with the math
# library, and if applicable, the main X library.
#
NAME 	= astrolog
CC 	= gcc
CFLAGS 	= -s -g -O2 -Wall -Wno-array-bounds -pedantic -fPIC
LD 	= gcc
LDFLAGS	= -L.
LIBS 	= -lm -lX11 -lhpdf
AR 	= ar
ARFLAGS	= r
RM	= rm
ECHO	= echo
SHELL	= /bin/sh
SHARED	= -shared -Wl,-soname,-libswe.so.0

SRC = astrolog.c calc.c charts0.c charts1.c charts2.c charts3.c charts4.c\
	data2.c data.c general.c gtopo.c intrpalt.c intrpret.c io.c\
	matrix.c riyal2.c riyal.c swe_call.c xcharts0.c xcharts1.c\
	xcharts2.c xcharts3.c xdata.c xdevice.c xgeneral.c xscreen.c

OBJ = $(SRC:.c=.o)

SWE = swedate.c swehouse.c swejpl.c swemmoon.c swemplan.c swepcalc.c\
	sweph.c swepdate.c swephlib.c swecl.c swehel.c

SWEOBJ = $(SWE:.c=.o)

all: astrolog

astrolog: libswe.a $(OBJ) $(SWEOBJ)
	#$(AR) $(ARFLAGS) libswe.a $(SWEOBJ)
	$(CC) -o $(NAME) $(OBJ) $(SWEOBJ) $(LIBS) $(LDFLAGS)
	strip $(NAME)

# create an archive and a dynamic link libary from SwissEph
# a user of this library will inlcude swephexp.h  and link with -lswe

libswe.a: $(SWEOBJ)
	$(AR) $(ARFLAGS) libswe.a $(SWEOBJ)

libswe.so: $(SWEOBJ)
	$(CC) $(SHARED) -o libswe.so $(SWEOBJ)

clean:
	$(RM) -f *.o libswe*
