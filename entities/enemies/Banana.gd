extends CharacterBody2D

@onready var anim = get_node("AnimatedSprite2D")
@onready var attack_area = get_node("AttackArea")

var player
var SPEED = 150
var health = 3
var is_attacking = false
var attack_cooldown = 1.0  # Set the cooldown time for the attack
var attack_timer = 0.0

func _process(delta):
	player = get_node("../Player")
	var direction = (player.global_position - self.global_position).normalized()
	velocity = direction * SPEED

	if direction.length() > 0:
		if anim.animation != "Death" and anim.animation != "Hurt":
			anim.play("Run")
		anim.flip_h = direction.x < 0
		if anim.flip_h:
			attack_area.position.x = -attack_area.position.x
		else:
			attack_area.position.x = abs(attack_area.position.x)
	else:
		anim.play("Idle")
	

	if is_attacking:
		attack_timer += delta
		if attack_timer >= attack_cooldown:
			is_attacking = false
			attack_timer = 0.0

func _physics_process(delta):
	move_and_slide()

func attack():
	if not is_attacking:
		is_attacking = true
		anim.play("Attack")

func _on_attack_area_area_entered(area):
	if area.is_in_group("Player"):
		attack()

