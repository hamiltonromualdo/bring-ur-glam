class_name Player
extends KinematicBody2D

export (bool) var GODNESS_MODE = false

export var SPEED = 100.0
export var GRAVITY = 10.0
export var JUMP_POWER = -250.0
const FLOOR = Vector2(0, -1)

export var DIRECTION = true
var _velocity = Vector2.ZERO

onready var animationPlayer = $PlayerImages/AnimationPlayer
onready var sprite = $PlayerImages

var is_grounded
signal grounded_updated(is_grounded)

func _on_EnemyDetector_body_entered(body: PhysicsBody2D) -> void:
    hurt()


func _on_DeathTimer_timeout() -> void:
    queue_free()
    # Go to game over screen
    get_tree().change_scene("res://src/UserInterface/GameOverScreen.tscn")


func _ready() -> void:
    $PlayerImages.load_data()


func die():
    _velocity = Vector2.ZERO
    $CollisionShape2D.set_deferred("disabled", true)
    $DeathTimer.start()
    sprite.flip_v(true)


func hurt():
    if GODNESS_MODE:
        return
    PlayerData.hp -= 10
    if PlayerData.hp <= 0:
        die()


func get_x_input() -> float:
    if Input.is_action_pressed("ui_right"):
        return SPEED
    elif Input.is_action_pressed("ui_left"):
        return -SPEED
    else:
        return 0.0


func get_y_input(velocity: Vector2) -> float:
    if is_on_floor() and Input.is_action_pressed("ui_jump"):
        return JUMP_POWER
    else:
        return velocity.y


func get_input_velocity(velocity: Vector2) -> Vector2:
    return Vector2(get_x_input(), get_y_input(velocity))


func set_gun_barrel(is_right: bool) -> void:
    if is_right:
        $Gun.set("position", Vector2(12, 10))
    else:
        $Gun.set("position", Vector2(-12, 10))


func update_direction(is_right: bool) -> void:
    DIRECTION = is_right
    set_gun_barrel(is_right)
    sprite.flip_h(!is_right)


func set_animation(velocity: Vector2) -> void:
    if velocity.x != 0:
        update_direction(velocity.x > 0)
        animationPlayer.play("Walk")
    else:
        animationPlayer.play("Idle")

    if velocity.y != 0:
        animationPlayer.play("Up")


func _physics_process(delta: float) -> void:
    var new_velocity = get_input_velocity(_velocity)
    set_animation(new_velocity)

    if Input.is_action_just_pressed("ui_shoot"):
        $Gun.fire(DIRECTION)

    new_velocity.y += GRAVITY

    _velocity = move_and_slide(new_velocity, FLOOR)

    var was_grounded = is_grounded
    is_grounded = is_on_floor()

    if was_grounded == null || is_grounded != was_grounded:
        emit_signal("grounded_updated", is_grounded)
