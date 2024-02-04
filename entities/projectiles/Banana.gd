extends Area2D

var ATTACK: Attack = Attack.new(1, self.global_position, 0)

func _ready():
	$AnimatedSprite2D.play("dropt")
	
func _on_area_entered(area):
	if area.is_in_group("Enemies") and area.get_parent().has_method("get_rotated"):
		$SlipSound.play()
		$Timer.start()
		$".".position = Vector2(2000, 2000)
		area.get_parent().get_rotated(ATTACK)

func _on_timer_timeout():
	queue_free()
