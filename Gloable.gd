extends Node

var SPEED = 600.0
var JUMP_VELOCITY = -950.0
var stunned:bool = false
var bloom_mode:bool = true
var strength 
var intensity 
var bloom 
var health = 100
var spiked = false
var count = 0
var jump_count = 0
var can_double_jump = true
var current_state
var last_direction
var playerDirection
var maxHealth = 1000
var maxHunger = 10000
var maxStamina = 1000
var staminaLostPerSecond = 125
var staminaGainedPerSecond = 250
var hungerLostPerSecond = 1
var canSprint = true
var hungerLimitForStamina = maxHunger * 0.5
var hungerLimitForHealth = maxHunger * 0.8
var healthPerSecond = 5
