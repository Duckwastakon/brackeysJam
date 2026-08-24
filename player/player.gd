extends CharacterBody2D

var movingState = 0
@export var maxSpeed = [500, 1000, 200]
@export var accelerations = [150, 250, 50]
@export var deceleration = 100

func _physics_process(delta: float) -> void:
	var movementDirection = Vector2(Input.get_axis("left", "right"), 
	Input.get_axis("up", "down")).normalized()
	
	if(movementDirection != Vector2.ZERO):
		velocity += movementDirection * accelerations[movingState]
		
		if(movementDirection.x == 0):
			velocity.x = move_toward(velocity.x, 0, deceleration)
		if(movementDirection.y == 0):
			velocity.y = move_toward(velocity.y, 0, deceleration)
		lockSpeed()
	else:
		velocity.x = move_toward(velocity.x, 0, deceleration)
		velocity.y = move_toward(velocity.y, 0, deceleration)
	
	playerWobble()
	move_and_slide()

func lockSpeed():
	if(abs(velocity.x) > maxSpeed[movingState]):
		if(abs(velocity.x) > 1.5*maxSpeed[movingState]):
			velocity.x = move_toward(velocity.x, 0, deceleration)
		else:
			velocity.x = velocity.x / abs(velocity.x) * maxSpeed[movingState]
	if(abs(velocity.y) > maxSpeed[movingState]):
		if(abs(velocity.y) > 1.5*maxSpeed[movingState]):
			velocity.y = move_toward(velocity.y, 0, deceleration)
		else:
			velocity.y = velocity.y / abs(velocity.y) * maxSpeed[movingState]

var rotatingState = -1
@onready var playerArt = $playerArt

func playerWobble():
	if(velocity != Vector2.ZERO):
		if (velocity.x > 0):
			playerArt.flip_h=true
		else:
			playerArt.flip_h=false
		
		var wobbleSpeed = 1000 / (abs(velocity.x) + abs(velocity.y))
		var maxWobbleDistance = clampf(2000 / (abs(velocity.x) + abs(velocity.y)) * 15, 5, 15)
		
		if(playerArt.rotation_degrees == maxWobbleDistance * rotatingState):
			rotatingState *= -1
		
		playerArt.rotation_degrees = move_toward(playerArt.rotation_degrees, 
		maxWobbleDistance * rotatingState, wobbleSpeed)
	else:
		playerArt.rotation_degrees = move_toward(playerArt.rotation_degrees, 0, 5)
