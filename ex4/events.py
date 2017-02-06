class Event(object):
    t = None

    def __init__(self, t):
        self.t = t


class Arrival(Event):
    tipo = "arrival"


class Finish(Event):
    tipo = "finish"
