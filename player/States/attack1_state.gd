extends State

class_name PlayerAttack1
@onready var state_machine: Node = $".."
@onready var rightHitArea: Area2D = $"../../RightHitArea"
@onready var leftHitArea: Area2D = $"../../LeftHitArea"
@onready var comboTimer: Timer = $"ComboTimer"

func enter():
	super.enter()
	animatedSprite.play("attack1")
	comboTimer.start()

func physics_update(delta: float) -> void:
	if animatedSprite.is_playing():
		player.velocity.x = 0
		if animatedSprite.frame == 5:
			leftHitArea.monitoring = animatedSprite.flip_h
			rightHitArea.monitoring = !animatedSprite.flip_h
		
		if Input.is_action_just_pressed("attack") and comboTimer.is_stopped():
			Transitioned.emit(self, "PlayerComboAttack1")
		
	elif Input.get_axis("left","right"): Transitioned.emit(self, "PlayerRunAndSprint")
	else: Transitioned.emit(self,"PlayerIdle")

func exit():
	super.exit()
	
	leftHitArea.monitoring = false
	rightHitArea.monitoring = false
	
	
	
