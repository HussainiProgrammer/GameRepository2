extends Area2D

@export var damage: int = 250

func _on_body_entered(body: Node2D) -> void: body.damage(damage)
