extends Node2D

func flip_h(value: bool) -> void:
    for sprite in $CompositionalSprites.get_children():
        sprite.flip_h = value


func flip_v(value: bool) -> void:
    for sprite in $CompositionalSprites.get_children():
        sprite.flip_v = value

var save_path = "user://player.dat"
func load_default() -> void:
    var file = File.new()
    var error = file.open(save_path, File.READ)
    if error == OK:
        var player_info = file.get_var()
        $CompositionalSprites/Hair.modulate = player_info["hair_color"]
        file.close()
    
