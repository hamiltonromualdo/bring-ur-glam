extends Node2D

const story = [
    ["Glamoureus", "Hello Sal"],
    ["Sal", "Hey!"],
    ["Glamoureus", "Brazil is undergoing a serious crisis."],
    ["Glamoureus", "The toxic maculinity is taking over."],
    ["Glamoureus", "We need HER!"],
    ["Glamoureus", "We need Salette!"],
    ["Sal", "You know she retired..."],
    ["Glamoureus", "Only her GLAM will save us."],
    ["Sal", "I'm not sure..."],
    ["Glamoureus", "She is our last hope!"],
    ["Sal", "Ok. But you know she will need a new outfit, right?"],
    ["Glamoureus", "All she needs!"],
    ["Sal", "I'll get ready!"],
]

var current = -1


func _next_line():
    if current + 1 == len(story):
        $ChangeSceneButton.visible = true
        $ChangeSceneButton.grab_focus()
        $Next.visible = false
        return
    current += 1
    var story_line = story[current]
    if story_line[0] == "Sal":
        $Sal.visible = true
        $SalImg.visible = true
        $Glamoureus.visible = false
        $GlamoureusImg.visible = false
        $Text.bbcode_text = "{line}".format({"line": story_line[1]})
    else:
        $Sal.visible = false
        $SalImg.visible = false
        $Glamoureus.visible = true
        $GlamoureusImg.visible = true
        $Text.bbcode_text = "[right]{line}[/right]".format({"line": story_line[1]})
    $Timer.start()
    $Next.visible = false


func _ready() -> void:
    $Text.text = ""
    $Next.visible = false
    $SalImg.visible = false
    $GlamoureusImg.visible = false
    $Sal.visible = false
    $Glamoureus.visible = false
    $NodeGroup.position.y = -130
    $MainTextBox.modulate = Color(1, 1, 1, 0)
    $NameTextBox.modulate = Color(1, 1, 1, 0)
    $BackgroundTween.interpolate_property($NodeGroup, "position", Vector2(0, 130), Vector2(0, 17), 3, Tween.TRANS_LINEAR, Tween.EASE_OUT)
    $BackgroundTween.start()


func _process(delta: float) -> void:
    if Input.is_action_just_pressed("ui_accept") and $Timer.is_stopped() and current <= len(story):
        _next_line()
    
    if $SoundControl.visible and Input.is_action_pressed("ui_cancel"):
        $SoundControl.visible = false
        $SettingsButton.release_focus()


func _on_Timer_timeout() -> void:
    $Next.visible = true


func _on_BackgroundTween_tween_all_completed() -> void:
    $TextBoxTween.interpolate_property($MainTextBox, "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
    $TextBoxTween.interpolate_property($NameTextBox, "modulate", Color(1, 1, 1, 0), Color(1, 1, 1, 1), 0.5, Tween.TRANS_LINEAR, Tween.EASE_OUT)
    $TextBoxTween.start()


func _on_TextBoxTween_tween_all_completed() -> void:
    $Next.visible = true


func _on_SettingsButton_pressed() -> void:
    $SoundControl.visible = true
