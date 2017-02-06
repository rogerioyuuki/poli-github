
from random import uniform, triangular


def get_arrival_interval():
    return uniform(0.5, 1.5)


def get_processing_time():
    return triangular(low=0, high=60, mode=30)
