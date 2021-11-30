extends Control


var TIMEOUT = 5


func start() -> void:
    $ProgressBar.max_value = TIMEOUT*100
    $ProgressBar.value = TIMEOUT*100
    $Timer.wait_time = TIMEOUT
    $Timer.start()


func _process(delta: float) -> void:
    $ProgressBar.value = $Timer.time_left*100
