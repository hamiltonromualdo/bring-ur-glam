extends Control


func _ready():
    $BackButton.grab_focus()

func _process(delta):
    if ($Credits.margin_top >= -539):
        $Credits.margin_top -= 0.2
    else:
        $Credits.set_margin(MARGIN_TOP, 100)
