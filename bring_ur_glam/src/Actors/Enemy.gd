class_name Enemy
extends KinematicBody2D


export var SPEED = 50
export var GRAVITY = 10
export var JUMP_POWER = -250
export var HP = 3
export (PackedScene) var BULLET

const FLOOR = Vector2(0, -1)


export var DIRECTION = true
var velocity = Vector2.ZERO

var player = null
var canFire = true


func set_direction(dir):
    DIRECTION = dir
    $Sprite.flip_h = !DIRECTION
    $EdgeDetector.position.x = abs($EdgeDetector.position.x)
    $Muzzle.set("position", Vector2(12, 0) if dir else Vector2(-12, 0))
    if !dir:
        $EdgeDetector.position.x *= -1

func _ready():
    $HealthBar.set_values(0, HP, HP)

func fire():
    if canFire:
        var b = BULLET.instance()
        b.set_fireball_direction(DIRECTION)
        owner.add_child(b)
        # TODO should use position or transform?
        #b.position = $Muzzle.global_position
        b.transform = $Muzzle.global_transform
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

func _physics_process(delta):
    if HP <= 0:
        return

    if player != null:
        velocity = position.direction_to(player.position) * SPEED
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
