package mvn.dispositivo;

import mvn.Bits8;
import mvn.Dispositivo;
import mvn.controle.MVNException;

import java.util.ArrayList;

/**
 * Created by aluno on 08/10/2015.
 */
public class StoreMax implements Dispositivo{
    private static final int N = 4;

    private ArrayList<Integer> list;
    private int read, write;

    public StoreMax() {
        list = new ArrayList<>(N);
        for (int i = 0; i < N; i++) {
            list.add(i, 0);
        }
        read = 0; write = 0;
    }

    /**
     * Escreve um Bits8 no dispositivo.<br/>
     * <br/>
     * <b>Pre-condicao</b>: <i>in</i> e nao nulo e o dispositivo permite gravacao.<br/>
     * <b>Pos-condicao</b>: O valor e escrito no dispositivo.
     *
     * @param in O Bits8 a ser escrito.
     * @throws MVNException Caso haja um problema de entrada/saida ao escrever no
     *                      dispositivo.
     */
    @Override
    public void escrever(Bits8 in) throws MVNException {
        int next_write;
        int min = getMin();
        int entrada = in.toInt();
        System.out.println(min);
        if (entrada > min) {
            for (int i = 0; i < N; i++) {
                if (list.get(i) == min) {
                    list.set(i, entrada);
                    write = i;
                    break;
                }
            }
        }
    }

    /**
     * LÃª um Bits8 do dispositivo.<br/>
     * <br/>
     * <b>Pre-condicao</b>: O dispositivo permite leitura.<br/>
     * <b>Pos-condicao</b>: Um Bits8 e lido do dispositivo.
     *
     * @return O Bits8 lido.
     * @throws MVNException Caso haja um problema de entrada e saida ao escrever no
     *                      dispositivo.
     */
    @Override
    public Bits8 ler() throws MVNException {
        Bits8 data = new Bits8(list.get(read));
        read = (read + 1) % N;
        return data;
    }

    /**
     * Verifica se o dispositivo esta habilitado para leitura.<br/>
     * <br/>
     * <b>Pre-condicao</b>: Nenhuma.<br/>
     * <b>Pos-condicao</b>: Verifica se a leitura e permitida no dispositivo.
     *
     * @return True caso seja possÃ­vel ler do dispositivo, False caso contrario.
     */
    @Override
    public boolean podeLer() {
        return true;
    }

    /**
     * Verifica se o dispositivo esta habilitado para escrita.<br/>
     * <br/>
     * <b>Pre-condicao</b>: Nenhuma.<br/>
     * <b>Pos-condicao</b>: Verifica se a gravacao e permitida no dispositivo.
     *
     * @return True caso seja possÃ­vel escrever no dispositivo, False caso
     * contrario.
     */
    @Override
    public boolean podeEscrever() {
        return getMin() < 255;
    }

    @Override
    public void reset() {
        for (int i = 0; i < N; i++) {
            list.set(i, 0);
        }
        read = 0;
        write = 0;
    }

    /**
     * Avança o cursor de leitura do dispositivo que pode ser lido em uma
     * quantidade especifica de bytes.<br/>
     * <br/>
     * <b>Pre-condicao</b>: O dispositivo permite leitura.<br/>
     * <b>Pos-condicao</b>: o cursor de leitura do dispositivo de leitura
     * na posição indicada.
     *
     * @param val O numero de posiçoes a ser avançadas.
     * @return numero de posiçoes avançadas.
     * @throws MVNException Caso haja um problema de entrada e saida ao executar comando.
     */
    @Override
    public Bits8 skip(Bits8 val) throws MVNException {
        read = (read + val.toInt()) % N;
        return ler();
    }

    /**
     * Obtem o numero total de bytes lidos da unidade logica ate o momento.<br/>
     * <br/>
     * <b>Pre-condicao</b>: O dispositivo permite leitura.<br/>
     * <b>Pos-condicao</b>: verifica número de bytes ja lidos.
     *
     * @return numero de bytes ja lidos
     * @throws MVNException Caso haja um problema de entrada e saida ao executar comando.
     */
    @Override
    public Bits8 position() throws MVNException {
        return new Bits8(read);
    }

    /**
     * Obtém o tamanho do arquivo associado a unidade logica, em bytes.<br/>
     * <br/>
     * <b>Pre-condicao</b>: O dispositivo permite leitura.<br/>
     * <b>Pos-condicao</b>: verifica o tamanho do arquivo associado a unidade
     * logica.
     *
     * @return tamanho do arquivo associado a unidade logica, em bytes.
     * @throws MVNException Caso haja um problema de entrada e saida ao executar comando.
     */
    @Override
    public Bits8 size() throws MVNException {
        return new Bits8(write);
    }

    /* PRIVATE METHODS */
    private int getMin() {
        int min = list.get(0);
        for (int i = 0; i < N; i++) {
            if (list.get(i) < min) {
                min = list.get(i);
            }
        }
        return min;
    }
}
