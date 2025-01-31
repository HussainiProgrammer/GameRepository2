extends State
class_name PlayerDoubleJump

func physics_update(delta: float) -> void:
	if Gloable.can_double_jump:
		Gloable.can_double_jump = false
		get_parent().get_parent().velocity.y = -900
	else: Transitioned.emit(self,"PlayerIdle")
