extends Area2D

class_name Wrench

@onready var projectile = get_node("AnimatedSprite2D")
var speed: float = 75.0
var direction: Vector2 = Vector2.RIGHT
var ATTACK: Attack = Attack.new(1, self.global_position, -2.5)

func _ready():
	projectile.play("default")

func _physics_process(delta):
	position += direction * speed * delta

func _on_body_entered(body: Node2D):
	match (body.name):
		"StaticBody2D":
			queue_free()
		"Player":
			body.take_damage(ATTACK)
			queue_free()

func _on_screen_exited():
	queue_free()
