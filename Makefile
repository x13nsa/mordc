objs = main.o data.o types.o morse.o strlen.o strncmp.o
exec = mordc

all: $(exec)

$(exec): $(objs)
	ld	-o $(exec) $(objs)
%.o: %.s
	as	-o $@ $<
clean:
	rm	-rf $(exec) $(objs)
