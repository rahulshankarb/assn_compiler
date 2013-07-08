/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */


import java.io.*;
/**
 *
 * @author EDY
 */
public class Walk {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        try {

       BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
       String cadena = br.readLine();
       int n ;
       while (!cadena.equals("0")) {
           
           n =  Integer.parseInt(cadena);
           System.out.println(n+ " => "+((int)Math.pow(n, 2)-(n-1)));

           cadena = br.readLine();
            }




        } catch (Exception e) {
        e.printStackTrace();
        }
    }

}
