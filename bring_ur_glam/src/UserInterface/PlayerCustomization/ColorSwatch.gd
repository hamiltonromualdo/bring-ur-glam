tool
extends TextureButton
class_name ColorSwatch


onready var color_rect : Sprite = $ColorRect
onready var contour_sprite : Sprite = $Contour


export var color : = Color("ffffff") setget set_color
export var contour : = false setget set_contour


func set_color(value: Color) -> void:
    color = value
    if color_rect:
        color_rect.modulate = value


func set_contour(value: bool) -> void:
    contour = value
    if  contour_sprite:
        contour_sprite.visible = value


func _ready() -> void:
    self.color = color
    self.contour = contour
