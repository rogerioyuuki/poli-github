/**
 * Escola Politécnica da Universidade de São Paulo
 * Departamento de Engenharia de Computação e Sistemas Digitais
 * Copyright© 2001..2011, todos os direitos reservados.
 * 
 * Este programa é de uso exclusivo das disciplinas de Laboratório de
 * Fundamentos de Engenharia de Computação (PCS2024 e PCS2302) e Linguagens
 * e Compiladores (PCS2056 e PCS2508).
 * É vetada a utilização e/ou distribuição deste código sem a autorização
 * dos docentes responsáveis pela disciplina ou do departamento responsável.
 */
package mvn;

import mvn.controle.MVNException;
import mvn.controle.PainelControle;
import mvn.dispositivo.StoreMax;

/**
 * Classe que inicia a MVN.
 * 
 * @author PSMuniz
 * @author Diego Queiroz
 * @version 1.0 - PCS/EPUSP
 * @version 2.0 - PCS/EPUSP (MVN 4.0)
 */
public class MvnPcs{
	
	/*** Controlador da MVN */
	private static MvnControle		mvnPcs;
	
	/*** Painel de Controle da MVN */
	private static PainelControle	painel;
	
	
	/**
	 * Método principal do programa. Responsável por inicializar o controlador
	 * e anexá-lo à um Painel de Controle.<br/>
	 * <br/>
	 * <b>Pré-condição</b>: Nenhuma.<br/>
	 * <b>Pós-condição</b>: O terminal da MVN é exibido.
	 * 
	 * @param args
	 *          Parâmetros do programa. Não utilizado.
	 */
	public static void main(String args[]){
//		StoreMax storemax = new StoreMax();
//		System.out.println(storemax.podeEscrever());
//		System.out.println(storemax.podeLer());
//		try {
//			storemax.escrever(new Bits8(15));
//			storemax.escrever(new Bits8(12));
//			storemax.escrever(new Bits8(13));
//			storemax.escrever(new Bits8(14));
//			System.out.println(storemax.list);
//			storemax.escrever(new Bits8(14));
//			System.out.println(storemax.list);
//			System.out.println(storemax.skip(new Bits8(2)).toInt());
//			System.out.println(storemax.list);
//			for (int i = 0; i < 10; i++) {
//				System.out.println(storemax.ler().toInt());
//			}
//			storemax.reset();
//			System.out.println(storemax.list);
//		} catch (MVNException e) {
//			e.printStackTrace();
//		}

		mvnPcs = new MvnControle();
		painel = new PainelControle(mvnPcs, false);
		painel.mostrarTerminal();
	}
	
} // Fim da Classe MvnPcs