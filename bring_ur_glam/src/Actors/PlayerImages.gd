extends Node2D

onready var hairSprite = $CompositionalSprites/Hair
onready var dressSprite = $CompositionalSprites/Dress
onready var shoesSprite = $CompositionalSprites/Shoes
onready var gunSprite = $CompositionalSprites/Gun
onready var skinSprite = $CompositionalSprites/Skin

var save_path = "user://player.dat"

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


func set_hair_style(index: int) -> void:
    hairIndex = index
    hairSprite.texture = hair_spritesheet[index]


func change_hair(incr: int) -> void:
    var index = posmod(hairIndex + incr, len(hair_spritesheet))
    set_hair_style(index)


func flip_h(value: bool) -> void:
    for sprite in $CompositionalSprites.get_children():
        sprite.flip_h = value


func flip_v(value: bool) -> void:
    for sprite in $CompositionalSprites.get_children():
        sprite.flip_v = value

func save_data() -> void:
    var player_info = {
        "hair_style": hairIndex,
        "hair_color": hairSprite.modulate,
        "dress_color": dressSprite.modulate,
        "shoes_color": shoesSprite.modulate,
        "gun_color": gunSprite.modulate,
        "skin_color": skinSprite.modulate,
    }
    var file = File.new()
    var error = file.open(save_path, File.WRITE)
    if error == OK:
        file.store_var(player_info)
        file.close()

func load_data() -> bool:
    var file = File.new()
    var error = file.open(save_path, File.READ)
    if error == OK:
        var player_info = file.get_var()
        set_hair_style(player_info["hair_style"])
        set_hair_color(player_info["hair_color"])
        set_dress_color(player_info["dress_color"])
        set_shoes_color(player_info["shoes_color"])
        set_gun_color(player_info["gun_color"])
        set_skin_color(player_info["skin_color"])
        file.close()
    return error == OK

