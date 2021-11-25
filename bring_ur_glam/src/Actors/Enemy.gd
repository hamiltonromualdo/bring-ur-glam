class_name Enemy
extends KinematicBody2D

enum PlayerFinderSize {SMALL, MEDIUM, LARGE}

export (bool) var MOVING_ENEMY = true
export (int) var HP = 3
export (float) var SHOOTING_INTERVAL = 0.5
export (int) var SPEED = 50
export (int) var GRAVITY = 10
export (int) var JUMP_POWER = -250
export (PlayerFinderSize) var PLAYER_FINDER_SIZE = PlayerFinderSize.MEDIUM
export (PackedScene) var BULLET

signal died

const FLOOR = Vector2(0, -1)

export var score: = 1

export var DIRECTION = true
var velocity = Vector2.ZERO

var player = null
var canFire = true

func get_player_finder_size() -> Vector2:
    var values = {PlayerFinderSize.SMALL: Vector2(10, 10),
                  PlayerFinderSize.MEDIUM: Vector2(75, 25),
                  PlayerFinderSize.LARGE: Vector2(100, 25)}
    return values[PLAYER_FINDER_SIZE]

func set_direction(dir):
    DIRECTION = dir
    $Sprite.flip_h = !DIRECTION
    $EdgeDetector.position.x = abs($EdgeDetector.position.x)
    $Gun.set("position", Vector2(12, 0) if dir else Vector2(-12, 0))
    if !dir:
        $EdgeDetector.position.x *= -1

func _ready():
    $HealthBar.set_values(0, HP, HP)
    $ShootingTimer.wait_time = SHOOTING_INTERVAL
    $PlayerFinder/CollisionShape2D.shape.extents = get_player_finder_size()

func fire():
    if canFire:
        $Gun.fire(DIRECTION)
        $ShootingTimer.start()
        canFire = false

func hurt():
    HP -= 1
    $HealthBar.set_hp(HP)
    if HP <= 0:
        velocity = Vector2.ZERO
        $HealthBar.visible = false
        $CollisionShape2D.set_deferred("disabled", true)
        $DeathTimer.start()
        $Sprite.flip_v = true
        PlayerData.score += score
        emit_signal("died")

func _physics_process(_delta):
    if HP <= 0:
        return

    if player != null:
        velocity = position.direction_to(player.global_position) * SPEED
        velocity.y = 0
        velocity.normalized()
        set_direction(velocity.x >= 0)
    else:
        velocity.x = SPEED
        if not DIRECTION:
            velocity.x *= -1

    if player != null:
        fire()

    velocity.y += GRAVITY
    if not MOVING_ENEMY:
        velocity.x = 0
    velocity = move_and_slide(velocity, FLOOR)

    if is_on_wall() or not $EdgeDetector.is_colliding():
        if player == null:
            set_direction(!DIRECTION)

    if get_slide_count() > 0:
        for i in range(get_slide_count()):
            if "Player" in get_slide_collision(i).collider.name:
                get_slide_collision(i).collider.hurt()

func _on_DeathTimer_timeout():
    queue_free()

func _on_PlayerFinder_body_entered(body: Node) -> void:
    if body.name == "Player":
        player = body

func _on_PlayerFinder_body_exited(body: Node) -> void:
    if body.name == "Player":
        player = null

func _on_ShootingTimer_timeout() -> void:
    canFire = true
