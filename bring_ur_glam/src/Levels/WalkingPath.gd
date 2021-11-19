tool
extends TileMap

export (bool) var INCLUDE_UPPER_TILE = true
export (bool) var INCLUDE_BOTTOM_TILE = true
export (bool) var REMOVE_ADJ_TILES = true


const matching_upper_tile_map = {
    0: 20,
    1: 20,
    2: 20,
    6: 20,
    4: 22,
    5: 23,
    7: 21,
    8: 24,
    9: 19,
    10: 19,
    11: 19,
    12: 25,
    16: 26,
    17: 24,
    18: 24
}

func set_cell(x: int, y: int, 
              tile: int,
              flip_x: bool = false, flip_y: bool = false, 
              transpose: bool = false, 
              autotile_coord: Vector2 = Vector2( 0, 0 )) -> void:
    # If there's a tile already in place and we are not removing, just skip it
    if tile != -1 and get_cell(x, y) != INVALID_CELL:
        return
        
    # Set the cell as expected, but using the vector API to avoid recursive calls to this
    # function (we don't want to handle the other calls - yeah, it's hacky)
    .set_cellv(Vector2(x, y), tile, flip_x, flip_y, transpose)
    
    # Flip the tile horizontally and place it below
    if INCLUDE_BOTTOM_TILE:
        .set_cellv(Vector2(x, y+1), tile, flip_x, true)
    
    # See if we have a matching upper tile and add it above the node
    # But if we are removing nodes, the tile should be -1
    var new_tile = matching_upper_tile_map[tile] if tile in matching_upper_tile_map else null
    if REMOVE_ADJ_TILES and tile == -1:
        new_tile = -1
    if INCLUDE_UPPER_TILE and new_tile != null:
        .set_cellv(Vector2(x, y-1), new_tile, flip_x)
    
