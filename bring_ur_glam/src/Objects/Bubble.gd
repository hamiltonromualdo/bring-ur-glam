extends Node2D

signal animation_finished


func pop() -> void:
    $AnimationPlayer.play("pop")


func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
    emit_signal("animation_finished")
