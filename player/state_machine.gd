extends Node
@export var initial_state: State

var current_state: State
var states: Dictionary = {}
var isIdle = true
var isRunnningOrSprinting = false
var isJumping = false
var isDoubleJumping = false
var isAttacking = false
var isDead = false

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transitioned)
			child.animatedSprite = $"../AnimatedSprite2D"
			child.nextComboTimer = $"NextComboTimer"

	if initial_state:
		initial_state.enter()
		current_state = initial_state

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)
		Gloable.current_state = current_state
		
	isIdle = current_state == states["playeridle"]
	isRunnningOrSprinting = current_state == states["playerrunandsprint"]
	isJumping = current_state == states["playerjump"]
	#isAttacking = current_state == states["playerattack1"] or current_state == states["playercomboattack1"] or current_state == states["playercomboattack2"]
	isDead = current_state == states["playerdeath"]
	
func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)
		$"../Label".text = current_state.name
		
	get_parent().move_and_slide()
		
func on_child_transitioned(state, new_state_name:String):
	if state != current_state: return
		
	var new_state:State = states.get(new_state_name.to_lower())
	if !new_state: return

	if current_state: current_state.exit()
	
	new_state.enter()
	current_state = new_state
