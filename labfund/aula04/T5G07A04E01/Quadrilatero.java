public class Quadrilatero extends Poligono {
    public Quadrilatero(float ladoA, float ladoB, float ladoC, float ladoD) {
        super(new float[] {ladoA, ladoB, ladoC, ladoD});
    }
              
    @Override
    public boolean validar() {
        if (super.validar() == true &&
            lados[0] + lados[1] + lados[2] > lados[3] &&
            lados[1] + lados[2] + lados[3] > lados[0] &&
            lados[2] + lados[3] + lados[0] > lados[1] &&
            lados[3] + lados[0] + lados[1] > lados[2]) return true;
        else return false;
    }
    
}