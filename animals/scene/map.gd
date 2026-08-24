extends Node2D
@onready var square = $background
@onready var tile = $tile
@onready var rec = $resource
var newTile = tile
var newRec = rec

var number = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate()
	generateRec()
	
func generate():
	print(square.position) # square starting position
	for o in 10:
		var n = o*64
		for i in 10 :
			var a = i * 64
			newTile = tile.duplicate()
			newTile.position = Vector2(a, n)
			add_child(newTile)
			number.append(newTile)

func generateRec():
	for i in 100:
		var f = randf() < 0.25
		if f:
			newRec = rec.duplicate()
			add_child(newRec)
			newRec.position = number[i].global_position + Vector2(randi_range(1, 64), randi_range(1, 64))
			print('tree added')
		


func _process(delta: float) -> void:
	pass
