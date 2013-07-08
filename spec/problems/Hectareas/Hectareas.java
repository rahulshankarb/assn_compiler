import java.util.Arrays;
import java.util.Scanner;


public class Hectareas {
	public static void main(String[] args) {
		Scanner s = new Scanner(System.in);
		int caso = 0;
		while (true) {
			caso++;
			int n;
			n= s.nextInt();
			if(n==0) break;
			int v[]= new int[n];
			int sum =0;
			for (int i = 0; i < n; i++){
				v[i]=s.nextInt();
				sum = sum +v[i];
			} 
				
			Arrays.sort(v);
			System.out.print("Caso "+caso+": ");
			for (int i = 0; i < v.length; i++) {
				System.out.print(v[i]+" ");
				
			}
			System.out.print("- ");
			System.out.println(sum>150?"falta espacio":150-sum);
			
				
			
			
		}
		
	}

}
