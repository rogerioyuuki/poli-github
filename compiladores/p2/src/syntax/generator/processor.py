from . import templates

excluded_automatos = {'STACK_IDENTIFIER', 'NUMBER'}


def preprocess(automato_list):
    automato_dict = dict(automato_list)

    for excluded in excluded_automatos:
        automato_dict.pop(excluded)

    for automato in automato_dict.values():
        automato['FIRST'] = list(FIRST(automato, automato_dict))
    
    for automato in automato_dict.values():
        automato['estados'] = preprocess_estados(automato, automato_dict)

    return automato_dict


def preprocess_estados(automato, automato_dict):
    estados = {}
    for regra in automato['regras']:
        # Estado
        if regra['estado'] not in estados:
            estado = {
                "transicoes": {},
                "chamadas": {}
            }

            estados[regra['estado']] = estado
        else:
            estado = estados[regra['estado']]

        # Preenche
        transicao = regra['transicao']
        if transicao.startswith('"'):
            estado['transicoes'][transicao.replace('"', '')] = regra
        elif transicao in excluded_automatos:
            estado['chamadas'][transicao] = regra
        else:
            for first in automato_dict[transicao]['FIRST']:
                if first in estado['chamadas']:
                    print("[{}] mais de uma chamada possível em '{}' para o token '{}'".format(automato['name'], regra['estado'], first))
                estado['chamadas'][first] = regra

    for estado_num, estado in estados.items():
        intersecao = set(estado['transicoes'].keys()) & set(estado['chamadas'].keys())
        if len(intersecao) > 0:
            print("[{}] duvida entre transicao e chamada em {} para os tokens {}".format(automato['name'], estado_num, intersecao))


    return estados




def FIRST(automato, automato_dict, visited=None):
    if visited is None:
        visited = set()

    visited.add(automato['name'])
    
    first = set()

    for regra in automato['regras']:
        if regra['estado'] != automato['inicial']:
            continue

        transicao = regra['transicao']

        if transicao.startswith('"'):
            # Terminal
            first.add(transicao.replace('"', ''))
        elif transicao in excluded_automatos:
            first.add(transicao)
        elif transicao not in visited:
            first = first | FIRST(automato_dict[transicao], automato_dict, visited)

    return first


def generate_code(automato_dict):
    programa = automato_dict.pop('KIPPLE')

    programa_code = templates.PROGRAMA.format(automato_code=generate_automato_code(programa),
                                              name='KIPPLE')

    return templates.BASE.format(programa=programa_code,
                                 automatos_restantes=generate_automatos_restantes_code(automato_dict))


def generate_automatos_restantes_code(automato_dict):
    buf = []
    for automato in automato_dict.values():
        buf.append(generate_automato_code(automato))
    return ''.join(buf)


def generate_automato_code(automato):
    automato_init = templates.AUTOMATO_INIT.format(name=automato['name'],
                                                   inicial=automato['inicial'])

    return templates.AUTOMATO.format(name=automato['name'],
                                     automato_init=automato_init,
                                     estados_finais=generate_estados_finais_code(automato),
                                     estados=generate_estados_code(automato))


def generate_estados_finais_code(automato):
    buf = []
    for estado in automato['final']:
        buf.append(templates.ESTADO_FINAL.format(name=automato['name'], final=estado))

    return ''.join(buf)


def generate_estados_code(automato):
    buf = []
    for estado in automato['estados']:
        buf.append(templates.ESTADOS.format(name=automato['name'],
                                            estado=estado,
                                            transicoes=generate_transicoes_code(automato, estado),
                                            chamadas=generate_chamadas_code(automato, estado)))

    return ''.join(buf)


def generate_transicoes_code(automato, estado):
    transicoes = automato['estados'][estado]['transicoes']

    it = 1
    buf = []
    for token, transicao in transicoes.items():
        buf.append(templates.TRANSICAO.format(name=automato['name'],
                                              estado=estado,
                                              it=it,
                                              saida=transicao['saida'],
                                              token=token))
        it += 1

    return ''.join(buf)

def generate_chamadas_code(automato, estado):
    chamadas = automato['estados'][estado]['chamadas']

    it = 1
    buf = []
    for first, transicao in chamadas.items():
        buf.append(templates.CHAMADA.format(name=automato['name'],
                                            estado=estado,
                                            it=it,
                                            saida=transicao['saida'],
                                            submaquina=transicao['transicao'],
                                            token=first))
        it += 1

    return ''.join(buf)
