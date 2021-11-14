extends KinematicBody2D

export var SPEED = 100
export var GRAVITY = 10
export var JUMP_POWER = -250
const FLOOR = Vector2(0, -1)
export var HP = 10

export var DIRECTION = true
var velocity = Vector2.ZERO


func _on_EnemyDetector_body_entered(body: PhysicsBody2D) -> void:
    hurt()


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
    if Input.is_action_pressed("ui_right"):
        velocity.x = SPEED
    elif Input.is_action_pressed("ui_left"):
        velocity.x = -SPEED
    else:
        velocity.x = 0
    
    if is_on_floor() and Input.is_action_pressed("ui_jump"):
        velocity.y = JUMP_POWER
    
    if velocity.x != 0:
        DIRECTION = velocity.x > 0
        if DIRECTION:
            $Position2D.set("position", Vector2(12, 10))
            $Sprite.flip_h = false
        else:
            $Position2D.set("position", Vector2(-12, 10))
            $Sprite.flip_h = true
        $AnimationPlayer.play("Walk")
    else:
        $AnimationPlayer.play("Idle")

    if velocity.y != 0:
        $AnimationPlayer.play("Up")

    velocity.y += GRAVITY

    velocity = move_and_slide(velocity, FLOOR)

func _on_DeathTimer_timeout():
    queue_free()
