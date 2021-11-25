extends Button
class_name ButtonWithSound


func _on_ButtonWithSound_focus_exited():
    $FocusSound.play()


func _on_ButtonWithSound_button_up():
    $PressedSound.play()
