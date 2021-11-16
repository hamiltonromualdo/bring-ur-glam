extends Camera2D

onready var prev_camera_pos = get_camera_position()
onready var tween = $Tween

const LOOK_AHEAD_FACTOR = 0.2
const SHIFT_TRANS = Tween.TRANS_SINE
const SHIFT_EASE = Tween.EASE_OUT
const SHIFT_DURATION = 1.0
var facing = 0


func _process(delta: float) -> void:
    _check_facing()
    prev_camera_pos = get_camera_position()


func _check_facing() -> void:
    var new_facing = sign(get_camera_position().x - prev_camera_pos.x)
    if new_facing != 0 && facing != new_facing:
        facing = new_facing
        var target_offset = get_viewport_rect().size.x * facing * LOOK_AHEAD_FACTOR
        tween.interpolate_property(self, "position:x", position.x, target_offset, SHIFT_DURATION, SHIFT_TRANS, SHIFT_EASE)
        tween.start()


func _on_Player_grounded_updated(is_grounded) -> void:
    drag_margin_v_enabled = !is_grounded
