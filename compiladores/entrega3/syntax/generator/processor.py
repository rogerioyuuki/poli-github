


def process(automato_list):
    automato_dict = dict(automato_list)

    for automato in automato_dict.values():
        automato['FIRST'] = list(FIRST(automato, automato_dict))

    return automato_dict


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
        elif transicao not in visited:
            first = first | FIRST(automato_dict[transicao], automato_dict, visited)

    return first
