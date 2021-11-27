extends CanvasLayer


func _ready() -> void:
    var error = PlayerData.connect("hp_updated", self, "update_hp")
    if error:
        print("Error connecting hp: ", error)

    error = PlayerData.connect("score_updated", self, "update_score")
    if error:
        print("Error connecting score: ", error)
        
    error = PlayerData.connect("stars_count_updated", self, "update_stars_count_text")
    if error:
        print("Error connecting stars count: ", error)

    $HealthBarRbn.set_values(0, PlayerData.hp, PlayerData.total_hp)


func update_score() -> void:
    $ScoreLabel.text = str(PlayerData.score)


func update_hp() -> void:
    $HealthBarRbn.set_hp(PlayerData.hp)


func update_stars_count_text() -> void:
    $StarsLabel.text = str(PlayerData.stars_count)
