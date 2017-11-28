/**
 *
 * @author Diego
 */
public class TrianguloIsosceles extends Triangulo {
    
    public TrianguloIsosceles(float ladoA, float ladoB){
        super(ladoA, ladoA, ladoB);
    }

    @Override
    public boolean validar() {
        // TODO: verificar se isosceles
		//Nao esquecer de chamar tambem a classe pai para fazer a validacao!
        
        if (super.validar() == true) return true;
        else return false;
    }
    
}
