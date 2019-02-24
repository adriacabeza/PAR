CC = icc # gcc
OPENMP   = -fopenmp

TAREADORCC = tareador-clang
TAREADOR_FLAGS = -tareador-lite

CFLAGS  = -Wall -fno-inline -ffloat-store 
OPTG0   = -g -O0
OPT3    = -g -O3

CINCL   = -I. -I${FFTW3_HOME}/include
CLIBS   = -L. ${FFTW3_HOME}/lib/libfftw3f.a -lm

TARGETS  = 3dfft_seq 3dfft_omp 3dfft_tar
all: $(TARGETS) 

3dfft_seq:	3dfft_seq.c const.h
	$(CC) $(CFLAGS) $(OPT3) $(CINCL) $< -o $@ $(CLIBS) 

3dfft_omp:	3dfft_omp.c const.h
	$(CC) $(CFLAGS) $(OPT3) $(OPENMP) $(CINCL) $< -o $@ $(CLIBS) 

3dfft_tar:	3dfft_tar.c const.h
	$(TAREADORCC) -DTEST $(CFLAGS) $(OPTG0) $(CINCL) $< -o $@ $(CLIBS) $(TAREADOR_FLAGS)


3dfft_tar0:	3dfft_tar.c const.h
	$(TAREADORCC) -DTEST $(CFLAGS) $(OPTG0) $(CINCL) $< -o $@ $(CLIBS) $(TAREADOR_FLAGS)


3dfft_tar1:	3dfft_tar1.c const.h
	$(TAREADORCC) -DTEST $(CFLAGS) $(OPTG0) $(CINCL) $< -o $@ $(CLIBS) $(TAREADOR_FLAGS)


3dfft_tar2:	3dfft_tar2.c const.h
	$(TAREADORCC) -DTEST $(CFLAGS) $(OPTG0) $(CINCL) $< -o $@ $(CLIBS) $(TAREADOR_FLAGS)


3dfft_tar3:	3dfft_tar3.c const.h
	$(TAREADORCC) -DTEST $(CFLAGS) $(OPTG0) $(CINCL) $< -o $@ $(CLIBS) $(TAREADOR_FLAGS)


3dfft_tar4:	3dfft_tar4.c const.h
	$(TAREADORCC) -DTEST $(CFLAGS) $(OPTG0) $(CINCL) $< -o $@ $(CLIBS) $(TAREADOR_FLAGS)


3dfft_tar5:	3dfft_tar5.c const.h
	$(TAREADORCC) -DTEST $(CFLAGS) $(OPTG0) $(CINCL) $< -o $@ $(CLIBS) $(TAREADOR_FLAGS)



clean:
	rm -rf $(TARGETS)

ultraclean:
	rm -rf $(TARGETS) .tareador_precomputed_* logs *.log *.prv *.pcf *.row *.txt *.sh.o* *.sh.e* *.ps
