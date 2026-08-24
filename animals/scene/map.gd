extends Node2D
@onready var square = $background
@onready var tile = $tile
@onready var rec = $resource
@onready var player = $player
@onready var area = $background/body


var newTile = tile
var newRec = rec
var newBack  ; var newCArea = area

var number = []
var chunk = []
var cArea = []
var currentChunk

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate()
	generateRec()
	currentChunk =  chunk[0]
	
func generate():
	newBack = square.duplicate() # needs reworking when addingh get s added
	chunk.append(newBack)
	add_child(newBack)
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


func _process(delta: float) -> void:
	pass


func _on_load_body_exited(body: Node2D) -> void:
	var place = player.global_position
	print(place)
	
	
func _on_body_body_entered(body: Node2D) -> void:
	pass
