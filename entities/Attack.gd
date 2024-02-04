class_name Attack

var damage: int
var attack_position: Vector2
var knockback_force: float

func _init(damage: int, position: Vector2, knockback_force: float):
	self.damage = damage
	self.attack_position = position
	self.knockback_force = knockback_force
