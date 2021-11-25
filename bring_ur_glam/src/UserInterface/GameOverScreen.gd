extends Control


func _ready():
    # Start with focus on RestartButton to allow keyboard control
    $PauseOverlay/MarginContainer/VBoxContainer/RestartButton.grab_focus()
