extends Area2D

func _ready():
	$AnimatedSprite2D.play("dropt")
	
func _on_area_entered(area):
	if (area.is_in_group("Enemies")):
		$SlipSound.play()
		$Timer.start()
		$".".position = Vector2(2000, 2000)
		area.get_rotated()
		
func _on_timer_timeout():
	queue_free()
