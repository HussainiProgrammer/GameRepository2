extends State
class_name PlayerComboAttack2
@onready var rightHitArea: Area2D = $"../../RightHitArea"
@onready var leftHitArea: Area2D = $"../../LeftHitArea"

func enter():
	super.enter()
	animatedSprite.play("attack3")
	
	#leftHitArea.monitoring = animatedSprite.flip_h
	#rightHitArea.monitoring = !animatedSprite.flip_h

func physics_update(delta: float) -> void:
	if animatedSprite.is_playing():
		if animatedSprite.frame == 5:
			leftHitArea.monitoring = animatedSprite.flip_h
			rightHitArea.monitoring = !animatedSprite.flip_h
		
	else: Transitioned.emit(self, "PlayerIdle")

func exit():
	super.exit()
	
	leftHitArea.monitoring = false
	rightHitArea.monitoring = false
	
	nextComboTimer.start()
	
