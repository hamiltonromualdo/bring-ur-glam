extends Control


func _on_ChangeSceneButton_button_up() -> void:
    self.paused = false


func _on_Resume_button_up() -> void:
    self.paused = false
