extends Control
@onready var info = $Start/Panel
@onready var remind = $Start/remnider
@onready var first = $Start/first
@onready var second = $Start/second
@onready var third = $Start/third

var start = 715.0
var end = 37.0
var last = -500
var times = 0;
var currant
var array = [info, remind, first, second, third]
var question = 1

func _ready() -> void:
	array = [info, remind, first, second, third]
	currant = 0
	var length = array.size()
	for n in length:
		if n > 0:
			array[n].position.y = start
	array[currant].position.y = end

func _on_button_pressed() -> void:
	if currant+1 == array.size():
		visible = false
		$Start.visible = false
		return
	else:
		var a = array[currant]
		var b = array[currant+1]
		
		var tween = create_tween()
		tween.tween_property(a, "position:y", last, 2)
		
		var tween2 = create_tween()
		tween2.tween_property(b, "position:y", end, 2)
		
		currant = currant +1
		print()
	
 
