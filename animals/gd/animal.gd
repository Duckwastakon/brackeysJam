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
	sprite.scale = data.get("scale", Vector2.ONE)

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
	for i in food:
		dropResource("meat", 1)
	
	queue_free()

var damageTween: Tween

func takeDamage(toolName) -> void:
	var toolData = CraftableItems.items[toolName]
	
	var dmg = toolData["dmg"]
	if toolData["toolType"] == "damaging":
		dmg *= toolData["dmgMultiplier"]
	
	HP -= dmg
	if HP <= 0:
		death()
	if damageTween == null:
		damageTween = create_tween()
	else:
		damageTween.kill()
		damageTween = create_tween()
	
	damageTween.tween_property(sprite, "modulate", Color.from_rgba8(255, 255, 255, 255), 0.5)
	
	sprite.modulate = Color.from_rgba8(255, 0, 0, 125)
	damageTween.play()
	if shakeAmount <= 0:
		shakeAmount = 8
		while(shakeAmount > 0):
			shakeAmount -= 1
			var newTween = create_tween()
			newTween.tween_property(sprite, "position",
			Vector2(randi_range(-4, 4), randi_range(-4, 4)), 0.04)
			
			newTween.play()
			await newTween.finished
			newTween.kill()
		sprite.position = Vector2(0, 0)
	else:
		shakeAmount = 8

var resource = preload("res://resources/dropped_item.tscn")
var shakeAmount = 0

func dropResource(itemName, amount):
	var newResource: CharacterBody2D = resource.instantiate()
	newResource.global_position = global_position
	
	newResource.setItem(itemName, amount)
	get_parent().call_deferred("add_child", newResource)
	
	newResource.velocity = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized() * 500 * randf_range(1.1, 1.4)
