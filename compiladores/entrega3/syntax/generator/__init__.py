import json
from .parser import get_automatos
from .processor import process


def generate(wirth_path):
    with open(wirth_path, 'r') as file:
        automatos = get_automatos(file.read())

    process(automatos)

    with open("test.json", 'w') as file:
        json.dump(automatos, file, indent=4)
