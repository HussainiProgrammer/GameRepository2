extends SwordState

func enter():
	super.enter()
	sword.visible = false

func physics_update(delta: float):
	if Input.is_action_pressed("attack") and nextComboTimer.is_stopped():
		Transitioned.emit(self, "SwordIdle")

func exit():
	super.exit()
	
	floating_timer.start()
	
