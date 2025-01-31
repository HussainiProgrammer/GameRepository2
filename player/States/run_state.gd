extends State

func physics_update(delta: float) -> void:
	var direction = Input.get_axis("left","right")
	if abs(direction) == 1:
		player.velocity.x = direction * SPEED
		
		if direction == -1: Gloable.last_direction = direction
		else: Gloable.last_direction = 1
		
		animatedSprite.flip_h = direction == -1
		
		if Input.is_action_just_pressed("jump"): Transitioned.emit(self,"PlayerJump")
		
	else:
		player.velocity.x = 0
		Transitioned.emit(self,"PlayerIdle")
		
	if Input.is_action_pressed("sprint") and Gloable.canSprint: SPEED = 1000.0
	elif Input.is_action_just_released("sprint") or !Gloable.canSprint: SPEED = 800
