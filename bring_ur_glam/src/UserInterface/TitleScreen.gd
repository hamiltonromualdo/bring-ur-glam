extends Control


func set_up_menu() -> void:
    $Menu.set_visible(true)

    $Menu/PlayButton.disabled = false
    $Menu/QuitButton.disabled = false

    # Start with focus on PlayButton to allow keyboard control
    $Menu/PlayButton.grab_focus()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    if ($Title.margin_top < 45):
        $Title.margin_top += 0.2
    if ($Title.margin_top >= 45 && $Glam.is_emitting() == false):
        $Glam.set_emitting(true)
        set_up_menu()
        