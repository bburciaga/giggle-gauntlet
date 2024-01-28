extends Area2D

var speed: float = 125.0

@export var rotation_speed = 1.5
var rotation_direction = 0

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_area_entered(area):
	if (area.is_in_group("Enemies")):
		area.take_damage()
	
