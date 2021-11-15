extends Position2D

export (PackedScene) var BULLET


func fire(direction):
    var b = BULLET.instance()
    b.set_fireball_direction(direction)
    b.set_as_toplevel(true)
    add_child(b)
    b.transform = global_transform
