class_name Attack

var damage: int
var position: Vector2
var knockback_force: float

func _init(damage: int, position: Vector2, knockback_force: float):
	self.damage = damage
	self.position = position
	self.knockback_force = knockback_force
