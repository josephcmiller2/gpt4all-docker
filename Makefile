include config.mak

all:
	make -C files
	touch env
	time podman build --tag $(TAGNAME) -f ./Dockerfile

clean:
	make -C files clean

distclean:
	make -C files distclean
	rm -f config.mak

remove: rm

rm:
	podman rm $(NAME)

list: ls

ls:
	podman ps -a

.PHONY: all remove rm list ls
