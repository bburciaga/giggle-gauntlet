extends Area2D

class_name Wrench

@onready var projectile = get_node("AnimatedSprite2D")
var speed: float = 75.0

func _ready():
	projectile.play("default")

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_body_entered(body):
	if "Player" == body.name:
		queue_free()
