tool
extends GridContainer
class_name ColorSelectorBase


var Swatch : PackedScene = preload("res://src/UserInterface/PlayerCustomization/ColorSwatch.tscn")
var color := Color.white
signal color_changed(color)


func get_colors():
    pass


func _ready() -> void:
    for n in get_children():
        remove_child(n)
        n.free()
    var COLORS = get_colors()
    for c in COLORS:
        var swatch: TextureButton = Swatch.instance()
        swatch.color = c
        add_child(swatch)
        swatch.set_owner(get_tree().edited_scene_root)
        swatch.connect("pressed", self, "_on_ColorSwatch_pressed", [c])
    color = COLORS[randi() % len(COLORS)]


func get_rand_color() -> Color:
    var COLORS = get_colors()
    return Color(COLORS[randi() % len(COLORS)])
    

func _on_ColorSwatch_pressed(color_string: String) -> void:
    color = Color(color_string)
    emit_signal("color_changed", color)
