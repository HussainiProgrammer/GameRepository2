extends Area2D

@export var health: int = 100
@onready var healthBar: TextureProgressBar = $"../healthBar"

func damage(amountOfDamage: int) -> void:
	health -= amountOfDamage
	
	if health < 0: health = 0
	healthBar.value = health
	
	if health == 0: $"..".queue_free()
