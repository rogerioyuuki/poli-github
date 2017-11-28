/**
 *
 * @author Diego
 */
public class Poligono {
    float[] lados;
    
    public Poligono(float[] lados){
        this.lados = lados;
    }
    
    
    public boolean validar(){
        /* Não sei que forma é, então o melhor
         * que eu posso fazer é verificar se possui
         * pelo menos 3 lados.
         */
		 
        // TODO: verificar se forma tem 3 lados
        
        if (lados.length >= 3) return true;
        else return false;
    }
    
    public float perimetro(){
        float soma = 0;
        for ( float i : lados ){
            soma += i;
        }
        return soma;
    }
    
    public void imprime(){
        System.out.println(getClass().getName());
        
        System.out.print("Lados: ");
        
        StringBuilder txt = new StringBuilder();
        String sep = "";
        for ( float i : lados ){
            txt.append(sep).append(i);
            sep = ", ";
        }
        System.out.println(txt);
        
        System.out.print("Perimetro: ");
        System.out.println(perimetro());
        
        if (validar()){
            System.out.println("Forma valida!");
        } else {
            System.out.println("Forma invalida!");
        }
        System.out.println();
    }
    
}
