extends Node2D
@onready var square = $background
@onready var tile = $background/tile
@onready var rec = $resource
@onready var player = $player

const chunkSE := 640
const tileS := 64
const TilesRow := 10
const rchance := 0.25

var chunks := {}
var current_chunk_coord := Vector2i.ZERO

func _ready() -> void:
	generate_chunk(Vector2i.ZERO)
	_update_chunks()

func _process(delta: float) -> void:
	var player_chunk = Vector2i(
		floori(player.global_position.x / chunkSE),
		floori(player.global_position.y / chunkSE)
	)
	if player_chunk != current_chunk_coord:
		current_chunk_coord = player_chunk
		_update_chunks()

func _update_chunks() -> void:
	for dx in [-1, 0, 1]:
		for dy in [-1, 0, 1]:
			generate_chunk(current_chunk_coord + Vector2i(dx, dy))

func generate_chunk(coord: Vector2i) -> void:
	if chunks.has(coord):
		return
	var origin = Vector2(coord.x * chunkSE, coord.y * chunkSE)
	var new_back = square.duplicate()
	new_back.position = origin
	add_child(new_back)
	chunks[coord] = new_back

	var tiles_in_chunk = []
	for y in TilesRow:
		for x in TilesRow:
			var new_tile = tile.duplicate()
			new_tile.position = origin + Vector2(x * tileS, y * tileS)
			add_child(new_tile)
			tiles_in_chunk.append(new_tile)

	generate_resources(tiles_in_chunk)

func generate_resources(tiles_in_chunk: Array) -> void:
	for t in tiles_in_chunk:
		if randf() < rchance:
			var new_rec = rec.duplicate()
			add_child(new_rec)
			new_rec.position = t.global_position + Vector2(randi_range(1, tileS), randi_range(1, tileS))
