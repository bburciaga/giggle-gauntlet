extends Area2D

var ATTACK: Attack = Attack.new(1, self.global_position, 0)

func _ready():
	$AnimatedSprite2D.play("dropt")

func _on_area_entered(area: Area2D):
	if area is HitboxComponent:
		var hitbox: HitboxComponent = area
		if area.is_in_group("Enemies"):
			var entity: Node = area.get_parent()
			$SlipSound.play()
			$Timer.start()
			$".".position = Vector2(2000, 2000)
			var animation = entity.get_node("AnimatedSprite2D")
			animation.rotation_degrees = -90.0 if randf() < 0.5 else 90.0
			animation.play("Hurt")
			hitbox.damage(ATTACK, true)
			queue_free()

func _on_timer_timeout():
	queue_free()
