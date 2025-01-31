extends Node
@export var initial_state: SwordState

var current_state: SwordState
var states: Dictionary = {}

@onready var enemy_detector: Area2D = $EnemyDetector
@onready var sword: Node2D = $Sword
@onready var hit_area: Area2D = $Sword/HitArea
@onready var sprite_2d: Sprite2D = $Sword/Sprite2D
@onready var floating_timer: Timer = $FloatingTimer
@onready var combo_timer: Timer = $ComboTimer
@onready var next_combo_timer: Timer = $NextComboTimer

var isVisible: bool = false
var isAttacking: bool = false

@export var swordLinearSpeed: float = 350
@export var swordAngularSpeed: float = 18
@export var idlePosition: Vector2
@export var idleAngle: float
@export var angle: float
@export var flippedAngle: float

var detectedEnemies: Array

func _ready() -> void:
	for child in get_children():
		if child is SwordState:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transitioned)
	
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func _process(delta: float) -> void:
	if current_state: current_state.update(delta)

func _physics_process(delta: float) -> void:
	idleAngle = angle if Gloable.playerDirection == 1 else flippedAngle
	
	if current_state: current_state.physics_update(delta)

func on_child_transitioned(state, new_state_name:String):
	if state != current_state: return
		
	var new_state: SwordState = states.get(new_state_name.to_lower())
	if !new_state: return

	if current_state: current_state.exit()
	
	new_state.enter()
	current_state = new_state

func _on_enemy_detector_area_entered(area: Area2D) -> void:
	if area not in detectedEnemies: detectedEnemies.append(area)

func _on_enemy_detector_area_exited(area: Area2D) -> void:
	detectedEnemies.erase(area)

func filterDetectedEnemies():
	for enemy in detectedEnemies:
		if !is_instance_valid(enemy) or enemy == sword:
			detectedEnemies.erase(enemy)
