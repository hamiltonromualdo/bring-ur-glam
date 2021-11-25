extends Camera2D

onready var prev_camera_pos = get_camera_position()

const LOOK_AHEAD_FACTOR = 0.2
const SHIFT_TRANS = Tween.TRANS_SINE
const SHIFT_EASE = Tween.EASE_OUT
const SHIFT_DURATION = 1.0
var facing = 0


func _process(_delta: float) -> void:
    prev_camera_pos = get_camera_position()


func _on_Player_grounded_updated(is_grounded) -> void:
    drag_margin_v_enabled = !is_grounded
