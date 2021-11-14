tool
extends TextureButton
class_name ColorSwatch

onready var color_rect : Sprite = $ColorRect

export var color : = Color("ffffff") setget set_color

func set_color(value: Color) -> void:
    color = value
    if not color_rect:
        return
    color_rect.modulate = value

func _ready() -> void:
    self.color = color
