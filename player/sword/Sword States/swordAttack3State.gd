extends SwordState

@export var swordLinearSpeed: float = 350
@export var swordAngularSpeed: float = 18

var currentEnemy: Node2D
var toEnemy: bool

func enter():
	super.enter()

	combo2Timer.stop()
	hit_area.monitoring = true
	toEnemy = true
	currentEnemy = stateMachine.detectedEnemies[0]

func physics_update(delta: float):
	if toEnemy and is_instance_valid(currentEnemy):
		sword.rotation = PI/2 + (sword_object.to_local(currentEnemy.global_position) - sword.position).angle()
		sword.position = sword.position.move_toward(sword_object.to_local(currentEnemy.global_position), swordLinearSpeed * delta)

		if sword.position == sword_object.to_local(currentEnemy.global_position) or !is_instance_valid(currentEnemy): toEnemy = false
	else:
		sword.rotation = move_toward(sword.rotation, deg_to_rad(stateMachine.idleAngle), swordAngularSpeed * delta)
		sword.position = sword.position.move_toward(stateMachine.idlePosition, swordLinearSpeed * delta)

		if sword.position == stateMachine.idlePosition and sword.rotation == deg_to_rad(stateMachine.idleAngle): Transitioned.emit(self, "SwordInvisible")

func exit():
	super.exit()
	
	hit_area.monitoring = false
	nextComboTimer.start()
