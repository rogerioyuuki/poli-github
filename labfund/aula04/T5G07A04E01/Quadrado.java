public class Quadrado extends Retangulo {
    public Quadrado(float lado) {
        super(lado, lado);
    }
    
    public boolean validar() {
        if (super.validar() == true) return true;
        else return false;
    }
}