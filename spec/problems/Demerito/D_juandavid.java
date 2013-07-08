/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */



import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.PrintStream;
import java.util.Hashtable;
import java.util.LinkedList;
import java.util.PriorityQueue;
import java.util.Scanner;

/**
 *
 * @author Juan David
 */
public class D_juandavid {


    static class nodo implements Comparable<nodo>{

        int x;
        int y;
        int id;
        LinkedList<nodo> ad=new LinkedList<nodo>();
        double costo;
        public nodo(int x,int y){
            
            this.x=x;
            this.y=y;
            //this.id=id;
            
            
            this.costo=Integer.MAX_VALUE;
        }

        double distancia(nodo a){
            return Math.sqrt((this.x-a.x)*(this.x-a.x)+(this.y-a.y)*(this.y-a.y));
        }
        public int compareTo(nodo o) {
            return Double.valueOf(costo).compareTo(o.costo);
        }


    }

    static nodo BusCrear(String aux){
        
        if(id.containsKey(aux))
            return n.get(id.get(aux));
        else{
            String[]l=aux.split(" ");
            nodo p=new nodo(Integer.parseInt(l[0]), Integer.parseInt(l[1]));
            p.id=t;
            n.put(t, p);
            id.put(aux, t);
            t++;
            return p;
        }
            
    }

    static void dijktra(nodo start){
        start.costo=0;
        cp.add(start);
        dis[start.id]=0;
        while(cp.size()!=0)
        {
            nodo top=cp.peek();
            cp.poll();
            
            for(nodo w:top.ad)
            {
           
               if(dis[w.id]>dis[top.id]+top.distancia(w))
               {
                   cp.remove(w);
                   w.costo=dis[top.id]+top.distancia(w);
                   dis[w.id]=dis[top.id]+top.distancia(w);
                   cp.add(w);
               }
            }
        }
    }


   static PriorityQueue<nodo>cp=new PriorityQueue<nodo>();
    static Hashtable<Integer, nodo> n=new Hashtable<Integer, nodo>();
    static Hashtable<String, Integer> id=new Hashtable<String, Integer>();
    static double[] dis=new double[10000];
    static int t=0;
    public static void main(String[]args) throws FileNotFoundException{

        Scanner in=new Scanner(System.in);
        int N;
         String aux="";
          String[]l;
        while(true)
        {
            N=Integer.parseInt(in.nextLine());
            if(N==0)
                break;
            n.clear();
            cp.clear();
            t=0;
            l=in.nextLine().split(" ");
            nodo inicio=new nodo(Integer.parseInt(l[0]), Integer.parseInt(l[1]));
            aux=l[0]+" "+l[1];
            inicio.id=t;
            n.put(t, inicio);
            id.put(aux, t);
            t++;
            nodo fin=new nodo(Integer.parseInt(l[2]), Integer.parseInt(l[3]));
            aux=l[2]+" "+l[3];
            fin.id=t;
            n.put(t, fin);
            id.put(aux, t);
            t++;
            for(int i=0;i<N;i++)
            {
                l=in.nextLine().split(" ");
                aux=l[0]+" "+l[1];
                nodo p1=BusCrear(aux);
                aux=l[2]+" "+l[3];
                nodo p2=BusCrear(aux);
                p1.ad.add(p2);
                p2.ad.add(p1);
                dis[i]=Double.MAX_VALUE;
            }
            dijktra(inicio);
            System.out.println(Math.round(dis[fin.id]));

        }

    }
}
