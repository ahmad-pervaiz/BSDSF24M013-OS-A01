PREFIX ?= /usr/local

all: lib/libmyutils.a lib/libmyutils.so bin/client_static bin/client_dynamic

obj/mystrfunctions.o: src/mystrfunctions.c
	gcc -Iinclude -fPIC -c src/mystrfunctions.c -o obj/mystrfunctions.o

obj/myfilefunctions.o: src/myfilefunctions.c
	gcc -Iinclude -fPIC -c src/myfilefunctions.c -o obj/myfilefunctions.o

obj/main.o: src/main.c
	gcc -Iinclude -c src/main.c -o obj/main.o

lib/libmyutils.a: obj/mystrfunctions.o obj/myfilefunctions.o
	ar rcs lib/libmyutils.a obj/mystrfunctions.o obj/myfilefunctions.o

lib/libmyutils.so: obj/mystrfunctions.o obj/myfilefunctions.o
	gcc -shared obj/mystrfunctions.o obj/myfilefunctions.o -o lib/libmyutils.so

bin/client_static: obj/main.o lib/libmyutils.a
	gcc obj/main.o -Llib -lmyutils -o bin/client_static

bin/client_dynamic: obj/main.o lib/libmyutils.so
	gcc obj/main.o -Llib -lmyutils -o bin/client_dynamic

install: all
	install -d $(PREFIX)/bin $(PREFIX)/lib $(PREFIX)/share/man/man3
	install -m 755 bin/client_dynamic $(PREFIX)/bin/client
	install -m 755 lib/libmyutils.so $(PREFIX)/lib/
	install -m 644 man/man3/*.3 $(PREFIX)/share/man/man3/
	ldconfig || true

uninstall:
	rm -f $(PREFIX)/bin/client
	rm -f $(PREFIX)/lib/libmyutils.so
	rm -f $(PREFIX)/share/man/man3/mystr*.3 $(PREFIX)/share/man/man3/mycat.1 $(PREFIX)/share/man/man3/wordCount.3 $(PREFIX)/share/man/man3/mygrep.3

clean:
	rm -f obj/*.o bin/* lib/*