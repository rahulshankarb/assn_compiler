import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;



public class Facto {
	public static void main(String[] args) throws IOException {

		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		String cadena = br.readLine();
		int n ;
		while (!cadena.equals("*")) {

			n =  Integer.parseInt(cadena);
			System.out.println(n<0?"Invalido":factorial(n));           

			cadena = br.readLine();
		}
	}

	static int factorial(int n) {
		if (n == 0) {
			return 1;
		} else {
			return n * factorial(n - 1);
		}
	}

}
