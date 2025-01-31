extends State
class_name PlayerComboAttack1
@onready var rightHitArea: Area2D = $"../../RightHitArea"
@onready var leftHitArea: Area2D = $"../../LeftHitArea"
@onready var comboTimer: Timer = $"ComboTimer"

func enter():
	super.enter()
	animatedSprite.play("attack2")
	
	#leftHitArea.monitoring = animatedSprite.flip_h
	#rightHitArea.monitoring = !animatedSprite.flip_h
	
	comboTimer.start()

func physics_update(delta: float) -> void:
	if animatedSprite.is_playing():		
		if animatedSprite.frame == 5:
			leftHitArea.monitoring = animatedSprite.flip_h
			rightHitArea.monitoring = !animatedSprite.flip_h
		
		if Input.is_action_just_pressed("attack") and comboTimer.is_stopped():
			Transitioned.emit(self, "PlayerComboAttack2")
		
	else: Transitioned.emit(self, "PlayerIdle")

func exit():
	super.exit()
	
	leftHitArea.monitoring = false
	rightHitArea.monitoring = false
	
	
	
