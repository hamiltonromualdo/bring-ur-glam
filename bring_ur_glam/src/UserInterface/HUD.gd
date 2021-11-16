extends CanvasLayer


var total_hp = 100


func update_score(score):
    $ScoreLabel.text = str(score)


func update_hp(hp):
    $HealthBarRbn.set_hp(hp)
    $HPValue.text = "{hp}/{total_hp}".format({"hp": hp, "total_hp": total_hp})


func set_total_hp(hp):
    total_hp = hp
    $HPValue.text = "{hp}/{total_hp}".format({"hp": total_hp, "total_hp": total_hp})
    $HealthBarRbn.set_values(0, total_hp, total_hp)
