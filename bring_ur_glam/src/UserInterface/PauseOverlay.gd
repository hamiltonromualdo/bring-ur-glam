extends Control

onready var scene_tree: SceneTree = get_tree()

var paused: = false setget set_paused


func _unhandled_input(event: InputEvent) -> void:
    if event.is_action_pressed("ui_cancel"):
        # If the sound control node is visible, esc should return
        # to the pause screen
        if $SoundControl.visible:
            $SoundControl.visible = false
        elif $HowToPlay.visible:
            $HowToPlay.visible = false
        else:
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



func _on_SoundControlButton_pressed() -> void:
    $SoundControl.visible = true


func _on_HowToPlayButton_pressed() -> void:
    $HowToPlay.visible = true
