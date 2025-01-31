extends Node

class_name State
signal Transitioned
@onready var player: CharacterBody2D = $"../.."
var animatedSprite: AnimatedSprite2D
var nextComboTimer: Timer

var SPEED = 500.0
const JUMP_VELOCITY = -400.0

func enter():
	pass
	
func exit():
	pass
	
func update(_delta:float):
	pass
	
func physics_update(_delta:float):
	pass
