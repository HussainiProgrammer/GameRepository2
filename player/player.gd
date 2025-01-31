extends CharacterBody2D

@onready var sword_object: Node2D = $SwordObject
@onready var animated_sprite_2d: AnimatedSprite2D = $"AnimatedSprite2D"
@onready var stateMachine = $"State Machine"
@onready var healthBar: TextureProgressBar = $"../CanvasLayer/PlayerHealthBar"
@onready var hungerBar: TextureProgressBar = $"../CanvasLayer/PlayerHungerBar"
@onready var staminaBar: TextureProgressBar = $"../CanvasLayer/PlayerStaminaBar"
@export var health = Gloable.maxHealth
@export var hunger = Gloable.maxHunger
@export var stamina = Gloable.maxStamina
@onready var stamina_timer: Timer = $StaminaTimer
# collision fix -->
@export var aniPos: int
@export var flippedAniPos: int
@export var swordPos: int
@export var flippedSwordPos: int
# <-- collision fix

func _physics_process(delta: float) -> void:
	if hunger == 0: damage(Gloable.healthPerSecond * delta)
	
	elif hunger > Gloable.hungerLimitForHealth and !stateMachine.isDead: increaseHealth(Gloable.healthPerSecond * delta)
	
	reduceHunger(Gloable.hungerLostPerSecond * delta)
	
	if not is_on_floor(): velocity += get_gravity() * delta
	
	if !(stateMachine.isAttacking or stateMachine.isDead):
		if not is_on_floor():
			if velocity.y > 0: animated_sprite_2d.play("fall")
			if velocity.y < 0: animated_sprite_2d.play("jump")

		if is_on_floor() and velocity.x == 0:
			animated_sprite_2d.play("idle")
			
		elif is_on_floor() and abs(velocity.x) > 0:
			if Input.is_action_pressed("sprint") and stamina > 0: reduceStamina(Gloable.staminaLostPerSecond * delta)

			animated_sprite_2d.play("run")
	
		if hunger > Gloable.hungerLimitForStamina and stamina_timer.is_stopped():
			increaseStamina(Gloable.staminaGainedPerSecond * delta)

  # collision fix -->
	if animated_sprite_2d.flip_h:
		animated_sprite_2d.position.x = flippedAniPos
		sword_object.position.x = flippedSwordPos
		Gloable.playerDirection = -1
		
	else:
		animated_sprite_2d.position.x = aniPos
		sword_object.position.x = swordPos
		Gloable.playerDirection = +1
  # <-- collision fix
		
	move_and_slide()

func damage(amountOfDamage: float) -> void:
	health -= amountOfDamage
	
	if health < 0: health = 0
	healthBar.value = round(health)
	
	if health == 0 and !stateMachine.isDead: stateMachine.on_child_transitioned(stateMachine.current_state, "PlayerDeath"); stateMachine.isDead = true


func increaseHealth(amountOfIncrease: float):
	health += amountOfIncrease

	if health > Gloable.maxHealth: health = Gloable.maxHealth
	healthBar.value = round(health)
	
func reduceStamina(amountOfReduction: float) -> void:
	stamina -= amountOfReduction
	
	if stamina < 0: stamina = 0
	staminaBar.value = round(stamina)
	
	if stamina == 0: Gloable.canSprint = false
	stamina_timer.start()
	
func increaseStamina(amountOfIncrease: float) -> void:
	stamina += amountOfIncrease

	if stamina > Gloable.maxStamina: stamina = Gloable.maxStamina
	staminaBar.value = round(stamina)
	
	Gloable.canSprint = true
	
func reduceHunger(amountOfReduction: float) -> void:
	hunger -= amountOfReduction
	
	if hunger < 0: hunger = 0
	
	hungerBar.value = round(hunger)

func increaseHunger(amountOfIncrease: float) -> void:
	hunger += amountOfIncrease
	
	if hunger > Gloable.maxHunger: hunger = Gloable.maxHunger
	
	hungerBar.value = round(hunger)
