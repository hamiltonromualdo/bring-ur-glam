extends Node2D

var global = null
var music = null
var effects = null

onready var master_bus_index = AudioServer.get_bus_index("Master")
onready var music_bus_index = AudioServer.get_bus_index("Music")
onready var effects_bus_index = AudioServer.get_bus_index("Effects")

onready var master_slider = $Control/MarginContainer/VBoxContainer/MainSlider
onready var music_slider = $Control/MarginContainer/VBoxContainer/MusicSlider
onready var effects_slider = $Control/MarginContainer/VBoxContainer/EffectsSlider

func _ready() -> void:
    master_slider.value = db2linear(AudioServer.get_bus_volume_db(master_bus_index))
    music_slider.value = db2linear(AudioServer.get_bus_volume_db(music_bus_index))
    effects_slider.value = db2linear(AudioServer.get_bus_volume_db(effects_bus_index))

func _on_MainSlider_value_changed(value: float) -> void:
    AudioServer.set_bus_volume_db(master_bus_index, linear2db(value))


func _on_MusicSlider_value_changed(value: float) -> void:
    AudioServer.set_bus_volume_db(music_bus_index, linear2db(value))


func _on_EffectsSlider_value_changed(value: float) -> void:
    AudioServer.set_bus_volume_db(effects_bus_index, linear2db(value))
