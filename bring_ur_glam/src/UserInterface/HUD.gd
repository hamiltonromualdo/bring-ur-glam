extends CanvasLayer


func _ready() -> void:
    var error = PlayerData.connect("hp_updated", self, "update_hp")
    if error:
        print("Error connecting hp: ", error)

    error = PlayerData.connect("score_updated", self, "update_score")
    if error:
        print("Error connecting score: ", error)

    $HealthBarRbn.set_values(0, PlayerData.total_hp, PlayerData.hp)


func update_score() -> void:
    $ScoreLabel.text = str(PlayerData.score)
    $Tween.interpolate_property($ScoreLabel, "rect_scale", Vector2(1, 1), Vector2(1.1, 1.1), 0.1, Tween.TRANS_LINEAR, Tween.EASE_OUT)
    $Tween.interpolate_property($ScoreLabel, "rect_scale", Vector2(1.1, 1.1), Vector2(1, 1), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN, 0.1)
    $Tween.start()


func update_hp() -> void:
    $HealthBarRbn.set_hp(PlayerData.hp)
