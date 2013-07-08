import java.io.*;


public class Labels {

	/**
	 * @param args
	 * @throws IOException 
	 * @throws NumberFormatException 
	 */
	public static void main(String[] args) throws NumberFormatException, IOException {
		// TODO Auto-generated method stub

		BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
		
		int caso = 0;
		while (true) {
			
			int n = Integer.parseInt(br.readLine());
			if(n==0)break;
			System.out.println("Case "+(++caso)+", N = "+n+", # of different labelings = "+(int)Math.pow(n, n-2));
			
		}
		
		
	}

}
