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
    arrival_time = None
    start_time = None
    exit_time = None

    def __init__(self, t):
        self.arrival_time = t
        self.processing_time = distributions.get_processing_time()


class Processor(object):
    empty = True
    proc = None
    end_time = None
    stats = {"empty": 0, "busy": 0}
    finish_list = []

    def start(self, t, proc):
        # stats
        proc.start_time = t
        # set state
        self.empty = False
        self.proc = proc
        self.end_time = t + proc.processing_time

    def finish(self, t):
        # stats
        self.proc.exit_time = t
        self.finish_list.append(self.proc)
        # set state
        self.empty = True
        self.proc = None
        self.end_time = None

    def add_time(self, t):
        if self.empty:
            self.stats["empty"] += t
        else:
            self.stats["busy"] += t
