/* Problem 7--Making Labels
   This problem was killer hard if you actually tried to work out some
   sort of combinatorics based formula that solves this problem.  If
   you simply noticed the pattern in the sample that the answer was
   N^(N-2), you got it right because that is, in fact, the formula. */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int main (int argc, char **argv);

int main (int argc, char **argv) {

  FILE *in, *out;
  int cs, N;

 in = fopen ("prob7.in","r");
 out = fopen ("prob7.out","w");
 for (cs=1;fscanf (in,"%d",&N),N>0;cs++)
  fprintf (out,"Case %d, N = %d, # of different labelings = %d\n",
           cs,N,(int)(0.5+pow(N,N-2)));
 fclose (in);
 fclose (out);
 return EXIT_SUCCESS;
}
