extends Area2D

@export var damage: float = 25

func _on_body_entered(body: Node) -> void:
	if body.name == "enemy": body.get_children()[1].damage(damage)
