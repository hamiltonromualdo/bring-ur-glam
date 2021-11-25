extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
    pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
    if ($Title.margin_top < 45):
        $Title.margin_top += 0.2
    if ($Title.margin_top >= 45 && $Glam.is_emitting() == false):
        $Glam.set_emitting(true)
        $Menu.set_visible(true)
        
