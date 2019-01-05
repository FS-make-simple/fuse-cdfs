OBJS = cdfs-utils.o cdfs-cdromutils.o cdfs-options.o cdfs-xattr.o cdfs-cache.o fuse-loop-epoll-mt.o entry-management.o cdfs.o
EXECUTABLE = fuse-cdfs

CC=gcc
CFLAGS = -Wall -std=gnu99 -O3 -D_FILE_OFFSET_BITS=64 -I/usr/include/fuse
LDFLAGS = -lpthread -lfuse -lrt -ldl -lcdio_paranoia -lcdio_cdda -lcdio -lsqlite3
COMPILE = $(CC) $(CFLAGS) -c
LINKCC = $(CC)


all: $(EXECUTABLE)

$(EXECUTABLE): $(OBJS)
	$(LINKCC) $(CFLAGS) -o $(EXECUTABLE) $(OBJS) $(LDFLAGS)

fuse-loop-epoll-mt.o: src/fuse-loop-epoll-mt.h src/logging.h
cdfs-utils.o: src/cdfs-utils.h src/logging.h
cdfs-cdromutils.o: src/cdfs-cdromutils.h src/logging.h
cdfs.o: src/cdfs-utils.h src/cdfs-options.h src/cdfs-xattr.h src/fuse-loop-epoll-mt.h src/entry-management.h src/logging.h src/cdfs.h src/global-defines.h
cdfs-options.o: src/cdfs-options.h src/logging.h src/global-defines.h
cdfs-xattr.o: src/cdfs-xattr.h src/logging.h src/cdfs.h src/global-defines.h
cdfs-cache.o: src/cdfs-cache.h src/logging.h src/cdfs.h src/global-defines.h
entry-management.o: src/entry-management.h src/logging.h src/global-defines.h

%.o: src/%.c 
	$(COMPILE) -o $@ $<


clean:
	rm -f $(OBJS) $(EXECUTABLE) *~
