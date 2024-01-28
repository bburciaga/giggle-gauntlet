extends Area2D

func _ready():
	$AnimatedSprite2D.play("dropt")
	
func _on_area_entered(area):
	if (area.is_in_group("Enemies")):
		area.get_rotated()
		queue_free()
