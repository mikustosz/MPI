NAME = lapMPI
W = -Wall
FLAGS = -fopenmp

all: gcc

gcc: $(NAME).c
	gcc $(W) -lm $(FLAGS) $(NAME).c -o $(NAME)Gcc$(NR)

debug: $(NAME).c
	gcc $(W) -DDEBUG -lm $(FLAGS) $(NAME).c -o $(NAME)Gcc$(NR)

icc: $(NAME).c
	icc $(W) -openmp -Ofast $(NAME).c -o $(NAME)Icc$(NR)

report: $(PROG)
	perf stat -e cycles,instructions,task-clock ./$(PROG) $(A1) $(A2) > $(PROG).out 2>&1 && cat $(PROG).out

tau: $(NAME).c
	tau_cc.sh $(NAME).c -o lapMPI_TAU


.PHONY: clean
clean:
	rm -f $(NAME)Gcc* $(NAME)Icc* *.out profile.* tautrace.* *.o
