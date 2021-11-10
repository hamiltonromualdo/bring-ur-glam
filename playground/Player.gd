extends KinematicBody2D

#export var ACCELERATION = 500
#export var MAX_SPEED = 200
#export var FRICTION = 1000

export var SPEED = 150
export var GRAVITY = 10
export var JUMP_POWER = -250
const FLOOR = Vector2(0, -1)

export var DIRECTION = true
var velocity = Vector2.ZERO

onready var animationPlayer = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _ready():
    animationTree.active = true
    
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
            $Position2D.set("position", Vector2(24, 16))
        else:
            $Position2D.set("position", Vector2(-24, 16))
        animationTree.set("parameters/Walk/blend_position", velocity.x)
        animationTree.set("parameters/Idle/blend_position", velocity.x)
        animationState.travel("Walk")
    else:
        animationState.travel("Idle")
    
    velocity.y += GRAVITY
    
    velocity = move_and_slide(velocity, FLOOR)
    

#func _process(delta):
#	var input_vector = Vector2.ZERO
#	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
#	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
#	input_vector = input_vector.normalized()
#
#	if input_vector != Vector2.ZERO:
#		DIRECTION = input_vector.x > 0
#		if DIRECTION:
#			$Position2D.set("position", Vector2(24, 16))
#		else:
#			$Position2D.set("position", Vector2(-24, 16))
#		animationTree.set("parameters/Walk/blend_position", input_vector.x)
#		animationTree.set("parameters/Idle/blend_position", input_vector.x)
#		animationState.travel("Walk")
#		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
#	else:
#		animationState.travel("Idle")		
#		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
#
#	velocity = move_and_slide(velocity)
