extends Node2D
@onready var info = $Start/Panel
@onready var remind = $Start/remnider
@onready var first = $Start/first
@onready var second = $Start/second
@onready var third = $Start/third
@onready var text = $Start/test/text
@onready var test = $Start/test/MenuBar
@onready var heading = $Start/test/heading

var start = 715.0
var end = 37.0
var last = -500
var times = 0;
var currant
var array = [info, remind, first, second, third]
var question = 1

func _ready() -> void:
	setTest()
	array = [info, remind, first, second, third]
	currant = 0
	var length = array.size()
	for n in length:
		if n > 0:
			array[n].position.y = start
	array[currant].position.y = end

func setTest():
	if question == 1:
		text.set_text('What are the two needs you have to take care of in the game?')
		heading.set_text('Test Time! (I did tell you there are things to remember for a reason)')
		
		
		
	elif question == 2:
		pass
	else:
		pass

func _process(delta: float) -> void:
	pass

func _on_button_pressed() -> void:
	if currant == array.size():
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
	
 
