import os
from . import generate

DIR = os.path.dirname(__file__)

print("Generating from WIRTH.txt")
generate(os.path.join(DIR, "WIRTH.txt"))
