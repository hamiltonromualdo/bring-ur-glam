tool
extends TileMap

enum TILE_COLORS {NONE = -1, BROWN = 0, PURPLE = 1, RED = 2, GREY = 3, GREEN = 4}
const TILE_COLORS_VEC = [TILE_COLORS.BROWN, TILE_COLORS.PURPLE, TILE_COLORS.RED, TILE_COLORS.GREY, TILE_COLORS.GREEN]
const GENERATION_TILE = 5
const BROWN_BOTTOM_DOORS = [18, 55, 106, 107, 109]
const GREY_BOTTOM_DOORS = [36, 108, 110, 111, 77]

const PARTS = {
    TILE_COLORS.BROWN: {
        "Window": [[9, 8], [10, 8], [12, 11]],
        "DoorDown": BROWN_BOTTOM_DOORS,
        "DoorUp": [15, 16, 17],
        "Roof": [7]
    },
    TILE_COLORS.PURPLE: {
        "Window": [[28, 30], [29, 30]],
        "DoorDown": GREY_BOTTOM_DOORS,
        "DoorUp": [33, 34, 35],
        "Roof": [27]
    },
    TILE_COLORS.RED: {
        "Window": [[48, 49], [50, 51]],
        "DoorDown": BROWN_BOTTOM_DOORS,
        "DoorUp": [52, 53, 54],
        "Roof": [47]
    },
    TILE_COLORS.GREY: {
        "Window": [[68, 73], [72, 73], [69, 73], [70, 73], [71, 73]],
        "DoorDown": GREY_BOTTOM_DOORS,
        "DoorUp": [74, 75, 76],
        "Roof": [67]
    },
    TILE_COLORS.GREEN: {
        "Window": [[88, 89], [90, 92], [91, 92], [94, 95], [93, 95]],
        "DoorDown": GREY_BOTTOM_DOORS,
        "DoorUp": [96, 97, 98],
        "Roof": [87]
    }
}


func _get_tile_color(tile: int):
    return TILE_COLORS_VEC[tile] if tile in TILE_COLORS_VEC else TILE_COLORS.NONE


func _is_marker_tile(tile, color):
    return _get_tile_color(tile) == color


func _get_rand_from_vec(vec: Array):
    return vec[randi() % len(vec)]


func get_rand_window(color):
    return _get_rand_from_vec(PARTS[color]["Window"])


func get_rand_door(color):
    return [_get_rand_from_vec(PARTS[color]["DoorDown"]), _get_rand_from_vec(PARTS[color]["DoorUp"])]


func get_roof(color):
    return _get_rand_from_vec(PARTS[color]["Roof"])


func set_cell(x: int, y: int, 
              tile: int,
              flip_x: bool = false, flip_y: bool = false, 
              transpose: bool = false, 
              autotile_coord: Vector2 = Vector2( 0, 0 )) -> void:
    if tile == GENERATION_TILE:
        # Get color from the tile on the right and use as reference
        var color = _get_tile_color(get_cell(x + 1, y))
        if color == TILE_COLORS.NONE:
            return

        # The generation tile should be placed on the left lower corner
        # From there, we find the bounds of the building to be created
        var x_bound = x + 1
        var y_bound = y - 1
        while _is_marker_tile(get_cell(x_bound, y), color):
            x_bound += 1
        while _is_marker_tile(get_cell(x, y_bound), color):
            y_bound -= 1
        var max_y = y
        var x_tiles = x_bound - x
        var y_tiles = y - y_bound
        
        if x_tiles <= 1 || y_tiles <= 1:
            return
        
        # Windows
        for x_pos in range(x, x_bound, 1):
            for y_pos in range(y, y_bound, -2):
                var tile_pair = get_rand_window(color)
                .set_cellv(Vector2(x_pos, y_pos), tile_pair[0])
                .set_cellv(Vector2(x_pos, y_pos-1), tile_pair[1])
                max_y = max_y if y_pos-1 > max_y else y_pos-1

        # Door
        if (x_tiles % 2) == 0:
            var x_pos = x + x_tiles/2 -1
            var tile_pair = get_rand_door(color)
            .set_cellv(Vector2(x_pos, y), tile_pair[0])
            .set_cellv(Vector2(x_pos, y-1), tile_pair[1])
            # Flip for on x axis
            .set_cellv(Vector2(x_pos + 1, y), tile_pair[0], true)
            .set_cellv(Vector2(x_pos + 1, y-1), tile_pair[1], true)
        else:
            # One door
            var x_pos = x + x_tiles/2
            var tile_pair = get_rand_door(color)
            .set_cellv(Vector2(x_pos, y), tile_pair[0])
            .set_cellv(Vector2(x_pos, y-1), tile_pair[1])
#
        # Roof
        var y_pos = max_y - 1
        for x_pos in range(x, x_bound, 1):
            .set_cellv(Vector2(x_pos, y_pos), get_roof(color))
    else: 
        .set_cellv(Vector2(x, y), tile, flip_x, flip_y, transpose)
