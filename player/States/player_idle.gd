extends State

func physics_update(delta: float) -> void:
	
	var direction = Input.get_axis('left','right')
	if direction != 0: Transitioned.emit(self,"PlayerRunAndSprint")
	if Input.is_action_just_pressed("jump"): Transitioned.emit(self, "PlayerJump")
	
	if Input.is_action_just_pressed("attack") and nextComboTimer.is_stopped():
		Transitioned.emit(self, "PlayerAttack1")
	
	if Input.is_action_just_pressed("esc"): Transitioned.emit(self, "PlayerDeath")
