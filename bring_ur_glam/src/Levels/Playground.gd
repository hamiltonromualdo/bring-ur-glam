extends Node2D

var Enemy = load("res://src/Actors/Enemy.tscn")
var enemiesInScreen = 1
var enemiesKilled = 0
var liveEnemies = 0

export (bool) var ENABLE_ENEMY_SPAWN = true

func _on_enemyDied() -> void:
    enemiesKilled += 1
    liveEnemies -= 1
    update_number_of_enemies_in_screen()


func update_number_of_enemies_in_screen() -> void:
    enemiesInScreen = 1 if enemiesKilled <= 1 else int(ceil(log(enemiesKilled) / log(2)))


func get_floor_x_boundaries() -> Array:
    var floorMap = $WalkingPath
    var floorMapRect = floorMap.get_used_rect()

    return [floorMapRect.position.x * floorMap.cell_size.x + floorMap.position.x,
        floorMapRect.end.x * floorMap.cell_size.x + floorMap.position.x]


func get_new_enemy_position(enemy: Enemy) -> Vector2:
    var floorXBoundaries = get_floor_x_boundaries()
    var floorLeftLimit = floorXBoundaries[0]
    var floorRightLimit = floorXBoundaries[1]

    var viewportRect = get_viewport().get_visible_rect()
    var viewportOffset = abs(viewportRect.position.x - viewportRect.end.x)/2

    var spawnToLeft = (randi() % 2) == 0
    var posX = 0
    var enemyOffset = abs(enemy.get_viewport_rect().position.x - enemy.get_viewport_rect().end.x)/2
    if spawnToLeft:
        posX = rand_range(floorLeftLimit + enemyOffset, $Player.position.x - viewportOffset)
    else:
        posX = rand_range($Player.position.x + viewportOffset, floorRightLimit - enemyOffset)

    var posY = $Player/Camera2D.limit_top

    return Vector2(posX, posY)


func instance_enemy() -> void:
    var enemy = Enemy.instance()
    add_child(enemy)
    liveEnemies += 1

    enemy.position = get_new_enemy_position(enemy)
    enemy.connect("died", self, "_on_enemyDied")
    enemy.move_and_collide(Vector2(0, 1000))


func check_and_instance_enemies():
    if liveEnemies == 0:
        for n in enemiesInScreen:
            instance_enemy()


func _ready() -> void:
    randomize()


func _process(_delta) -> void:
    if ENABLE_ENEMY_SPAWN:
        check_and_instance_enemies()
