objs = main.o data.o
exec = mordc

all: $(exec)

$(exec): $(objs)
	ld	-o $(exec) $(objs)
%.o: %.s
	as	-o $@ $<
clean:
	rm	-rf $(exec) $(objs)
