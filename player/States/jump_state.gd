extends State
class_name PlayerJump

func physics_update(delta: float) -> void:
	if player.is_on_floor():
		Gloable.can_double_jump = true
		player.velocity.y = -900
		
	else: Transitioned.emit(self,"PlayerIdle")
	
