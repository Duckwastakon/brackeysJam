extends CharacterBody2D

const decel = 1
var startingScale = 1
const itemName = "sticks"

func _ready() -> void:
	startingScale = $ColorRect.scale.x

func _physics_process(delta: float) -> void:
	if(velocity != Vector2.ZERO):
		velocity.x = move_toward(velocity.x, 0, decel)
		velocity.y = move_toward(velocity.y, 0, decel)
		
		$ColorRect.scale = Vector2(clamp(startingScale * velocity.length(), 1, 2), 
		clamp(startingScale * velocity.length(), 1, 2))
		
		move_and_slide()
