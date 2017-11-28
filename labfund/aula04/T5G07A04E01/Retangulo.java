public class Retangulo extends Quadrilatero {
    public Retangulo(float ladoA, float ladoB) {
        super(ladoA, ladoA, ladoB, ladoB);
    }
    
    @Override
    public boolean validar() {
        if (super.validar() == true) return true;
        else return false;
    }
}