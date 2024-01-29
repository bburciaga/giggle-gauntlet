extends Area2D

class_name Wrench

@onready var projectile = get_node("AnimatedSprite2D")
var speed: float = 75.0
var direction: Vector2 = Vector2.RIGHT

func _ready():
	projectile.play("default")

func _physics_process(delta):
	position += direction * speed * delta

func _on_body_entered(body):
	if "Player" == body.name:
		queue_free()

func _on_screen_exited():
	queue_free()
