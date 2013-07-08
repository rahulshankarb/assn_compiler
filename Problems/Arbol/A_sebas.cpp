
#include <cstdio>
#include <cmath>

int main() {
	int a,b,c,tc;
	tc=0;
	while (true) {
		scanf("%i %i",&a,&b);
		if (a==0 && b==0) break;
		tc++;
		c = (int)ceil( sqrt(a*a + b*b) );
		printf("Caso #%i: %i\n", tc, c);
	}
}

