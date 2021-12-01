extends Button


func _on_Rand_button_down() -> void:
    $Sprite.modulate = "#253664"


func _on_Rand_button_up() -> void:
    $Sprite.modulate = "#ffffff"


func _on_Rand_mouse_entered() -> void:
    $Sprite.modulate = "#ffffff"


func _on_Rand_mouse_exited() -> void:
    $Sprite.modulate = "#ffffff"
