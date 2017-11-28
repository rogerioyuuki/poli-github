/**
 *
 * @author Diego
 */
public class Triangulo extends Poligono {
    public Triangulo(float ladoA, float ladoB, float ladoC){
        super(new float[]{ladoA, ladoB, ladoC});
    }

    @Override
    public boolean validar() {
        /* Um triangulo deve ter 3 lados e a soma
         * de dois lados deve ser MENOR que o
         * terceiro lado.
         */
		 
		 //TODO: verificar se tem 3 lados e a soma de dois lados quaisquer eh menor do que o terceiro lado
		 //Nao esquecer de chamar tambem a classe pai para fazer a validacao!
        
        if (super.validar() == true &&
            lados[0] + lados[1] > lados[2] &&
            lados[1] + lados[2] > lados[0] &&
            lados[2] + lados[0] > lados[1])
            return true;
        else return false;
        
    }
    
    
}
