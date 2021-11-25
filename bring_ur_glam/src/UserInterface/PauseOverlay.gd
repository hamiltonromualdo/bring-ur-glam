extends Control

onready var scene_tree: SceneTree = get_tree()

var paused: = false setget set_paused


func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("ui_cancel"):
        self.paused = not self.paused


func set_paused(value: bool) -> void:
    paused = value
    scene_tree.paused = value
    visible = value
    if visible:
        # Start with focus on ResumeButton to allow keyboard control
        $MarginContainer/VBoxContainer/ResumeButton.grab_focus()


func _on_ChangeSceneButton_button_up() -> void:
    yield($MarginContainer/VBoxContainer/RestartButton/PressedSound, "finished")
    self.paused = false


func _on_Resume_button_up() -> void:
    yield($MarginContainer/VBoxContainer/ResumeButton/PressedSound, "finished")
    self.paused = false

