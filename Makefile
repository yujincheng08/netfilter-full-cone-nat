ccflags-y += -O3
KVERSION = $(shell uname -r)
XTABLES_LIBDIR ?= $(shell pkg-config xtables --variable=xtlibdir)

%.so: %.o
	$(CC) -shared -lxtables -o $@ $^
%.o: %.c
	$(CC) ${CFLAGS} -fPIC -D_INIT=$*_init -c -o $@ $<

all: libipt_FULLCONENAT.so libip6t_FULLCONENAT.so
clean:
	$(RM) libipt_FULLCONENAT.so libipt_FULLCONENAT.o libip6t_FULLCONENAT.so libip6t_FULLCONENAT.o
install: all
	install -m 0644 libipt_FULLCONENAT.so libip6t_FULLCONENAT.so $(XTABLES_LIBDIR)/
.PHONY: all clean install
