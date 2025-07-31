#include <stdio.h>

extern int test(int,int);	; This means that this is externally exported which means that it's accessible by things outside of this C Program. So that will allow it to be accessible by our assembly program

int test(int a, int b){
	printf("HERE!\n");
	return a+b;
}
