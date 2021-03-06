class_name PickableItem
extends Area2D

const up_limit = 4
const down_limit = -4

const SPRITE = {
    PickableItemType.Type.Star: preload("res://assets/objects/star.png"),
    PickableItemType.Type.Heart: preload("res://assets/objects/heart.png"),
    PickableItemType.Type.Unicorn: preload("res://assets/objects/unicorn.png"),
    PickableItemType.Type.Shield: preload("res://assets/objects/shield.png"),
    PickableItemType.Type.Rainbow: preload("res://assets/objects/rainbow.png"),
    PickableItemType.Type.Key: preload("res://assets/objects/key.png"),
}


export (float) var initial_pos = 0
export (float) var step = 0.25
export (PickableItemType.Type) var type = PickableItemType.Type.Star
signal picked(instance_id)


func _incr_position(pos: float) -> void:
    $Sprite.position.y += pos
    $CollisionShape2D.position.y += pos
    $Bubble.position.y += pos


func _ready() -> void:
    $Sprite.texture = SPRITE[type]
    initial_pos = $Sprite.position.y


func _on_Star_body_entered(_body: Node) -> void:
    $Bubble.pop()
    $AudioStreamPlayer2D.play()


func _on_Bubble_animation_finished() -> void:
    emit_signal("picked", get_instance_id())
    queue_free()


func _process(_delta: float) -> void:
    var pos = initial_pos - $Sprite.position.y
    if pos >= up_limit or pos <= down_limit:
        step *= -1
    _incr_position(step)
    $Shadow.scale.x += step/10
