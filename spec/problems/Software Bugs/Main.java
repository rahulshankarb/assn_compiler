

/**
 *
 * @author EDY
 */
import java.io.*;
public class Main {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {

        try {
            BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
            String cadena = br.readLine();

                while (!cadena.equals(null)) {
                    
                    eliminar(cadena);

                    cadena = br.readLine();
                  
                }


        } catch (Exception e) {
        }
        // TODO code application logic here
    }

    static void eliminar (String cadena){
        
        cadena = cadena.replaceAll("BUG", "");
        int x = cadena.indexOf("BUG");

                while (x!=-1) {
                     cadena = cadena.replaceAll("BUG", "");
            //eliminar(cadena);
             x = cadena.indexOf("BUG");
        }


        System.out.println(cadena);
       

    }

}
