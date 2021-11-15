extends Node2D

onready var hairSprite = $PlayerImages/CompositionalSprites/Hair
onready var dressSprite = $PlayerImages/CompositionalSprites/Dress
onready var shoesSprite = $PlayerImages/CompositionalSprites/Shoes
onready var gunSprite = $PlayerImages/CompositionalSprites/Gun
onready var skinSprite = $PlayerImages/CompositionalSprites/Skin

onready var hairColor = $VBoxContainer/HairColor
onready var skinColor = $VBoxContainer/SkinColor
onready var gunColor = $VBoxContainer/GunColor
onready var dressColor = $VBoxContainer/DressColor
onready var shoesColor = $VBoxContainer/ShoesColor

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
var skin_spritesheet = preload("res://assets/player/skin_1.png")

func set_hair_color(color: Color) -> void:
    hairSprite.modulate = color


func set_dress_color(color: Color) -> void:
    dressSprite.modulate = color


func set_shoes_color(color: Color) -> void:
    shoesSprite.modulate = color


func set_gun_color(color: Color) -> void:
    gunSprite.modulate = color


func set_skin_color(color: Color) -> void:
    skinSprite.modulate = color


func change_hair(incr: int) -> void:
    hairIndex = posmod(hairIndex + incr, len(hair_spritesheet))
    hairSprite.texture = hair_spritesheet[hairIndex]


func randomize_char() -> void:
    change_hair(randi())
    set_hair_color(hairColor.get_rand_color())
    set_dress_color(dressColor.get_rand_color())
    set_shoes_color(shoesColor.get_rand_color())
    set_gun_color(gunColor.get_rand_color())
    set_skin_color(skinColor.get_rand_color())


func _ready() -> void:
    randomize_char()


func _on_Rand_pressed() -> void:
    randomize_char()


func _on_HairChangeLeft_pressed() -> void:
    change_hair(-1)


func _on_HairChangeRight_pressed() -> void:
    change_hair(1)


func _on_SkinTone_color_changed(color) -> void:
    set_skin_color(color)


func _on_HairColor_color_changed(color) -> void:
    set_hair_color(color)


func _on_GunColorSelector_color_changed(color) -> void:
    set_gun_color(color)


func _on_DressColor_color_changed(color) -> void:
    set_dress_color(color)


func _on_ShoesColor_color_changed(color) -> void:
    set_shoes_color(color)
