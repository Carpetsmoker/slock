# slock - simple screen locker
# See LICENSE file for copyright and license details.

include config.mk

NAME=slock

all: options config.h
	${CC} *.c -o ${NAME} ${CFLAGS} ${LDFLAGS}

options:
	@echo ${NAME} build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CC       = ${CC}"

config.h:
	cp config.def.h $@

clean:
	rm -f ${NAME}

install: all
	mkdir -p ${DESTDIR}${PREFIX}/bin
	cp -f ${NAME} ${DESTDIR}${PREFIX}/bin
	chmod 755 ${DESTDIR}${PREFIX}/bin/${NAME}
	chmod u+s ${DESTDIR}${PREFIX}/bin/${NAME}
	mkdir -p ${DESTDIR}${MANPREFIX}/man1
	sed "s/VERSION/${VERSION}/g" <${NAME}.1 >${DESTDIR}${MANPREFIX}/man1/${NAME}.1
	chmod 644 ${DESTDIR}${MANPREFIX}/man1/${NAME}.1

uninstall:
	rm -f ${DESTDIR}${PREFIX}/bin/${NAME}
	rm -f ${DESTDIR}${MANPREFIX}/man1/${NAME}.1

.PHONY: all options clean dist install uninstall
