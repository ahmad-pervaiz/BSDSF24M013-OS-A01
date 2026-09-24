all: lib/libmyutils.a bin/client_static

obj/mystrfunctions.o: src/mystrfunctions.c
	gcc -Iinclude -c src/mystrfunctions.c -o obj/mystrfunctions.o

obj/myfilefunctions.o: src/myfilefunctions.c
	gcc -Iinclude -c src/myfilefunctions.c -o obj/myfilefunctions.o

obj/main.o: src/main.c
	gcc -Iinclude -c src/main.c -o obj/main.o

lib/libmyutils.a: obj/mystrfunctions.o obj/myfilefunctions.o
	ar rcs lib/libmyutils.a obj/mystrfunctions.o obj/myfilefunctions.o

bin/client_static: obj/main.o lib/libmyutils.a
	gcc obj/main.o -Llib -lmyutils -o bin/client_static


clean:
	rm -f obj/*.o bin/* lib/*
