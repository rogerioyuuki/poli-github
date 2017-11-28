/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author Diego
 */
public class TrianguloEscaleno extends Triangulo {
    
    
    public TrianguloEscaleno(float ladoA, float ladoB, float ladoC){
        super(ladoA, ladoB, ladoC);
    }

    @Override
    public boolean validar() {
        // TODO: verificar se escaleno
		//Nao esquecer de chamar tambem a classe pai para fazer a validacao!
        
        if (super.validar() == true &&
            lados[0] != lados[1] &&
            lados[1] != lados[2] &&
            lados[2] != lados[0]) return true;
        else return false;
    }
    
}
