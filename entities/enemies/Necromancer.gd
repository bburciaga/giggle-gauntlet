extends CharacterBody2D

@onready var ray_cast = $RayCast2D
@onready var timer = $ProjectileTimer
@onready var anim: AnimatedSprite2D = get_node("AnimatedSprite2D")
@onready var player = get_node("../Player")
@export var ammo: PackedScene
@onready var player_vars = get_node("/root/PlayerVariables")

const wrench_path = preload("res://entities/projectiles/Wrench.tscn")

var SPEED = 15

func _physics_process(delta):
	move()
	_aim()
	_check_player_collsion()
	move_and_slide()

##### Entity Actions #####

func move() -> void:
	var direction = (player.global_position - self.global_position).normalized()
	if "Hurt" == anim.animation or "Death" == anim.animation:
		velocity = direction * 0
	else:
		velocity = direction * SPEED
	
	if (anim.rotation_degrees == -90.0 || anim.rotation_degrees == 90.0):  
		return
	
	if direction.length() > 0:
		if anim.animation != "Death" and anim.animation != "Hurt" and anim.animation != "Attack":
			anim.play("Run")
		anim.flip_h = direction.x < 0
	else:
		anim.play("Idle")

func _shoot():
	if "Hurt" != anim.animation and anim.animation != "Death":
		anim.play("Attack")
		var wrench: Wrench = ammo.instantiate()
		wrench.position = position
		wrench.direction = (ray_cast.target_position).normalized()
		get_tree().get_root().get_node(".").add_child(wrench)

##### Entity Auto #####

func _aim() -> void:
	ray_cast.target_position = to_local(player.global_position)

func _check_player_collsion() -> void:
	if ray_cast.get_collider() == player and timer.is_stopped():
		timer.start()
	elif ray_cast.get_collider() != player and not timer.is_stopped():
		timer.stop()

##### Utilities #####

func _on_rotation_timer_timeout() -> void:
	anim.rotation_degrees = 0.0

func _on_projectile_timer_timeout() -> void:
	_shoot()
