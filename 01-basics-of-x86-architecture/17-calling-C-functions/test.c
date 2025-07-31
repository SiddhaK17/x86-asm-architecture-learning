#include <stdio.h>	// Standard I/O for printf

// Declaration (forward declaration) of the test function
// 'extern' tells other translation units (like your .s file) that this function exists and can be linked
extern int test(int,int);	// This means that this is externally exported which means that it's accessible by things outside of this C Program. So that will allow it to be accessible by our assembly program

// Definition of the 'test' function
int test(int a, int b){
	printf("HERE!\n");	// Print a debug message when the function is called
	return a+b;			// Return the sum of a and b
}
