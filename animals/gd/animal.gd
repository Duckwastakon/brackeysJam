extends CharacterBody2D
@onready var sprite = $Sprite
@onready var switch = $Switch

var animal_type: String
var SPEED: float
var HP: float
var move_range: float
var max_stop: int
var random_wait: bool
var food: int

var f = true
var movement: Vector2 = Vector2.ZERO
var maxStop = false
var stop = 0
var dead = false

func setup(type: String) -> void:
	animal_type = type
	var data = AnimalData.profiles[type]
	SPEED = data["speed"]
	HP = data["hp"]
	move_range = data["move_range"]
	max_stop = data["max_stop"]
	random_wait = data["random_wait"]
	food = randi_range(data["food_min"], data["food_max"])
	sprite.texture = data["sprite"]

func _ready() -> void:
	if not switch.timeout.is_connected(_on_switch_timeout):
		switch.timeout.connect(_on_switch_timeout)
	switch.start()

func _physics_process(delta: float) -> void:
	Global.wobble(sprite, velocity)
	velocity = movement * SPEED
	move_and_slide()

	maxStop = stop == max_stop

	if HP <= 0:
		death()

func _on_switch_timeout() -> void:
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

func death() -> void:
	pass

func takeDamage() -> void:
	pass
