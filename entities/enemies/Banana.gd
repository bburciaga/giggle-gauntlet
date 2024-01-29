extends CharacterBody2D

@onready var anim = get_node("AnimatedSprite2D")

var player
var SPEED = 150
var health = 3

func _physics_process(delta):		
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
