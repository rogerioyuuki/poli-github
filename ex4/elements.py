from collections import deque
import distributions


class FIFO(object):
    q = deque()
    stats = {}

    @property
    def empty(self):
        return len(self.q) == 0

    def push(self, el):
        self.q.appendleft(el)

    def pop(self):
        return self.q.pop()

    def add_time(self, t):
        # Collect statistics
        try:
            self.stats[len(self.q)] += t
        except:
            self.stats[len(self.q)] = t


class Process(object):
    def __init__(self):
        self.processing_time = distributions.get_processing_time()


class Processor(object):
    empty = True
    proc = None
    end_time = None
    stats = {"empty": 0, "busy": 0}

    def start(self, t, proc):
        self.empty = False
        self.proc = proc
        self.end_time = t + proc.processing_time

    def finish(self):
        self.empty = True
        self.proc = None
        self.end_time = None

    def add_time(self, t):
        if self.empty:
            self.stats["empty"] += t
        else:
            self.stats["busy"] += t
