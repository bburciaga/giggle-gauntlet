extends Area2D

@onready var gnome = get_node("AnimatedSprite2D")

func _ready():
	gnome.play("rotate")
	
func _on_body_entered(body):
	if body.name == "Player":
		body.activate_gnome_weapon()
		queue_free()
