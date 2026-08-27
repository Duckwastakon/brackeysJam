extends Node
@onready var timer = $sacerfice


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_sacerfice_timeout() -> void:
	if AnimalData.phase ==  5:
		timer.start()
	else:
		AnimalData.phase += 1
		timer.start()
	

func added():
	if AnimalData.phase ==  1:
		timer.start()
	else:
		AnimalData.phase -= 1
		timer.start()
