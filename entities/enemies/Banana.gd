extends CharacterBody2D

@onready var anim: AnimatedSprite2D = get_node("AnimatedSprite2D")
@onready var attack_area = get_node("AttackArea")
@onready var player = get_node("../Player")
@onready var player_vars = get_node("/root/PlayerVariables")

const SPEED = 25
var health = 3
var ATTACK: Attack =Attack.new(1, self.global_position, -2.5)

func _process(delta):
	move()

##### Entity Actions #####

func move() -> void:
	# rotate entity
	if (anim.rotation_degrees == -90.0 || anim.rotation_degrees == 90.0):  
		return
	
	# get direction to player
	var direction = global_position.direction_to(player.global_position)
	if "Hurt" == anim.animation or "Death" == anim.animation:
		velocity = direction * 0
	else:
		velocity = direction * SPEED
	
	# animation check to see if it should play run animation
	if direction.length() > 0:
		if anim.animation != "Death" and anim.animation != "Hurt" and anim.animation != "Attack":
			anim.play("Run")
		anim.flip_h = direction.x < 0
		if anim.flip_h:
			$CollisionShape2D.position.x = 10
			attack_area.position.x = -attack_area.position.x - 5
		else:
			attack_area.position.x = abs(attack_area.position.x)
	else:
		anim.play("Idle")
	
	move_and_slide()

func damage(attack: Attack, activate: bool = false):
	if anim.animation != "Hurt":
		health -= attack.damage
	
	velocity = (global_position - attack.position) * attack.knockback_force
	move_and_slide()
		
	if health >= 1:
		anim.play("Hurt")
		await anim.animation_finished
		anim.animation = "Idle"
	else:
		player_vars.score += 5
		anim.play("Death")
		await anim.animation_finished
		self.queue_free()
	
	if activate:
		$RotationTimer.start()

##### Utility Methods #####

func _on_attack_area_area_entered(area: Area2D):
	if area.is_in_group("Player"):
		anim.play("Attack")
		player.damage(ATTACK)

func _on_rotation_timer_timeout():
	anim.rotation_degrees = 0.0
