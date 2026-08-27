extends CharacterBody2D
@onready var sprite = $Sprite
@onready var switch = $Switch

var disguise_type: String
var SPEED: float
var move_range: float
var max_stop: int
var random_wait: bool

var is_revealed = false
var true_sprite = preload("res://drawn assets/monster.PNG")

var f = true
var movement: Vector2 = Vector2.ZERO
var maxStop = false
var stop = 0

func disguise_as(type: String) -> void:
	disguise_type = type
	var data = AnimalData.profiles[type]
	SPEED = data["speed"]
	move_range = data["move_range"]
	max_stop = data["max_stop"]
	random_wait = data["random_wait"]
	sprite.texture = data["sprite"]
	is_revealed = false

func reveal() -> void:
	is_revealed = true
	sprite.texture = true_sprite
	SPEED = 250

func _ready() -> void:
	if not switch.timeout.is_connected(_on_switch_timeout):
		switch.timeout.connect(_on_switch_timeout)
	switch.start()

func _physics_process(delta: float) -> void:
	Global.wobble(sprite, velocity)
	if is_revealed:
		chase_behavior()
	velocity = movement * SPEED
	move_and_slide()
	maxStop = stop == max_stop

func chase_behavior() -> void:
	pass  # fill in later — e.g. move toward player

func _on_switch_timeout() -> void:
	if is_revealed:
		return  # skip wander logic once revealed
	if random_wait:
		switch.wait_time = randi_range(1, 5)
	random()
	if f:
		movement = Vector2.ZERO
		stop += 1
	else:
		if movement == Vector2.ZERO:
			start_moving()
		else:
			var range = randi_range(1, 180)
			movement = movement.rotated(deg_to_rad(range))

func start_moving() -> void:
	movement = Vector2(
		randi_range(-move_range, move_range),
		randi_range(-move_range, move_range)
	)

func random() -> void:
	if maxStop:
		f = false
		stop = 0
	else:
		f = randf() < 0.5
