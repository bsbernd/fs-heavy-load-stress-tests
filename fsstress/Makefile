CFLAGS += -Wall -g -DNO_XFS -I. -D_LARGEFILE64_SOURCE -D_GNU_SOURCE
#LDFLAGS += -static

SRCS=$(wildcard *.c)
TARGETS=$(patsubst %.c,%,$(SRCS))

all: $(TARGETS)

clean:
	rm -f $(TARGETS)


