#                                     .-.	art by: cp97
#  ((_,...,_))   __ ___   ___  _ __ __| | ___ 	coded by: x13nsa
#     |o o|     '_ ` _ \ / _ \| '__/ _` |/ __|	date: Jul 15 2024 (happy birthday!!)
#     \   /     | | | | | (_) | | | (_| | (__ 
#      ^-^      | |_| |_|\___/|_|  \__,_|\___|
objs = main.o data.o types.o morse.o strlen.o strncmp.o
exec = mordc

all: $(exec)

$(exec): $(objs)
	ld	-o $(exec) $(objs)
%.o: %.s
	as	-o $@ $<
clean:
	rm	-rf $(exec) $(objs)
