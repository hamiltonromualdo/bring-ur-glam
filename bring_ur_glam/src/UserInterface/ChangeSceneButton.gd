tool
extends ButtonWithSound

export var next_scene: PackedScene

func _on_button_up() -> void:
    yield($PressedSound, "finished")
    PlayerData.reset()
    var error = get_tree().change_scene_to(next_scene)
    if error:
        print("Error changing scene: ", error)

func _get_configuration_warning() -> String:
    return "Next scene is unset" if not next_scene else ""
