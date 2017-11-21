#include "main.h"
#include "uthash.h"
#include "utarray.h"


typedef struct transicao {

	Token key;
	int estadoAtual;
	int estadoResultado;

	UT_hash_handle hh;

} Transicao;


typedef struct automato {

	char *title;

	Transicao **tabelaTransicao;
	int estado;
	int *estadosFinais;

	UT_hash_handle hh;

} Automato;


typedef struct APE {

	Automato *automatos;

	Automato *automatoAtual;
	UT_array pilha;

} APE;
