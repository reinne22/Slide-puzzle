extends Area2D

var tiles = []
var solved = []
var mouse = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_game()

func start_game():
	tiles = [$Tile1, $Tile2, $Tile3, $Tile4, $Tile5, $Tile6, $Tile7, $Tile8, $Tile9]
	solved = tiles.duplicate()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and mouse:
		var _mouse_copy = mouse
		print(mouse.position)
		mouse = false
		var _rows = int(_mouse_copy.position.y / 160)
		var _cols = int(_mouse_copy.position.x / 265)
		check_neighbours(_rows, _cols)

func check_neighbours(_rows, _cols):
	var empty = false 
	var done = false 
	var _pos = _rows * 3 + _cols
	while !empty and !done:
		var new_pos = tiles[_pos].position
		if _rows < 3:
			new_pos.y += 265
			empty = find_empty (new_pos,_pos)
			new_pos.y -= 265
		if _rows > 0:
			new_pos.y += 265
			empty = find_empty (new_pos,_pos)
			new_pos.y -= 265
		if _rows < 3:
			new_pos.x += 160
			empty = find_empty (new_pos,_pos)
			new_pos.x -= 160
		if _rows > 0:
			new_pos.x += 160
			empty = find_empty (new_pos,_pos)
			new_pos.x -= 160
		done = true

func find_empty(position,_pos):
	var new_rows = int(position.y / 265)
	var new_cols = int(position.x / 160)
	var new_pos = new_rows * 3 + new_cols
	if tiles[new_pos] == $Tile9:
		sawap_tiles(_pos, new_pos)
		return true
	else:
		return false

func sawap_tiles(tile_src, tile_dst):
	var temp_pos = tiles[tile_src].position
	tiles[tile_src].position = tiles[tile_dst].position
	tiles[tile_dst].position = temp_pos
	var _temp_tile = tiles[tile_src]
	tiles[tile_src] = tiles[tile_dst]
	tiles[tile_dst] = _temp_tile

func _input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		mouse = event
