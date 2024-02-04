class_name Wrench
extends Area2D

var speed: float = 75.0
var direction: Vector2 = Vector2.RIGHT
var ATTACK: Attack = Attack.new(1, self.global_position, -2.5)

@onready var projectile = get_node("AnimatedSprite2D")

func _ready():
	projectile.play("default")

func _physics_process(delta):
	position += direction * speed * delta

func _on_area_entered(area: Area2D):
	var entity = area.get_parent()
	if area is HitboxComponent:
		var hitbox: HitboxComponent = area
		match entity.name:
			"Player":
				hitbox.damage(ATTACK)
				queue_free()
			"Banana":
				queue_free()
			"Necromancer":
				queue_free()

func _on_body_entered(body: Node2D):
	match (body.name):
		"StaticBody2D":
			queue_free()
		"Player":
			body.damage(ATTACK)
			queue_free()

func _on_screen_exited():
	queue_free()
