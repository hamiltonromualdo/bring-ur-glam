extends Control

onready var resume_btn = $MarginContainer/VBoxContainer/Resume
onready var quit_btn = $MarginContainer/VBoxContainer/Quit

func toggle_visibility():
    get_tree().paused = !get_tree().paused
    visible = !visible

func _ready():
    resume_btn.grab_focus()
    quit_btn.grab_focus()

func _process(delta):
    if resume_btn.is_hovered():
        resume_btn.grab_focus()
    if quit_btn.is_hovered():
        quit_btn.grab_focus()

func _input(event):
    if event.is_action_pressed("ui_cancel"):
        resume_btn.grab_focus()
        toggle_visibility()

func _on_Resume_pressed():
    toggle_visibility()

func _on_Exit_pressed():
    get_tree().quit()


func _on_Restart_pressed() -> void:
    toggle_visibility()
    get_tree().change_scene("res://src/UserInterface/CustomizePlayer.tscn")
