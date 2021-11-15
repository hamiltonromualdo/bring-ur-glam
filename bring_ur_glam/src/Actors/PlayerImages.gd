extends Node2D

func flip_h(value: bool) -> void:
    for sprite in $CompositionalSprites.get_children():
        sprite.flip_h = value

func flip_v(value: bool) -> void:
    for sprite in $CompositionalSprites.get_children():
        sprite.flip_v = value
