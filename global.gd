extends Node

var dayTime = true
var days = 0;
var warmthObjects = []

var shake_intensity := 1.0  

var equippedIndex = 0

var wobblingObjects = []
var rotationStates = []

func wobble(objectSprite, velocity):
	if(objectSprite == null): return
	var rotatingState = 1
	
	if(wobblingObjects.find(objectSprite) != -1):
		rotatingState = rotationStates[wobblingObjects.find(objectSprite)]
	else:
		wobblingObjects.append(objectSprite)
		rotationStates.append(1)
	
	if(velocity != Vector2.ZERO):
		if (velocity.x > 0):
			objectSprite.flip_h=true
		else:
			objectSprite.flip_h=false
		
		var wobbleSpeed =  (abs(velocity.x) + abs(velocity.y)) / 500
		var maxWobbleDistance = clampf(2000 / (abs(velocity.x) + abs(velocity.y)) * 15, 5, 15)
		
		if(objectSprite.rotation_degrees == maxWobbleDistance * rotatingState):
			rotatingState *= -1
			rotationStates[wobblingObjects.find(objectSprite)] = rotatingState
		
		objectSprite.rotation_degrees = move_toward(objectSprite.rotation_degrees, 
		maxWobbleDistance * rotatingState, wobbleSpeed)
	else:
		objectSprite.rotation_degrees = move_toward(objectSprite.rotation_degrees, 0, 5)
