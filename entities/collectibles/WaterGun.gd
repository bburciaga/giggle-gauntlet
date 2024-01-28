extends Area2D

@onready var weapon = get_node("AnimatedSprite2D")

func _ready():
	weapon.play("hover")

func _on_body_entered(body):
	if "Player" == body.name:
		body.activate_water_gun_weapon()
		queue_free()
