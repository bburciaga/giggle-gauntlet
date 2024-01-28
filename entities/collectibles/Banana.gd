extends Area2D

@onready var banana = get_node("AnimatedSprite2D")

func _ready():
	banana.play("surprise")

func _on_body_entered(body):
	if body.name == "Player":
		body.activate_banana_weapon()
		queue_free()
