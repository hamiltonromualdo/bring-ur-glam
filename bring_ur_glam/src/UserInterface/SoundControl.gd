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


var is_dirty = false


func set_is_dirty() -> void:
    if $Timer.is_stopped():
        $Timer.start()
    is_dirty = true


func save_info() -> void:
    print('save info')
    var audio_file_path = "user://audio_settings.dat"
    var file = File.new()
    var error = file.open(audio_file_path, File.WRITE)
    if error == OK:
        var audio_info = {
            "master": AudioServer.get_bus_volume_db(master_bus_index),
            "music": AudioServer.get_bus_volume_db(music_bus_index),
            "effects": AudioServer.get_bus_volume_db(effects_bus_index),
        }
        file.store_var(audio_info)
        file.close()

func _ready() -> void:
    master_slider.value = db2linear(AudioServer.get_bus_volume_db(master_bus_index))
    music_slider.value = db2linear(AudioServer.get_bus_volume_db(music_bus_index))
    effects_slider.value = db2linear(AudioServer.get_bus_volume_db(effects_bus_index))

func _on_MainSlider_value_changed(value: float) -> void:
    AudioServer.set_bus_volume_db(master_bus_index, linear2db(value))
    set_is_dirty()


func _on_MusicSlider_value_changed(value: float) -> void:
    AudioServer.set_bus_volume_db(music_bus_index, linear2db(value))
    set_is_dirty()


func _on_EffectsSlider_value_changed(value: float) -> void:
    AudioServer.set_bus_volume_db(effects_bus_index, linear2db(value))
    set_is_dirty()


func _on_Timer_timeout() -> void:
    if is_dirty:
        save_info()
        is_dirty = false
