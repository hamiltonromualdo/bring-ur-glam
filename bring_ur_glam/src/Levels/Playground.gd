extends Node2D

export (PackedScene) var KEY

var can_go_to_next = false

func _on_DoorArea_body_entered(_body):
    if can_go_to_next:
        var error = get_tree().change_scene("res://src/Levels/EndGame.tscn")
        if error:
            print("Error in door enter: ", error)
    else:
        $HelpMessage.visible = true
        $HelpTimer.start()


func _on_Enemy15_died() -> void:
    # This is a special enemy that will spawn a key to the door
    var key = KEY.instance()
    key.position = Vector2(1947.932, 166.945)
    key.set_as_toplevel(true)
    add_child(key)
    
    $Tween.interpolate_property(key, "scale", Vector2(1, 1), Vector2(1.5, 1.5), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN)
    $Tween.interpolate_property(key, "scale", Vector2(1.5, 1.5), Vector2(1, 1), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN, 0.1)
    $Tween.start()
    
    can_go_to_next = true


func _on_HelpTimer_timeout() -> void:
    $HelpMessage.visible = false
