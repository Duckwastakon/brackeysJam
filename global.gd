extends Node

var wobblingObjects = []
var rotationStates = []

func wobble(objectSprite, velocity):
	var rotatingState = 1
	
	if(wobblingObjects.find(objectSprite) != -1):
		rotatingState = rotationStates[wobblingObjects.find(objectSprite)]
	else:
		wobblingObjects.append(objectSprite)
		rotationStates.append(1)
		
		await get_tree().create_timer(2).timeout
	
	if(velocity != Vector2.ZERO):
		if (velocity.x > 0):
			objectSprite.flip_h=true
		else:
			objectSprite.flip_h=false
		
		var wobbleSpeed = 1000 / (abs(velocity.x) + abs(velocity.y))
		var maxWobbleDistance = clampf(2000 / (abs(velocity.x) + abs(velocity.y)) * 15, 5, 15)
		
		if(objectSprite.rotation_degrees == maxWobbleDistance * rotatingState):
			rotatingState *= -1
			rotationStates[wobblingObjects.find(objectSprite)] = rotatingState
		
		objectSprite.rotation_degrees = move_toward(objectSprite.rotation_degrees, 
		maxWobbleDistance * rotatingState, wobbleSpeed)
	else:
		objectSprite.rotation_degrees = move_toward(objectSprite.rotation_degrees, 0, 5)
