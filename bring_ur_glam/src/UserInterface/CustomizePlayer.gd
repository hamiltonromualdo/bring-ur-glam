extends Node2D

onready var hairColor = $Control/VBoxContainer/HairColor
onready var skinColor = $Control/VBoxContainer/SkinColor
onready var gunColor = $Control/VBoxContainer/GunColor
onready var dressColor = $Control/VBoxContainer/DressColor
onready var shoesColor = $Control/VBoxContainer/ShoesColor

onready var player = $PlayerImages

var save_path = "user://player.dat"


func randomize_char() -> void:
    randomize()
    player.change_hair(randi())
    player.set_hair_color(hairColor.get_rand_color())
    player.set_dress_color(dressColor.get_rand_color())
    player.set_shoes_color(shoesColor.get_rand_color())
    player.set_gun_color(gunColor.get_rand_color())
    player.set_skin_color(skinColor.get_rand_color())


func _ready() -> void:
    var loaded = player.load_data()
    if loaded:
        update_swatches(loaded)
    else:
        randomize_char()

    # Start with focus on StartGame to allow keyboard control
    $Control/VBoxContainer/HBoxContainer2/StartGame.grab_focus()

func update_swatches(player_info) -> void:
    hairColor.set_color(player_info["hair_color"])
    dressColor.set_color(player_info["dress_color"])
    shoesColor.set_color(player_info["shoes_color"])
    gunColor.set_color(player_info["gun_color"])
    skinColor.set_color(player_info["skin_color"])

func _on_Rand_pressed() -> void:
    randomize_char()


func _on_HairChangeLeft_pressed() -> void:
    player.change_hair(-1)


func _on_HairChangeRight_pressed() -> void:
    player.change_hair(1)


func _on_SkinTone_color_changed(color) -> void:
    player.set_skin_color(color)


func _on_HairColor_color_changed(color) -> void:
    player.set_hair_color(color)


func _on_GunColorSelector_color_changed(color) -> void:
    player.set_gun_color(color)


func _on_DressColor_color_changed(color) -> void:
    player.set_dress_color(color)


func _on_ShoesColor_color_changed(color) -> void:
    player.set_shoes_color(color)


func _on_StartGame_pressed() -> void:
    yield($Control/VBoxContainer/HBoxContainer2/StartGame/PressedSound, "finished")
    player.save_data()
    var error = get_tree().change_scene("res://src/Levels/Playground.tscn")
    if error:
        print("Error changing scene: ", error)
