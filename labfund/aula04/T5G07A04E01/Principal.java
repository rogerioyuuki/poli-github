/**
 *
 * @author Diego
 */
public class Principal {

    public static void main(String[] args) {
        
        Poligono p = new Poligono(new float[]{10, 20, 30, 40, 50});
        p.imprime();
        
        p = new Triangulo(3, 4, 5);
        p.imprime();
		
		Triangulo t = new TrianguloEquilatero(2);
		t.imprime();
        
        Quadrilatero q = new Quadrilatero(2, 4, 5, 6);
        q.imprime();
        
        Triangulo t1 = new Triangulo(1, 5, 9);
        t1.imprime();
        
        Quadrilatero q1 = new Quadrilatero(1, 2, 3, 7);
        q1.imprime();
        
        Triangulo t2 = new TrianguloEscaleno(3, 4, 5);
        t2.imprime();
        
        Triangulo t3 = new TrianguloEscaleno(3, 3, 5);
        t3.imprime();
        
    }
}
