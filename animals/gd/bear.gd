extends CharacterBody2D

@onready var deer = $Deer
@onready var switch = $Switch
var SPEED = 100
var f = 1
var movement : Vector2 = Vector2.ZERO
var v = 0
var maxStop = false
var max = 4
var stop = 0
var food

var dead = false
var HP = 50

func _ready() -> void:
	food = randi_range(6, 12)
	

func _process(delta: float) -> void:
	Global.wobble(deer, velocity)
	velocity = movement * SPEED
	move_and_slide()
	
	if stop == max:
		maxStop == true
	else:
		maxStop = false

	if HP <= 0:
		death()

func _on_switch_timeout() -> void:
	random()
	if f :
		movement = Vector2.ZERO
		stop = stop + 1
	else :
		if movement == Vector2.ZERO:
			start_moving()
		else:
			var range = randi_range(1, 180)
			movement.rotated(deg_to_rad(range))

func start_moving():
	movement = Vector2(randi_range(-50, 50), randi_range(-50, 50))

func random() :
	if maxStop == true:
		f = false
		stop = 0
	else:
		f = randf() < 0.5
		print(f)

func death():
	pass
func takeDamage():
	pass
