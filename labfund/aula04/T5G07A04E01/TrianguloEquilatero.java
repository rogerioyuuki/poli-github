/**
 *
 * @author Diego
 */
public class TrianguloEquilatero extends TrianguloIsosceles {
    
    public TrianguloEquilatero(float lado){
        super(lado, lado);
    }

    @Override
    public boolean validar() {
        // TODO: verificar se equilatero
		//Nao esquecer de chamar tambem a classe pai para fazer a validacao!
        
        if (super.validar() == true) return true;
        else return false;
    }
    
}
