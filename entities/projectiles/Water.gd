extends Area2D

class_name Water

var speed: float = 125.0

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_area_entered(area):
	if (area.is_in_group("Enemies")):
		area.take_damage()
		queue_free()

func _on_screen_exited():
	queue_free()
