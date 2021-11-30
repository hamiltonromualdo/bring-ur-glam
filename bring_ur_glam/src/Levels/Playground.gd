extends Node2D

func _on_DoorArea_body_entered(_body):
    var error = get_tree().change_scene("res://src/Levels/EndGame.tscn")
    if error:
        print("Error in door enter: ", error)
