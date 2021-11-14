extends KinematicBody2D

export var SPEED = 100
export var GRAVITY = 10
export var JUMP_POWER = -250
const FLOOR = Vector2(0, -1)

export var DIRECTION = true
var velocity = Vector2.ZERO

export var HP = 3

func _ready():
    $HealthBar.set_values(0, HP, HP)

func hurt():
    HP -= 1
    $HealthBar.set_hp(HP)
    if HP <= 0:
        velocity = Vector2.ZERO
        $HealthBar.visible = false
        $CollisionShape2D.set_deferred("disabled", true)
        $DeathTimer.start()
        $Sprite.flip_v = true

func _physics_process(delta):
    if HP <= 0:
        return

    velocity.x = SPEED
    if not DIRECTION:
        velocity.x *= -1

    velocity.y += GRAVITY
    velocity = move_and_slide(velocity, FLOOR)
    
    if is_on_wall() or not $EdgeDetector.is_colliding():
        DIRECTION = !DIRECTION
        $Sprite.flip_h = !DIRECTION
        $EdgeDetector.position.x *= -1


func _on_DeathTimer_timeout():
    queue_free()
