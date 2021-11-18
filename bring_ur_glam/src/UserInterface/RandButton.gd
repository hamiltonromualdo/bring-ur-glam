extends Button


func _on_Rand_button_down() -> void:
    $Sprite.modulate = "#004565"


func _on_Rand_button_up() -> void:
    $Sprite.modulate = "#0072a5"


func _on_Rand_mouse_entered() -> void:
    $Sprite.modulate = "#0072a5"


func _on_Rand_mouse_exited() -> void:
    $Sprite.modulate = "#005a82"
