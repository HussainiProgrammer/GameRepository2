extends SwordState

@export var oscillation_speed: float = 180e-3
@export var oscillation_amount: float = 0.2

func enter():
	super.enter()
	sword.position = stateMachine.idlePosition
	sword.rotation_degrees = stateMachine.idleAngle
	sword.visible = true

func physics_update(delta: float) -> void:
	stateMachine.filterDetectedEnemies()
	
	if stateMachine.detectedEnemies:
		if !combo2Timer.is_stopped(): Transitioned.emit(self, "SwordAttack3")
		elif !combo1Timer.is_stopped(): Transitioned.emit(self, "SwordAttack2")
		elif nextComboTimer: Transitioned.emit(self, "SwordAttack1")
		
	elif floating_timer.is_stopped(): Transitioned.emit(self, "SwordInvisible")
	
	else:
		sword.rotation_degrees = stateMachine.idleAngle
		sword.position.y += sin(deg_to_rad(oscillation_speed * Time.get_ticks_msec())) * oscillation_amount
