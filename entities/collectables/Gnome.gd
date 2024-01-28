extends Area2D

func _on_body_entered(body):
	if body.name == "Player":
		body.activate_gnome_weapon()
		queue_free()
