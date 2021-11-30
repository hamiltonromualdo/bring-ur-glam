extends Node

signal hp_updated
signal score_updated
signal shield_enabled

const total_hp: = 100
var hp: = total_hp setget set_hp
var score: = 0 setget set_score
var protected: = false setget set_protected


func _ready() -> void:
    var audio_file_path = "user://audio_settings.dat"
    var file = File.new()
    var error = file.open(audio_file_path, File.READ)
    if error == OK:
        var audio_info = file.get_var()
        AudioServer.set_bus_volume_db(0, audio_info["master"])
        AudioServer.set_bus_volume_db(1, audio_info["music"])
        AudioServer.set_bus_volume_db(2, audio_info["effects"])
        file.close()
    else:
        var audio_info = {
            "master": AudioServer.get_bus_volume_db(0),
            "music": AudioServer.get_bus_volume_db(1),
            "effects": AudioServer.get_bus_volume_db(2),
        }
        file.store_var(audio_info)
        file.close()
        


func reset() -> void:
    hp = total_hp
    score = 0


func set_hp(new_hp: int) -> void:
    hp = int(clamp(new_hp, 0, total_hp))
    emit_signal("hp_updated")


func set_score(new_score: int) -> void:
    score = new_score
    emit_signal("score_updated")


func set_protected(new_protected: bool) -> void:
    protected = new_protected
    if protected:
        emit_signal("shield_enabled")
