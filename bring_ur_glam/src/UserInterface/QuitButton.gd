extends ButtonWithSound

func _on_button_up() -> void:
    yield($PressedSound, "finished")
    get_tree().quit()
