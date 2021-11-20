extends Node

signal score_updated


var score: = 0 setget set_score


func reset() -> void:
    score = 0


func set_score(new_score: int) -> void:
    score = new_score
    emit_signal("score_updated")
