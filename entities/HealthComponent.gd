class_name HealthComponent
extends Node2D

@export var MAX_HEALTH := 10.0
@onready var PLAYER = get_node("/root/PlayerVariables")
var health: float

func _ready():
	health = MAX_HEALTH

func _process(delta):
	game_over()

func damage (attack: Attack, activate: bool = false):
	health -= attack.damage
	
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

func game_over():
	if "Player" == get_parent().name and 1 > health:
		get_tree().change_scene_to_file("res://menus/finish/Finish.tscn")
