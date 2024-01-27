extends CharacterBody2D

@onready var anim = get_node("AnimatedSprite2D")

var SPEED = 300

func _physics_process(delta):
	var direction = Input.get_vector(
		"move_left",
		"move_right",
		"move_up",
		"move_down"
	)
	velocity = direction * SPEED
	
	if direction.length() > 0:
		anim.play("Run")
		anim.flip_h = direction.x < 0
	else:
		anim.play("Idle")
		
	move_and_slide()
