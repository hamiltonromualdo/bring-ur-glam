tool
extends GridContainer
class_name ColorSelectorBase


var Swatch : PackedScene = preload("res://src/UserInterface/PlayerCustomization/ColorSwatch.tscn")
var color := Color.white
signal color_changed(color)


func get_colors():
    pass


func hightlight_selected() -> void:
    for swatch in get_children():
        if swatch.color == color:
            swatch.contour = true
        else:
            swatch.contour = false


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
        var error = swatch.connect("pressed", self, "_on_ColorSwatch_pressed", [c])
        if error:
            print("Error connecting swatch: ", error)
    color = COLORS[randi() % len(COLORS)]
    hightlight_selected()


func get_rand_color() -> Color:
    var COLORS = get_colors()
    color = Color(COLORS[randi() % len(COLORS)])
    hightlight_selected()
    return color


func _on_ColorSwatch_pressed(color_string: String) -> void:
    color = Color(color_string)
    hightlight_selected()
    emit_signal("color_changed", color)
