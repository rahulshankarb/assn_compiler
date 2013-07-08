import java.util.Scanner;


public class Especiales {
	public static void main(String[] args) {
		Scanner s=new Scanner(System.in);
		int n;
		while ((n=s.nextInt())!=0) {
			System.out.println(prime(n)?"No":"Yes");
			//System.out.println(" "+n);
		}
	}

	static boolean prime(int n) {
		int from=2,to=(int)Math.sqrt(n);
		while (from<=to) if(n%from++==0) return true;
		return false;
	}
}
