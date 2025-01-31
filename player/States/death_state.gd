extends State

@onready var reloadTimer: Timer = $"ReloadTimer"
@onready var collision_shape_2d: CollisionShape2D = $"../../CollisionShape2D"

func enter():
	super.enter()
	collision_shape_2d.visible = false
	player.velocity.x = 0
	animatedSprite.play("death")
	reloadTimer.start()

func _on_reload_timer_timeout() -> void:
	get_tree().reload_current_scene()
