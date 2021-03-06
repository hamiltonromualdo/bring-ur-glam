extends Control
class_name HealthBar

func set_values(min_value, max_value, value):
    $ProgressBar.min_value = min_value
    $ProgressBar/ProgressBar2.min_value = min_value
    $ProgressBar.max_value = max_value
    $ProgressBar/ProgressBar2.max_value = max_value
    $ProgressBar.value = value
    $ProgressBar/ProgressBar2.value = value

func set_hp(value_to_set):
    $ProgressBar.value = value_to_set
    $ProgressBar/Timer.start()

func _ready():
    set_process(false)

func _process(_delta):
    $ProgressBar/ProgressBar2.value = lerp($ProgressBar/ProgressBar2.value, $ProgressBar.value, 0.1)
    if ($ProgressBar/ProgressBar2.value - $ProgressBar.value <= 5):
        $ProgressBar/ProgressBar2.value = $ProgressBar.value
        set_process(false)
        $ProgressBar/Timer.stop()

func _on_Timer_timeout():
    set_process(true)
