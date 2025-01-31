extends Node2D

@onready var enemy_detector: Area2D = $EnemyDetector
@onready var sword: Node2D = $Sword
@onready var hit_area: Area2D = $Sword/HitArea
@onready var sprite_2d: Sprite2D = $Sword/Sprite2D
@onready var floating_timer: Timer = $FloatingTimer
@onready var combo_timer: Timer = $ComboTimer
@onready var next_combo_timer: Timer = $NextComboTimer

var isVisible: bool = false
var isAttacking: bool = false
var toEnemy: bool = false

@export var swordLinearSpeed: float = 350
@export var swordAngularSpeed: float = 18
@export var oscillation_speed: float = 180e-3
@export var oscillation_amount: float = 0.2
@export var idlePosition: Vector2
@export var idleAngle: float
@export var angle: float
@export var flippedAngle: float
@export var damage: float

var currentEnemy: Node2D
var detectedEnemies: Array

func _ready() -> void:
	hit_area.damage = damage

func _physics_process(delta: float) -> void:
	if isVisible:
		idleAngle = angle if Gloable.playerDirection == 1 else flippedAngle
		
		if floating_timer.is_stopped() and !isAttacking:
			sword.visible = false
			isVisible = false
			return
			
		if isAttacking: updateAttack(delta)
			
		elif detectedEnemies: startAttack()
			
		else:
			sword.position.y += sin(deg_to_rad(oscillation_speed * Time.get_ticks_msec())) * oscillation_amount
					
	elif Input.is_action_just_pressed("attack"):
		sword.position = idlePosition
		sword.visible = true
		isVisible = true
		floating_timer.start()

func _on_enemy_detector_area_entered(area: Area2D) -> void:
	if area not in detectedEnemies: detectedEnemies.append(area)

func _on_enemy_detector_area_exited(area: Area2D) -> void:
	detectedEnemies.erase(area)

func startAttack():
	filterDetectedEnemies()
	if detectedEnemies:
		currentEnemy = detectedEnemies[0]
		hit_area.monitoring = true
		toEnemy = true
		isAttacking = true

func updateAttack(delta: float):
	var backwardRotation: float
	if toEnemy and is_instance_valid(currentEnemy):
		sword.rotation = PI/2 + (to_local(currentEnemy.global_position) - sword.position).angle()
		sword.position = sword.position.move_toward(to_local(currentEnemy.global_position), swordLinearSpeed * delta)

		if sword.position == to_local(currentEnemy.global_position) or !is_instance_valid(currentEnemy):
			toEnemy = false
			backwardRotation = idleAngle - sword.rotation_degrees
	else:
		sword.rotation = move_toward(sword.rotation, deg_to_rad(idleAngle), swordAngularSpeed * delta)
		sword.position = sword.position.move_toward(idlePosition, swordLinearSpeed * delta)

		
		if sword.position == idlePosition and sword.rotation == deg_to_rad(idleAngle): stopAttack()

func stopAttack():
	hit_area.monitoring = false
	isAttacking = false
	sword.visible = false
	isVisible = false
	floating_timer.stop()
	filterDetectedEnemies()

func filterDetectedEnemies():
	for enemy in detectedEnemies:
		if !is_instance_valid(enemy) or enemy == sword:
			detectedEnemies.erase(enemy)
