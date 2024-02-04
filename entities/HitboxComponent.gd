class_name HitboxComponent
extends Area2D

@export var health_component: HealthComponent

func damage (attack: Attack, activate: bool = false) -> void:
	if health_component:
		print("Damage Health: ", attack.damage)
		health_component.damage(attack)
	
		var entity = get_parent()
		if entity.is_in_group("Enemies"):
			entity.velocity = (entity.global_position - attack.position) * attack.knockback_force
			entity.move_and_slide()
		
			if activate:
				$RotationTimer.start()
