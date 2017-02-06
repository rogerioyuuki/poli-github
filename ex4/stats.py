def average_queue_time(finish_list):
    n = len(finish_list)
    total_queue_time = sum([proc.start_time - proc.arrival_time
                            for proc in finish_list])
    return total_queue_time / n


def average_total_time(finish_list):
    n = len(finish_list)
    total_time = sum([proc.exit_time - proc.arrival_time
                      for proc in finish_list])
    return total_time / n


def average_queue_size(queue_stats):
    sum_qt = sum([queue_stats[size] * size for size in queue_stats])
    total_time = sum([queue_stats[size] for size in queue_stats])
    return sum_qt / total_time


def busy_percentage(processor_stats):
    empty = processor_stats["empty"]
    busy = processor_stats["busy"]
    return busy * 100 / (empty + busy)
