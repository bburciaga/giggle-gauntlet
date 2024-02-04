extends Area2D

class_name Water

var speed: float = 125.0
var ATTACK: Attack = Attack.new(1, self.global_position, 2.5)

func _physics_process(delta):
	position += transform.x * speed * delta

func _on_area_entered(area: Area2D):
	print(area.get_parent().has_method("take_damage"))
	if area.is_in_group("Enemies") and area.get_parent().has_method("take_damage"):
		area.get_parent().take_damage(ATTACK)
		queue_free()

func _on_screen_exited():
	queue_free()
