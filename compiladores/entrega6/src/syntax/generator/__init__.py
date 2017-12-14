import os
import json
from .parser import get_automatos
from .processor import preprocess, generate_code


def generate(wirth_path, save_dir):
    with open(wirth_path, 'r') as file:
        print("Getting automatos from WIRTH")
        automatos = get_automatos(file.read())

    print("Preprocessing automatos...")
    automatos = preprocess(automatos)

    with open(os.path.join(save_dir, "debug.json"), 'w') as file:
        json.dump(automatos, file, indent=4)

    with open(os.path.join(save_dir, "create_ape.c"), 'w') as file:
        print("Writing to create_ape.c...")
        file.write(generate_code(automatos))
