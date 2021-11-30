tool
extends Node2D

export var win_scene: PackedScene
export var totalEnemies: = 50

func _get_configuration_warning() -> String:
    return "Win scene is unset" if not win_scene else ""


var Enemy = load("res://src/Actors/Enemy.tscn")
var enemiesLeft = totalEnemies
var liveEnemies = 0
var enemiesSpawned = 0
var rng = RandomNumberGenerator.new()


func linear_interpolate(from: float, to: float, inclination: float) -> float:
    return from + (to - from) * inclination


# Enemies get increasingly more difficult with spawn number.
# Here we use linear interpolation in ranges for each setting
func set_enemy_spec(enemy: Enemy) -> void:
    # Forcing float division by making one of te arguments a float
    var inclination = float(enemiesSpawned)/(totalEnemies - 1)
    
    enemy.HP = int(round(linear_interpolate(1, 4, inclination)))
    enemy.SPEED = linear_interpolate(10, 75, inclination)
    enemy.SHOOTING_INTERVAL = linear_interpolate(1.2, 0.6, inclination)


func _on_enemyDied() -> void:
    liveEnemies -= 1
    enemiesLeft -= 1
    update_enemies_count()
    if enemiesLeft == 0:
        win()


func win() -> void:
    var error = get_tree().change_scene_to(win_scene)
    if error:
        print("Error changing scene: ", error)


func update_enemies_count() -> void:
    $EnemiesCountLayer/EnemiesCount.text = "{enemiesLeft}/{totalEnemies}".format({"enemiesLeft": enemiesLeft, "totalEnemies": totalEnemies})


func enemies_to_spawn() -> int:
    var inclination = float(enemiesSpawned)/(totalEnemies - 1)
    var enemiesThatShouldBeOnScreen = int(round(linear_interpolate(5, 10, inclination)))
    return int(clamp(enemiesThatShouldBeOnScreen - liveEnemies, 0, enemiesLeft))


func get_player_camera_rect() -> Rect2:
    # Get the canvas transform
    var ctrans = $Player/Camera2D.get_canvas_transform()

    # The canvas transform applies to everything drawn,
    # so scrolling right offsets things to the left, hence the '-' to get the world position.
    # Same with zoom so we divide by the scale.
    var min_pos = -ctrans.get_origin() / ctrans.get_scale()

    # The maximum edge is obtained by adding the rectangle size.
    # Because it's a size it's only affected by zoom, so divide by scale too.
    var view_size = get_viewport_rect().size / ctrans.get_scale()

    return Rect2(min_pos, view_size)


func is_point_in_camera(pos: Vector2) -> bool:
    var viewportRect = get_player_camera_rect()
    return viewportRect.has_point(pos)


func is_point_in_building_tile_map(pos: Vector2) -> bool:
    var tilePos = $Buildings.world_to_map(pos)
    return $Buildings.get_cell(tilePos.x, tilePos.y) != TileMap.INVALID_CELL


func get_random_pos() -> Vector2:
    var possibleXValues = range(0, 400)
    var possibleYValues = range(-400, 200)

    var posX = possibleXValues[rng.randi() % possibleXValues.size()]
    var posY = possibleYValues[rng.randi() % possibleYValues.size()]
    return Vector2(posX, posY)


func get_new_enemy_position() -> Vector2:
    var enemyPos = get_random_pos()
    while is_point_in_camera(enemyPos) or !is_point_in_building_tile_map(enemyPos):
        enemyPos = get_random_pos()

    print("Instanced enemy at X: {x} Y: {y}".format({"x": enemyPos.x, "y": enemyPos.y}))
    return enemyPos


func instance_enemy() -> void:
    if liveEnemies < enemiesLeft:
        var enemy = Enemy.instance()
        set_enemy_spec(enemy)
        enemy.set_global_position(get_new_enemy_position())
        enemy.connect("died", self, "_on_enemyDied")

        add_child(enemy)
        liveEnemies += 1
        enemiesSpawned += 1

        print(
            "Instanced enemy {num} with HP: {hp} Speed: {speed} Shooting Interval {shoot}".format({
                "num": enemiesSpawned,
                "hp": enemy.HP,
                "speed": enemy.SPEED,
                "shoot": enemy.SHOOTING_INTERVAL
            })
        )


func check_and_instance_enemies():
    var enemiesToSpawn = enemies_to_spawn()
    for n in enemiesToSpawn:
        instance_enemy()


func set_camera_limits() -> void:
    $Player/Camera2D.limit_left = 0
    $Player/Camera2D.limit_right = 400
    $Player/Camera2D.limit_top = -300


func _ready() -> void:
    rng.randomize()
    set_camera_limits()
    update_enemies_count()
    check_and_instance_enemies()


func _on_EnemyTimer_timeout():
    check_and_instance_enemies()
    $EnemyTimer.start()
