extends Node
@onready var timer = $sacerfice


func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass


func _on_sacerfice_timeout() -> void:
	if AnimalData.phase ==  5: # if phase is at 5, cant go higher
		timer.start()
	else:
		AnimalData.phase += 1
		timer.start()

func added():
	if AnimalData.phase ==  1: # if the phase is t one, cant go below
		timer.start()
	else:
		AnimalData.phase -= 1
		timer.start()
