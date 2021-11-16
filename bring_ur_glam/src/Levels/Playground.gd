extends Node2D

var Enemy = load("res://src/Actors/Enemy.tscn")
var enemiesInScreen = 1
var enemiesKilled = 0
var liveEnemies = 0

var total_hp = 100
var hp = 100

func _on_enemyDied() -> void:
    enemiesKilled += 1
    liveEnemies -= 1
    updateNumberOfEnemiesInScreen()
    $HUD.update_score(enemiesKilled)


func updateNumberOfEnemiesInScreen() -> void:
    enemiesInScreen = 1 if enemiesKilled <= 1 else ceil(log(enemiesKilled) / log(2))
    

func getFloorXBoundaries() -> Array:
    var floorMap = $WalkingPath
    var floorMapRect = floorMap.get_used_rect()
    
    return [floorMapRect.position.x * floorMap.cell_size.x + floorMap.position.x,
        floorMapRect.end.x * floorMap.cell_size.x + floorMap.position.x]
    

func getNewEnemyPosition(enemy: Enemy) -> Vector2:
    var floorXBoundaries = getFloorXBoundaries()
    var floorLeftLimit = floorXBoundaries[0]
    var floorRightLimit = floorXBoundaries[1]
    
    var viewportRect = get_viewport().get_visible_rect()
    var viewportOffset = abs(viewportRect.position.x - viewportRect.end.x)/2

    var spawnToLeft = (randi() % 2) == 0
    var posX = 0
    if spawnToLeft:
        posX = rand_range(floorLeftLimit, $Player.position.x - viewportOffset)
    else:
        posX = rand_range($Player.position.x + viewportOffset, floorRightLimit)

    var posY = $Player/Camera2D.limit_top
    
    return Vector2(posX, posY)


func instanceEnemy() -> void:
    var enemy = Enemy.instance()
    add_child(enemy)
    liveEnemies += 1

    enemy.position = getNewEnemyPosition(enemy)
    enemy.connect("died", self, "_on_enemyDied")
    enemy.move_and_collide(Vector2(0, 1000))


func checkAndInstanceEnemies():
    if liveEnemies == 0:
        for n in enemiesInScreen:
            instanceEnemy()


func _on_Player_hit() -> void:
    hp -= 10
    $HUD.update_hp(hp)
    if hp <= 0:
        $Player.die()
    

func _ready() -> void:
    $HUD.set_total_hp(total_hp)
    randomize()


func _process(delta) -> void:
    checkAndInstanceEnemies()
