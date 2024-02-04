extends Node2D

class_name HealthComponent

@export var MAX_HEALTH := 10.0
@onready var PLAYER = get_node("/root/PlayerVariables")
var health: float

func _ready():
	health = MAX_HEALTH

func damage (attack: Attack, activate: bool = false):
	health -= attack.damage
	
	print(get_parent().name, " ", self.health)
	
	var animation: AnimatedSprite2D = get_parent().get_node("AnimatedSprite2D")
	if health >= 1:
		animation.play("Hurt")
		await animation.animation_finished
		animation.animation = "Idle"
	else:
		PLAYER.score += 5
		animation.play("Death")
		await animation.animation_finished
		self.queue_free()
	
	if health <= 0:
		get_parent().queue_free()
