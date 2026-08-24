extends Node2D
@onready var square = $background
@onready var tile = $background/tile
@onready var rec = $resource
@onready var player = $player
@onready var area = $background/body

var inOne = false; var inTwo = false;var inThree = false; var inFour =false;var inFive = false; var inSix = false;  var inSeven = false; var inEight = false

var newTile = tile
var newRec = rec
var newBack  ; var newCArea = area
var first = true
var sqPosition = Vector2(0.0, 0.0)
var CurrentsqPosition = Vector2(0.0, 0.0)

var tilePosition = Vector2(0.0, 0.0)
var currentPosition = Vector2(0.0, 0.0)


var number = []
var chunk = []
var cArea = []
var currentChunk

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	first = true
	generate()
	currentChunk =  chunk[0]
	
func generate():
	
	if first:
		first = false
	else:
		if inOne:
			pass
		elif inTwo:
			pass
		elif inThree:
			pass
		elif inFour:
			pass
		elif inFive: 
			pass
		elif inSix :
			pass
		elif inSeven:
			sqPosition = Vector2(CurrentsqPosition.x-640, CurrentsqPosition.y)
		else:
			pass
	
	
	newBack = square.duplicate() # needs reworking when addingh get s added
	newBack.position = sqPosition
	chunk.append(newBack)
	add_child(newBack)
	print(square.position) # square starting position
	CurrentsqPosition = sqPosition
	
	for o in 10:
		var n = o*64
		for i in 10 :
			var a = i * 64
			newTile = tile.duplicate()
			newTile.position = Vector2(a, n)
			add_child(newTile)
			number.append(newTile)
			
	generateRec()

func generateRec():
	for i in 100:
		var f = randf() < 0.25
		if f:
			newRec = rec.duplicate()
			add_child(newRec)
			newRec.position = number[i].global_position + Vector2(randi_range(1, 64), randi_range(1, 64))		


func _process(delta: float) -> void:
	pass


func _on_load_body_exited(body: Node2D) -> void: # when exited big guy
	var place = player.global_position
	print(place)
	generate()
	
	
func _on_one_body_entered(body: Node2D) -> void:
	inOne = true;
	inTwo = false; inThree = false; inFour = false; inFive = false; inSix = false ;inSeven = false; inEight = false
func _on_two_body_entered(body: Node2D) -> void:
	inTwo = true
	inOne = false; inThree = false; inFour = false; inFive = false; inSix = false ;inSeven = false; inEight = false
func _on_three_body_entered(body: Node2D) -> void:
	inThree = true
	inTwo = false; inOne = false; inFour = false; inFive = false; inSix = false ;inSeven = false; inEight = false
func _on_four_body_entered(body: Node2D) -> void:
	inFour = true
	inTwo = false; inThree = false; inOne = false; inFive = false; inSix = false ;inSeven = false; inEight = false

func _on_five_body_entered(body: Node2D) -> void:
	inFive = true
	inTwo = false; inThree = false; inFour = false; inOne = false; inSix = false ;inSeven = false; inEight = false

func _on_six_body_entered(body: Node2D) -> void:
	inSix = true
	inTwo = false; inThree = false; inFour = false; inFive = false; inOne = false ;inSeven = false; inEight = false

func _on_seven_body_entered(body: Node2D) -> void:
	inSeven = true
	inTwo = false; inThree = false; inFour = false; inFive = false; inSix = false ;inOne = false; inEight = false

func _on_eight_body_entered(body: Node2D) -> void:
	inEight = true
	inTwo = false; inThree = false; inFour = false; inFive = false; inSix = false ;inSeven = false; inOne = false
