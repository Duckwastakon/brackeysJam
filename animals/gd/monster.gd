extends CharacterBody2D
@onready var sprite = $sprite
@onready var switch = $Switch

var disguise_type: String
var SPEED: float
var move_range: float
var max_stop: int
var random_wait: bool
var true_sprite = preload("res://drawn assets/animals/monster.PNG")

var is_revealed = true
var chasing = false
var pause = false
var leaving = false

var player: CharacterBody2D

var f = true
var movement: Vector2 = Vector2.ZERO
var maxStop = false
var stop = 0

var shapeshift_chance = 0.15 
var reveal_chance = 0.5

func disguise_as(type: String) -> void:
	disguise_type = type
	var data = AnimalData.profiles[type]
	SPEED = data["speed"]
	move_range = data["move_range"]
	max_stop = data["max_stop"]
	random_wait = data["random_wait"]
	sprite.texture = data["sprite"]
	scale = data["scale"]
	is_revealed = false
	$damage/CollisionShape2D.disabled = true

func reveal() -> void:
	is_revealed = true
	if player != null:
		startChasing()
	sprite.texture = true_sprite
	scale = Vector2(2.5, 2.5)
	
	pause = true
	
	await get_tree().create_timer(2).timeout
	pause = false
	$damage/CollisionShape2D.disabled = false

func startChasing():
	print("startChase")
	CameraController.zoomInCamera(0.25)
	CameraController.infShake(1)
	chasing = true
	switch.stop()

func _ready() -> void:
	if not switch.timeout.is_connected(_on_switch_timeout):
		switch.timeout.connect(_on_switch_timeout)
	switch.start()

func _physics_process(delta: float) -> void:
	Global.wobble(sprite, velocity)
	if leaving:
		SPEED = 1200
		velocity = movement.normalized() * SPEED * randf_range(0.8, 1.2)
		move_and_slide()
		return
	if is_revealed:
		if(chasing):
			print("chasing")
			print(velocity)
			print(SPEED)
			print(pause)
			chase_behavior()
		SPEED = AnimalData.mon_speed
	velocity = movement.normalized() * SPEED * randf_range(0.8, 1.2)
	move_and_slide()
	maxStop = stop == max_stop

func chase_behavior() -> void:
	if pause:
		movement = Vector2.ZERO
	else:
		movement = global_position.direction_to(player.global_position).normalized()
		print(global_position.direction_to(player.global_position).normalized())
	

func _on_switch_timeout() -> void:
	if chasing:
		return
	
	if randf() < shapeshift_chance:
		if randf() < reveal_chance:
			reveal()
			return
		else:
			disguise_as(AnimalData.profiles.keys().pick_random())
			return
	
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

func _on_player_searching_area_entered(area: Area2D) -> void:
	if area == $damage: return
	player = area.get_parent()
	if(is_revealed):
		startChasing()

func _on_damage_area_entered(area: Area2D) -> void:
	if area == $playerSearching: return
	area.get_parent().takeDamage(25)
	leave()
	#pause = true
	
	#await get_tree().create_timer(randf_range(1, 2)).timeout
	
	#pause = false

func _on_player_searching_area_exited(area: Area2D) -> void:
	if chasing and player != null and is_revealed and area != $damage:
		leave()

func leave():
	if leaving or player == null: return
	print("leaving")
	movement = -global_position.direction_to(player.global_position)
	switch.stop()
	leaving = true
	chasing = false
	player = null
	CameraController.stopShaking()
	CameraController.unZoomCamera()
	
	await get_tree().create_timer(3).timeout
	
	queue_free()

func takeDamage(amt):
	if(!is_revealed):
		reveal()
