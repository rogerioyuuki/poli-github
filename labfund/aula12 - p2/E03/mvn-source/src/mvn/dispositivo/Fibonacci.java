/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package mvn.dispositivo;

import mvn.Bits8;
import mvn.Dispositivo;
import mvn.controle.MVNException;

/**
 *
 * @author mjunior
 */
public class Fibonacci implements Dispositivo {
  private Bits8 v0, v1;
  
  /**
   * Construtor: inicializa v0 e v1 como 0<br/>
   * <br/>
   * <b>Pré-condição</b>: Nenhuma.<br/>
   * <b>Pós-condição</b>: Fibonacci instanciado.
   */
  public Fibonacci() {
    reset();
  }

  @Override
  public String toString() {
    return new String();
  }


  /**
   * Atualiza v1 para o valor passado, guardando o antigo valor
   de v1 no atributo v0<br/>
   * <br/>
   * <b>Pre-condicao</b>: Nenhuma. <br/>
   * <b>Pos-condicao</b>: v1 atualizado e v0 igual ao v1 antigo.
   *
   * @param in O Bits8 a ser escrito.
   * @throws MVNException caso haja um problema.
   */
  @Override
  public void escrever(Bits8 in) throws MVNException {
    if (in != null) {
      v0 = v1;
      v1 = in;
    }
    else {
      throw new MVNException();
    }
  }

  /**
   * Retorna o valor seguinte da sequência de Fibonacci, v0+v1,
   atualizando v0 e v1 como se v0+v1 tivesse sido passado como
   parâmetro para o método escrever.<br/>
   * <br/>
   * <b>Pre-condicao</b>: O dispositivo permite leitura.<br/>
   * <b>Pos-condicao</b>: Um Bits8 e lido do dispositivo.
   *
   * @return O Bits8 lido.
   * @throws MVNException caso haja um problema.
   */
  @Override
  public Bits8 ler() throws MVNException {
    Bits8 next = new Bits8(v0);
    next.add(v1);
    escrever(next);
    return next;
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
    return true;
  }

  /**
   * Reinicializa v0 e v1 em 0.<br/>
   * <br/>
   * <b>Pre-condicao</b>: Nenhuma.<br/>
   * <b>Pos-condicao</b>: v0 e v1 reinicializados em 0
   */
  @Override
  public void reset() {
    v0 = new Bits8(0);
    v1 = new Bits8(0);
  }

  /**
   * Salta n valores da sequência de Fibonacci, como se o
   método ler fosse chamado n vezes; retorna então o valor seguinte
   da sequência da mesma forma que seria feito com uma nova
   chamada do método ler<br/>
   * <br/>
   * <b>Pre-condicao</b>: Nenhuma.<br/>
   * <b>Pos-condicao</b>: n valores saltados
   *
   * @param val O numero de posiçoes a ser avançadas.
   * @return o proximo valor apos o salto
   * @throws MVNException caso haja um problema.
   */
  @Override
  public Bits8 skip(Bits8 val) throws MVNException {
    for (int n = val.toInt(); n > 0 ; n--) {
      ler();
    }
    return ler();
  }

  /**
   * Retorna o valor de v0.<br/>
   * <br/>
   * <b>Pre-condicao</b>: Nenhuma.<br/>
   * <b>Pos-condicao</b>: v0 retornado
   *
   * @return v0
   * @throws MVNException caso haja um problema.
   */
  @Override
  public Bits8 position() throws MVNException {
    if (v0 != null) {
      return v0;
    }
    else {
      throw new MVNException();
    }
  }

  /**
   * Retorna v1.<br/>
   * <br/>
   * <b>Pre-condicao</b>: Nenhuma.<br/>
   * <b>Pos-condicao</b>: v1 retornado
   *
   * @return v1
   * @throws MVNException caso haja um problema.
   */
  @Override
  public Bits8 size() throws MVNException {
    if (v1 != null) {
      return v1;
    }
    else {
      throw new MVNException();
    }
  }
}
