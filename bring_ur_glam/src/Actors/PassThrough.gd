extends Area2D


func _on_PassThrough_body_exited(body: Node) -> void:
    if body.get_collision_layer_bit(4) and not get_parent().get_collision_mask_bit(4):
        get_parent().set_collision_mask_bit(4, true)
