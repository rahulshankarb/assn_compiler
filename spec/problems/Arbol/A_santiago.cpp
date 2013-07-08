#include <iostream>
#include <cmath>

using namespace std;

int main()
{
	int caso = 1;
	while(true)
	{
		int a, b;
		cin >> a >> b;
		if(a == 0 && b == 0)
			break;
		a *= a;
		b *= b;
		double res = sqrt(a + b);
		int resI = (int) res;
		cout << "Caso #" << caso++ << ": ";
		if(resI * resI == a + b)
			cout << resI << endl;
		else
			cout << resI + 1 << endl;
	}
}
