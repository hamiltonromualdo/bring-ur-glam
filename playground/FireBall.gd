extends Area2D

export var DIRECTION = false

const SPEED = 200
var velocity = Vector2()

func _ready():
    pass # Replace with function body.

func _physics_process(delta):
    velocity.x = SPEED * delta
    if not DIRECTION:
        velocity.x *= -1
    translate(velocity)

func set_fireball_direction(dir):
    DIRECTION = dir
    $Sprite.flip_h = !dir

func _on_VisibilityNotifier2D_screen_exited():
    queue_free()


func _on_FireBall_body_entered(body):
    queue_free()
