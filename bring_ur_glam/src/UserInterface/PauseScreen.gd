extends Control

onready var resume_btn = $MarginContainer/VBoxContainer/Resume
onready var quit_btn = $MarginContainer/VBoxContainer/Quit
onready var restart_btn = $MarginContainer/VBoxContainer/Restart


func toggle_visibility() -> void:
    get_tree().paused = !get_tree().paused
    visible = !visible


func _ready() -> void:
    resume_btn.grab_focus()


func _process(delta: float) -> void:
    if Input.is_action_just_pressed("ui_cancel"):
        resume_btn.grab_focus()
        toggle_visibility()

    
func _on_Resume_pressed() -> void:
    toggle_visibility()
    
    
func _on_Quit_pressed() -> void:
    get_tree().quit()


func _on_Restart_pressed() -> void:
    toggle_visibility()
    get_tree().change_scene("res://src/UserInterface/CustomizePlayer.tscn")
