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

 #Clean 
 clean:
	rm -f obj/*.o bin/* lib/*