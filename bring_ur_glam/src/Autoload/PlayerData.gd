extends Node

signal hp_updated
signal score_updated

const total_hp: = 100
var hp: = total_hp setget set_hp
var score: = 0 setget set_score


func reset() -> void:
    hp = total_hp
    score = 0


func set_hp(new_hp: int) -> void:
    hp = int(clamp(new_hp, 0, total_hp))
    emit_signal("hp_updated")


func set_score(new_score: int) -> void:
    score = new_score
    emit_signal("score_updated")
