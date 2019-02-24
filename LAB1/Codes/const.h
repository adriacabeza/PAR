#ifndef __ERROR_PRECISION__
#define __ERROR_PRECISION__

#define ERROR_ALLOWED 4.0

#ifndef TEST
#define TEST 0
#else
#define TEST 1
#endif 

double getusec_() {
        struct timeval time;
        gettimeofday(&time, 0);
        return ((double)time.tv_sec * (double)1e6 + (double)time.tv_usec);
}

#define START_COUNT_TIME stamp=getusec_();
#define STOP_COUNT_TIME(_m) stamp=getusec_()-stamp;\
                        stamp=stamp/1e6;\
                        printf ("%s:%0.6fs\n",(_m), stamp);
#define  ERROR(_s) {printf("%s\n",(_s)); return 1;}

#endif
