extends CharacterBody2D

@onready var anim = get_node("AnimatedSprite2D")

var player
var SPEED = 150
var health = 3

func _physics_process(delta):
	if (anim.rotation_degrees == -90.0 || anim.rotation_degrees == 90.0):  
		return
		
	player = get_node("../Player")
	var direction = (player.global_position - self.global_position).normalized()
	velocity = direction * SPEED
	
	if direction.length() > 0:
		if anim.animation != "Death" and anim.animation != "Hurt":
			anim.play("Run")
		anim.flip_h = direction.x < 0
	else:
		anim.play("Idle")
	move_and_slide()
		
func take_damage():
	if anim.animation != "Hurt":
		health -= 1
		
	if health >= 1:
		anim.play("Hurt")
		await anim.animation_finished
		anim.animation = "Idle"
	else:
		anim.play("Death")
		await anim.animation_finished
		self.queue_free()

func get_rotated():
	anim.rotation_degrees = -90.0 if randf() < 0.5 else 90.0
	take_damage()
	$RotationTimer.start()
	
func _on_rotation_timer_timeout():
	anim.rotation_degrees = 0.0


#func _on_enemy_death_body_entered(body):
	#if body.name == "Player":
		#anim.play("Death")
		#await anim.animation_finished
		#self.queue_free()



