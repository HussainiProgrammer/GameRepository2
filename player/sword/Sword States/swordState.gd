extends Node

class_name SwordState

signal Transitioned
@onready var sword_object: Node2D = $"../.."
@onready var stateMachine: Node = $".."
@onready var sword: Node2D = $"../../Sword"
@onready var floating_timer: Timer = $"../FloatingTimer"
@onready var combo1Timer: Timer = $"../Combo1Timer"
@onready var combo2Timer: Timer = $"../Combo2Timer"
@onready var nextComboTimer: Timer = $"../NextComboTimer"
@onready var hit_area: Area2D = $"../../Sword/HitArea"

func enter():
	pass
	
func exit():
	pass
	
func update(delta: float):
	pass
	
func physics_update(delta: float):
	pass
