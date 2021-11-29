class_name Star
extends Area2D

const up_limit = 4
const down_limit = -4
var initial_pos = 0
var step = 0.25

func _incr_position(pos: float) -> void:
    $Sprite.position.y += pos
    $CollisionShape2D.position.y += pos
    $Bubble.position.y += pos


func _ready() -> void:
    initial_pos = $Sprite.position.y


func _on_Star_body_entered(_body: Node) -> void:
    $Bubble.pop()
    $AudioStreamPlayer2D.play()


func _on_Bubble_animation_finished() -> void:
    queue_free()


func _process(_delta: float) -> void:
    var pos = initial_pos - $Sprite.position.y
    if pos >= up_limit or pos <= down_limit:
        step *= -1
    _incr_position(step)
    $Shadow.scale.x += step/10
