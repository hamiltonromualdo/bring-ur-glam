extends Control

onready var label = $Label

func _ready():
    # Start with focus on RestartButton to allow keyboard control
    $MarginContainer/VBoxContainer/RestartButton.grab_focus()
    label.text = label.text % PlayerData.score
