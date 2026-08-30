extends Node2D
@onready var square = $background
@onready var tile = $background/tile
@onready var player = $ySortedObjects/player
@onready var ySortingContainer = $ySortedObjects
@export var monster_scene: PackedScene
@export var animal_scene: PackedScene
@export var temple_scene: PackedScene = preload("res://animals/scene/temple.tscn")
var resource_scene = preload("res://resources/resource.tscn")
var crateScene = preload("res://resources/crate.tscn")
@onready var timer = $Day

const chunkSE := 640
const tileS := 64
const TilesRow := 10
const rchance := 0.1

var temple_instance: Node2D = null
var templeSpawned = false

var canSpawnMonster = false

var monster_spawn_chance = 0.2
var monster_instance: CharacterBody2D = null

var chunks := {}
var current_chunk_coord := Vector2i.ZERO

var animal_weights = {
	"rabbit": 60,
	"deer": 20,
	"fox": 15,
	"bear": 5
}

func _ready() -> void:
	generate_chunk(Vector2i.ZERO)
	_update_chunks()
	spawn_temple()
	
	Global.dayTime = true
	
	canSpawnMonster = true

func _process(delta: float) -> void:
	if monster_instance != null:
		if(player.global_position.distance_to(monster_instance.global_position) > 2500):
			monster_instance.queue_free()
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

	var tile_positions: Array[Vector2] = []
	for y in TilesRow:
		for x in TilesRow:
			tile_positions.append(origin + Vector2(x * tileS, y * tileS))
	generate_resources(tile_positions)

func generate_resources(tile_positions: Array[Vector2]) -> void:
	for pos in tile_positions:
		if randf() < rchance:
			var new_rec
			if randi_range(1, 20) == 1:
				new_rec = crateScene.instantiate()
			else:
				new_rec = resource_scene.instantiate()
			
			ySortingContainer.add_child(new_rec)
			new_rec.position = pos + Vector2(randi_range(1, tileS), randi_range(1, tileS))
		
		
		if randf() < 1.0/200:
			generate_animal(pos + Vector2(randi_range(1, tileS), randi_range(1, tileS)))

func generate_animal(spawn_position: Vector2) -> void:
	if monster_instance == null and canSpawnMonster and randf() < monster_spawn_chance:
		monster_instance = monster_scene.instantiate()
		monster_instance.player = player
		ySortingContainer.add_child(monster_instance)
		monster_instance.global_position = spawn_position
		if randf() < 0.6:
			monster_instance.disguise_as(get_random_animal_type())
		return

	var animal_type = get_random_animal_type()
	var new_animal = animal_scene.instantiate()
	ySortingContainer.add_child(new_animal)
	new_animal.global_position = spawn_position
	new_animal.setup(animal_type)

func get_random_animal_type() -> String:
	var total_weight = 0
	for weight in animal_weights.values():
		total_weight += weight
	var roll = randf() * total_weight
	var cumulative = 0.0
	for animal_type in animal_weights.keys():
		cumulative += animal_weights[animal_type]
		if roll < cumulative:
			return animal_type
	return animal_weights.keys()[-1]

func spawn_temple() -> void:
	if templeSpawned:
		return
	templeSpawned = true
	temple_instance = temple_scene.instantiate()
	ySortingContainer.add_child(temple_instance)
	
	var temple_distance = randf_range(1000, 3000) 
	var temple_angle = randf_range(0, TAU)
	temple_instance.global_position = Vector2.RIGHT.rotated(temple_angle) * temple_distance

func _on_day_timeout() -> void:
	if Global.dayTime:
		Global.dayTime = false
		timer.start()
		var newTween = create_tween()
		newTween.tween_property($CanvasModulate, "color", Color.from_rgba8(114, 114, 114, 255), 1)
		newTween.play()
	else:
		Global.dayTime = true
		timer.start()
		var newTween = create_tween()
		newTween.tween_property($CanvasModulate, "color", Color.from_rgba8(255, 255, 255, 255), 1)
		newTween.play()

func _on_monster_timer_timeout() -> void:
	if monster_instance == null and canSpawnMonster and randf() < 0.5:
		monster_instance = monster_scene.instantiate()
		monster_instance.player = player
		ySortingContainer.add_child(monster_instance)
		var posx = randi_range(-1000, 1000)
		var rand = randi_range(-1, 1)
		while rand == 0:
			rand = randi_range(-1, 1)
		var posy = rand * (1000 - abs(posx))
		monster_instance.global_position = player.global_position + Vector2(posx, posy)
	
	$monsterTimer.start(randi_range(30, 60))
