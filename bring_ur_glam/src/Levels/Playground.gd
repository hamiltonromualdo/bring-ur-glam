extends Node2D

const FIREBALL = preload("res://src/Objects/HeartAmmo.tscn")

func _process(delta):
	if Input.is_action_just_pressed("ui_shoot"):
		var playerPosition = $Person.DIRECTION
		
		var fireball = FIREBALL.instance()
		fireball.set_fireball_direction(playerPosition)
		get_parent().add_child(fireball)
		fireball.position = $Person/Position2D.global_position
