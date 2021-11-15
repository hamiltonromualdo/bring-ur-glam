extends Area2D

export var DIRECTION = false

const SPEED = 150
var velocity = Vector2()


func _ready() -> void:
    $HeartSound.play()
    
    
func _on_Bullet_body_entered(body) -> void:
    if body is Enemy or body is Player:
        body.hurt()
    queue_free()


func _on_VisibilityNotifier2D_screen_exited() -> void:
    queue_free()


func _physics_process(delta: float) -> void:
    velocity.x = SPEED * delta
    if not DIRECTION:
        velocity.x *= -1
    translate(velocity)


func set_fireball_direction(dir: bool) -> void:
    DIRECTION = dir
    $Sprite.flip_h = !dir
