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
		
		lockSpeed()
	else:
		velocity.x = move_toward(velocity.x, 0, deceleration)
		velocity.y = move_toward(velocity.y, 0, deceleration)
	
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
