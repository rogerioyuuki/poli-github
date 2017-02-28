# -*- coding: utf-8 -*-
import distributions
import events
import elements
import stats


class Simulation(object):
    t = 0
    max_run_time = 0
    queue = elements.FIFO()
    processor = elements.Processor()
    arrival_events = []
    finish_event = None

    def __init__(self, max_run_time):
        self.max_run_time = max_run_time
        # Prepopulate arrival events
        t = 0
        while t < max_run_time + 10:
            self.arrival_events.append(events.Arrival(t))
            t += distributions.get_arrival_interval()

    def run(self):
        while self.t < self.max_run_time:
            self.iterate()

    def iterate(self):
        next_event = self.get_next_event()
        if next_event.tipo == "arrival":
            self.treat_arrival(next_event.t)
        else:
            self.treat_finish(next_event.t)

    def treat_arrival(self, arrival_time):
        self.jmp_time(arrival_time)
        if self.processor.empty:
            self.processor.start(self.t, elements.Process(self.t))
            self.finish_event = events.Finish(self.processor.end_time)
        else:
            self.queue.push(elements.Process(self.t))

    def treat_finish(self, finish_time):
        self.jmp_time(finish_time)
        self.processor.finish(self.t)
        self.finish_event = None
        if not self.queue.empty:
            self.processor.start(self.t, self.queue.pop())
            self.finish_event = events.Finish(self.processor.end_time)

    def jmp_time(self, t):
        self.queue.add_time(t - self.t)
        self.processor.add_time(t - self.t)
        self.t = t

    def get_next_event(self):
        if self.finish_event is None:
            return self.arrival_events.pop(0)
        if self.finish_event.t < self.arrival_events[0].t:
            return self.finish_event
        else:
            return self.arrival_events.pop(0)


def main(max_run_time):
    sim = Simulation(max_run_time)
    sim.run()
    print("Quantidade de processos executados: " +
          str(len(sim.processor.finish_list)))
    print("Tempo médio de fila: " +
          str(stats.average_queue_time(sim.processor.finish_list)))
    print("Tempo médio no sistema: " +
          str(stats.average_total_time(sim.processor.finish_list)))
    print("Tamanho médio da fila: " +
          str(stats.average_queue_size(sim.queue.stats)))
    print("Porcentagem de utilização: " +
          str(stats.busy_percentage(sim.processor.stats)) + "%")

if __name__ == "__main__":
    main(max_run_time=3600)
