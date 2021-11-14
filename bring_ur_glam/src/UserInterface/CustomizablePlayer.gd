extends Node2D

onready var hairSprite = $CompositionalSprites/Hair
onready var dressSprite = $CompositionalSprites/Dress
onready var shoesSprite = $CompositionalSprites/Shoes
onready var gunSprite = $CompositionalSprites/Gun
onready var bodySprite = $CompositionalSprites/Body

var hairIndex = 0
var hair_spritesheet = {
    0: preload("res://assets/player/hair_1.png"),
    1: preload("res://assets/player/hair_2.png"),
    2: preload("res://assets/player/hair_3.png"),
    3: preload("res://assets/player/hair_4.png"),
}
var dress_spritesheet = preload("res://assets/player/dress_1.png")
var shoes_spritesheet = preload("res://assets/player/shoes_1.png")
var gun_spritesheet = preload("res://assets/player/gun_1.png")
var body_spritesheet = preload("res://assets/player/body_1.png")

func rand_color() -> Color:
    return Color(randf(), randf(), randf())

func set_hair_color(color: Color) -> void:
    hairSprite.modulate = color
    $HairColorPicker.color = color

func set_dress_color(color: Color) -> void:
    dressSprite.modulate = color
    $DressColorPicker.color = color

func set_shoes_color(color: Color) -> void:
    shoesSprite.modulate = color
    $ShoesColorPicker.color = color

func set_gun_color(color: Color) -> void:
    gunSprite.modulate = color
    $GunColorPicker.color = color

func set_body_color(color: Color) -> void:
    bodySprite.modulate = color
    $BodyColorPicker.color = color

func change_hair(incr: int) -> void:
    hairIndex = posmod(hairIndex + incr, len(hair_spritesheet))
    hairSprite.texture = hair_spritesheet[hairIndex]

func randomize_char() -> void:
    change_hair(randi())
    set_hair_color(rand_color())
    set_dress_color(rand_color())
    set_shoes_color(rand_color())
    set_gun_color(rand_color())
    set_body_color(rand_color())

func _ready() -> void:
    randomize_char()

func _on_HairChangeLeft_pressed() -> void:
    change_hair(-1)

func _on_HairChangeRight_pressed() -> void:
    change_hair(1)
    
func _on_HairColorPicker_color_changed(color: Color) -> void:
    set_hair_color(color)

func _on_DressColorPicker_color_changed(color: Color) -> void:
    set_dress_color(color)

func _on_ShoesColorPicker_color_changed(color: Color) -> void:
    set_shoes_color(color)

func _on_GunColorPicker_color_changed(color: Color) -> void:
    set_gun_color(color)

func _on_BodyColorPicker_color_changed(color: Color) -> void:
    set_body_color(color)

func _on_Rand_pressed() -> void:
    randomize_char()
