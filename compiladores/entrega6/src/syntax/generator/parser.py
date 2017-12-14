import requests
import lxml.html


URL = "http://mc-barau.herokuapp.com/"


def get_automatos(wirth):
    mcbarau_html = get_mcbarau(wirth)

    automatos = [(name, parse_automato(name, aut)) for name, aut in parse_html(mcbarau_html)]

    return automatos


def get_mcbarau(wirth):
    response = requests.get(URL)

    if response.status_code != 200:
        response.raise_for_status()

    page = lxml.html.fromstring(response.text)
    
    cookies = response.cookies
    params = dict(page.forms[0].form_values())
    params['commit'] = 'Mark States'
    params['wirth_notation'] = wirth

    result = requests.post(URL, cookies=cookies, data=params)

    if result.status_code != 200:
        result.raise_for_status()

    return result.text


def parse_html(htmlstring):
    html = lxml.html.fromstring(htmlstring)

    # h3 antes de div.automatas
    xpath_title = 'body/div[@class="automatas"]/preceding::h3'

    # <pre> dentro de <div> ao lado de h4 que tem "Minimized DFA" dentro de div.automatas após h3
    xpath_definition = 'body/h3/following-sibling::*[1]/self::div[@class="automatas"]/h4[contains(text(), "Minimized DFA")]/following-sibling::*[1]/self::div/pre'
    
    elements_of_interest = html.xpath('{} | {}'.format(xpath_title, xpath_definition))
    values_list = [el.text_content() for el in elements_of_interest]
    iterable = iter(values_list)

    return tuple(zip(iterable, iterable))


def parse_automato(name, automato_str):
    automato = automato_str.strip().split("\n")

    inicial = automato[0].replace('initial: ', '')
    final = [final.strip() for final in automato[1].replace('final: ', '').split(',')]

    regras = automato[2:]

    return {'name': name, 'inicial': inicial, 'final': final, 'regras': [parse_regras(r) for r in regras]}


def parse_regras(regra):
    entrada, saida = regra.split(" -> ")

    estado, transicao = entrada.strip('()').split(', ')

    return {'estado': estado, 'transicao': transicao, 'saida': saida}
